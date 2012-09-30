#!/usr/bin/env python
#place in wsgi directory
import fapws._evwsgi as evwsgi
from fapws import base
from server import application
if __name__=="__main__":
	evwsgi.start("0.0.0.0","8000")
	evwsgi.set_base_module(base)
	evwsgi.wsgi_cb(("",application))
	evwsgi.set_debug(0)
	evwsgi.run()
