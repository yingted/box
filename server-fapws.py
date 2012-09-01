#!/usr/bin/env python
import fapws._evwsgi as evwsgi
from fapws import base
from server import handler
if __name__=="__main__":
	evwsgi.start("0.0.0.0","8000")
	evwsgi.set_base_module(base)
	evwsgi.wsgi_cb(("",handler))
	evwsgi.set_debug(0)
	evwsgi.run()
