#!/usr/bin/env bash
set -euxo pipefail

variables_file="packer_variables.json"
template_file="packer.json"

# Allow overriding because Fedora/RedHat/CentOS users need to give the packer binary a different name usually because
# there is a packer package that is not related to 'packer.io'
packer_exec="${PACKER_EXEC:=packer}"

cat << EOF > packer_variables.json
{
  "build_number": "0",
  "builder": "${USER}",
  "commit": "local",
  "force_deregister": "true"
}
EOF

${packer_exec} validate -var-file=${variables_file} ${template_file}
${packer_exec} build -var-file=${variables_file} ${template_file} | tee packer.log
