while true do
	local n,m,a=io.read"*n",io.read"*n",{}
	if n==0 then break end
	while table.getn(a)<n do
		table.insert(a,{io.read"*n",io.read"*n"})
	end
	a[0]=a[n]
	while m>0 do
		m=m-1
		local px,py,c=io.read"*n",io.read"*n",0
		for i=1,n do
			local x1,y1,x2,y2=a[i-1][1],a[i-1][2],a[i][1],a[i][2]
			if y1>py then
				if y2<=py and(x2-px)*(y1-py)>(y2-py)*(x1-px)then
					c=c-1
				end
			elseif y2>py and(x2-px)*(y1-py)<(y2-py)*(x1-px)then
				c=c+1
			end
		end
		print(c)
	end
end
