VER:=1.2.1
IP:=/z/sw/packages/tensorflow-gpu/1.2.1
$(IP)/lib/python2.7/site-packages/tensorflow/__init__.py:
	module load cuda cudnn gflags protobuf numpy scipy \
		&& PYTHONUSERBASE=$(IP) pip install --user tensorflow-gpu==1.2.1
	cp sitecustomize.py $(IP)/lib/python2.7/site-packages/
