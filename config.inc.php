<?php
// Database settings
$cfg['dbtype'] = 'mysql';
$cfg['dbserver'] = getenv('DB_HOST') ?: 'mariadb';
$cfg['dbport'] = '3306';
$cfg['dbname'] = getenv('DB_NAME') ?: 'nagiosxi';
$cfg['dbuser'] = getenv('DB_USER') ?: 'nagios';
$cfg['dbpass'] = getenv('DB_PASS') ?: 'nagiospass';

// XI-specific settings
$cfg['root_url'] = '/nagiosxi';
$cfg['use_ssl'] = false;
$cfg['use_https'] = false;

// Optional: enable debug logging
$cfg['debug'] = false;
