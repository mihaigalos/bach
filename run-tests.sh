#!/usr/bin/env bash
set -uo pipefail

unset BACH_ASSERT_DIFF BACH_ASSERT_DIFF_OPTS
PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin

bash_bin="$BASH"

case "$(uname)" in
    Darwin)
        if ! brew list --full-name --versions bash &>/dev/null; then
            brew install bash
        fi
        if [[ "$BASH" == /bin/bash ]]; then
            bash_bin="$(brew --prefix)"/bin/bash
        fi
        ;;
esac

"$bash_bin" --version

retval=0
for file in tests/*.test.sh examples/learn*; do
    "$bash_bin" -euo pipefail "$file" || retval=1
done

exit "$retval"
