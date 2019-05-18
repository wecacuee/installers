# Carla simulator 
# https://carla.readthedocs.io/en/latest/getting_started/
# https://github.com/carla-simulator/carla/releases/tag/0.9.4


VER=0.9.4
ROOT=CARLA
NAME=$(ROOT)_$(VER)
CARLAURL=https://doc-04-1c-docs.googleusercontent.com/docs/securesc/0t2juf68dp6i4er7gtke9q43hso498pk/dk72955t67evjja1s8lkk6e2b820g7j9/1551981600000/08261810080133743559/*/1p5qdXU4hVS2k5BOYSlEm7v7_ez3Et9bP?e=download
TOWNURL=https://doc-04-2c-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/0ov3091kqemcgk1qv54p5rpsdob4vljv/1551981600000/08261810080133743559/*/1YM5WO1LdtFQUt7cnJRIowpijIgrROhTR?e=download

DNLD_PREFIX=$(HOME)/co/
BUILD_PREFIX=$(HOME)/co/
INSTALL_PREFIX=$(HOME)/.local/

TAR_PATH=$(DNLD_PREFIX)/$(NAME).tar.gz
BUILD_LOC=$(BUILD_PREFIX)/$(NAME)
INSTALL_LOC=$(INSTALL_PREFIX)/$(NAME)

VE=$(BUILD_LOC)/ve-$(NAME)
VEACT=$(VE)/bin/activate


.PHONY:
manual_control: run dynamic_weather add_life
	#. $(VEACT) && \
	cd $(BUILD_LOC) && python manual_control.py

.PHONY:
dynamic_weather: run add_life
	#. $(VEACT) && \
	cd $(BUILD_LOC) && python dynamic_weather.py

.PHONY:
add_life: run
	#. $(VEACT) && \
	cd $(BUILD_LOC) && python spawn_npc.py -n 80


.PHONY:
run: $(BUILD_LOC)/CarlaUE4.sh $(VEACT)
	#. $(VEACT) && \
	cd $(<D) && bash $(<F) &
	sleep 20

$(BUILD_LOC)/CarlaUE4.sh: $(TAR_PATH)
	mkdir -p $(@D)
	tar xzf $(TAR_PATH) -C $(@D)
	touch $@

$(TAR_PATH):
	mkdir -p $(@D)
	wget $(CARLAURL) -O $@

$(VEACT): 
	virtualenv --python=python3.5 $(VE)
	#. $(VEACT) && pip install pygame numpy
	pip install --user pygame numpy


