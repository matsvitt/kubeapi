FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .


VOLUME /data
VOLUME /datashared

EXPOSE 8000

CMD ["uvicorn", "appb:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
