FROM registry.access.redhat.com/ubi8/nodejs-16
LABEL "io.k8s.display-name"="duckhunt-js" \
      "io.openshift.s2i.build.image"="registry.access.redhat.com/ubi8/nodejs-16" \
      "io.openshift.s2i.build.commit.author"="Ryan Nix <rnix@redhat.com>" \
      "io.openshift.s2i.build.commit.date"="Tue Mar 14 15:19:18 2023 -0500" \
      "io.openshift.s2i.build.commit.id"="faf42db70474dc19655a445b780c95adcb8044fe" \
      "io.openshift.s2i.build.commit.ref"="master" \
      "io.openshift.s2i.build.commit.message"="Changing title" \
      "io.openshift.s2i.build.source-location"="https://github.com/ryannix123/DuckHunt-JS.git"

USER root
# Copying in source code
COPY upload/src /tmp/src
# Change file ownership to the assemble user. Builder image must support chown command.
RUN chown -R 1001:0 /tmp/src
USER 1001
# Assemble script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
RUN /usr/libexec/s2i/assemble
# Run script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
CMD /usr/libexec/s2i/run
