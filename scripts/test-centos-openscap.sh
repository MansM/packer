#!/bin/bash

#installing openscap
yum install -y scap-security-guide

#running openscap
oscap xccdf eval \
  --profile xccdf_org.ssgproject.content_profile_rht-ccp \
  --results-arf arf.xml \
  --report report.html \
 /usr/share/xml/scap/ssg/content/ssg-centos7-ds.xml