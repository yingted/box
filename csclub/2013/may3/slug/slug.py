import re
nonword=re.compile(r"(?:\W|_)+")
for _ in xrange(int(raw_input())):
	slug=nonword.sub("_",raw_input().lower().translate(None,"'\"`"))
	print slug.strip("_")if slug.translate(None,"_")else slug
