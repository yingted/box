#!/usr/bin/python -SOO
import sys,sandbox
conf=sandbox.SandboxConfig("traceback","codecs","datetime","encodings","exit","future","hashlib","itertools","math","random","regex","stdin","stdout","stderr","time","unicodedata",use_subprocess=False)
conf.allowModule("sys","argv")
conf.recursion_limit=sys.getrecursionlimit()
sys.argv=sys.argv[1:]
with open(sys.argv[0],"rb")as fp:
	source=fp.read()
sandbox.Sandbox(conf).execute(source,globals={
	"__name__":"__main__",
})
