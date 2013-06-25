local function pdet(a,b,c)
	return (a[1]-b[1])*(c[2]-b[2])>(a[2]-b[2])*(c[1]-b[1])
end
while true do
	local n,m,a=io.read"*n",io.read"*n",{}
	if n==0 then break end
	while table.getn(a)<n do
		table.insert(a,{io.read"*n",io.read"*n"})
	end
	a[0]=a[n]
	while m>0 do
		m=m-1
		local pdet,p,c=pdet,{io.read"*n",io.read"*n"},0
		for i=1,n do
			if a[i-1][2]>p[2]then
				if a[i][2]<=p[2]and pdet(a[i],p,a[i-1])then
					c=c-1
				end
			elseif a[i][2]>p[2]and pdet(a[i-1],p,a[i])then
				c=c+1
			end
		end
		print(c)
	end
end
