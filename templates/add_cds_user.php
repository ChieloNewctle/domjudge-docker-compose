#!/usr/bin/env php
<?php declare(strict_types=1);

if (isset($_SERVER['REMOTE_ADDR'])) {
    die("Commandline use only");
}

$ROLES = array(9, 10, 11);

require('/opt/domjudge/domserver/etc/domserver-static.php');
require(ETCDIR . '/domserver-config.php');

require(LIBDIR . '/init.php');

setup_database_connection();

$id = $DB->q(
    "RETURNID INSERT INTO user (username, name, password) VALUES ('cds', 'cds', %s)",
    dj_password_hash('${domserver_cds_password}')
);

foreach ($ROLES as $role) {
    $DB->q("INSERT INTO userrole (userid, roleid) VALUES (%i, %i)", $id, $role);
}
