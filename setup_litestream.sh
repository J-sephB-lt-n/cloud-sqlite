#!/bin/bash

wget https://github.com/benbjohnson/litestream/releases/download/v0.3.13/litestream-v0.3.13-linux-amd64.deb
dpkg -i litestream-v0.3.13-linux-amd64.deb
mv ./litestream.yml /etc/litestream.yml
systemctl enable litestream
systemctl start litestream
