FROM python:3.9-slim-bullseye

RUN groupadd -r appuser && useradd -r -g appuser appuser

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && rm -rf /root/.cache/pip \
    && chown -R appuser:appuser /app

COPY . .

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app  # Fix pytest import issue

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

CMD ["python", "-m", "app.main"]
