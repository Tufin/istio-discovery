.PHONY: docker

BINARY=istio-discovery
DOCKER_REPO=tufin
IMAGE=$(DOCKER_REPO)/istio-discovery

clean:
	rm $(BINARY)

build:
	GOOS=linux GOARCH=amd64 go build -o .dist/$(BINARY)

test:
	go test `go list ./...`

docker:
	docker build --build-arg=binary=$(BINARY) -t $(IMAGE) -f docker/Dockerfile .dist

deploy:
	docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)
	docker push $(IMAGE)

