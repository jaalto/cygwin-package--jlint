#!/bin/sh
#
# install-after.sh -- Custom installation
#
# The script will receive one argument: relative path to
# installation root directory. Script is called like:
#
#    $ install-after.sh .inst
#
# This script is run after [install] command.

Cmd()
{
    echo "$@"
    [ "$test" ] && return
    "$@"
}

Main()
{
    root=${1:-".inst"}

    if [ "$root"  ] && [ -d $root ]; then

        root=$(echo $root | sed 's,/$,,')  # Delete trailing slash

        docdir=$(cd $root/usr/share/doc/jlint && pwd)

        [ ! "$docdir" ] && return 1

        PATH=".:$PATH"

        Cmd install -m 644 *.texi jlint.sh $docdir/
        Cmd cd $docdir/
        Cmd texi2html *.texi

        echo "Remove unneeded file (was need in texi: @include jlint.sh)"
        Cmd rm -f jlint.sh
    fi
}

Main "$@"

# End of file
