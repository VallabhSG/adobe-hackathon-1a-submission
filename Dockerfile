    # Use a lightweight Python base image
    FROM --platform=linux/amd64 python:3.9-slim

    # Set the working directory inside the container
    WORKDIR /app

    # PyMuPDF (fitz) needs this dependency
    RUN apt-get update && apt-get install -y libgl1-mesa-glx

    # Copy all project files into the container
    COPY . .

    # Install the required Python libraries from requirements.txt
    RUN pip install --no-cache-dir -r requirements.txt

    # CORRECTED: The command now points to the correct script name
    CMD ["python3", "process_pdfs.py"]
    