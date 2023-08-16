FROM python:3.9

# first layers should be dependency install so changes in code won't cause the build to
# start from scratch.
ADD data /ml-pipeline
ADD src /ml-pipeline  
WORKDIR /ml-pipeline
COPY requirements.txt /ml-pipeline/requirements.txt

RUN apt-get -y update && apt-get install -y --no-install-recommends \
         wget \
         nginx \
         ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir -r /ml-pipeline/requirements.txt

# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.

ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
# ENV PATH="/opt/program:${PATH}"
# ENV MODEL_PATH="/opt/ml/model"

# Set up the program in the image

EXPOSE 7777 2222 8000