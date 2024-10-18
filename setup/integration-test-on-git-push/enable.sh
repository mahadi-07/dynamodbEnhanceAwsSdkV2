cd ../../
sleep 1

git init
cd .git/hooks || exit

#echo '#!/bin/bash
#echo "Running integration test before commit..."
#mvn clean -pl web-admin-control test
#' > pre-commit
#
#chmod +x pre-commit

echo '#!/bin/bash
echo "Running integration test before push..."
mvn clean -pl web-admin-control test
' > pre-push

chmod +x pre-push

#echo "force integration test enabled on git commit"
echo "force integration test enabled on git push"