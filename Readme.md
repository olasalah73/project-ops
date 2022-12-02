***Project***
--
***
*build , test and deploy simple java application on eks cluster using CI/CD jenkins pipeline*
***
**setup**
-
```
- provision full infrastructure using terraform .
- deploy jenkins on kubernets using ansible .
- install sonatype nexus on ec2 using ansible .
- install sonarqube .
- createing CI/CD pipeline to build test and deploy the application to production .
```
***
***Terraform***
-
```
- creating vpc
- 2 public and private subnets 
- route tables
- security groups
- eks cluster
- node group in private subnets
- 1 ec2 instance on public subnet
- nat gatway

and running all the .tf file
(terraform init)
(terraform validate)
(terraform plan)
(terraform apply)

```
***
***Ansible***
-
``` 
- jenkins role
   * Connecting to eks cluster.
   * Creating new namespace for jenkins .
   * apply jenkins yaml file deployment and svc.
- nexus playbook
   * install java version 8 and net tools .
   * download and untar nexus installer .
   * create nexus user and make it owner of nexus dir and sonatype-work dir .
   * starting nexus using nexus user and verify that with netstat .
```
***
***docker***
-
```
- writing docker file 
- running the container image
```
***
***kubectl***
--
```
- create yaml files for (pod,deployment and svc) for app and jenkins
(kubectl apply -f)
```
***
***Maven***
```
- build jar file 
- create junit test using Jacoco plugin which installed in pom.xml
```
***
***Jenkins***
-
```
* install jenkins plugins ( sonarqube scanner - nexus paltform - JaCoCo-plugin )
* Create pipeline to automate :
  - build jar file using mvn package .
  - mvn test to run the test cases .
  - Static application security testing with SonarQube to scan code for finding security defects .
  - build docker image from docker file and push that image to nexus docker repository .
  - deploy the application to production .
```
***
***in real life application***

- More than one branch for different environments
***
 ![alt text](https://github.com/olasalah73/project-ops/blob/cc82e846508ae3798b5f7046e99d93ce18b1bc28/img/diagram-project.jpg)
***

