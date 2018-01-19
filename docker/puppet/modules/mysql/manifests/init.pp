class mysql {

    $mysql_packages_list = [
      'mysql-community-server',
      'mysql-community-client',
  ]

      yumrepo { "mysql56-community":
        baseurl    => "http://repo.mysql.com/yum/mysql-5.6-community/el/7/x86_64/",
        mirrorlist => absent,
        descr      => "MySQL 5.6 Community Server",
        enabled    => 1,
        gpgcheck   => 0, }

      package { $mysql_packages_list :
        ensure  => installed,
        require => Yumrepo['mysql56-community'],
      }

    service { 'mysqld':
    enable  => true,
    ensure  => running,
    require => Package['mysql-community-server'],
  }  

}