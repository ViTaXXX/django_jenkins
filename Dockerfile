FROM python:3
WORKDIR /usr/src/app

RUN sed -i 's/http:/https:/g' /etc/apt/sources.list.d/debian.sources
RUN echo 'Acquire::https::Verify-Peer "false";' > /etc/apt/apt.conf.d/99ignore-ssl-certificates

RUN apt-get install git && pip install --root-user-action=ignore --upgrade pip && pip install --root-user-action=ignore django mysqlclient
COPY ./django_tutorial /usr/src/app

ADD ./script.sh /usr/src/app/
RUN chmod +x /usr/src/app/script.sh

EXPOSE 8002
EXPOSE 8082
EXPOSE 80
EXPOSE 8006

#ENV ALLOWED_HOSTS=*
#ENV HOST=mariadb
#ENV USUARIO=django
#ENV CONTRA=django
#ENV BASE_DATOS=django
#ENV DJANGO_SUPERUSER_PASSWORD=admin
#ENV DJANGO_SUPERUSER_USERNAME=admin
#ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
ENTRYPOINT ["/usr/src/app/script.sh"]