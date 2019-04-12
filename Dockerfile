
FROM centos/ruby-22-centos7
USER default
EXPOSE 8080
ENV RACK_ENV production
ENV RAILS_ENV production


ARG DT_API_URL="https://qti18306.live.dynatrace.com/api"
ARG DT_API_TOKEN="ZvgLQSrnRxejocKaSpI_z"
ARG DT_ONEAGENT_OPTIONS="flavor=all&include=ruby>"
ENV DT_HOME="/opt/dynatrace/oneagent"


COPY . /opt/app-root/src/
RUN scl enable rh-ruby22 "bundle install"
CMD ["scl", "enable", "rh-ruby22", "./run.sh"]

USER root
RUN chmod og+rw /opt/app-root/src/db

USEr root
RUN mkdir -p "$DT_HOME"

USER root
RUN chmod a+rwx -R "$DT_HOME"
USER root
RUN wget -O "$DT_HOME/oneagent.zip" "$DT_API_URL/v1/deployment/installer/agent/unix/paas/latest?Api-Token=$DT_API_TOKEN&$DT_ONEAGENT_OPTIONS" && \
    unzip -d "$DT_HOME" "$DT_HOME/oneagent.zip" && \
    rm "$DT_HOME/oneagent.zip"
    
    
USER default
