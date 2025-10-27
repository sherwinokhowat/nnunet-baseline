FROM nvcr.io/nvidia/pytorch:25.08-py3
RUN python3.12 -m pip install git+https://github.com/ProjectNeura/Erbium.git
COPY app /workspace/code
WORKDIR /workspace/code
RUN python3.12 -m pip install -r requirements.txt
RUN apt-get update && apt-get install -y dos2unix && dos2unix /workspace/code/main.sh
CMD ["bash", "main.sh"]
