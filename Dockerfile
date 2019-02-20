FROM alpine:latest
LABEL maintainer "contact@ilyaglotov.com"

RUN apk --update --no-cache add perl \
                                git \
                                perl-net-dns \
                                make \
                                \
  && git clone --branch=master \
               --depth=1 \
               https://github.com/kirei/fpdns \
  && cd fpdns \
  && perl Makefile.PL \
  && make \
  \
  && adduser -D fpdns \
  && apk del make git

ENV PERL5LIB /fpdns/lib

USER fpdns

ENTRYPOINT ["/fpdns/blib/script/fpdns"]
