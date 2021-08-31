!function(e,t){"object"==typeof exports&&"object"==typeof module?module.exports=t():"function"==typeof define&&define.amd?define([],t):"object"==typeof exports?exports.bulmaTagsinput=t():e.bulmaTagsinput=t()}("undefined"!=typeof self?self:this,function(){return function(n){var i={};function r(e){if(i[e])return i[e].exports;var t=i[e]={i:e,l:!1,exports:{}};return n[e].call(t.exports,t,t.exports,r),t.l=!0,t.exports}return r.m=n,r.c=i,r.d=function(e,t,n){r.o(e,t)||Object.defineProperty(e,t,{configurable:!1,enumerable:!0,get:n})},r.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return r.d(t,"a",t),t},r.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},r.p="",r(r.s=0)}([function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var i=n(1),a=n(2),s=n(3),o=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var i in n)Object.prototype.hasOwnProperty.call(n,i)&&(e[i]=n[i])}return e},l=function(){function i(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}return function(e,t,n){return t&&i(e.prototype,t),n&&i(e,n),e}}();var r=function(e){function r(e){var t=1<arguments.length&&void 0!==arguments[1]?arguments[1]:{};!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,r);var n=function(e,t){if(!e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return!t||"object"!=typeof t&&"function"!=typeof t?e:t}(this,(r.__proto__||Object.getPrototypeOf(r)).call(this));if(n.element=s.a(e)?document.querySelector(e):e,!n.element)throw new Error("An invalid selector or non-DOM node has been provided.");return n._clickEvents=["click"],n.options=o({},a.a,t),n.element.dataset.hasOwnProperty("lowercase")&&(n.options.lowercase=n.element.dataset("lowercase")),n.element.dataset.hasOwnProperty("uppercase")&&(n.options.lowercase=n.element.dataset("uppercase")),n.element.dataset.hasOwnProperty("duplicates")&&(n.options.lowercase=n.element.dataset("duplicates")),n.init(),n}return function(e,t){if("function"!=typeof t&&null!==t)throw new TypeError("Super expression must either be null or a function, not "+typeof t);e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,enumerable:!1,writable:!0,configurable:!0}}),t&&(Object.setPrototypeOf?Object.setPrototypeOf(e,t):e.__proto__=t)}(r,i["a"]),l(r,[{key:"init",value:function(){if(!this.options.disabled){this.tags=[],this.container=document.createElement("div"),this.container.className="tagsinput",this.container.classList.add("field"),this.container.classList.add("is-grouped"),this.container.classList.add("is-grouped-multiline"),this.container.classList.add("input");var e=this.element.getAttribute("type");e&&"tags"!==e||(e="text"),this.input=document.createElement("input"),this.input.setAttribute("type",e),this.element.getAttribute("placeholder")?this.input.setAttribute("placeholder",this.element.getAttribute("placeholder")):this.input.setAttribute("placeholder","Add a Tag"),this.container.appendChild(this.input);var t=this.element.nextSibling;this.element.parentNode[t?"insertBefore":"appendChild"](this.container,t),this.element.style.cssText="position:absolute;left:0;top:0;width:1px;height:1px;opacity:0.01;",this.element.tabIndex=-1,this.enable()}}},{key:"enable",value:function(){var s=this;this.enabled||this.options.disabled||(this.element.addEventListener("focus",function(){s.container.classList.add("is-focused"),s.select(Array.prototype.slice.call(s.container.querySelectorAll(".tag:not(.is-delete)")).pop())}),this.input.addEventListener("focus",function(){s.container.classList.add("is-focused"),s.select(Array.prototype.slice.call(s.container.querySelectorAll(".tag:not(.is-delete)")).pop())}),this.input.addEventListener("blur",function(){s.container.classList.remove("is-focused"),s.select(Array.prototype.slice.call(s.container.querySelectorAll(".tag:not(.is-delete)")).pop()),s.savePartial()}),this.input.addEventListener("keydown",function(e){var t=e.charCode||e.keyCode||e.which,n=void 0,i=s.container.querySelector(".tag.is-active"),r=Array.prototype.slice.call(s.container.querySelectorAll(".tag:not(.is-delete)")).pop(),a=s.caretAtStart(s.input);if(i&&(n=s.container.querySelector('[data-tag="'+i.innerHTML.trim()+'"]')),s.setInputWidth(),13===t||t===s.options.delimiter.charCodeAt(0)||188===t||9===t){if(!s.input.value&&(t!==s.options.delimiter.charCodeAt(0)||188===t))return;s.savePartial()}else if(46===t&&n)n.nextSibling?s.select(n.nextSibling.querySelector(".tag")):n.previousSibling&&s.select(n.previousSibling.querySelector(".tag")),s.container.removeChild(n),s.tags.splice(s.tags.indexOf(n.getAttribute("data-tag")),1),s.setInputWidth(),s.save();else if(8===t)if(n)n.previousSibling?s.select(n.previousSibling.querySelector(".tag")):n.nextSibling&&s.select(n.nextSibling.querySelector(".tag")),s.container.removeChild(n),s.tags.splice(s.tags.indexOf(n.getAttribute("data-tag")),1),s.setInputWidth(),s.save();else{if(!r||!a)return;s.select(r)}else if(37===t)if(n)n.previousSibling&&s.select(n.previousSibling.querySelector(".tag"));else{if(!a)return;s.select(r)}else{if(39!==t)return s.select();if(!n)return;s.select(n.nextSibling.querySelector(".tag"))}return e.preventDefault(),!1}),this.input.addEventListener("input",function(){s.element.value=s.getValue(),s.element.dispatchEvent(new Event("input"))}),this.input.addEventListener("paste",function(){return setTimeout(savePartial,0)}),this.container.addEventListener("mousedown",function(e){s.refocus(e)}),this.container.addEventListener("touchstart",function(e){s.refocus(e)}),this.savePartial(this.element.value),this.enabled=!0)}},{key:"disable",value:function(){this.enabled&&!this.options.disabled&&(this.reset(),this.enabled=!1)}},{key:"select",value:function(e){var t=this.container.querySelector(".is-active");t&&t.classList.remove("is-active"),e&&e.classList.add("is-active")}},{key:"addTag",value:function(e){var a=this;if(~e.indexOf(this.options.delimiter)&&(e=e.split(this.options.delimiter)),Array.isArray(e))return e.forEach(function(e){a.addTag(e)});var t=e&&e.trim();if(!t)return!1;if("true"==this.options.lowercase&&(t=t.toLowerCase()),"true"==this.options.uppercase&&(t=t.toUpperCase()),this.options.duplicates||-1===this.tags.indexOf(t)){this.tags.push(t);var n=document.createElement("div");n.className="control",n.setAttribute("data-tag",t);var i=document.createElement("div");i.className="tags",i.classList.add("has-addons");var r=document.createElement("span");if(r.className="tag",r.classList.add("is-active"),this.select(r),r.innerHTML=t,i.appendChild(r),this.options.allowDelete){var s=document.createElement("a");s.className="tag",s.classList.add("is-delete"),this._clickEvents.forEach(function(e){s.addEventListener(e,function(e){var t=void 0,n=e.target.parentNode,i=Array.prototype.slice.call(a.container.querySelectorAll(".tag")).pop(),r=a.caretAtStart(a.input);if(n&&(t=a.container.querySelector('[data-tag="'+n.innerText.trim()+'"]')),t)a.select(t.previousSibling),a.container.removeChild(t),a.tags.splice(a.tags.indexOf(t.getAttribute("data-tag")),1),a.setInputWidth(),a.save();else{if(!i||!r)return;a.select(i)}})}),i.appendChild(s)}n.appendChild(i),this.container.insertBefore(n,this.input)}}},{key:"getValue",value:function(){return this.tags.join(this.options.delimiter)}},{key:"setValue",value:function(e){var t=this;Array.prototype.slice.call(this.container.querySelectorAll(".tag")).forEach(function(e){t.tags.splice(t.tags.indexOf(e.innerHTML),1),t.container.removeChild(e)}),this.savePartial(e)}},{key:"setInputWidth",value:function(){var e=Array.prototype.slice.call(this.container.querySelectorAll(".control")).pop();this.container.offsetWidth&&(this.input.style.width=Math.max(this.container.offsetWidth-(e?e.offsetLeft+e.offsetWidth:30)-30,this.container.offsetWidth/4)+"px")}},{key:"savePartial",value:function(e){"string"==typeof e||Array.isArray(e)||(e=this.input.value),!1!==this.addTag(e)&&(this.input.value="",this.save(),this.setInputWidth())}},{key:"save",value:function(){this.element.value=this.tags.join(this.options.delimiter),this.element.dispatchEvent(new Event("change"))}},{key:"caretAtStart",value:function(t){try{return 0===t.selectionStart&&0===t.selectionEnd}catch(e){return""===t.value}}},{key:"refocus",value:function(e){return e.target.classList.contains("tag")&&this.select(e.target),e.target===this.input?this.select():(this.input.focus(),e.preventDefault(),!1)}},{key:"reset",value:function(){this.tags=[]}},{key:"destroy",value:function(){this.disable(),this.reset(),this.element=null}}],[{key:"attach",value:function(){var e=0<arguments.length&&void 0!==arguments[0]?arguments[0]:'input[type="tags"]',t=1<arguments.length&&void 0!==arguments[1]?arguments[1]:{},n=new Array,i=document.querySelectorAll(e);return[].forEach.call(i,function(e){setTimeout(function(){n.push(new r(e,t))},100)}),n}}]),r}();t.default=r},function(e,t,n){"use strict";var i=function(){function i(e,t){for(var n=0;n<t.length;n++){var i=t[n];i.enumerable=i.enumerable||!1,i.configurable=!0,"value"in i&&(i.writable=!0),Object.defineProperty(e,i.key,i)}}return function(e,t,n){return t&&i(e.prototype,t),n&&i(e,n),e}}();var r=function(){function t(){var e=0<arguments.length&&void 0!==arguments[0]?arguments[0]:[];!function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}(this,t),this._listeners=new Map(e),this._middlewares=new Map}return i(t,[{key:"listenerCount",value:function(e){return this._listeners.has(e)?this._listeners.get(e).length:0}},{key:"removeListeners",value:function(){var t=this,e=0<arguments.length&&void 0!==arguments[0]?arguments[0]:null,n=1<arguments.length&&void 0!==arguments[1]&&arguments[1];null!==e?Array.isArray(e)?name.forEach(function(e){return t.removeListeners(e,n)}):(this._listeners.delete(e),n&&this.removeMiddleware(e)):this._listeners=new Map}},{key:"middleware",value:function(e,t){var n=this;Array.isArray(e)?name.forEach(function(e){return n.middleware(e,t)}):(Array.isArray(this._middlewares.get(e))||this._middlewares.set(e,[]),this._middlewares.get(e).push(t))}},{key:"removeMiddleware",value:function(){var t=this,e=0<arguments.length&&void 0!==arguments[0]?arguments[0]:null;null!==e?Array.isArray(e)?name.forEach(function(e){return t.removeMiddleware(e)}):this._middlewares.delete(e):this._middlewares=new Map}},{key:"on",value:function(e,t){var n=this,i=2<arguments.length&&void 0!==arguments[2]&&arguments[2];if(Array.isArray(e))e.forEach(function(e){return n.on(e,t)});else{var r=(e=e.toString()).split(/,|, | /);1<r.length?r.forEach(function(e){return n.on(e,t)}):(Array.isArray(this._listeners.get(e))||this._listeners.set(e,[]),this._listeners.get(e).push({once:i,callback:t}))}}},{key:"once",value:function(e,t){this.on(e,t,!0)}},{key:"emit",value:function(n,i){var r=this,a=2<arguments.length&&void 0!==arguments[2]&&arguments[2];n=n.toString();var s=this._listeners.get(n),o=null,l=0,c=a;if(Array.isArray(s))for(s.forEach(function(e,t){a||(o=r._middlewares.get(n),Array.isArray(o)?(o.forEach(function(e){e(i,function(){var e=0<arguments.length&&void 0!==arguments[0]?arguments[0]:null;null!==e&&(i=e),l++},n)}),l>=o.length&&(c=!0)):c=!0),c&&(e.once&&(s[t]=null),e.callback(i))});-1!==s.indexOf(null);)s.splice(s.indexOf(null),1)}}]),t}();t.a=r},function(e,t,n){"use strict";t.a={disabled:!1,delimiter:",",allowDelete:!0,lowercase:!1,uppercase:!1,duplicates:!0}},function(e,t,n){"use strict";n.d(t,"a",function(){return r});var i="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(e){return typeof e}:function(e){return e&&"function"==typeof Symbol&&e.constructor===Symbol&&e!==Symbol.prototype?"symbol":typeof e},r=function(e){return"string"==typeof e||!!e&&"object"===(void 0===e?"undefined":i(e))&&"[object String]"===Object.prototype.toString.call(e)}}]).default});