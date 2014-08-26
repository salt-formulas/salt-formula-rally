# Rally
Rally is a Benchmark-as-a-Service project for OpenStack.

## Sample pillars

    rally:
    test:
      enabled: true
      source:
        engine: git
        address: git://github.com/stackforge/rally.git
        revision: master
      cloud:
        example:
          auth_url: http://example.net:5000/v2.0/
          username: admin
          password: myadminpass
          tenant_name: demo
        

## Read more
* https://www.mirantis.com/blog/rally-openstack-tempest-testing-made-simpler/
* https://wiki.openstack.org/wiki/Rally
* https://wiki.openstack.org/wiki/Rally/HowTo
* https://launchpad.net/rally
* https://github.com/stackforge/rally
* https://trello.com/b/DoD8aeZy/rally