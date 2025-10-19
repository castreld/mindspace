<?php

return [
    'paths' => ['api/*', 'storage/*', 'sanctum/csrf-cookie', 'broadcasting/auth'],
    
    'allowed_methods' => ['*'],

    'allowed_origins' => [
        'https://racially-semituberous-adelia.ngrok-free.dev',
        'http://localhost:8000',
    ],

    'allowed_origins_patterns' => [
        '#^http://localhost:\d+$#',
    ],

    'allowed_headers' => [
        'Content-Type',
        'Authorization',
        'Accept',
        'X-Requested-With',
        '*'
    ],

    'exposed_headers' => [],

    'max_age' => 3600,

    'supports_credentials' => true,
];