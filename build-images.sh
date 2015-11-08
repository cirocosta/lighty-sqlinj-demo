echo "Building vulnerable image ..."
mv ./vuln-Dockerfile Dockerfile
docker build -t lighttpd-vuln .
mv ./Dockerfile vuln-Dockerfile

# echo "Building patched image ..."
# mv ./patched-Dockerfile Dockerfile
# docker build -t lighttpd-patched .
# mv ./Dockerfile patched-Dockerfile
