<?php
if (
    isset($_SERVER['HTTP_X_FORWARDED_PROTO']) &&
    strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false
) {
    $cfg['PmaAbsoluteUri'] = 'https://pma.cloud-42project-overkill.me/';
    $cfg['ForceSSL'] = true;
    $cfg['CookieSecure'] = true;
} else {
    $cfg['PmaAbsoluteUri'] = 'http://pma.cloud-42project-overkill.me/';
    $cfg['ForceSSL'] = false;
    $cfg['CookieSecure'] = false;
}
