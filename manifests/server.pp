class openerp::server {
  package{'openerp-server':
    ensure => installed,
  }

  if !$openerp_postgres_password { fail("You need to deinfe \$openerp_postgres_password for ${fqdn}") }
  postgres::role{'openerp':
    password => $openerp_postgres_password
  }
  postgres::database{'openerp':
    owner => 'openerp',
    encoding => 'UTF8',
    require => Postgres::Role['openerp'], 
  }

  service{'openerp-server':
    ensure => running,
    enable => true,
    require => [ Package['openerp-server'], Postgres::Role['openerp'] ],
  }
}
