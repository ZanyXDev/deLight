#!/bin/bash
CUR_GIT_ROOT=$(git rev-parse --show-toplevel)
#qmake ../delight.pro -spec linux-g++ CONFIG+=debug CONFIG+=qml_debug && /usr/bin/make -j $(nproc) qmake_all && /usr/bin/make -j $(nproc)

docker run --rm \
    --user $UID:$GID \
    --workdir="/home/$USER" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --mount type=bind,source=$CUR_GIT_ROOT,target=/app \
     carlonluca/qt-dev:5.15.10-lts-lgpl /app/tools/ci/build.sh
