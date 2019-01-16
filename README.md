# Jenkins setup & configuration with Chef & JCasC

<p align="center">
  <img src="https://github.com/tomaszmichalak/jenkins-as-a-code/blob/master/assets/jenkins-dashboard.png?raw=true" alt="Jenkins dashboard"/>
</p>

This is a wrapper cookbook for the [Jenkins Chef cookbook](https://github.com/chef-cookbooks/jenkins).

It automate steps:
- installs Jenkins from the last stable package. 
- configures the [JCasC plugin](https://jenkins.io/projects/jcasc/)
- initializes a [jenkins.yaml](https://github.com/tomaszmichalak/jenkins-as-a-code/blob/master/files/default/var/lib/jenkins/jenkins.yml) file

The `jenkins.yaml` file allows to define:
- required plugins
- plugins configurations
- jobs (with [Job DSL](https://github.com/jenkinsci/job-dsl-plugin))

with a simple, human-friendly, plain text `yaml` syntax.

## How to run?
Use Kitchen to run your Jenkins instance locally:

`$> kitchen converge`

Then you can open [http://192.168.33.1:8080/](http://192.168.33.1:8080/login?from=%2F) and login with
credentials `admin/admin`.

Please note that the Jenkins initialization can take some time (required plugins and jobs are 
preconfigured asynchronously during Jenkins restart). You can view Jenkins logs to validate the state:

```$xslt
$> kitchen login
$> tail -f /var/log/jenkins/jenkins.log
Jan 16, 2019 7:45:54 AM hudson.WebAppMain$3 run
INFO: Jenkins is fully up and running
```


