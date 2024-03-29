#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

SIKACOIND=${SIKACOIND:-$SRCDIR/sikacoind}
SIKACOINCLI=${SIKACOINCLI:-$SRCDIR/sikacoin-cli}
SIKACOINTX=${SIKACOINTX:-$SRCDIR/sikacoin-tx}
SIKACOINQT=${SIKACOINQT:-$SRCDIR/qt/sikacoin-qt}

[ ! -x $SIKACOIND ] && echo "$SIKACOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
SKCVER=($($SIKACOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for sikacoind if --version-string is not set,
# but has different outcomes for sikacoin-qt and sikacoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$SIKACOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $SIKACOIND $SIKACOINCLI $SIKACOINTX $SIKACOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${SKCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${SKCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
