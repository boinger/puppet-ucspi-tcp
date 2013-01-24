puppet-ucspi-tcp
================

* Install & manage ucspi-tcp (required for djbdns/tinydns)

* Notes:<ul><li>Defaults to pulling a specific version directly from http://cr.yp.to/daemontools/.
This isn't particularly ideal/best practice.
You should fork this project and make it install a package from your locally hosted binary repo.
</ul>

##Requirements##

* wget

##Usage##

###Basic
```puppet
class { 'ucspi::install': }
```
##License##

 Copyright (C) 2013 Jeff Vier <jeff@jeffvier.com> (Author)<br />
 License: Apache 2.0
