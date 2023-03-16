import adsk.core, adsk.fusion, adsk.cam
import os

# NOTES:
# - Searches all descendants, since some frames/rails are nested deeper than immediate children.

# Filter used to only export parts containing this expression in the Body name.   Usually used when
# wanting to quickly figure out rotation expression for a specific part, without having to export 
# everything.
bodyFilters = [ "Frame", "MGN12" ]
paramFilters = ["Usable"]

# Body names containing these substrings will NOT be exported.
componentExcludes = []  # "HEMERA", "12H Block", "(1)", "(2)", "Frame", "MGN12H",

# Maximum files to export.  Implemented as safe guard, since haven't figured out how to cancel 
# running script without killing the app.
maxExportCount = 100

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

    # Get occurrences in the root component.
    occurrences = rootComp.allOccurrences  # occurrences 

    foundItems = []

    logger.print("")
    logger.print("")
    logger.print("USER PARAMETERS:")

    # Design.userParameters https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-ba26f8cd-6136-44a8-81fe-b133198cfa2d
    # - design.userParameters is not returning favorites
    # UserParameters Object https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-b20ca304-13b8-442b-83cf-4acc51ff710f
    # UserParameter Object https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-3b28328a-25ef-4add-8e31-38626060ca87
    # Sample Set parameters https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-1c19f064-fdf0-11e4-a863-f8b156d7cd97
    foundParams = []
    for userParameter in design.userParameters:

        if len(paramFilters) > 0 and not any(userParameter.name.find(filter) != -1 for filter in paramFilters):
            continue

        foundParams.append(f"{userParameter.name} = {str(userParameter.value)}")

    foundParams.sort()
    for foundParam in foundParams:
        logger.print(f" - {foundParam}")
    
    logger.print("")
    logger.print(f"PARTS:")

    # Export each component as a STEP file.
    currExportCount = 0
    for occ in occurrences:
        if not occ.isLightBulbOn:
            continue

        if currExportCount >= maxExportCount:
            break

        comp = occ.component

        if any(comp.name.find(exclude) != -1 for exclude in componentExcludes):
            continue


        # BRepBody https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-9910880d-2299-4947-917a-39b5f030eef4
        for body in comp.bRepBodies:

            bodyName = body.name
            bodyName = bodyName.replace("(1)", "").strip()

            # Skip mismatching files if filter specified
            if len(bodyFilters) > 0 and not any(bodyName.find(filter) != -1 for filter in bodyFilters):
                continue

            
            # body.boundingBox BoundingBox3D https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-9ce5053e-72b6-4a47-8172-e4223fb4caff
            # minPoint|maxPoint Point3D https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-c49e1ed5-7221-49a4-abc9-81e7beb2e51d
            boundingBox = body.boundingBox
            minPt = boundingBox.minPoint
            maxPt = boundingBox.maxPoint

            dx = round(maxPt.x - minPt.x, 2)
            dy = round(maxPt.y - minPt.y, 2)
            dz = round(maxPt.z - minPt.z, 2)
            length = max(dx, dy, dz)

            foundItems.append(
                str(
                f"{bodyName} " +
                # f", min: {round(minPt.x, 2)}, {round(minPt.y, 2)}, {round(minPt.z, 2)}" +
                # f", max: {round(maxPt.x, 2)}, {round(maxPt.y, 2)}, {round(maxPt.z, 2)}" +
                # f", dims: {round(dx, 2)}, {round(dy, 2)}, {round(dz, 2)}"
                f", length: {round(length, 2)}"
            ));

    foundItems.sort()
    for foundItem in foundItems:
        logger.print(" - " + foundItem)

    logger.print("Done!")
    # ui.messageBox('Export Done!')

