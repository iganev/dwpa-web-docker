<?php
//phpMailer object creation and configuration
require_once('m/class.phpmailer.php');
require_once('m/class.smtp.php');

$mailer = new PHPMailer(true);
$mailer->IsSMTP();
$mailer->IsHTML(false);
$mailer->SMTPAuth   = true;
$mailer->SMTPSecure = 'tls';
$mailer->Host       = getenv("MAIL_HOST") ?: '';
$mailer->Port       = getenv("MAIL_PORT") ?: 587;
$mailer->SMTPKeepAlive = true;
$mailer->FromName   = getenv("MAIL_NAME") ?: '';
$mailer->From       = getenv("MAIL_FROM") ?: '';
$mailer->Username   = getenv("MAIL_USER") ?: '';
$mailer->Password   = getenv("MAIL_PASS") ?: '';
$mailer->CharSet    = 'utf-8';
?>
