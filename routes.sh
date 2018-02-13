#!/bin/bash

NROUTES=1000


function create_routes() {
  local n=${1:-$NROUTES}
  for i in `seq $n`; do
    echo "  - Creating route header-test-route-$i ... "
    sed "s/%1/$i/g" route.json.template | oc create -f -
  done
}


function delete_routes() {
  local n=${1:-$NROUTES}
  for i in `seq $n`; do
    echo "  - Deleting route header-test-route-$i ... "
    oc delete route header-test-route-$i
    # [ $((i%50)) == 0 ] && sleep 2
  done
}


function stress_route_recreate() {
  local n=${1:-$NROUTES}
  local name="stress1"
  for i in `seq $n`; do
    echo "  - Creating/Deleting route header-test-route-$name #$i ... "
    oc delete route header-test-route-$name
    sed "s/%1/$name/g" route.json.template | oc create -f -
  done
}

#
#  main():
#
script=$(basename "$0")
case "${script}" in 
  create-routes) create_routes  "$@"           ;;

  delete-routes) delete_routes  "$@"           ;;

  stress-recreate) stress_route_recreate  "$@" ;;

  *)  echo "ERROR: unknown script ${script} "  ;;
esac
