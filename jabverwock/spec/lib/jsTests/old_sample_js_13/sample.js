	 /**
	  * spanエレメント(オブジェクト)追加
	  */
		
	 function displayString_createElement() {
	     var o = document.createElement("span");
	     o.setAttribute("id", "js_koneta_01-01");
	     o.innerHTML     = "JavaScript万歳！";
	     o.style.cssText = "font-weight: bold;"
			     + "font-size: 12pt"
			     + "color: #00ff00";
	     document.getElementById("js_koneta_01").appendChild(o);
	 }

	 /**
	  * imgエレメント(オブジェクト)追加
	  */
	 function displayImage_createElement() {
	     var o = document.createElement("img");
	     o.setAttribute("id", "js_koneta_01-01");
	     o.setAttribute("src", "images/js/analysis_back.jpg");
	     document.getElementById("js_koneta_01").appendChild(o);
	 }

	 /**
	  * エレメント(オブジェクト)消去
	  */
	 function deleteElement_createElement() {
	     o = document.getElementById("js_koneta_01-01");
	     document.getElementById("js_koneta_01").removeChild(o);
	 }
