#install openshift clients
#version from OCP_VERSION env variable set in Dockerfile
set -e 

function downloadClients
{
  echo "Downloading clients..."
  local __oc_client_filename=openshift-client-linux.tar.gz

  local dlurl=https://mirror.openshift.com/pub/openshift-v4/clients/ocp/$OCP_VERSION
  curl $dlurl/${__oc_client_filename} > ${__oc_client_filename}

  echo "Copying oc and kubectl to /usr/local/bin/..."
  tar  -C /usr/local/bin/ -xf ${__oc_client_filename}

  echo "Downloading openshift-install..."
  local __oc_install_filename=openshift-install-linux.tar.gz
  curl $dlurl/${__oc_install_filename} > ${__oc_install_filename}
  echo "Copying openshift-install to /usr/local/bin/"
  tar  -C /usr/local/bin/ -xf ${__oc_install_filename}

  #remove downloaded files
  rm -rf $__oc_client_filename $__oc_install_filename
  echo "Downloading clients...done."

}
#download openshift clients
downloadClients
