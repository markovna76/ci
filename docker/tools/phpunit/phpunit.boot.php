#!/usr/bin/env php

<?php

define('PHPUNIT_PATH', '/vendor/bin/phpunit');

$configPath = '';
$arguments = prepareArguments($argv);
for ($i = 0; $i < count($arguments); $i++){
    if ('--version' === $arguments[$i]) {
        echo "PHPUnit will.use.from.vendor\n";
        exit(0);
    } else {
        $configPath = getConfigPath($arguments[$i]);
        if ($configPath) {
            runPHPUNIT($arguments, $configPath);
            exit(0);
        }
    }
}
echo "PHPUnit config file not found\n\n";
exit(1);

function getConfigPath(string $path) : string
{
    if ((substr_count($path, '/') < 2)) {
        return '';
    }
    do {
        foreach (['local-', ''] as $cfgPfx) {
            $configPath = sprintf('%s/%sphpunit.xml', $path, $cfgPfx);
            if (is_file($configPath)) {
                return $configPath;
            }
        }
        $path = dirname($path);
    } while (!is_file($path . PHPUNIT_PATH) || $path != '/');
    return '';
}

function prepareArguments(array $arguments) : array
{
    return explode(
        ' ',
        preg_replace(
            '/--configuration\s*[^\s]+|--no-configuration/',
            '',
            implode(' ', array_slice($arguments, 1))
        )
    );
}

function runPHPUNIT(array $arguments, string $configPath): void
{
    $fullCmd = sprintf(
        '%s --configuration %s %s',
        dirname($configPath) . PHPUNIT_PATH,
        $configPath,
        implode(' ', $arguments)
    );

    printf('
        %1$s
        Project root: %2$s
        Phpunit path: %3$s
        Config path:  %4$s
        %1$s
        Running: %5$s
        
    ',
        str_pad('', strlen($configPath) + 18, '='),
        dirname($configPath),
        dirname($configPath) . PHPUNIT_PATH,
        $configPath,
        $fullCmd
    );
    system($fullCmd, $result_code);
    if ($result_code != 0) {
      exit(1);
    } else {
      exit(0);
    }
}