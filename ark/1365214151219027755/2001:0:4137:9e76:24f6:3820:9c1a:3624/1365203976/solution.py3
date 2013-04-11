temp = input().split()
x = int(temp[0])
y = int(temp[1])
z = int (temp[2])
happiness = 0

for i in range (y):
    temp = input().split()
	if int(temp[0]) <= z <= int(temp[1]):
		happiness = int(temp[2])
		
print (happiness)