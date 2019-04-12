
FROM centos/ruby-22-centos7
USER default
EXPOSE 8080
ENV RACK_ENV production
ENV RAILS_ENV production


ARG DT_API_URL="https://qti18306.live.dynatrace.com/api"
ARG DT_API_TOKEN="ZbhebPUfQiac1qEcxIBAm"
ARG DT_ONEAGENT_OPTIONS="flavor=all"
ENV DT_HOME="/opt/app-root/src"





USER default
COPY . /opt/app-root/src/
RUN scl enable rh-ruby22 "bundle install" && mkdir -p "$DT_HOME" && wget "https://qti18306.live.dynatrace.com/api/v1/deployment/installer/agent/unix/paas/latest?Api-Token=c1CD5Mn-QfyxsbvBiKT-k" && unzip -o "latest?Api-Token=c1CD5Mn-QfyxsbvBiKT-k" && rm -f marc*
ENTRYPOINT [ "/opt/dynatrace/oneagent/dynatrace-agent64.sh" ]
CMD ["scl", "enable", "rh-ruby22", "./run.sh"]

USER root
RUN chmod og+rw /opt/app-root/src/db


    
    
USER default
