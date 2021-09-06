# ensure there's a test.bacpac file in the same directory
docker build --build-arg DB=test -t test_db .
docker run -d -p 1433:1433 test_db