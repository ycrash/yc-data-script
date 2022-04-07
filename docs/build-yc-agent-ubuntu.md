# Build yCrash agent in Ubuntu

Please follow the below steps to compile and build yCrash agent in Ubuntu.

1. Install the below packages

```
apt update \
 && apt install -y \
    curl \
    gcc \
    make \
    git \
    wget \
    vim \
 && apt clean \
 && apt autoremove -y \
 && rm -rf /var/lib/apt/lists/*
```
2. Create a new directory ```/opt/workspace/go``` to install Go.

```
mkdir -p /opt/workspace/go
```
3. Download the Go and set the path

```
cd /opt/workspace/go

curl -LSs https://dl.google.com/go/go1.16.4.linux-amd64.tar.gz -o go.tar.gz \
 && tar -xvf go.tar.gz \
 && rm -v go.tar.gz \
 && mv go /usr/local \
 && rm -rf /var/lib/apt/lists/*
 
 PATH=${PATH}:/usr/local/go/bin
```
4. Download and install ```musl``` package.

```
curl -LSs https://www.musl-libc.org/releases/musl-1.2.2.tar.gz -o musl-1.2.2.tar.gz \
 && tar -xvf musl-1.2.2.tar.gz \
 && cd musl-1.2.2 \
 && ./configure \
 && make \
 && make install \
 && cd .. \
 && rm -rf musl*
 
 CC=/usr/local/musl/bin/musl-gcc
```
5. Create a new directory for yCrash agent and clone the project.

```
mkdir yc-agent-repo

git clone https://github.com/ycrash/ycrash-agent.git
```
7. Go to ```/opt/workspace/yc-agent-repo/ycrash-agent/yc``` directory and run the below command command to compile and build the yCrash agent

```
go build -a -ldflags "-linkmode external -extldflags '-static' -s -w"
```
9. Once the build is completed, you will find ```yc.sh``` file inside ```/opt/workspace/yc-agent-repo/ycrash-agent/yc``` directory. 

You can find different yCrash agent arguments in the [official documentation](https://docs.ycrash.io/ycrash-agent/all-agent-arguments.html#all-arguments).
