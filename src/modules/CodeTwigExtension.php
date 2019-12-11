<?php

namespace modules;

class CodeTwigExtension extends \Twig_Extension
{
    public function getFilters()
    {
        return [
            new \Twig_Filter('backticksToCode', function ($string) {
                return preg_replace('/`([^`]+)`/i', '<span class="bg-grey-light rounded px-2 py-1 font-logs text-red text-lg">$1</span>', $string);
            }),
        ];
    }
}
