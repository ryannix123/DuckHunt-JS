FROM docker.io/nodeshift/centos7-s2i-nodejs
LABEL "io.openshift.s2i.build.image"="docker.io/nodeshift/centos7-s2i-nodejs" \
      "io.openshift.s2i.build.commit.author"="Vadim Rutkovsky <vrutkovs@redhat.com>" \
      "io.openshift.s2i.build.commit.date"="Tue Apr 12 12:08:24 2022 +0200" \
      "io.openshift.s2i.build.commit.id"="7318f3fccdb6877b3dc8a766be53608a9d1cba5b" \
      "io.openshift.s2i.build.commit.ref"="master" \
      "io.openshift.s2i.build.commit.message"="Disable all sounds" \
      "io.openshift.s2i.build.source-location"="https://github.com/vrutkovs/DuckHunt-JS.git"

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
