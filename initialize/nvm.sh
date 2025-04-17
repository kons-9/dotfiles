#!/bin/bash
# install nvm and node, which is used in copilot
# maybe it is not latest version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# install node
nvm install node@latest

# install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

