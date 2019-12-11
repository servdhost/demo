<?php
/**
 * Yii Application Config.
 *
 * Edit this file at your own risk!
 *
 * The array returned by this file will get merged with
 * vendor/craftcms/cms/src/config/app.php and app.[web|console].php, when
 * Craft's bootstrap script is defining the configuration for the entire
 * application.
 *
 * You can define custom modules and system components, and even override the
 * built-in system components.
 *
 * If you want to modify the application config for *only* web requests or
 * *only* console requests, create an app.web.php or app.console.php file in
 * your config/ folder, alongside this one.
 */

return [
    'modules' => [
        'my-module' => \modules\Module::class,
    ],
    'components' => [
        'log' => function () {
            return Craft::createObject([
                'class' => yii\log\Dispatcher::class,
                'targets' => [
                    [
                        'class' => codemix\streamlog\Target::class,
                        'url' => 'php://stderr',
                        'levels' => yii\log\Logger::LEVEL_ERROR,
                    ],
                ],
            ]);
        },
    ],
    'bootstrap' => ['my-module'],
];
