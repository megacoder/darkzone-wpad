all::	wpad.dat wpad.conf

check::
	@curl -s http://wpad/wpad.dat

diff::	/var/www/html/wpad.dat wpad.dat
	diff -uNp /var/www/html/wpad.dat wpad.dat

diff::	/etc/httpd/conf.d/wpad.conf wpad.conf
	diff -uNp /etc/httpd/conf.d/wpad.conf wpad.conf

install:: wpad.dat wpad.conf
	install -D -c -m 0444 wpad.dat /var/www/html/wpad.dat
	install -D -c -m 0444 wpad.conf /etc/httpd/conf.d/wpad.conf
	service httpd condrestart

import::
	@curl -s http://wpad/wpad.dat >wpad.dat.tmp && move-if-change wpad.dat.tmp wpad.dat

uninstall::
	${RM} /var/www/html/wpad.dat
	${RM} /etc/httpd/conf.d/wpad.conf
	service httpd condrestart

clean::

distclean clobber:: clean
