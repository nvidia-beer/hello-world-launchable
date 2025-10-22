# Hello World Launchable 🚀

A simple GPU test notebook for Brev deployment. This launchable runs a Jupyter notebook that verifies your GPU setup using `nvidia-smi`.

## Project Structure

```
hello-world-launchable/
├── .brev/
│   └── config.yaml                    # Brev configuration
├── Dockerfile                         # Custom image: CUDA 12.4 + PyTorch + Jupyter
├── docker-compose.yml                 # Official NVIDIA PyTorch image (ready to deploy)
├── docker-compose-custom-docker.yml   # Uses YOUR custom-built Dockerfile image
├── hello_world.ipynb                  # Main notebook - runs nvidia-smi
└── README.md                          # This file
```

## What It Does

This launchable provides GPU-enabled Jupyter environments with:
- **CUDA 12.4** with PyTorch 2.4
- **JupyterLab** with data science packages
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

**⚠️ Important Limitations:**
- Brev does **NOT** build Docker images from Dockerfiles directly. You must use pre-built images.
- Docker Compose deployments **DO NOT support stop/start** - you can only **terminate and redeploy**.
- For instances you can stop/start, use "Brev Container" mode instead.

We provide two docker-compose configurations:

### Option 1: Official NVIDIA PyTorch Image (Recommended - Easiest) ✅

Uses `docker-compose.yml` with official NVIDIA NGC container.

**Advantages:**
- ✅ No build required - works immediately
- ✅ Official NVIDIA image (trusted)
- ✅ CUDA 12.4 + PyTorch + all GPU libraries
- ✅ JupyterLab installed automatically

**Deploy on Brev:**

1. In Brev console, create a new Launchable
2. **Select "Docker Compose"** option
3. Point to your GitHub repository: `nvidia-beer/hello-world-launchable`
4. **Compose file**: Use default `docker-compose.yml`
5. Configure GPU resources:
   - GPU Type: **L40S, A100, or A10G**
   - Memory: **48GB** (recommended for L40S)
   - Ports: **8888** (for Jupyter)
6. Deploy!

**⚠️ Stop/Start Not Supported**: Docker Compose deployments cannot be stopped and restarted - only terminated and redeployed. Each redeploy will download the notebook fresh from GitHub. 

**If you need stop/start functionality:** Use "Brev Container" mode instead, or build your own image with Option 2.

**What it uses:**
```yaml
image: nvcr.io/nvidia/pytorch:24.07-py3  # Official NVIDIA container
# CUDA 12.4 + Python 3.10 + PyTorch 2.4 + JupyterLab
```

---

### Option 2: Build and Use YOUR Custom Dockerfile

Uses `docker-compose-custom-docker.yml` with YOUR custom-built image from the Dockerfile in this repo.

**Advantages:**
- ✅ Full control over your environment
- ✅ Includes your notebook in the image
- ✅ Based on NVIDIA PyTorch (CUDA 12.4 + PyTorch 2.4)
- ✅ Your exact package versions

**Steps:**

#### Step 1: Build and Push Your Custom Image

```bash
# Build the image from the Dockerfile
docker build -t nvidiaibeer/hello-world-launchable:latest .

# Login to Docker Hub
docker login

# Push to Docker Hub
docker push nvidiaibeer/hello-world-launchable:latest
```

**Change the image name** to your Docker Hub username:
- Replace `nvidiaibeer` with your Docker Hub username
- Update line 17 in `docker-compose-custom-docker.yml` accordingly

#### Step 2: Deploy on Brev

1. Push your changes to GitHub
2. In Brev console, create a new Launchable
3. **Select "Docker Compose"** option
4. Point to your GitHub repository
5. **Compose file**: Specify `docker-compose-custom-docker.yml`
6. Configure GPU resources:
   - GPU Type: **L40S, A100, or A10G**
   - Memory: **48GB**
   - Ports: **8888**
7. Deploy!

**What it uses:**
```yaml
image: nvidiaibeer/hello-world-launchable:latest  # YOUR custom built image
```

### Using Jupyter

Once deployed:
- Access JupyterLab at: `https://your-instance.brev.dev:8888`
- No password required (configured for easy access)
- Open and run `hello_world.ipynb`
- Execute the `!nvidia-smi` cell to verify GPU access
- Modify and extend the notebook for your needs

**⚠️ Cost Warning for Docker Compose Deployments:**
- Docker Compose instances **cannot be stopped** - only terminated
- You will be charged for the entire time the instance exists
- **Always terminate** (delete) your instance when done to avoid charges
- Consider using "Brev Container" mode if you need stop/start functionality to save costs

## About Brev

NVIDIA Brev provides streamlined access to NVIDIA GPU instances with:
- **Provision**: Instant GPU access without cloud account setup
- **Configure**: Automatic driver and library configuration  
- **Connect**: SSH or VS Code/Cursor integration

For more examples, see the [Brev Launchables Repository](https://github.com/brevdev/launchables).

