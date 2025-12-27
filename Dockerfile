# -------- Build stage --------
    FROM python:3.11-slim AS builder

    WORKDIR /app
    
    RUN apt-get update && apt-get install -y gcc && rm -rf /var/lib/apt/lists/*
    
    COPY requirements.txt .
    RUN pip install --no-cache-dir --prefix=/install -r requirements.txt
    
    # -------- Runtime stage --------
    FROM python:3.11-slim
    
    # Create non-root user
    RUN useradd -m appuser
    
    WORKDIR /app
    
    COPY --from=builder /install /usr/local
    COPY app app
    
    USER appuser
    
    EXPOSE 8000
    
    HEALTHCHECK CMD curl --fail http://localhost:8000/health || exit 1
    
    CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
    