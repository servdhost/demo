module.exports = {
    plugins: [
        require('glhd-tailwindcss-transitions')({
            transitionDelay: {
                default: '0s'
            }
        }),
    ],
    theme: {
        extend: {
            maxWidth: {
                '7xl': '80rem'
            }
        },
        fontFamily: {
            'body': ['Poppins', 'sans-serif'],
            'heading': ['ABeeZee', 'sans-serif'],
            'logs': ['Inconsolata', 'monospace'],
        },
        colors: {
            green: {
                default: '#1ea55a',
                button: '#1c863a',
                light: '#6ac283'
            },
            orange: {
                default: '#ff9a33',
                light: '#f9e0c2',
                dark: '#ff9a33'
            },
            blue: {
                default: '#2c2f40',
                dark: '#0F0F30',
                light: '#e5e5ec'
            },
            red: {
               default: '#ff3333',
               light: '#fad1d1',
               dark: '#914141'
            },
            hr: {
                light: 'rgba(255,255,255,0.15)',
                dark: 'rgba(0,0,0,0.15)'
            },
            beige: {
                default: '#e9cdb4',
                dark: '#a28265',
                light: '#fde7d3'
            },
            mint: {
                default: '#93FEB8',
                dark: '#77d197',
                light: '#c9fedb'
            },
            craft_red: '#e5422b',
            transparent: 'transparent',
            black: '#000',
            white: '#fff',
            grey: {
                default: '#939497',
                dark: '#45504a',
                light: '#f1f1f4'
            },
            error: '#ff3333',
        },
        inset: {
            '0': 0,
            auto: 'auto',
            sidebar: '56rem',
        }
    },
    variants: {
        opacity: ['responsive', 'hover'],
        display: ['group-hover', 'responsive']
    }
}
