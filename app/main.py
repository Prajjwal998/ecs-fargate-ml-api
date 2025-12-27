from fastapi import FastAPI

app = FastAPI(title="ML Prediction API")

@app.get("/health")
def health_check():
    return {"status": "ok"}

@app.get("/predict")
def predict():
    return {"score": 0.75}
