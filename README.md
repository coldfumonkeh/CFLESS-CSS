LESS CSS Processor for ColdFusion Builder
============

This extension was written at the cf.Objective() 2012 ColdFusion conference.
Following a presentation on LESS CSS from Nathan Strutz, I wanted to create an easy way to process LESS files from any ColdFusion Builder project location.

This extension will process and convert the files into production-ready .css files ready for deployment. It retains the original .less files for continual development.


Installation
============

Download the project from the github repository (or clone / pull the project) and place the files within your ColdFusion server webroot.

Launch ColdFusion Builder and open the extensions view panel if not already open. 
Press the 'Import Extension from folder' button. Navigate to the location of the extension and follow the simple installation wizard.


Usage
=====

To run the CFLESS processor, right-click on the directory in the project view within which the .less files are located.
Select 'CFLESS Style Processor -> Process style sheets' from the context menu.

The extension will query all directories recursively starting from the directory you selected. All .less files discovered will automatically be converted into .css files and saved in the same location.

You will be presented with a dialog window after completion to show you how many files were discovered and the location of the converted .css files.


Compatibility
=============

This extension is compatible with all versions of ColdFusion Builder.

The extension has been tested on Adobe ColdFusion 9.


Revision History
================

### 1.0 - May 19th, 2012###
 
- Commit: Initial extension