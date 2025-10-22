FROM nvidia/cuda:12.8.0-base-ubuntu22.04

# Install Python, Jupyter, and essential packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter and common data science packages
RUN pip3 install --no-cache-dir \
    jupyter \
    jupyterlab \
    notebook \
    ipywidgets \
    numpy \
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

