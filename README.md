# Hello World Launchable 🚀

A simple GPU test notebook for Brev deployment. This launchable runs a Jupyter notebook that verifies your GPU setup using `nvidia-smi`.

## Project Structure

```
hello-world-launchable/
├── .brev/
│   └── config.yaml         # Brev configuration
├── Dockerfile              # CUDA 12.8 + Jupyter setup
├── docker-compose.yml      # Docker Compose configuration for Brev
├── setup.sh                # Setup script for Brev Container option
├── hello_world.ipynb       # Main notebook - runs nvidia-smi
└── README.md               # This file
```

## What It Does

This launchable provides a custom Docker container with:
- **CUDA 12.8** base environment
- **JupyterLab** pre-installed
- **GPU test notebook** that runs `nvidia-smi`
- Automatic launch on port 8888

The notebook displays:
- Available GPU(s) and their status
- CUDA version
- Driver version  
- GPU memory and utilization

Perfect for testing your Brev GPU setup!

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

**Important**: Brev does NOT build Docker images from Dockerfiles directly. You must use pre-built images or setup scripts.

### Option 1: Docker Compose with Pre-Built Image (Recommended)

This option uses your custom Docker image after you build and push it to a registry.

#### Step 1: Build and Push Your Image

```bash
# Build the image
docker build -t YOUR-DOCKERHUB-USERNAME/hello-world-launchable:latest .

# Login to Docker Hub
docker login

# Push to Docker Hub
docker push YOUR-DOCKERHUB-USERNAME/hello-world-launchable:latest
```

#### Step 2: Update docker-compose.yml

Edit `docker-compose.yml` and replace the image line:
```yaml
image: YOUR-DOCKERHUB-USERNAME/hello-world-launchable:latest
```

#### Step 3: Deploy on Brev

1. Push your updated repository to GitHub
2. In Brev console, create a new Launchable
3. **Select "Docker Compose"** option
4. Point to your GitHub repository
5. Brev will use `docker-compose.yml` to pull your pre-built image
6. Configure GPU resources:
   - GPU Type: L40S, A100, or A10G
   - Memory: 48GB (recommended for L40S)
   - Ports: 8888 (for Jupyter)
7. Deploy!

### Option 2: Brev Container with Setup Script

This uses Brev's built-in Python/CUDA containers and runs a setup script.

1. In Brev console, create a new Launchable
2. **Select "Brev Container"** option
3. Configure:
   - Python Version: 3.10 or 3.11
   - CUDA Version: 12.x (closest available to 12.8)
4. Point to your GitHub repository
5. Brev will automatically run `setup.sh` to install Jupyter and dependencies
6. Configure GPU resources (L40S, A100, A10G)
7. Deploy!

### Using Jupyter

Once deployed:
- Access JupyterLab at: `https://your-instance.brev.dev:8888`
- No password required (configured for easy access)
- Open and run `hello_world.ipynb`
- Execute the `!nvidia-smi` cell to verify GPU access
- Modify and extend the notebook for your needs

**Important**: Always **stop** your Brev instance when not in use to avoid charges!

## About Brev

NVIDIA Brev provides streamlined access to NVIDIA GPU instances with:
- **Provision**: Instant GPU access without cloud account setup
- **Configure**: Automatic driver and library configuration  
- **Connect**: SSH or VS Code/Cursor integration

For more examples, see the [Brev Launchables Repository](https://github.com/brevdev/launchables).

