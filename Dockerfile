# Use an official Python runtime as a parent image
FROM python:3.5.4

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
# Note: No requirements.txt is provided, so we manually install the packages
RUN pip install protobuf==3.4.0 numpy==1.14.5 tensorflow==1.8.0 gym==0.10.5

# Install Multi-Agent Particle Environments (MPE)
# This assumes you have the MPE code in a subdirectory `multiagent-particle-envs` of your project
# Or alternatively, you can clone from its repository if it's available online
COPY multiagent-particle-envs /app/multiagent-particle-envs
RUN cd /app/multiagent-particle-envs && pip install -e .

# Add MPE to PYTHONPATH by setting the environment variable
ENV PYTHONPATH "${PYTHONPATH}:/app/multiagent-particle-envs"

# Set up the entry point to run the training script
ENTRYPOINT ["python", "experiments/train.py"]
CMD ["--scenario", "simple_adversary"]
