# syntax=docker/dockerfile:1.3

ARG FRAPPE_VERSION
ARG ERPNEXT_VERSION

FROM frappe/bench:latest as assets

ARG FRAPPE_VERSION
ARG ERPNEXT_VERSION

USER root

WORKDIR /builds

RUN chown -R frappe:frappe /builds

USER frappe

RUN bench init --version=${FRAPPE_VERSION} --skip-redis-config-generation --verbose --skip-assets /builds/bench

WORKDIR /builds/bench

# Comment following if ERPNext not required
RUN bench get-app --branch=${ERPNEXT_VERSION} --skip-assets --resolve-deps erpnext

COPY --chown=frappe:frappe repos apps

RUN bench setup requirements

RUN bench build --production --verbose --hard-link

FROM frappe/frappe-nginx:${FRAPPE_VERSION}

USER root

RUN rm -fr /usr/share/nginx/html/assets

COPY --from=assets /builds/bench/sites/assets /usr/share/nginx/html/assets

USER 1000
