#!/bin/bash

set -e

#The following variables are user configurable
SKIN_PATH=`/bin/pwd`
OTRS_USER="www-data"
OTRS_GROUP="users"
OTRS_ROOT="/opt/otrs"

#make theme directory
/bin/mkdir -p $OTRS_ROOT/Kernel/Output/HTML/Nerim

#Fix permissions and make the proper symlinks
/bin/chown -R $OTRS_USER:$OTRS_GROUP $SKIN_PATH
/bin/chown -R $OTRS_USER:$OTRS_GROUP $OTRS_ROOT/Kernel/Output/HTML/Nerim
/usr/bin/find $SKIN_PATH/skins/ -type f -print0 | xargs -0 /bin/chmod 0660
/usr/bin/find $SKIN_PATH/skins/ -type d -print0 | xargs -0 /bin/chmod 2770

/bin/ln -s $SKIN_PATH/NerimSkin.xml $OTRS_ROOT/Kernel/Config/Files/ || true
/bin/chown -h $OTRS_USER:$OTRS_GROUP $OTRS_ROOT/Kernel/Config/Files/NerimSkin.xml
/bin/ln -s $SKIN_PATH/skins/Agent/Nerim $OTRS_ROOT/var/httpd/htdocs/skins/Agent || true
/bin/chown -h $OTRS_USER:$OTRS_GROUP $OTRS_ROOT/var/httpd/htdocs/skins/Agent/Nerim
/bin/ln -s $SKIN_PATH/skins/Customer/Nerim $OTRS_ROOT/var/httpd/htdocs/skins/Customer || true
/bin/chown -h $OTRS_USER:$OTRS_GROUP $OTRS_ROOT/var/httpd/htdocs/skins/Customer/Nerim

/bin/cp -r $SKIN_PATH/theme/Nerim $OTRS_ROOT/Kernel/Output/HTML

echo ""
echo "==========================================================="
echo "All set. Now you can use the NERIM skin and theme in otrs"
echo "==========================================================="
echo ""
