ARG DB=test
FROM mcr.microsoft.com/mssql/server:2019-latest
ENV ACCEPT_EULA=y
ENV SA_PASSWORD=SomePassword
ENV MSSQL_PID=Developer
ENV TARGET_DB=${DB}db
ENV BACPAC=${DB}.bacpac
USER root
RUN apt-get update \
    && apt-get install netcat wget libunwind8 libicu66 unzip -y \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /tmp
RUN wget https://go.microsoft.com/fwlink/?linkid=2157202 -O sqlpackage.zip
RUN unzip sqlpackage.zip -d /opt/sqlpackage
RUN chmod a+x /opt/sqlpackage/sqlpackage
USER mssql
# install sql package from:
# https://docs.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-2017#get-sqlpackage-net-core-for-linux

WORKDIR /tmp
COPY ${DB}/*.bacpac .
COPY install.sh .
RUN ./install.sh