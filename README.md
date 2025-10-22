# Hello World Launchable 🚀

A simple GPU test notebook for Brev deployment. This launchable runs a Jupyter notebook that verifies your GPU setup using `nvidia-smi`.

## Project Structure

```
hello-world-launchable/
├── .brev/
│   └── config.yaml         # Brev configuration (container mode)
├── Dockerfile              # CUDA 12.8 + Jupyter setup
├── hello_world.ipynb       # Main notebook - runs nvidia-smi
└── README.md               # This file
```

## What It Does

This launchable uses **Container Mode** with a custom Dockerfile to:
- Provide CUDA 12.8 base environment
- Install JupyterLab automatically
- Launch Jupyter on port 8888
- Run `!nvidia-smi` in the notebook to verify GPU access

The notebook displays:
- Available GPU(s) and their status
- CUDA version
- Driver version  
- GPU memory and utilization

Perfect for testing your Brev Launchable GPU setup!

## Local Testing

### Build and Run Docker Container

```bash
# Build the image
docker build -t hello-world-launchable .

# Run with GPU support
docker run --gpus all -p 8888:8888 hello-world-launchable
```

Then open http://localhost:8888 in your browser to access JupyterLab.

## Deploying to Brev

### Quick Deploy with Container Mode

1. Push this repository to your Git provider (GitHub, GitLab, etc.)
2. In the Brev console, create a new Launchable
3. **Select "Container Mode"** when creating your instance
4. Point to your repository - Brev will:
   - Detect the `Dockerfile` at the root
   - Use `.brev/config.yaml` for configuration
   - Build the container with CUDA 12.8
   - Launch JupyterLab automatically
5. Configure your GPU resources (A10G, A100, etc.) or use config from `config.yaml`
6. Deploy!

### Using Jupyter

Once deployed, you can:
- Access JupyterLab through the Brev console (port 8888)
- Open and run `hello_world.ipynb`
- Execute the `!nvidia-smi` cell to verify GPU access
- Modify and extend the notebook for your needs

## About Brev

NVIDIA Brev provides streamlined access to NVIDIA GPU instances with:
- **Provision**: Instant GPU access without cloud account setup
- **Configure**: Automatic driver and library configuration  
- **Connect**: SSH or VS Code/Cursor integration

For more examples, see the [Brev Launchables Repository](https://github.com/brevdev/launchables).

