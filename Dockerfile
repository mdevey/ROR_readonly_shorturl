FROM docker.elastic.co/elasticsearch/elasticsearch:6.5.1

# Add ReadOnlyRest ROR to elasticsearch
ENV RORZIP=readonlyrest-1.16.33_es6.5.1.zip
COPY $RORZIP /
RUN elasticsearch-plugin install --batch file:///$RORZIP
