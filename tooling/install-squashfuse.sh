#/bin/bash
set -e

cd /tmp
wget -c -q "https://github.com/vasi/squashfuse/archive/e51978c.tar.gz" -O /tmp/squashfuse-e51978c.tar.gz

tar xf squashfuse-e51978c.tar.gz
cd squashfuse-*/

./autogen.sh
./configure CFLAGS=-no-pie LDFLAGS=-static

make -j$(nproc)
make install

/usr/bin/install -c -m 644 *.h '/usr/local/include/squashfuse' # ll.h

# rm -rf /tmp/squashfuse-*/
