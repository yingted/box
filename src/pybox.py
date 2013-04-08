#!/usr/bin/python -SOO
import sys,sandbox
conf=sandbox.SandboxConfig("traceback","codecs","datetime","encodings","exit","future","hashlib","itertools","math","random","regex","stdin","stdout","stderr","time","unicodedata",use_subprocess=False)
def allow(mods,prefix=()):
	assert type(prefix)==tuple,prefix
	if isinstance(mods,dict):
		for mod,sub in mods.items():
			allow(sub,prefix+(mod,))
		return
	if isinstance(mods,str):
		mods=mods,
	for mod in mods:
		conf.allowModule(*(prefix+(mod,)))
allow({
	"sys":"argv",
	"bisect":("bisect","bisect_left","bisect_right","insort","insort_left","insort_right"),
	"heapq":("heapify","heappop","heappush","heappushpop","heapreplace","merge","nlargest","nsmallest"),
	"operator":"itemgetter",
})
conf.recursion_limit=sys.getrecursionlimit()
sys.argv=sys.argv[1:]
with open(sys.argv[0],"rb")as fp:
	source=fp.read()
sandbox.Sandbox(conf).execute(source,globals={
	"__name__":"__main__",
})
