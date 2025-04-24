#!/bin/bash

# maybe it is not latest version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# install node
nvm install node
nvm use node

# install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

