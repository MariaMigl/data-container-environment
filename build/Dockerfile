FROM python:3.13.1


ARG REQUIREMENTS_DIR=""

RUN apt update && apt upgrade -y && apt install -y sqlite3 vim

RUN apt install -y cron

WORKDIR /backup-folder

RUN pip install --upgrade pip

WORKDIR /requirements

COPY $REQUIREMENTS_DIR/requirements.txt requirements.txt

COPY ./juju /root/.jupyter

RUN sha512sum requirements.txt | cut -d' ' -f1 > hash.txt

RUN pip install --root-user-action=ignore -r requirements.txt && rm -rf /root/.cache/pip && rm requirements.txt

RUN touch /etc/cron.d/jupyter-folder-backup && chmod 644 /etc/cron.d/jupyter-folder-backup

# Ajustar permissões para o arquivo cron
RUN echo "0,15,30,45 * * * * cp -rf /jupyter-folder/* /backup-folder >> /var/log/cron.log 2>&1" > /etc/cron.d/jupyter-folder-backup

# Criar o arquivo de log do cron
RUN touch /var/log/cron.log
RUN crontab -u root /etc/cron.d/jupyter-folder-backup

# Configurar o diretório de trabalho final
WORKDIR /jupyter-folder

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

ENTRYPOINT ["start.sh"]