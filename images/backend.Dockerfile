# syntax=docker/dockerfile:1.3

ARG ERPNEXT_VERSION
FROM frappe/erpnext-worker:${ERPNEXT_VERSION}

COPY repos ../apps

USER root

RUN install-app hrms
RUN install-app frappedesk
RUN install-app lms

USER frappe
