for(var n=readline();n--;print(out.join("")))
	for(var code=readline().replace(/[^0-9a-f]/g,"").split("").map(function(e)parseInt(e,16)),ip=0,stack=[],out=[];ip>=0&&ip<code.length;)
		switch(code[ip++]){
			case 0:	stack.push(code[ip++]); break;
			case 1:	stack.pop(); break;
			case 2:	ip+=stack.pop()?((code[ip++]<<4)|code[ip])-126:2; break;
			case 3:	stack.push(stack[stack.length-1]); break;
			case 4:	stack.push((stack.pop()+stack.pop())&15); break;
			case 5: stack.push((stack.pop()*stack.pop())&15); break;
			case 6:	stack.push(15^(stack.pop()&stack.pop())); break;
			case 7:	out.push(String.fromCharCode(stack.pop()|(stack.pop()<<4))); break;
			case 8: [stack[stack.length-1],stack[stack.length-1-code[ip++]]]=[stack[stack.length-1-code[ip]],stack[stack.length-1]]; break;
			case 9: stack.push(1^(stack.pop()>=stack.pop())); break;
			case 10: stack.push((1/stack.pop()*stack.pop())&15); break;
			case 11: stack.push(stack.length?1:0); break;
			case 12: code[ip-128+(stack.pop()|(stack.pop()<<4))]=stack.pop(); break;
			case 13: stack.push(code[ip-128+(stack.pop()|(stack.pop()<<4))]); break;
		}
