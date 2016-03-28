Created for Alter Group by SanBeaman 2013 -  2014 

Shell Version Revision:
		 * v10.61 fixed an issue with bodyAnim sequencing and timeiming
		 *  v10.61 added some code to better work on  review server and show both end slides
		 * v10.60 merging MYSCORM.as from SCF's branch and edits to the SHELL for launch in SABA
		 * v10.52 made cahnges so the done button & Start button would advance to next SCO in ReviewShell, use cashell.html NOT cashell_lms.html
		 *  v10.51  minor layout tweeks added a SectionTitle text length to accomodate huge russian titles in ASCE
		 * v10.50  minor layout tweeks for long lang and SABA (Still need to work on SectionHEader)
		 * 	 v10.49 switched sectionHeader change event to target.... _sectionHeader:SectionHeader NOT _sectionSceneHeader:HeaderSectionScene, need to combine so Welcome 2chrysler dont break
		 * v10.48 started ASCE Arabic, added _layoutModifier to SceneBase and BodyUI, to hopefully allow RTL layouts to flip 'slideRight' to 'slideLeft' and vice versa 
		 * as opposed to hardcoding the change in the CML which is what I had to do for RPSS arabic
		 * v10.47 removed assets from Flash Library and added answerCorrect.mp3 and answerWrong.mp3 to the template.xml, and simplified how bitmaps are loaded in the template loader.
		 * 			changed the _mainLoaderMax.replaceURLText("{imgdir}",mpath,true); to onINit and use the loaderarray instead of looking for specific loaders
		 *   !!!!!!!!!!!!! make sure audio folder is added to assets folder and template.xml and manifest are changed to reflect new assets
		 * v10.46 fixed xml loader so it won't error when it doesn't find speical loaders, added default bodyImage paramters to template xml, also removed bodyIcon just have to add style="none"
		 * v10.45 saba versions of Wecome to chrysler
		 * v10.44 added a prelaoder for timeline coverflow
		 * v10.44 some adjustments to c2r for saba
		 * v10.43 added _sectionComplete pass thru to SceneBase in order to disable Start Button if user returns (needed to simplify manifest between saba and lat
		 * v10.42 modified preloader, fixed issue with hasSceneMenu and navbarmenu scene types
		 * v10.41 clean up minor issues during export for production steps
		 * v10.40 extras for text direction and starting media sync
		 * v10.30 added landID and textDirection and tightened up margins
		 * v10.23 in Sandbox for second review
		 * v10.22 created a more flexible rateSlider Thumb class, and fixed trackOver scaling
		 * v10.21 fixed the Printview on the TextArea Dragrate SlideType
		 * v10.20 more optimization and external asset laoding
		 * v10.16 comnined shell loading into new TemplateLoader Class, so 1 shell can open a course and langugae based on flashvars and xml
		 * 			-also added non embedded image preloader
		 * v10.16 fixed bodyButtons, changed shellcontroller to sID to sNUmbernot id
		 * v10.15 added splash and review shell to load new sections even if outside LMS
		 * v10.13 rewrote layout so it'smore consistent margin , xPad, yPad...
		 * v10.01 added lots.... most still in Dev
		 * 			animType to slide node: timesync = timeIn and timeOut (like shell_ca) animsync =  appends tweens in sequence.
		 * 			trimming down 'UI types' BodyImage, BodyBUllet, BodyBulletCol.... 
		 * 			removed xLoc and yLoc, need to check if x = string, use relative layout, else use number
		 * 			incorporated SlidePlayer 
		 * 			Added Resource Class to dynamically change Button assets based on template CODe
		 * 			XML has templte code to set overall style of course
		 * 			 
		 * v9.2 added two types of sync animations, to accomdate items that animate at same time  added unfinished textarea input
		 * v9.1 added SceneHolder to differentiat between GPS interface and new ones
		 *  v9.0 Major changes to allow Shell to work with different courses, changes to XML Section .
		 *  v8.7 added a box for the Done and next pulse state along withglow.
		 *
		 * v8.6 changed the COmplete And EXit Button to continue instead of exit ALL and see if postRule Action will complete course
		 * v8.3 changed it so MarkAllComplete happens independent of exitAll
		 * v8.1 changed MYSCORM to have special completeAndExit SCORM call
		 * 
		 * 
