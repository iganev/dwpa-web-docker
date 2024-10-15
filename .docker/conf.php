<?php
// DB Configuration
$cfg_db_host = 'database';
$cfg_db_user = getenv("DWPA_DB_USER");
$cfg_db_pass = getenv("DWPA_DB_PASS");
$cfg_db_name = getenv("DWPA_DB_NAME");

// reCaptcha auth
$publickey  = getenv("DWPA_RECAPTCHA_PUBLIC_KEY");
$privatekey = getenv("DWPA_RECAPTCHA_PRIVATE_KEY");

// Bosskey
$bosskey = getenv("DWPA_BOSS_KEY");

// 3wifi API key
$wifi3apikey = '';

// wigle API key
$wigleapikey = getenv("DWPA_WIGLE_API_KEY");

// App specific defines
define('HCXPCAPTOOL', '/usr/local/bin/hcxpcapngtool');
define('RKG', '/usr/local/bin/routerkeygen-cli');

define('CAP', '/srv/app/cap/');
define('CRACKED', '/srv/app/dict/cracked.txt.gz');

define('SHM', '/tmp/');
define('MIN_HC_VER', '2.1.1');
?>
