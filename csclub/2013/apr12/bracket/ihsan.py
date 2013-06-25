fi = open('/dev/stdin')
dict = {'(':')','{':'}','<':'>','[':']'}
stack = []
bool = False
for line in [fi.readline().strip() for i in xrange(int(fi.readline()))]: 
  for i in xrange(len(line)):  
    if line[i] in dict:
      stack.append(dict[line[i]])
    elif len(stack)>0 and line[i] == stack.pop(): 
      bool = True
    else:
      bool = False
      continue	
  stack=[]
  if bool:
    print "1"
  else:
    print "0"
