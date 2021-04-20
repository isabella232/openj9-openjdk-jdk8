#!/bin/bash

# ===========================================================================
# (c) Copyright IBM Corp. 2020, 2021 All Rights Reserved
# ===========================================================================
# This code is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 only, as
# published by the Free Software Foundation.
#
# IBM designates this particular file as subject to the "Classpath" exception
# as provided by IBM in the LICENSE file that accompanied this code.
#
# This code is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# version 2 for more details (a copy is included in the LICENSE file that
# accompanied this code).
#
# You should have received a copy of the GNU General Public License version
# 2 along with this work; if not, see <http://www.gnu.org/licenses/>.
# ===========================================================================

cmd="$1" # Our first arg is the name of the command to be invoked
shift

args=()
for arg in "$@"; do
  case "$arg" in
    -I/*)
      arg="-I$(cygpath -w "${arg:2}")"
      ;;
    /DEF:/*)
      arg="/DEF:$(cygpath -w "${arg:5}")"
      ;;
    /pdb:/*)
      arg="/pdb:$(cygpath -w "${arg:5}")"
      ;;
    /cygdrive/*)
      arg="$(cygpath -w "$arg")"
      ;;
    *)
      ;;
  esac
  args+=("$arg")
done

"$cmd" "${args[@]}"