class openerp::server {
  package{'openerp-server':
    ensure => installed,
  }

  if !$openerp_postgres_password { fail("You need to deinfe \$openerp_postgres_password for ${fqdn}") }
  postgres::role{'openerp':
    options => 'CREATEDB',
    password => $openerp_postgres_password
  }

  service{'openerp-server':
    ensure => running,
    enable => true,
    require => [ Package['openerp-server'], Postgres::Role['openerp'] ],
  }
}
