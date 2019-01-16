default['jenkins']['master'].tap do |master|
  master['install_method'] = 'package'
  # jenkins version
  # master['version'] =
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