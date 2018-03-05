#!/bin/bash
set -u

SRC_DIR=/root/src/review.opencontrail.org/Juniper/
c_p_c_rev=c5beff384
c_z_j_rev=fc62da4a8

mkdir -p ${SRC_DIR}

function checkout() {
  local repo=$1
  local rev=${2:-master}
  local repopath=${SRC_DIR}/${repo}

  test -d ${repopath} || git clone https://github.com/Juniper/${repo} ${repopath}
  pushd ${repopath} >/dev/null
  git fetch origin
  echo -n "${repo}: "
  git checkout -B dev-env ${rev} >/dev/null
  git reset --hard >/dev/null
  popd >/dev/null 

}

checkout contrail-project-config $c_p_c_rev
checkout contrail-zuul-jobs $c_z_j_rev

