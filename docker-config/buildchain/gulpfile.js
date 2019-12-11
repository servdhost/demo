var gulp = require('gulp');
var util = require('gulp-util');
var autoprefixer = require('gulp-autoprefixer');
var browserSync = require('browser-sync').create();
var plumber = require('gulp-plumber');
var source = require('vinyl-source-stream');
var buffer = require('vinyl-buffer');
var sourcemaps = require('gulp-sourcemaps');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var imagemin = require('gulp-imagemin');
var changed = require('gulp-changed');
var csso = require('gulp-csso');
var merge = require('merge-stream');
var rsp = require('remove-svg-properties').stream;
var fs = require('file-system');
//var browserify = require('gulp-browserify')
var browserify = require('browserify');
var babelify = require('babelify');
var vueify = require('vueify');
var postcss = require('gulp-postcss');

var tailwindcss = require('tailwindcss');

/********** Jobs ***********/

var cssSrc  = 'src/assets/css/app.css';
var cssWatch  = 'src/assets/css/**/*.css';
var cssDest = 'src/web/assets/css';

var jsWatch = ['src/assets/js/**/*'];
var jsEntry = 'src/assets/js/app.js';
var jsDest  = 'src/web/assets/js';

var imageFiles = ['src/assets/images/**/*'];
var imageDest  = 'src/web/assets/images';

/*var svgFiles = ['src/resources/svgSprites/*.svg'];
var svgDest  = 'src/public/assets/sprites';

var pngFiles = ['src/resources/pngSprites/*.png'];
var pngDest  = 'src/public/assets/sprites';
var pngSassDest  = 'src/resources/css';*/

var templateWatch = 'src/templates/**/*';

gulp.task('css', function() {
	return gulp.src(cssSrc)
		.pipe(plumber({
			errorHandler: onError
		}))
		.pipe(postcss([
			require('postcss-import'),
		    tailwindcss('./tailwind.config.js'),
		    require('postcss-nesting'),
		    require('autoprefixer')({browsers: ['last 1 version']}),
		    require('cssnano')
		]))
		/*.pipe(sourcemaps.init())
		.pipe(sass({ errLogToConsole: true, outputStyle: 'compressed' }))
		.pipe(autoprefixer())
		.pipe(sourcemaps.write('./maps'))*/
		.pipe(gulp.dest(cssDest))
		.pipe(browserSync.stream({match: "**/*.css"}));
});

gulp.task('js', function() {

	browserify(jsEntry)
		 .transform("envify", {
		   "global": true,
		   "NODE_ENV": !!util.env.production ? 'production' : 'development'
		 })
        .transform(vueify)
		.transform(babelify)
        .bundle()
		.on('error', function(err){
		    console.log(err.stack);
			this.emit('end');
		})
		.pipe(source('app.js')) // gives streaming vinyl file object
    	.pipe(buffer()) // <----- convert from streaming to buffered vinyl file object
		.pipe( util.noop() )
    	.pipe(gulp.dest(jsDest))
		.pipe(browserSync.reload({stream:true}))
		;
});

gulp.task('images', function() {
	return gulp.src(imageFiles)
		.pipe(plumber({
			errorHandler: onError
		}))
		.pipe(changed(imageDest))
      	.pipe(imagemin())
      	.pipe(gulp.dest(imageDest))
		.pipe(browserSync.stream({match: "**/*.[jpg|png|gif|webp]"}));

});

/********** Entry Points ***********/

gulp.task('reload', function(){
	return gulp.src(templateWatch)
		.pipe(plumber({
			errorHandler: onError
		}))
		.pipe(browserSync.reload({stream:true}));
});

gulp.task('build', ['images', 'css', 'js'], function() {

});

gulp.task('watch', ['browser-sync'], function() {
  	gulp.watch(cssWatch, ['css']);
  	gulp.watch(jsWatch, ['js']);
	gulp.watch(imageFiles, ['images']);
	gulp.watch(templateWatch, ['reload']);
});


/********** Helpers ***********/

gulp.task('browser-sync', function() {
    browserSync.init({
		proxy: {
            target: 'nginx:80',
			proxyOptions: {
	            changeOrigin: false
	        }
        }
    });
});

var onError = function (error) {

	var message = '<div style="text-align:left;">' +
									'<div style="font-weight:bold;color:red;margin-bottom: 5px;">TASK FAILED [' + error.plugin + ']</div>' +
									'<div>' + error.relativePath + ' : ' + error.line + '</div>' +
									'<div>' + error.messageOriginal + '</div>' +
								'</div>';

	console.log(error.toString());
	browserSync.notify(message, 10000);
	this.emit('end');
};
