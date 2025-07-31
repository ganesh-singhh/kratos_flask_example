FROM python:3.12-slim

WORKDIR /app

ENV FLASK_APP=autoapp.py
ENV FLASK_ENV=development

# 2. Install pipenv
RUN pip install --no-cache pipenv

# 3. Copy Pipfile + lock
COPY ["Pipfile", "Pipfile.lock", "./"]

# 4. Install deps
RUN pipenv install --deploy --ignore-pipfile

# 5. Copy app
COPY . .

RUN pipenv requirements > requirements.txt
RUN pip install -r requirements.txt

EXPOSE 2992
EXPOSE 5001

CMD [ "flask", "run", "-p", "5001", "-h", "0.0.0.0" ]
