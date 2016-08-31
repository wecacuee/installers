CUDA_TOOLKIT_ROOT_DIR?=/usr/local/cuda-7.0
CUDA_INSTALLED?=$(CUDA_TOOLKIT_ROOT_DIR)/targets/x86_64-linux/lib/libcudart.so
CUDNN_INSTALLED?=$(CUDA_TOOLKIT_ROOT_DIR)/lib64/libcudnn.so
CUDNN_ROOT?=$(CUDA_TOOLKIT_ROOT_DIR)

-include utils.mk

$(CUDA_INSTALLED):
ifeq ($(isflux),arc-ts)
else
	sudo apt-add-repository 'deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64 /'
	sudo apt-get update
	sudo apt-get install cuda-7-0
endif

$(CUDNN_INSTALLED):
	rsync -e 'ssh -p 2222' -lrczav dhiman@lens:~/co/cudnn/cuda/ $(CUDA_TOOLKIT_ROOT_DIR)/


