# Production Dockerfile (recreated) - loadgenerator (Locust)

FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app
RUN addgroup --system app && adduser --system --ingroup app app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Locust web UI defaults to 8089
EXPOSE 8089
USER app

# FRONTEND_ADDR is injected via K8s env; default points to frontend service
ENV FRONTEND_ADDR=frontend:80 \
    USERS=10 \
    SPAWN_RATE=1

ENTRYPOINT ["sh","-c","locust -f locustfile.py --host=http://${FRONTEND_ADDR} --headless -u ${USERS} -r ${SPAWN_RATE}"]

