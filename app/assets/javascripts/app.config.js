(function() {
  'use strict';

  angular
    .module('evvntfully')
    .config(AppConfig)
  ;

  AppConfig.$inject = ['$httpProvider'];
  function AppConfig ($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
})();
