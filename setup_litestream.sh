#!/bin/bash

wget https://github.com/benbjohnson/litestream/releases/download/v0.3.13/litestream-v0.3.13-linux-amd64.deb
dpkg -i litestream-v0.3.13-linux-amd64.deb
systemctl enable litestream
systemctl start litestream
