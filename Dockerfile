FROM rocker/r-ver:4.3.0

WORKDIR /app

COPY . .

RUN Rscript -e 'if(file.exists("install_packages.R")) source("install_packages.R")'

EXPOSE 3838

CMD ["Rscript", "main.R"]
