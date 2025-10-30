FROM nvcr.io/nvidia/pytorch:25.08-py3
RUN python3.12 -m pip install git+https://github.com/ProjectNeura/Erbium.git
RUN python3.12 -m pip install git+https://github.com/sherwinokhowat/nnUNet.git
COPY app /workspace/code
WORKDIR /workspace/code
RUN python3.12 -m pip install -r requirements.txt
RUN sed -i 's/\r$//' main.sh
CMD ["bash", "main.sh"]
