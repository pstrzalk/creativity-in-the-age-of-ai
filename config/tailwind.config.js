const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        background: '#f8c6c2'
      },
      fontFamily: {
        sans: ['Inter', ...defaultTheme.fontFamily.sans],
      },
      textTransform: {
        'small-caps': 'small-caps',
      },
    },
  },
  safelist: [
    'mb-6', 'pt-20', 'w-10', 'h-10',
    'text-xl', 'text-2xl', 'text-3xl', 'text-4xl', 'text-5xl', 'text-6xl', 'italic', 'font-bold',
    'text-red-500', 'animate-spin', 'font-mono', 'bg-slate-100', 'bg-slate-200', 'bg-slate-300',
    'grid-cols-4'
  ],
  plugins: [
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ],
}
