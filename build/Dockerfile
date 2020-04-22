FROM debian:10

# Install dependancies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        ca-certificates git build-essential clang libace-dev libssl-dev \
        cmake default-libmysqlclient-dev

# Create and switch to compilation dir
WORKDIR /mangos-zero

# Change directory permissions created by root
RUN chown 1000:1000 . && chmod 755 .

# Switch to regular user
USER 1000:1000

# Build and copy binaries and configuration files to local folders
ENTRYPOINT git clone https://github.com/mangoszero/server.git \
            --recursive --depth 1 \
            && mkdir server/build \
            && cd server/build \
            # Configure
            && cmake .. -DCMAKE_INSTALL_PREFIX=/mangos-zero/world \
                        -DCMAKE_C_COMPILER=/usr/bin/clang \
                        -DCMAKE_CXX_COMPILER=/usr/bin/clang++ \
            # Compile
            && NB_CORES=`grep -c ^processor /proc/cpuinfo` \
            && make -j $NB_CORES \
            && make install -j $NB_CORES \
            # Copy tools
            && cd /mangos-zero/world/bin \
            && cp -r `find . -maxdepth 1 | grep -Ev 'mangosd|realmd|^.$'` \
                /world/tools \
            # Copy binaries
            && cp /mangos-zero/world/bin/mangosd /world/bin \
            && cp /mangos-zero/world/bin/realmd /realmd/bin \
            # Copy configuration
            && cp /mangos-zero/etc/ahbot.conf.dist /world/etc \
            && cp /mangos-zero/etc/mangosd.conf.dist /world/etc \
            && cp /mangos-zero/etc/realmd.conf.dist /realmd/etc \
            # Copy mangos sources
            && cp -r /mangos-zero/server /world/src/

