class nginx {
	  package { 'nginx':
    ensure  => installed,
    require => File["/etc/yum.repos.d/nginx.repo"],
    notify  => Service['nginx'],
  }

    file { "/etc/yum.repos.d/nginx.repo":
    ensure => file,
    group  => root, owner  => root,
    mode   => 644,
    source => 'puppet:///modules/nginx/nginx.repo',
  }

    service { 'nginx':
    ensure  => running,
    enable  => true,
  }

        file { '/etc/nginx/conf.d/vhost-local.conf':
        ensure => file,
        mode => 644,
        source => 'puppet:///modules/nginx/vhost-local.conf',
        require => Package["nginx"],
        }
        

}