import adsk.core, adsk.fusion, adsk.cam
import os

# Bulk export Fusion 360 Body objects as .STL files, optionally changing orientation.

# TASKS/QUESTIONS:
#   TODO: Is Export Components needed?  Currently just searches top level Bodies.  Is nested 
#       search needed?  Could use allOccurrences, but would then need smarter logic to exclude tiny
#       parts not intended to be printed e.g. Hemera gears and nuts.  Would probably end up needing 
#       more complex graph exclusion/filter syntax support...

# RESOURCES:
# - STLExport API Sample https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-ECA8A484-7EDD-427D-B1E3-BD59A646F4FA
# - UI Logger https://modthemachine.typepad.com/my_weblog/2021/03/log-debug-messages-in-fusion-360.html
# - Also, have sprinkled code with links to Fusion 360 API reference docs.

# FUTURES:
#   TODO: Auto generate .STL filename that includes part count != 1, e.g. "Z Belt Holder (x3).stl"
#   TODO: Emit Design version number or date as file prefix? e.g. fileVersion  = app.activeDocument.
#       dataFile.latestVersionNumber
#   TODO: Write files to versioned subdir? Diff? "c:\\git\\v1engineering-mods\\mp3dp-v4\\models\\v51\\..." 
#   TODO:P2 Drag-n-drop MP3DP files into Cura 5.0 were automatically OK.  So, may not need to use 
#       body.boundingBox to autocenter XY, and ensure Z > 0.

# Target folder.  WARNING: Existing files are overwritten.
targetFolder = "c:\\git\\v1engineering-mods\\mp3dp-v4\\models\\" 

# Filter used to only export parts containing this expression in the Body name.   Usually used when
# wanting to quickly figure out rotation expression for a specific part, without having to export 
# everything.
filter = ""

# Body names containing these substrings will NOT be exported.
excludes = [ "(1)", "(2)", "Frame", "MGN12H", "12H Block", "HEMERA" ]

# Maximum files to export.  Implemented as safe guard, since haven't figured out how to cancel 
# running script without killing the app.
maxExportCount = 100

pi = 3.1415926535897931

class UiLogger:
    def __init__(self, forceUpdate):  
        app = adsk.core.Application.get()
        ui  = app.userInterface
        palettes = ui.palettes
        self.textPalette = palettes.itemById("TextCommands")
        self.forceUpdate = forceUpdate
        self.textPalette.isVisible = True 
    
    def print(self, text):       
        self.textPalette.writeText(text)
        if (self.forceUpdate):
            adsk.doEvents() 

def run(context):

    logger = UiLogger(True)

    # Get the application and the active design.

    # Application https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-GUID-7209c4c7-bc58-4388-9e20-036410459094
    app = adsk.core.Application.get()
    ui  = app.userInterface

    # app.activeProduct returns Design instance (a subclass, derived from Product)
    # Product https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-c1fb15c9-0117-4666-a8c3-2dd305f7f6ac
    # Design https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-GUID-GUID-GUID-5e0f5e8e-0ec0-4ee7-b827-0ec8da882bee
    design = app.activeProduct

    # Get the root component of the active design.
    # design.rootComponent https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-ce33611e-ba91-484d-88b1-8eb2cec47be2
    # Component https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-GUID-GUID-b56b394e-b9c9-4403-a78b-a186b897909c
    rootComp = design.rootComponent

    # Get occurrences in the root component.  Immediate children, not all descendants.
    occurrences = rootComp.occurrences 

    # Export each component as a STEP file.
    currExportCount = 0
    for occ in occurrences:
        if not occ.isLightBulbOn:
            continue

        if currExportCount >= maxExportCount:
            break

        comp = occ.component

        if any(comp.name.find(exclude) != -1 for exclude in excludes):
            continue

        exportMgr = design.exportManager

        tempTransforms = []

        # BRepBody https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-9910880d-2299-4947-917a-39b5f030eef4
        for body in comp.bRepBodies:

            bodyName = body.name
            bodyName = bodyName.replace("(1)", "").strip()

            # Skip mismatching files if filter specified
            if len(filter) > 0 and bodyName.find(filter) == -1:
                continue

            exportBodyName = bodyName

            # Translate to Origin, help avoid exported model being way way off the print plate
            # .boundingBox BoundingBox3D https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-9ce5053e-72b6-4a47-8172-e4223fb4caff
            # body.boundingBox not used until if/when needed.

            # Found valid rotation expression in the body name?
            if (bodyName.find("(") > 0 and bodyName.find(")") > 0 and
                bodyName.find("(") < bodyName.find(")") and 
                len(bodyName.split("(")[1].replace(")","").strip().split(",")) == 3):
                
                bodyParts = bodyName.split("(")
                exportBodyName = bodyParts[0].strip()
                rotateExprs = bodyParts[1].replace(")","").strip().split(",")
                logger.print(f"Rotating {bodyName}, transform... x: {rotateExprs[0]}, y: {rotateExprs[1]}, z: {rotateExprs[2]}")

                for iterAxis in range(3):

                    rotationDeg = int(rotateExprs[iterAxis])

                    if (rotationDeg == 0):
                        continue

                    rotationRad = rotationDeg * pi / 180.0

                    # Create a collection of entities for move
                    itemsToMove = adsk.core.ObjectCollection.create()
                    itemsToMove.add(body)

                    if iterAxis == 0:
                        axisVector = rootComp.xConstructionAxis.geometry.getData()[2]
                    elif iterAxis == 1:
                        axisVector = rootComp.yConstructionAxis.geometry.getData()[2]
                    else:
                        axisVector = rootComp.zConstructionAxis.geometry.getData()[2]

                    # Create a transform to do move
                    # Matrix3D https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-b831d9f4-c231-4b9f-9b4d-658614ecdc79
                    # setToRotation https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-d2e83d0b-781c-4faf-91ff-6cd31cc2174d
                    # yConstructionAxis is ConstructionAxis https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-ae6c0cf2-2de7-4c57-9a98-0362d80f2b30
                    # geometry is InfiniteLine3D  https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-fa75390c-8a5d-4b56-b562-7e3538cb9dbc
                    # getDate()[2] is direction Vector3D
                    transform = adsk.core.Matrix3D.create()
                    transform.setToRotation(
                        rotationRad,
                        axisVector,
                        rootComp.originConstructionPoint.geometry)

                    # Create a move feature
                    # Features Object https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-7bfd8596-4584-48b6-8b9b-1ea63e304d34
                    # .moveFeatures prop https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-cfe13494-2912-4625-bdce-c182a59ae21a
                    # MoveFeatures Object https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-12b98475-8e53-4427-aa87-05f8c8095ad2
                    moveFeats = comp.features.moveFeatures

                    moveFeatureInput = moveFeats.createInput(itemsToMove, transform)
                    
                    # .add returns MoveFeature https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-3e28e5d9-0aaa-46fd-8a80-c118012d3168
                    newMoveFeature = moveFeats.add(moveFeatureInput)

                    tempTransforms.append(newMoveFeature)

            # Export .STL
            fileName = targetFolder + exportBodyName + ".stl"
            options = exportMgr.createSTLExportOptions(body, fileName)
            exportMgr.execute(options)

            # Want to export .STEP files?
            # stepFileName = targetFolder + comp.name + ".step"
            # options = exportMgr.createSTEPExportOptions(stepFileName, comp)

            # Want to export to other formats?  See https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-d1462fe6-fd43-11e4-b6b4-f8b156d7cd97

            # Undo temporary transforms...
            for transform in reversed(tempTransforms):
                
                # deleteMe() https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-850bf987-aa26-42f5-9f16-f31c0a6cd99f
                transform.deleteMe()

            tempTransforms.clear()

            logger.print("Exported " + fileName)

        currExportCount += 1

    logger.print("Done!")
    ui.messageBox('Export Done!')