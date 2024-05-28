# Testbed
## Build Preparation
<details><summary>Ubuntu 22.04</summary>
```sudo apt-get install cmake make gcc g++ pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev```
</details>

## Scenario A (Emulation)
Hardware configuration:
- WS with UE
- WS with gNB
- Channel Emulator
### How to setup the Channel Emulator
todo
### How to run UE

In the UE WS type:
```
git clone https://github.com/Lab1R531/gadget.git
cd gadget/4G/
mkdir build
cd build
cmake ..
make -j`nproc`
cd ../../
. UE_start.sh
```
#### NB: an example of UE_start.sh script is provided in gadget/scripts/UE_start_example.sh. Copy and Modify that file in the main folder making sure that the paths of the executable and configuration file are correct! 

### How to run gNB
In the gNB WS type:
```
git clone https://github.com/Lab1R531/gadget.git
cd gadget/5G/
mkdir build
cd build
cmake ..
make -j`nproc`
cd ../../
. GNB_start.sh
```
#### NB: an example of GNB_start.sh script is provided in gadget/scripts/GNB_start_example.sh. Copy and Modify that file in the main folder making sure that the paths of the executable and configuration file are correct! 

## Scenario B (Simulation)
Hardware configuration:
- WS with UE
- WS with gNB
- ZeroMQ
### How to setup ZeroMQ
```
sudo apt-get install libzmq3-dev
```
### How to run UE
In the UE WS type:
```
git clone https://github.com/Lab1R531/gadget.git
cd gadget/4G/
mkdir build
cd build
cmake ../ -DENABLE_EXPORT=ON -DENABLE_ZEROMQ=ON
make -j`nproc`
cd ../../
. UE_start.sh
```
#### NB: an example of UE_start.sh script is provided in gadget/scripts/UE_start_example.sh. Copy and Modify that file in the main folder making sure that the paths of the executable and configuration file are correct! 

### How to run gNB
In the gNB WS type:
```
git clone https://github.com/Lab1R531/gadget.git
cd gadget/5G/
mkdir build
cd build
cmake ../ -DENABLE_EXPORT=ON -DENABLE_ZEROMQ=ON
make -j`nproc`
cd ../../
. GNB_start.sh
```
#### NB: an example of GNB_start.sh script is provided in gadget/scripts/GNB_start_example.sh. Copy and Modify that file in the main folder making sure that the paths of the executable and configuration file are correct! 
