Need change entrypoint like: Before start CZ we should link /tmp/.czrc into /app folder
after CZ work we should remvoe vefore created link

/usr/local/bin script something like below

---

#!/bin/sh
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
docker run -v `git rev-parse --show-toplevel`:/app -ti --rm docker.oft-e.com/tools/conventional-commits:commitizen $@

---

also .git/hooks should have prepare-commit-msg with following

---

#!/bin/bash
#  If we should run the cz script from special user:group :
# docker run -v `git rev-parse --show-toplevel`:/app -ti --rm docker.oft-e.com/tools/conventional-commits:commitizen `id -u` `id -g` $@
# else:
# docker run -v `git rev-parse --show-toplevel`:/app -ti --rm docker.oft-e.com/tools/conventional-commits:commitizen $@

# if you should run bash in this docker container run command in the console:
# docker run -v `git rev-parse --show-toplevel`:/app -ti --rm docker.oft-e.com/tools/conventional-commits:commitizen bash

---



