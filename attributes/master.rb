default['jenkins']['master'].tap do |master|
  # install
  # master['install_method'] = 'war'
  # master['version'] = '2.150.1'

  master['install_method'] = 'package'
  # In most cases latest LTS version is a good choice, but feel free to set a
  # specific version here
  #
  # master['version'] = nil
  master['channel'] = 'stable'
  master['jmx_port'] = '18080'
  master['jmx_ip'] = node['ipaddress']
  master['jvm_options'] = '-Djava.awt.headless=true'\
    ' -Xmx3072m -Djenkins.install.runSetupWizard=false'\
    ' -Dhudson.model.LoadStatistics.clock=100'\
    ' -Dcom.sun.management.jmxremote'\
    ' -Dcom.sun.management.jmxremote.authenticate=false'\
    ' -Dcom.sun.management.jmxremote.ssl=false'\
    ' -Dcom.sun.management.jmxremote.port=${JMX_PORT}'\
    ' -Dcom.sun.management.jmxremote.rmi.port=${JMX_PORT}'\
    ' -Djava.rmi.server.hostname=${JMX_IP}'
end