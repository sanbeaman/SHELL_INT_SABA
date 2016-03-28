var CourseUtils = function() {};

CourseUtils.prototype = function() {
	var	setCurrentPassed = function(passed) {
			var sSuccess = passed ? "passed" : "unknown";
			var sCompletion = passed ? "completed" : "incomplete";
			storeDataValue("cmi.success_status", sSuccess); // these are in utils/APIWrapper.js
			storeDataValue("cmi.completion_status", sCompletion);
			storeDataValue("cmi.exit", passed?"normal":"suspend");  //SCF - changed from suspend to normal exit if passed
			persistData();
			return true;
		},

		goNext = function() {
			storeDataValue("adl.nav.request", "continue"); // these are in utils/APIWrapper.js
			terminateCommunication();
		},

		getCourseTitle = function() {
			try {
				var xmlDoc = loadXml(getCourseBaseUrl() + "imsmanifest.xml");
				return xmlDoc.getElementsByTagName("organization")[0].getElementsByTagName("title")[0].firstChild.nodeValue;
			} catch(e) {
				return "";
			}
		},

		getLearnerName = function() {
			return retrieveDataValue("cmi.learner_name"); // this is in utils/APIWrapper.js
		},

		loadXml = function(xmlFile) {
			var xhttp = createXmlHttp();
			xhttp.open("GET",xmlFile,false);
			xhttp.send();

			return xhttp.responseXML;
		},

		getCourseBaseUrl = function() {
			var xmlhttp = createXmlHttp();
			if (xmlhttp == null) return "";
			var host = document.location.host;
			var protocol = document.location.protocol;
			var paths = document.location.pathname.split("/");
			var found = false;

			while (paths.length > 1)
			{
				paths.pop();
				var tmp = protocol + "//" + host + paths.join("/");
				xmlhttp.open("HEAD", tmp + "/imsmanifest.xml" + "?_=" + Math.random(), false);
				xmlhttp.send(null);
				found = xmlhttp.readyState == 4 && xmlhttp.status == 200;
				if (found)
				{
					return tmp + "/";
				}
			}
			return "";
		},

		createXmlHttp = function() {
			var xmlHttp = null;

			try	{
				// Firefox, Opera 8.0+, Safari
				xmlHttp = new XMLHttpRequest();
			} catch (e) {
				// Internet Explorer
				try	{
					xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {}
				}
			}
			return xmlHttp;
		},

		loadJSON = function(jsonFile) {
			var xhttp = createXmlHttp();
			xhttp.open("GET", jsonFile, false);
			xhttp.send();
			return xhttp.responseText;
		},

		parseQuery = function()
		{
			var qstr = document.location.search.substring(1);
			var query = {};
			var a = qstr.split('&');
			for (var i in a)
			{
				var b = a[i].split('=');
				query[decodeURIComponent(b[0])] = decodeURIComponent(b[1]);
			}
			return query;
		}


	return {
	    setCurrentPassed: setCurrentPassed,
	    parseQuery: parseQuery,
		goNext: goNext,
		getCourseTitle: getCourseTitle,
		getLearnerName: getLearnerName,
		loadJSON: loadJSON
	};
} ();

var cu = new CourseUtils();
