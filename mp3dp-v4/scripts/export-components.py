import adsk.core, adsk.fusion, adsk.cam


# TODO: Implement support for orienting parts for printing. e.g. parse notes/comment for transform.  Or, maybe only export models explicitly named with export prefix?
# TODO: Implement nested component search, could use allOccurrences, but would need smarter logic to exclude tiny parts not intended to be printed e.g. Hemera gears and nuts.
# 
# Resources:
# - STLExport API Sample https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-ECA8A484-7EDD-427D-B1E3-BD59A646F4FA
# - UI Logger https://modthemachine.typepad.com/my_weblog/2021/03/log-debug-messages-in-fusion-360.html

targetFolder = "c:\\git\\v1engineering-mods\\mp3dp-v4\\models\\" 
excludes = [ "(1)", "(2)", "Frame", "MGN12H", "12H Block", "HEMERA" ]
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

    # app.activeProduct returns Design instance (a subclass, derived from Product)
    # Product https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-c1fb15c9-0117-4666-a8c3-2dd305f7f6ac
    # Design https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-GUID-GUID-GUID-5e0f5e8e-0ec0-4ee7-b827-0ec8da882bee
    design = app.activeProduct

    # Get the root component of the active design.
    # design.rootComponent https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-ce33611e-ba91-484d-88b1-8eb2cec47be2
    # Component https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-GUID-GUID-GUID-GUID-b56b394e-b9c9-4403-a78b-a186b897909c
    rootComp = design.rootComponent

    # Get all the occurrences in the root component.
    occurrences = rootComp.occurrences 

    # Export each component as a STEP file.
    currExportCount = 0
    for occ in occurrences:
        if not occ.isLightBulbOn:
            continue

        if currExportCount >= maxExportCount:
            break

        comp = occ.component

        # or comp.parentComponent.name.find(exclude) != -1 
        if any(comp.name.find(exclude) != -1 for exclude in excludes):
            continue

        exportMgr = design.exportManager
        fileName = targetFolder + comp.name + ".stl"
        options = exportMgr.createSTLExportOptions(occ, fileName)

        # Want to export .STEP files?
        # stepFileName = targetFolder + comp.name + ".step"
        # options = exportMgr.createSTEPExportOptions(stepFileName, comp)

        # Want to export to other formats?  See https://help.autodesk.com/view/fusion360/ENU/?guid=GUID-d1462fe6-fd43-11e4-b6b4-f8b156d7cd97

        exportMgr.execute(options)
        logger.print("Exported " + fileName)
        currExportCount += 1

