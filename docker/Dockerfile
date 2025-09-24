FROM nvcr.io/nvidia/pytorch:25.08-py3
RUN python3.12 -m pip install git+https://github.com/ProjectNeura/Erbium.git
COPY docker/app /workspace/code
WORKDIR /workspace/code
RUN python3.12 -m pip install requirements.txt
CMD ["python3.12", "main.py"]