
=====
Rally
=====

Rally is a Benchmark-as-a-Service project for OpenStack.

Sample pillars
==============

.. code-block:: yaml

    rally:
      benchmark:
        enabled: true
        source:
          engine: git
          address: git://github.com/stackforge/rally.git
          revision: master
        database:
          engine: mysql
          host: 10.10.20.20
          port: 3306
          name: rally
          user: rally
          password: password
        provider:
          example_cloud:
            auth:
              auth_url: http://example.net:5000/v2.0/
              username: admin
              password: myadminpass
              tenant_name: demo
            tests:
            - nova_volumes
            - neutron_networks

Rally client with specified git scenarios

.. code-block:: yaml

    rally:
      client:
        enabled: true
        source:
          engine: git
          address: git@repo.domain.com/heat-templates.git
          revision: master

Read more
=========

* https://rally.readthedocs.org/en/latest/install.html
* https://www.mirantis.com/blog/rally-openstack-tempest-testing-made-simpler/
* https://wiki.openstack.org/wiki/Rally
* https://wiki.openstack.org/wiki/Rally/HowTo
* https://launchpad.net/rally
* https://github.com/stackforge/rally
* https://trello.com/b/DoD8aeZy/rally