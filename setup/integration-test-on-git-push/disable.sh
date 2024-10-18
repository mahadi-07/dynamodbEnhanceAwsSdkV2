cd ../../
sleep 1

cd .git/hooks || exit

rm -f pre-commit
echo "remove force integration test enabled on git commit"
rm -f pre-push
echo "remove force integration test enabled on git push"