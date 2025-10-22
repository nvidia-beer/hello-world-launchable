FROM nvcr.io/nvidia/pytorch:24.07-py3

# Base image includes:
# - CUDA 12.4
# - Python 3.10
# - PyTorch 2.4 + cuDNN + NCCL
# - NumPy + other scientific packages

# Install Jupyter and additional packages
RUN pip install --no-cache-dir \
    jupyterlab \
    notebook \
    ipywidgets \
    pandas \
    matplotlib

# Set working directory
WORKDIR /workspace

# Copy notebook into the container
COPY hello_world.ipynb /workspace/

# Expose Jupyter port
EXPOSE 8888

# Launch JupyterLab when container starts
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

