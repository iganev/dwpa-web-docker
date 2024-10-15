<?php
//phpMailer object creation and configuration
require_once('m/class.phpmailer.php');
require_once('m/class.smtp.php');

$mailer = new PHPMailer(true);
$mailer->IsSMTP();
$mailer->IsHTML(false);
$mailer->SMTPAuth   = true;
$mailer->SMTPSecure = 'tls';
$mailer->Host       = getenv("DWPA_MAIL_HOST") ?: '';
$mailer->Port       = getenv("DWPA_MAIL_PORT") ?: 587;
$mailer->SMTPKeepAlive = true;
$mailer->FromName   = getenv("DWPA_MAIL_NAME") ?: '';
$mailer->From       = getenv("DWPA_MAIL_FROM") ?: '';
$mailer->Username   = getenv("DWPA_MAIL_USER") ?: '';
$mailer->Password   = getenv("DWPA_MAIL_PASS") ?: '';
$mailer->CharSet    = 'utf-8';
?>
