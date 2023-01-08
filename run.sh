docker build -t tesstrain .
docker run --mount type=bind,src=$(PWD)/data,dst=/tesstrain/data -it tesstrain bash
