---
title: Rails validation form
author: Leo
date: '2021-03-28 23:29:00 +0700'
categories:
- Fullstack
- Rails
- Validation
tags:
- rails
- html
- javascript
---

## By HTML5 and Javascript 
eg, a submit form  
Using setCustomValidity function by default js and  `oninput="checkPasscode();` , `required` on input field.
```html
<form>
	<label for="passcode">Enter Passcode:</label>
	<input id="passcode" 
		   type="password" 
		   placeholder="Your passcode" 
		   oninput="checkPasscode();"
		   required/>
	<button type="submit">Submit</button>
</form>
```
```js
function checkPasscode() {
	var passcode_input = document.querySelector("#passcode");
	
	if (passcode_input.value != "Ivy") {
		passcode_input.setCustomValidity("Wrong. It's 'Ivy'.");
	} else {
		passcode_input.setCustomValidity(""); // be sure to leave this empty!
		alert("Correct!");
	}
}
```
