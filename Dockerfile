
FROM centos/ruby-22-centos7
USER default
EXPOSE 8080
ENV RACK_ENV production
ENV RAILS_ENV production


ARG DT_API_URL="https://qti18306.live.dynatrace.com/api"
ARG DT_API_TOKEN="ZvgLQSrnRxejocKaSpI_z"
ARG DT_ONEAGENT_OPTIONS="flavor=all&include=ruby>"
ENV DT_HOME="/opt/dynatrace/oneagent"
USER root
RUN mkdir -p "$DT_HOME"

WORKDIR "$DT_HOME"
RUN rm -f marc* &&  "wget https://qti18306.live.dynatrace.com/api/v1/deployment/installer/agent/unix/paas/latest?Api-Token=c1CD5Mn-QfyxsbvBiKT-k -O marc" && unzip -o marc && rm -f marc*

COPY . /opt/app-root/src/
RUN scl enable rh-ruby22 "bundle install"
CMD ["scl", "enable", "rh-ruby22", "./run.sh"]

USER root
RUN chmod og+rw /opt/app-root/src/db


    
    
USER default
