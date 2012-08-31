"no use strict";function initBaseUrls(e){require.tlns=e}function initSender(){var e=require(null,"ace/lib/event_emitter").EventEmitter,t=require(null,"ace/lib/oop"),n=function(){};return function(){t.implement(this,e),this.callback=function(e,t){postMessage({type:"call",id:t,data:e})},this.emit=function(e,t){postMessage({type:"event",name:e,data:t})}}.call(n.prototype),new n}var console={log:function(e){postMessage({type:"log",data:e})}},window={console:console},normalizeModule=function(e,t){if(t.indexOf("!")!==-1){var n=t.split("!");return normalizeModule(e,n[0])+"!"+normalizeModule(e,n[1])}if(t.charAt(0)=="."){var r=e.split("/").slice(0,-1).join("/"),t=r+"/"+t;while(t.indexOf(".")!==-1&&i!=t)var i=t,t=t.replace(/\/\.\//,"/").replace(/[^\/]+\/\.\.\//,"")}return t},require=function(e,t){var t=normalizeModule(e,t),n=require.modules[t];if(n)return n.initialized||(n.initialized=!0,n.exports=n.factory().exports),n.exports;var r=t.split("/");r[0]=require.tlns[r[0]]||r[0];var i=r.join("/")+".js";return require.id=t,importScripts(i),require(e,t)};require.modules={},require.tlns={};var define=function(e,t,n){arguments.length==2?(n=t,typeof e!="string"&&(t=e,e=require.id)):arguments.length==1&&(n=e,e=require.id);if(e.indexOf("text!")===0)return;var r=function(t,n){return require(e,t,n)};require.modules[e]={factory:function(){var e={exports:{}},t=n(r,e.exports,e);return t&&(e.exports=t),e}}},main,sender;onmessage=function(e){var t=e.data;if(t.command)main[t.command].apply(main,t.args);else if(t.init){initBaseUrls(t.tlns),require(null,"ace/lib/fixoldbrowsers"),sender=initSender();var n=require(null,t.module)[t.classname];main=new n(sender)}else t.event&&sender&&sender._emit(t.event,t.data)},define("ace/lib/fixoldbrowsers",["require","exports","module","ace/lib/regexp","ace/lib/es5-shim"],function(e,t,n){e("./regexp"),e("./es5-shim")}),define("ace/lib/regexp",["require","exports","module"],function(e,t,n){function o(e){return(e.global?"g":"")+(e.ignoreCase?"i":"")+(e.multiline?"m":"")+(e.extended?"x":"")+(e.sticky?"y":"")}function u(e,t,n){if(Array.prototype.indexOf)return e.indexOf(t,n);for(var r=n||0;r<e.length;r++)if(e[r]===t)return r;return-1}var r={exec:RegExp.prototype.exec,test:RegExp.prototype.test,match:String.prototype.match,replace:String.prototype.replace,split:String.prototype.split},i=r.exec.call(/()??/,"")[1]===undefined,s=function(){var e=/^/g;return r.test.call(e,""),!e.lastIndex}();if(s&&i)return;RegExp.prototype.exec=function(e){var t=r.exec.apply(this,arguments),n,a;if(typeof e=="string"&&t){!i&&t.length>1&&u(t,"")>-1&&(a=RegExp(this.source,r.replace.call(o(this),"g","")),r.replace.call(e.slice(t.index),a,function(){for(var e=1;e<arguments.length-2;e++)arguments[e]===undefined&&(t[e]=undefined)}));if(this._xregexp&&this._xregexp.captureNames)for(var f=1;f<t.length;f++)n=this._xregexp.captureNames[f-1],n&&(t[n]=t[f]);!s&&this.global&&!t[0].length&&this.lastIndex>t.index&&this.lastIndex--}return t},s||(RegExp.prototype.test=function(e){var t=r.exec.call(this,e);return t&&this.global&&!t[0].length&&this.lastIndex>t.index&&this.lastIndex--,!!t})}),define("ace/lib/es5-shim",["require","exports","module"],function(e,t,n){function v(e){try{return Object.defineProperty(e,"sentinel",{}),"sentinel"in e}catch(t){}}Function.prototype.bind||(Function.prototype.bind=function(t){var n=this;if(typeof n!="function")throw new TypeError;var r=o.call(arguments,1),i=function(){if(this instanceof i){var e=function(){};e.prototype=n.prototype;var s=new e,u=n.apply(s,r.concat(o.call(arguments)));return u!==null&&Object(u)===u?u:s}return n.apply(t,r.concat(o.call(arguments)))};return i});var r=Function.prototype.call,i=Array.prototype,s=Object.prototype,o=i.slice,u=r.bind(s.toString),a=r.bind(s.hasOwnProperty),f,l,c,h,p;if(p=a(s,"__defineGetter__"))f=r.bind(s.__defineGetter__),l=r.bind(s.__defineSetter__),c=r.bind(s.__lookupGetter__),h=r.bind(s.__lookupSetter__);Array.isArray||(Array.isArray=function(t){return u(t)=="[object Array]"}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var n=_(this),r=arguments[1],i=0,s=n.length>>>0;if(u(t)!="[object Function]")throw new TypeError;while(i<s)i in n&&t.call(r,n[i],i,n),i++}),Array.prototype.map||(Array.prototype.map=function(t){var n=_(this),r=n.length>>>0,i=Array(r),s=arguments[1];if(u(t)!="[object Function]")throw new TypeError;for(var o=0;o<r;o++)o in n&&(i[o]=t.call(s,n[o],o,n));return i}),Array.prototype.filter||(Array.prototype.filter=function(t){var n=_(this),r=n.length>>>0,i=[],s=arguments[1];if(u(t)!="[object Function]")throw new TypeError;for(var o=0;o<r;o++)o in n&&t.call(s,n[o],o,n)&&i.push(n[o]);return i}),Array.prototype.every||(Array.prototype.every=function(t){var n=_(this),r=n.length>>>0,i=arguments[1];if(u(t)!="[object Function]")throw new TypeError;for(var s=0;s<r;s++)if(s in n&&!t.call(i,n[s],s,n))return!1;return!0}),Array.prototype.some||(Array.prototype.some=function(t){var n=_(this),r=n.length>>>0,i=arguments[1];if(u(t)!="[object Function]")throw new TypeError;for(var s=0;s<r;s++)if(s in n&&t.call(i,n[s],s,n))return!0;return!1}),Array.prototype.reduce||(Array.prototype.reduce=function(t){var n=_(this),r=n.length>>>0;if(u(t)!="[object Function]")throw new TypeError;if(!r&&arguments.length==1)throw new TypeError;var i=0,s;if(arguments.length>=2)s=arguments[1];else do{if(i in n){s=n[i++];break}if(++i>=r)throw new TypeError}while(!0);for(;i<r;i++)i in n&&(s=t.call(void 0,s,n[i],i,n));return s}),Array.prototype.reduceRight||(Array.prototype.reduceRight=function(t){var n=_(this),r=n.length>>>0;if(u(t)!="[object Function]")throw new TypeError;if(!r&&arguments.length==1)throw new TypeError;var i,s=r-1;if(arguments.length>=2)i=arguments[1];else do{if(s in n){i=n[s--];break}if(--s<0)throw new TypeError}while(!0);do s in this&&(i=t.call(void 0,i,n[s],s,n));while(s--);return i}),Array.prototype.indexOf||(Array.prototype.indexOf=function(t){var n=_(this),r=n.length>>>0;if(!r)return-1;var i=0;arguments.length>1&&(i=O(arguments[1])),i=i>=0?i:Math.max(0,r+i);for(;i<r;i++)if(i in n&&n[i]===t)return i;return-1}),Array.prototype.lastIndexOf||(Array.prototype.lastIndexOf=function(t){var n=_(this),r=n.length>>>0;if(!r)return-1;var i=r-1;arguments.length>1&&(i=Math.min(i,O(arguments[1]))),i=i>=0?i:r-Math.abs(i);for(;i>=0;i--)if(i in n&&t===n[i])return i;return-1}),Object.getPrototypeOf||(Object.getPrototypeOf=function(t){return t.__proto__||(t.constructor?t.constructor.prototype:s)});if(!Object.getOwnPropertyDescriptor){var d="Object.getOwnPropertyDescriptor called on a non-object: ";Object.getOwnPropertyDescriptor=function(t,n){if(typeof t!="object"&&typeof t!="function"||t===null)throw new TypeError(d+t);if(!a(t,n))return;var r,i,o;r={enumerable:!0,configurable:!0};if(p){var u=t.__proto__;t.__proto__=s;var i=c(t,n),o=h(t,n);t.__proto__=u;if(i||o)return i&&(r.get=i),o&&(r.set=o),r}return r.value=t[n],r}}Object.getOwnPropertyNames||(Object.getOwnPropertyNames=function(t){return Object.keys(t)}),Object.create||(Object.create=function(t,n){var r;if(t===null)r={__proto__:null};else{if(typeof t!="object")throw new TypeError("typeof prototype["+typeof t+"] != 'object'");var i=function(){};i.prototype=t,r=new i,r.__proto__=t}return n!==void 0&&Object.defineProperties(r,n),r});if(Object.defineProperty){var m=v({}),g=typeof document=="undefined"||v(document.createElement("div"));if(!m||!g)var y=Object.defineProperty}if(!Object.defineProperty||y){var b="Property description must be an object: ",w="Object.defineProperty called on non-object: ",E="getters & setters can not be defined on this javascript engine";Object.defineProperty=function(t,n,r){if(typeof t!="object"&&typeof t!="function"||t===null)throw new TypeError(w+t);if(typeof r!="object"&&typeof r!="function"||r===null)throw new TypeError(b+r);if(y)try{return y.call(Object,t,n,r)}catch(i){}if(a(r,"value"))if(p&&(c(t,n)||h(t,n))){var o=t.__proto__;t.__proto__=s,delete t[n],t[n]=r.value,t.__proto__=o}else t[n]=r.value;else{if(!p)throw new TypeError(E);a(r,"get")&&f(t,n,r.get),a(r,"set")&&l(t,n,r.set)}return t}}Object.defineProperties||(Object.defineProperties=function(t,n){for(var r in n)a(n,r)&&Object.defineProperty(t,r,n[r]);return t}),Object.seal||(Object.seal=function(t){return t}),Object.freeze||(Object.freeze=function(t){return t});try{Object.freeze(function(){})}catch(S){Object.freeze=function(t){return function(n){return typeof n=="function"?n:t(n)}}(Object.freeze)}Object.preventExtensions||(Object.preventExtensions=function(t){return t}),Object.isSealed||(Object.isSealed=function(t){return!1}),Object.isFrozen||(Object.isFrozen=function(t){return!1}),Object.isExtensible||(Object.isExtensible=function(t){if(Object(t)===t)throw new TypeError;var n="";while(a(t,n))n+="?";t[n]=!0;var r=a(t,n);return delete t[n],r});if(!Object.keys){var x=!0,T=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],N=T.length;for(var C in{toString:null})x=!1;Object.keys=function D(e){if(typeof e!="object"&&typeof e!="function"||e===null)throw new TypeError("Object.keys called on a non-object");var D=[];for(var t in e)a(e,t)&&D.push(t);if(x)for(var n=0,r=N;n<r;n++){var i=T[n];a(e,i)&&D.push(i)}return D}}if(!Date.prototype.toISOString||(new Date(-621987552e5)).toISOString().indexOf("-000001")===-1)Date.prototype.toISOString=function(){var t,n,r,i;if(!isFinite(this))throw new RangeError;t=[this.getUTCMonth()+1,this.getUTCDate(),this.getUTCHours(),this.getUTCMinutes(),this.getUTCSeconds()],i=this.getUTCFullYear(),i=(i<0?"-":i>9999?"+":"")+("00000"+Math.abs(i)).slice(0<=i&&i<=9999?-4:-6),n=t.length;while(n--)r=t[n],r<10&&(t[n]="0"+r);return i+"-"+t.slice(0,2).join("-")+"T"+t.slice(2).join(":")+"."+("000"+this.getUTCMilliseconds()).slice(-3)+"Z"};Date.now||(Date.now=function(){return(new Date).getTime()}),Date.prototype.toJSON||(Date.prototype.toJSON=function(t){if(typeof this.toISOString!="function")throw new TypeError;return this.toISOString()}),Date.parse("+275760-09-13T00:00:00.000Z")!==864e13&&(Date=function(e){var t=function i(t,n,r,s,o,u,a){var f=arguments.length;if(this instanceof e){var l=f==1&&String(t)===t?new e(i.parse(t)):f>=7?new e(t,n,r,s,o,u,a):f>=6?new e(t,n,r,s,o,u):f>=5?new e(t,n,r,s,o):f>=4?new e(t,n,r,s):f>=3?new e(t,n,r):f>=2?new e(t,n):f>=1?new e(t):new e;return l.constructor=i,l}return e.apply(this,arguments)},n=new RegExp("^(\\d{4}|[+-]\\d{6})(?:-(\\d{2})(?:-(\\d{2})(?:T(\\d{2}):(\\d{2})(?::(\\d{2})(?:\\.(\\d{3}))?)?(?:Z|(?:([-+])(\\d{2}):(\\d{2})))?)?)?)?$");for(var r in e)t[r]=e[r];return t.now=e.now,t.UTC=e.UTC,t.prototype=e.prototype,t.prototype.constructor=t,t.parse=function(r){var i=n.exec(r);if(i){i.shift();for(var s=1;s<7;s++)i[s]=+(i[s]||(s<3?1:0)),s==1&&i[s]--;var o=+i.pop(),u=+i.pop(),a=i.pop(),f=0;if(a){if(u>23||o>59)return NaN;f=(u*60+o)*6e4*(a=="+"?-1:1)}var l=+i[0];return 0<=l&&l<=99?(i[0]=l+400,e.UTC.apply(this,i)+f-126227808e5):e.UTC.apply(this,i)+f}return e.parse.apply(this,arguments)},t}(Date));var k="	\n\f\r   ᠎             　\u2028\u2029﻿";if(!String.prototype.trim||k.trim()){k="["+k+"]";var L=new RegExp("^"+k+k+"*"),A=new RegExp(k+k+"*$");String.prototype.trim=function(){return String(this).replace(L,"").replace(A,"")}}var O=function(e){return e=+e,e!==e?e=0:e!==0&&e!==1/0&&e!==-1/0&&(e=(e>0||-1)*Math.floor(Math.abs(e))),e},M="a"[0]!="a",_=function(e){if(e==null)throw new TypeError;return M&&typeof e=="string"&&e?e.split(""):Object(e)}}),define("ace/lib/event_emitter",["require","exports","module"],function(e,t,n){var r={};r._emit=r._dispatchEvent=function(e,t){this._eventRegistry=this._eventRegistry||{},this._defaultHandlers=this._defaultHandlers||{};var n=this._eventRegistry[e]||[],r=this._defaultHandlers[e];if(!n.length&&!r)return;t=t===Object(t)?t:{},t.type||(t.type=e),t.stopPropagation||(t.stopPropagation=function(){this.propagationStopped=!0}),t.preventDefault||(t.preventDefault=function(){this.defaultPrevented=!0});for(var i=0;i<n.length;i++){n[i](t);if(t.propagationStopped)break}if(r&&!t.defaultPrevented)return r(t)},r.setDefaultHandler=function(e,t){this._defaultHandlers=this._defaultHandlers||{};if(this._defaultHandlers[e])throw new Error("The default handler for '"+e+"' is already set");this._defaultHandlers[e]=t},r.on=r.addEventListener=function(e,t){this._eventRegistry=this._eventRegistry||{};var n=this._eventRegistry[e];n||(n=this._eventRegistry[e]=[]),n.indexOf(t)==-1&&n.push(t)},r.removeListener=r.removeEventListener=function(e,t){this._eventRegistry=this._eventRegistry||{};var n=this._eventRegistry[e];if(!n)return;var r=n.indexOf(t);r!==-1&&n.splice(r,1)},r.removeAllListeners=function(e){this._eventRegistry&&(this._eventRegistry[e]=[])},t.EventEmitter=r}),define("ace/lib/oop",["require","exports","module"],function(e,t,n){t.inherits=function(){var e=function(){};return function(t,n){e.prototype=n.prototype,t.super_=n.prototype,t.prototype=new e,t.prototype.constructor=t}}(),t.mixin=function(e,t){for(var n in t)e[n]=t[n]},t.implement=function(e,n){t.mixin(e,n)}}),define("ace/mode/json_worker",["require","exports","module","ace/lib/oop","ace/worker/mirror","ace/mode/json/json_parse"],function(e,t,n){var r=e("../lib/oop"),i=e("../worker/mirror").Mirror,s=e("./json/json_parse"),o=t.JsonWorker=function(e){i.call(this,e),this.setTimeout(200)};r.inherits(o,i),function(){this.onUpdate=function(){var e=this.doc.getValue();try{var t=s(e)}catch(n){var r=this.charToDocumentPosition(n.at-1);this.sender.emit("error",{row:r.row,column:r.column,text:n.message,type:"error"});return}this.sender.emit("ok")},this.charToDocumentPosition=function(e){var t=0,n=this.doc.getLength(),r=this.doc.getNewLineCharacter().length;if(!n)return{row:0,column:0};var i=0;while(t<n){var s=this.doc.getLine(t),o=s.length+r;if(i+o>e)return{row:t,column:e-i};i+=o,t+=1}return{row:t-1,column:s.length}}}.call(o.prototype)}),define("ace/worker/mirror",["require","exports","module","ace/document","ace/lib/lang"],function(e,t,n){var r=e("../document").Document,i=e("../lib/lang"),s=t.Mirror=function(e){this.sender=e;var t=this.doc=new r(""),n=this.deferredUpdate=i.deferredCall(this.onUpdate.bind(this)),s=this;e.on("change",function(e){t.applyDeltas([e.data]),n.schedule(s.$timeout)})};(function(){this.$timeout=500,this.setTimeout=function(e){this.$timeout=e},this.setValue=function(e){this.doc.setValue(e),this.deferredUpdate.schedule(this.$timeout)},this.getValue=function(e){this.sender.callback(this.doc.getValue(),e)},this.onUpdate=function(){}}).call(s.prototype)}),define("ace/document",["require","exports","module","ace/lib/oop","ace/lib/event_emitter","ace/range","ace/anchor"],function(e,t,n){var r=e("./lib/oop"),i=e("./lib/event_emitter").EventEmitter,s=e("./range").Range,o=e("./anchor").Anchor,u=function(e){this.$lines=[],e.length==0?this.$lines=[""]:Array.isArray(e)?this.insertLines(0,e):this.insert({row:0,column:0},e)};(function(){r.implement(this,i),this.setValue=function(e){var t=this.getLength();this.remove(new s(0,0,t,this.getLine(t-1).length)),this.insert({row:0,column:0},e)},this.getValue=function(){return this.getAllLines().join(this.getNewLineCharacter())},this.createAnchor=function(e,t){return new o(this,e,t)},"aaa".split(/a/).length==0?this.$split=function(e){return e.replace(/\r\n|\r/g,"\n").split("\n")}:this.$split=function(e){return e.split(/\r\n|\r|\n/)},this.$detectNewLine=function(e){var t=e.match(/^.*?(\r\n|\r|\n)/m);t?this.$autoNewLine=t[1]:this.$autoNewLine="\n"},this.getNewLineCharacter=function(){switch(this.$newLineMode){case"windows":return"\r\n";case"unix":return"\n";case"auto":return this.$autoNewLine}},this.$autoNewLine="\n",this.$newLineMode="auto",this.setNewLineMode=function(e){if(this.$newLineMode===e)return;this.$newLineMode=e},this.getNewLineMode=function(){return this.$newLineMode},this.isNewLine=function(e){return e=="\r\n"||e=="\r"||e=="\n"},this.getLine=function(e){return this.$lines[e]||""},this.getLines=function(e,t){return this.$lines.slice(e,t+1)},this.getAllLines=function(){return this.getLines(0,this.getLength())},this.getLength=function(){return this.$lines.length},this.getTextRange=function(e){if(e.start.row==e.end.row)return this.$lines[e.start.row].substring(e.start.column,e.end.column);var t=this.getLines(e.start.row+1,e.end.row-1);return t.unshift((this.$lines[e.start.row]||"").substring(e.start.column)),t.push((this.$lines[e.end.row]||"").substring(0,e.end.column)),t.join(this.getNewLineCharacter())},this.$clipPosition=function(e){var t=this.getLength();return e.row>=t&&(e.row=Math.max(0,t-1),e.column=this.getLine(t-1).length),e},this.insert=function(e,t){if(!t||t.length===0)return e;e=this.$clipPosition(e),this.getLength()<=1&&this.$detectNewLine(t);var n=this.$split(t),r=n.splice(0,1)[0],i=n.length==0?null:n.splice(n.length-1,1)[0];return e=this.insertInLine(e,r),i!==null&&(e=this.insertNewLine(e),e=this.insertLines(e.row,n),e=this.insertInLine(e,i||"")),e},this.insertLines=function(e,t){if(t.length==0)return{row:e,column:0};if(t.length>65535){var n=this.insertLines(e,t.slice(65535));t=t.slice(0,65535)}var r=[e,0];r.push.apply(r,t),this.$lines.splice.apply(this.$lines,r);var i=new s(e,0,e+t.length,0),o={action:"insertLines",range:i,lines:t};return this._emit("change",{data:o}),n||i.end},this.insertNewLine=function(e){e=this.$clipPosition(e);var t=this.$lines[e.row]||"";this.$lines[e.row]=t.substring(0,e.column),this.$lines.splice(e.row+1,0,t.substring(e.column,t.length));var n={row:e.row+1,column:0},r={action:"insertText",range:s.fromPoints(e,n),text:this.getNewLineCharacter()};return this._emit("change",{data:r}),n},this.insertInLine=function(e,t){if(t.length==0)return e;var n=this.$lines[e.row]||"";this.$lines[e.row]=n.substring(0,e.column)+t+n.substring(e.column);var r={row:e.row,column:e.column+t.length},i={action:"insertText",range:s.fromPoints(e,r),text:t};return this._emit("change",{data:i}),r},this.remove=function(e){e.start=this.$clipPosition(e.start),e.end=this.$clipPosition(e.end);if(e.isEmpty())return e.start;var t=e.start.row,n=e.end.row;if(e.isMultiLine()){var r=e.start.column==0?t:t+1,i=n-1;e.end.column>0&&this.removeInLine(n,0,e.end.column),i>=r&&this.removeLines(r,i),r!=t&&(this.removeInLine(t,e.start.column,this.getLine(t).length),this.removeNewLine(e.start.row))}else this.removeInLine(t,e.start.column,e.end.column);return e.start},this.removeInLine=function(e,t,n){if(t==n)return;var r=new s(e,t,e,n),i=this.getLine(e),o=i.substring(t,n),u=i.substring(0,t)+i.substring(n,i.length);this.$lines.splice(e,1,u);var a={action:"removeText",range:r,text:o};return this._emit("change",{data:a}),r.start},this.removeLines=function(e,t){var n=new s(e,0,t+1,0),r=this.$lines.splice(e,t-e+1),i={action:"removeLines",range:n,nl:this.getNewLineCharacter(),lines:r};return this._emit("change",{data:i}),r},this.removeNewLine=function(e){var t=this.getLine(e),n=this.getLine(e+1),r=new s(e,t.length,e+1,0),i=t+n;this.$lines.splice(e,2,i);var o={action:"removeText",range:r,text:this.getNewLineCharacter()};this._emit("change",{data:o})},this.replace=function(e,t){if(t.length==0&&e.isEmpty())return e.start;if(t==this.getTextRange(e))return e.end;this.remove(e);if(t)var n=this.insert(e.start,t);else n=e.start;return n},this.applyDeltas=function(e){for(var t=0;t<e.length;t++){var n=e[t],r=s.fromPoints(n.range.start,n.range.end);n.action=="insertLines"?this.insertLines(r.start.row,n.lines):n.action=="insertText"?this.insert(r.start,n.text):n.action=="removeLines"?this.removeLines(r.start.row,r.end.row-1):n.action=="removeText"&&this.remove(r)}},this.revertDeltas=function(e){for(var t=e.length-1;t>=0;t--){var n=e[t],r=s.fromPoints(n.range.start,n.range.end);n.action=="insertLines"?this.removeLines(r.start.row,r.end.row-1):n.action=="insertText"?this.remove(r):n.action=="removeLines"?this.insertLines(r.start.row,n.lines):n.action=="removeText"&&this.insert(r.start,n.text)}}}).call(u.prototype),t.Document=u}),define("ace/range",["require","exports","module"],function(e,t,n){var r=function(e,t,n,r){this.start={row:e,column:t},this.end={row:n,column:r}};(function(){this.isEqual=function(e){return this.start.row==e.start.row&&this.end.row==e.end.row&&this.start.column==e.start.column&&this.end.column==e.end.column},this.toString=function(){return"Range: ["+this.start.row+"/"+this.start.column+"] -> ["+this.end.row+"/"+this.end.column+"]"},this.contains=function(e,t){return this.compare(e,t)==0},this.compareRange=function(e){var t,n=e.end,r=e.start;return t=this.compare(n.row,n.column),t==1?(t=this.compare(r.row,r.column),t==1?2:t==0?1:0):t==-1?-2:(t=this.compare(r.row,r.column),t==-1?-1:t==1?42:0)},this.comparePoint=function(e){return this.compare(e.row,e.column)},this.containsRange=function(e){return this.comparePoint(e.start)==0&&this.comparePoint(e.end)==0},this.intersects=function(e){var t=this.compareRange(e);return t==-1||t==0||t==1},this.isEnd=function(e,t){return this.end.row==e&&this.end.column==t},this.isStart=function(e,t){return this.start.row==e&&this.start.column==t},this.setStart=function(e,t){typeof e=="object"?(this.start.column=e.column,this.start.row=e.row):(this.start.row=e,this.start.column=t)},this.setEnd=function(e,t){typeof e=="object"?(this.end.column=e.column,this.end.row=e.row):(this.end.row=e,this.end.column=t)},this.inside=function(e,t){return this.compare(e,t)==0?this.isEnd(e,t)||this.isStart(e,t)?!1:!0:!1},this.insideStart=function(e,t){return this.compare(e,t)==0?this.isEnd(e,t)?!1:!0:!1},this.insideEnd=function(e,t){return this.compare(e,t)==0?this.isStart(e,t)?!1:!0:!1},this.compare=function(e,t){return!this.isMultiLine()&&e===this.start.row?t<this.start.column?-1:t>this.end.column?1:0:e<this.start.row?-1:e>this.end.row?1:this.start.row===e?t>=this.start.column?0:-1:this.end.row===e?t<=this.end.column?0:1:0},this.compareStart=function(e,t){return this.start.row==e&&this.start.column==t?-1:this.compare(e,t)},this.compareEnd=function(e,t){return this.end.row==e&&this.end.column==t?1:this.compare(e,t)},this.compareInside=function(e,t){return this.end.row==e&&this.end.column==t?1:this.start.row==e&&this.start.column==t?-1:this.compare(e,t)},this.clipRows=function(e,t){if(this.end.row>t)var n={row:t+1,column:0};if(this.start.row>t)var i={row:t+1,column:0};if(this.start.row<e)var i={row:e,column:0};if(this.end.row<e)var n={row:e,column:0};return r.fromPoints(i||this.start,n||this.end)},this.extend=function(e,t){var n=this.compare(e,t);if(n==0)return this;if(n==-1)var i={row:e,column:t};else var s={row:e,column:t};return r.fromPoints(i||this.start,s||this.end)},this.isEmpty=function(){return this.start.row==this.end.row&&this.start.column==this.end.column},this.isMultiLine=function(){return this.start.row!==this.end.row},this.clone=function(){return r.fromPoints(this.start,this.end)},this.collapseRows=function(){return this.end.column==0?new r(this.start.row,0,Math.max(this.start.row,this.end.row-1),0):new r(this.start.row,0,this.end.row,0)},this.toScreenRange=function(e){var t=e.documentToScreenPosition(this.start),n=e.documentToScreenPosition(this.end);return new r(t.row,t.column,n.row,n.column)}}).call(r.prototype),r.fromPoints=function(e,t){return new r(e.row,e.column,t.row,t.column)},t.Range=r}),define("ace/anchor",["require","exports","module","ace/lib/oop","ace/lib/event_emitter"],function(e,t,n){var r=e("./lib/oop"),i=e("./lib/event_emitter").EventEmitter,s=t.Anchor=function(e,t,n){this.document=e,typeof n=="undefined"?this.setPosition(t.row,t.column):this.setPosition(t,n),this.$onChange=this.onChange.bind(this),e.on("change",this.$onChange)};(function(){r.implement(this,i),this.getPosition=function(){return this.$clipPositionToDocument(this.row,this.column)},this.getDocument=function(){return this.document},this.onChange=function(e){var t=e.data,n=t.range;if(n.start.row==n.end.row&&n.start.row!=this.row)return;if(n.start.row>this.row)return;if(n.start.row==this.row&&n.start.column>this.column)return;var r=this.row,i=this.column;t.action==="insertText"?n.start.row===r&&n.start.column<=i?n.start.row===n.end.row?i+=n.end.column-n.start.column:(i-=n.start.column,r+=n.end.row-n.start.row):n.start.row!==n.end.row&&n.start.row<r&&(r+=n.end.row-n.start.row):t.action==="insertLines"?n.start.row<=r&&(r+=n.end.row-n.start.row):t.action=="removeText"?n.start.row==r&&n.start.column<i?n.end.column>=i?i=n.start.column:i=Math.max(0,i-(n.end.column-n.start.column)):n.start.row!==n.end.row&&n.start.row<r?(n.end.row==r&&(i=Math.max(0,i-n.end.column)+n.start.column),r-=n.end.row-n.start.row):n.end.row==r&&(r-=n.end.row-n.start.row,i=Math.max(0,i-n.end.column)+n.start.column):t.action=="removeLines"&&n.start.row<=r&&(n.end.row<=r?r-=n.end.row-n.start.row:(r=n.start.row,i=0)),this.setPosition(r,i,!0)},this.setPosition=function(e,t,n){var r;n?r={row:e,column:t}:r=this.$clipPositionToDocument(e,t);if(this.row==r.row&&this.column==r.column)return;var i={row:this.row,column:this.column};this.row=r.row,this.column=r.column,this._emit("change",{old:i,value:r})},this.detach=function(){this.document.removeEventListener("change",this.$onChange)},this.$clipPositionToDocument=function(e,t){var n={};return e>=this.document.getLength()?(n.row=Math.max(0,this.document.getLength()-1),n.column=this.document.getLine(n.row).length):e<0?(n.row=0,n.column=0):(n.row=e,n.column=Math.min(this.document.getLine(n.row).length,Math.max(0,t))),t<0&&(n.column=0),n}}).call(s.prototype)}),define("ace/lib/lang",["require","exports","module"],function(e,t,n){t.stringReverse=function(e){return e.split("").reverse().join("")},t.stringRepeat=function(e,t){return(new Array(t+1)).join(e)};var r=/^\s\s*/,i=/\s\s*$/;t.stringTrimLeft=function(e){return e.replace(r,"")},t.stringTrimRight=function(e){return e.replace(i,"")},t.copyObject=function(e){var t={};for(var n in e)t[n]=e[n];return t},t.copyArray=function(e){var t=[];for(var n=0,r=e.length;n<r;n++)e[n]&&typeof e[n]=="object"?t[n]=this.copyObject(e[n]):t[n]=e[n];return t},t.deepCopy=function(e){if(typeof e!="object")return e;var t=e.constructor();for(var n in e)typeof e[n]=="object"?t[n]=this.deepCopy(e[n]):t[n]=e[n];return t},t.arrayToMap=function(e){var t={};for(var n=0;n<e.length;n++)t[e[n]]=1;return t},t.createMap=function(e){var t=Object.create(null);for(var n in e)t[n]=e[n];return t},t.arrayRemove=function(e,t){for(var n=0;n<=e.length;n++)t===e[n]&&e.splice(n,1)},t.escapeRegExp=function(e){return e.replace(/([.*+?^${}()|[\]\/\\])/g,"\\$1")},t.getMatchOffsets=function(e,t){var n=[];return e.replace(t,function(e){n.push({offset:arguments[arguments.length-2],length:e.length})}),n},t.deferredCall=function(e){var t=null,n=function(){t=null,e()},r=function(e){return r.cancel(),t=setTimeout(n,e||0),r};return r.schedule=r,r.call=function(){return this.cancel(),e(),r},r.cancel=function(){return clearTimeout(t),t=null,r},r}}),define("ace/mode/json/json_parse",["require","exports","module"],function(e,t,n){var r,i,s={'"':'"',"\\":"\\","/":"/",b:"\b",f:"\f",n:"\n",r:"\r",t:"	"},o,u=function(e){throw{name:"SyntaxError",message:e,at:r,text:o}},a=function(e){return e&&e!==i&&u("Expected '"+e+"' instead of '"+i+"'"),i=o.charAt(r),r+=1,i},f=function(){var e,t="";i==="-"&&(t="-",a("-"));while(i>="0"&&i<="9")t+=i,a();if(i==="."){t+=".";while(a()&&i>="0"&&i<="9")t+=i}if(i==="e"||i==="E"){t+=i,a();if(i==="-"||i==="+")t+=i,a();while(i>="0"&&i<="9")t+=i,a()}e=+t;if(!isNaN(e))return e;u("Bad number")},l=function(){var e,t,n="",r;if(i==='"')while(a()){if(i==='"')return a(),n;if(i==="\\"){a();if(i==="u"){r=0;for(t=0;t<4;t+=1){e=parseInt(a(),16);if(!isFinite(e))break;r=r*16+e}n+=String.fromCharCode(r)}else{if(typeof s[i]!="string")break;n+=s[i]}}else n+=i}u("Bad string")},c=function(){while(i&&i<=" ")a()},h=function(){switch(i){case"t":return a("t"),a("r"),a("u"),a("e"),!0;case"f":return a("f"),a("a"),a("l"),a("s"),a("e"),!1;case"n":return a("n"),a("u"),a("l"),a("l"),null}u("Unexpected '"+i+"'")},p,d=function(){var e=[];if(i==="["){a("["),c();if(i==="]")return a("]"),e;while(i){e.push(p()),c();if(i==="]")return a("]"),e;a(","),c()}}u("Bad array")},v=function(){var e,t={};if(i==="{"){a("{"),c();if(i==="}")return a("}"),t;while(i){e=l(),c(),a(":"),Object.hasOwnProperty.call(t,e)&&u('Duplicate key "'+e+'"'),t[e]=p(),c();if(i==="}")return a("}"),t;a(","),c()}}u("Bad object")};return p=function(){c();switch(i){case"{":return v();case"[":return d();case'"':return l();case"-":return f();default:return i>="0"&&i<="9"?f():h()}},function(e,t){var n;return o=e,r=0,i=" ",n=p(),c(),i&&u("Syntax error"),typeof t=="function"?function s(e,n){var r,i,o=e[n];if(o&&typeof o=="object")for(r in o)Object.hasOwnProperty.call(o,r)&&(i=s(o,r),i!==undefined?o[r]=i:delete o[r]);return t.call(e,n,o)}({"":n},""):n}})