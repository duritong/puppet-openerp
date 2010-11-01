class openerp::web {
  require openerp::server

  package{'openerp-web': ensure => present }

  file{'/etc/openerp-web.cfg':
    source => "puppet:///modules/site-openerp/${fqdn}/openerp-web.cfg",
    require => Package['openerp-web'],
    notify => Service['openerp-web'],
    owner => root, group => openerp, mode => 0640;
  }

  service{'openerp-web':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
  }
}
