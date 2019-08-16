#!/bin/bash

CONTAINER_IMAGE_NAME="dvc-deps-management"

REPO_FOLDER="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MOUNT_FOLDER=$REPO_FOLDER/mount_folder
mkdir -p $MOUNT_FOLDER

docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t $CONTAINER_IMAGE_NAME .
docker run -d --mount type=bind,source=$MOUNT_FOLDER,target=/remote --name $CONTAINER_IMAGE_NAME $CONTAINER_IMAGE_NAME

if [[ "$*" =~ "clone" ]]; then
  docker exec --user dvc -ti $CONTAINER_IMAGE_NAME bash /home/dvc/scripts/clone.sh
fi

if [[ "$*" =~ "bash" ]]; then
  docker exec --user dvc -ti $CONTAINER_IMAGE_NAME bash -c "cd /home/dvc/walkthrough; bash"
fi
