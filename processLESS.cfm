<!---
	Author: Matt Gifford (@coldfumonkeh)
	Date: 19th May, 2012
	Name: processLess.cfm
	Purpose: The CFLESS CFBuilder extension handler file
--->
<cfparam name="ideEventInfo" default="" />

<cfscript>
	xmldoc 					= xmlParse(ideeventinfo);
	response 				= xmlSearch(xmldoc,"//resource");	
	projectFolderLocation 	= response[1].XmlAttributes.path;

	thisPath = getDirectoryFromPath(getCurrentTemplatePath());
    loadPaths = ArrayNew(1);
    arrayAppend(loadPaths, thisPath & "lesscss-engine-1.1.4.jar");
    loader = createObject("component", "javaloader.JavaLoader").init(loadPaths, 'true');
    engine = loader.create("com.asual.lesscss.LessEngine").init();
    arrDetails = [];
</cfscript>

<cfdirectory directory="#projectFolderLocation#" recurse="yes" name="rstLessFiles" sort="directory asc" filter="*.less">

<cfif rstLessFiles.recordcount>

<cfoutput>

<cfloop query="rstLessFiles">
	
	<cfset FileName  = REReplaceNoCase(name, '(?:\.(?:less))?$', "") />
	<cfset FileName = FileName & '.css' />
	
	<cffile action="read" file="#projectFolderLocation#/#name#" variable="inputLESS" />
	<cfset outputCSS = engine.compile(inputLESS) />
	<cffile action="write" file="#projectFolderLocation#/#FileName#" output="#outputCSS#" />
	
	<cfset stuFileDetails = structNew() />
	<cfset stuFileDetails['originalPath'] = projectFolderLocation & '/' & name />
	<cfset stuFileDetails['processedPath'] = projectFolderLocation & '/' & FileName />
	
	<cfset arrayAppend(arrDetails,stuFileDetails) />

</cfloop>

</cfoutput>

</cfif>

<cfheader name="Content-Type" value="text/xml">
<response showresponse="yes">
	<ide>
		<dialog width="500" height="400" /> 
		<body> 
		<![CDATA[ 
		<cfoutput>
		<cfif arraylen(arrDetails)>
	
		<h2>The following #arraylen(arrDetails)# file/s were converted from LESS to CSS:</h2>
			
		<ul>
		<cfloop array="#arrDetails#" index="i">
			<li>#i['processedPath']#</li>
		</cfloop>
		</ul>
		
		</cfif>
		</cfoutput>
		]]> 
		</body>			
		<commands>		
			<command type="refreshproject"> 
				<params> 
					<param key="projectname" value="#projectFolderLocation#" /> 
				</params> 
			</command>
		</commands>
	</ide>
</response>