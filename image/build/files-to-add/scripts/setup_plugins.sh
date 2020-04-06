# variables section
plugins=()
script_dir=/opt/grafana/scripts

if [ ! -z "${GRAFANA_DATA}" ]; then
  export GRAFANA_DATA=/grafana/data
  echo "Info :: Setting Grafana data dir = ${GRAFANA_DATA}"
  export GRAFANA_LOGS=/opt/grafana/logs
  echo "Info :: Setting Grafana Log dir = ${GRAFANA_LOGS}"
  export GRAFANA_PLUGINS=${GRAFANA_DATA}/plugins
  echo "Info :: Setting Grafana Plugins dir = ${GRAFANA_PLUGINS}"
  export GRAFANA_PROVISIONING=${GRAFANA_DATA}/provisioning
  echo "Info :: Setting Grafana provisioning dir = ${GRAFANA_PROVISIONING}"
fi

setup_paths()
{
  mkdir -p $GRAFANA_DATA
  mkdir -p $GRAFANA_LOGS
  mkdir -p $GRAFANA_PLUGINS
  mkdir -p $GRAFANA_PROVISIONING 
}

install_plugins()
{
  echo "Installing plugins"
  for line in $plugins
  do
    echo "Info :: processing plugin entry $line"
    plugin_name=`echo $line | cut -d"=" -f1`
    download_url=`echo $line | cut -d"=" -f2`
    echo "Info :: $plugin_name "
    echo "Info :: $download_url"
    cd ${GRAFANA_PLUGINS}
    wget -q ${download_url} -O /tmp/${plugin_name}.zip 
    unzip /tmp/${plugin_name}.zip ${GRAFANA_PLUGNS}    
  done
  echo "Info :: deleting the donloaded plugin zip bundles"
  rm -f /tmp/grafana*.zip

}


echo "Info :: Checking Grafana Environment Variables"
setup_paths

echo "Info :: Executing setup script"
echo "Info :: Checking for plugins_list.txt file"
plugin_list=${script_dir}/plugins_list.txt
if [ -f ${plugin_list} ]; then
  echo "Info :: plugins list $plugin_list file found"
  plugins=`cat $plugin_list`
  if [ -n "$plugins" ]; then
    echo "Info :: plugins_list is not empty. proceesing with plugins install"
    install_plugins
  else
    echo "Warn :: plugins_list is empty. nothing to  install"
  fi
fi   
