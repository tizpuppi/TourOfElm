var gulp = require('gulp');
var elm  = require('gulp-elm');
var uglify = require('gulp-uglify');
var fs     = require('fs');
var gutil  = require('gulp-util');
var del = require('del');
var webserver = require('gulp-webserver');

gulp.task('default', ['serve']);

gulp.task('serve', ['build','watch','server']);

gulp.task('build', ['build:elm','build:files']);

var paths = {
  src : 'src',
  out : 'assets'
};

// elm-make --yes
gulp.task('build:init', elm.init);

gulp.task('build:elm', ['build:init'], function(){
  return gulp.src(paths.src + '/**/*.elm')
    .pipe(elm.bundle('app.js',{warn:true}))
    .on('error', gutil.log)
    .pipe(uglify())
    .pipe(gulp.dest(paths.out + '/'));
});

gulp.task('build:files', function(){
  return gulp.src([paths.src + '/static/index.html', paths.src + '/static/styles.css', paths.src + '/static/favicon.ico'])
    .pipe(gulp.dest(paths.out + '/'))
});


gulp.task('clean', function(cb){
  del([paths.out +"/**/*"], {force: true} , cb)
});

gulp.task('server', function() {
  gulp.src(paths.out)
    .pipe(webserver({
      livereload: true,
      directoryListing: false,
      open: true,
      fallback: 'index.html'
    }));
});

gulp.task('watch', function(){
  gulp.watch([paths.src +'/**/*.elm'],['build:elm']);
  gulp.watch([paths.src +'/*.html'],['build:files'])
});
