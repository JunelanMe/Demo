class osphp {
     
   $base_packages_list = [
    'rsync',
    'wget',
    'unzip',
    'bzip2',
    'gcc-c++',
    'libstdc++-devel',
    'cmake',
    'gcc',
    'pcre-devel',
    'openssl',
    'openssl-devel',
    'mlocate',
    'libxml2-devel',
    'nfs-utils',
    'ntp',
    'rpcbind',
    'initscripts',
    'gd',
   ]

   $php_package_list = [
    'php-mysql',
    'php',
    'php-bcmath',
    'php-devel',
    'php-fpm',
    'php-gd',
    'php-intl',
    'php-xml',
    'php-mcrypt',
    'php-mbstring',
    'php-mysqlnd',
    'php-opcache',#for cpdf collect the os load
    'php-pdo',
    'php-pear',
    'php-pecl-geoip',
    'php-pecl-xdebug',
    'php-pecl-zip',
   ]

     package { $base_packages_list :
    ensure  => installed,
    before  => Package[$php_package_list],
    require => Yumrepo['remi'],
  }

  notify { 'pkg-install':
    message => '----- Base pkgs installation completed -----',
  }

    package { $php_package_list :
    ensure  => installed,
    require => Yumrepo['remi-php70'],
  }

        yumrepo { "remi-php70":
        baseurl    => "http://repo1.sea.innoscale.net/remi/enterprise/7/php70/x86_64/",
        mirrorlist => absent,
        descr      => "Remi's PHP 7.0 RPM repository for Enterprise Linux 7 - \$basearch",
        enabled    => 1,
        priority => 1,
        gpgcheck   => 0, 
        }
  
    service { 'php-fpm':
    enable  => true,
    ensure  => running,
    require => Package['php-fpm'],
  }

      yumrepo { "remi":
      mirrorlist => "http://rpms.famillecollet.com/enterprise/7/remi/mirror",
      descr      => 'Les RPM de remi pour Enterprise Linux 7 - $basearch',
      enabled    => 1,
      priority => 2,
      gpgcheck   => 0
    }

}