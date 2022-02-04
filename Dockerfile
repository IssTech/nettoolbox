# Pulling Debian Base Image
from debian:buster-slim

# Update Debian Packages
RUN apt update

# Install all networks tools
RUN apt install -y \
  bash \
  coreutils \
  dnsutils \
  curl

CMD ["sh"]
