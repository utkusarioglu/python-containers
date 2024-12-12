image_tag="${1:?'Image tag required as param #1'}"
im=utkusarioglu/python-devcontainer:$image_tag

docker image rm $im
docker pull $im
docker run -it --rm $im 
