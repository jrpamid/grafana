# variables section
plugins=()
script_dir=/opt/grafana/scripts
GRAFANA_PLUGINS=/grafana/data/plugins

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
    unzip  /tmp/${plugin_name}.zip ${GRAFANA_PLUGNS}    
  done
  echo "Info :: deleting the donloaded plugin zip bundles"
  rm -f /tmp/grafana*.zip

}


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
