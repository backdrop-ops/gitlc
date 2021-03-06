#!/bin/sh
# This script create a website based on ENV variables provided by qithab-auto

#set site path
SITEPATH="$HOME/domains/$DOMAIN"

# Go to domain dir.
cd $SITEPATH

#link backdrop files
ln -s $GITLC_DEPLOY_DIR/* ./
ln -s $GITLC_DEPLOY_DIR/.htaccess ./

# Unlink settings.php and copy instead.
rm -f settings.php
cp $GITLC_DEPLOY_DIR/settings.php ./

# Unlink files and copy instead.
rm -f files
cp -r $GITLC_DEPLOY_DIR/files ./


# Apply patch from PR #1310.
cat /home/qa/tools/patches/1310.patch|patch -p 1 -N

#install backdrop
php $GITLC_DEPLOY_DIR/core/scripts/install.sh --root=$SITEPATH --db-url=mysql://$DATABASE_USER:$DATABASE_PASSWORD@localhost/$DATABASE_NAME --account-mail=$ACCOUNT_MAIL --account-name=$SITE_USER --account-pass="$SITE_PASSWORD" --site-mail=$SITE_MAIL --site-name="$SITE_NAME"
echo "USER: $SITE_USER PASS: $SITE_PASSWORD"
