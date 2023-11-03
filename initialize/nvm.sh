#!/bin/bash
# install nvm and node, which is used in copilot
# maybe it is not latest version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# install node
nvm install node@latest

# install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

