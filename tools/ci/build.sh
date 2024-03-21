#!/bin/sh
cd /app
rm -r build 
mkdir build 
cd build
qmake ../delight.pro -spec linux-g++ CONFIG+=debug CONFIG+=qml_debug && /usr/bin/make -j $(nproc) qmake_all && /usr/bin/make -j $(nproc)
