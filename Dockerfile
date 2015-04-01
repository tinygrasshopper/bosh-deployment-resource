FROM concourse/busyboxplus:ruby

ADD gems /tmp/gems

RUN gem install /tmp/gems/*.gem --no-document && \
    gem install bosh_cli --no-document

ADD . /tmp/resource-gem

RUN cd /tmp/resource-gem && \
    gem build *.gemspec && gem install *.gem --no-document && \
    mkdir -p /opt/resource && \
    ln -s $(which bdr_check) /opt/resource/check && \
    ln -s $(which bdr_out) /opt/resource/out