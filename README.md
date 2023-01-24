


# OpenStack Administration with Ansible 2
This is the code repository for [OpenStack Administration with Ansible 2](https://www.packtpub.com/virtualization-and-cloud/openstack-administration-ansible-2-second-edition?utm_source=github&utm_medium=repository&utm_content=9781787121638), published by Packt. It contains all the supporting project files necessary to work through the book from start to finish.
## Instructions and Navigations
All of the code is organized into folders. Each folder starts with a number followed by the application name. For example, chap2-code

The code will look like the following:
       
        - name: User password assignment 
         debug: msg="User {{ item.0 }} was added to {{ item.2 }} project, with the assigned password of {{ item.1 }}" 
         with_together: 
        - userid 
        - passwdss.stdout_lines 
        - tenantid 

### Software requirements:

* Linux based OS, OS X and/or any of the BSD’s
       
       * openstack-ansible (OSA): https://github.com/openstack/openstack-ansible
       * Ansible 2.0 or better  : http://docs.ansible.com/ansible/intro_installation.html
       * Ansible Container      : https://docs.ansible.com/ansible-container/installation.html
       * Kargo                  : https://github.com/kubernetes-incubator/kargo
       * Nagios                 : https://assets.nagios.com/downloads/nagioscore/docs/nagioscore/4/en/quickstart.html
       * Nconf                  : http://www.nconf.org/dokuwiki/doku.php?id=nconf:help:documentation:start:installation
       
## Related Products:

* [OpenStack Cloud Computing Cookbook - Third Edition]( https://www.packtpub.com/virtualization-and-cloud/openstack-cloud-computing-cookbook-third-edition?utm_source=github&utm_medium=repository&utm_content=9781782174783 )

* [OpenStack: Building a Cloud Environment]( https://www.packtpub.com/virtualization-and-cloud/openstack-building-cloud-environment?utm_source=github&utm_medium=repository&utm_content=9781787123182 )

* [Ansible 2 for Beginners [Video]]( https://www.packtpub.com/networking-and-servers/ansible-2-beginners-video?utm_source=github&utm_medium=repository&utm_content=9781786465719 )

###Suggestions and Feedback
[Click here] ( https://docs.google.com/forms/d/e/1FAIpQLSe5qwunkGf6PUvzPirPDtuy1Du5Rlzew23UBp2S-P3wB-GcwQ/viewform ) if you have any feedback or suggestions.
### Download a free PDF

 <i>If you have already purchased a print or Kindle version of this book, you can get a DRM-free PDF version at no cost.<br>Simply click on the link to claim your free PDF.</i>
<p align="center"> <a href="https://packt.link/free-ebook/9781785884610">https://packt.link/free-ebook/9781785884610 </a> </p>