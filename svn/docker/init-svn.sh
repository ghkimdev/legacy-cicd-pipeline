#!/bin/bash
set -e

for repo in sample-spring sample-react sample-fastapi
do

    REPO_PATH="/var/svn/repos/${repo}"

    if [ ! -d "${REPO_PATH}/db" ]; then

    	echo "Creating SVN repository..."
        svnadmin create "${REPO_PATH}"
        chown -R www-data:www-data ${REPO_PATH}

    	echo "Importing initial project structure..."
        svn mkdir \
          file://${REPO_PATH}/trunk \
          file://${REPO_PATH}/branches \
          file://${REPO_PATH}/tags \
          -m "Initialize layout"


    	svn import /seed/${repo} \
    	    file://${REPO_PATH}/trunk \
    	    -m "Initial repository structure"

    	echo "Installing hooks..."
        for hook in start-commit pre-commit post-commit; do
            cp /hooks/${hook} \
              "${REPO_PATH}/hooks/${hook}"

            chmod +x "${REPO_PATH}/hooks/${hook}"
        done
    	echo "SVN bootstrap complete."
    else
        echo "Repository already exists."
    fi
done
