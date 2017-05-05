let browsers = '> 1%';

module.exports = {
	plugins: [
		require('postcss-import')(),

		require('postcss-cssnext')({
			browsers: browsers,
			warnForDuplicates: false
		}),

		require('cssnano')({
			browsers: browsers
		}),
	]
}
