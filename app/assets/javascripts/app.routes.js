(function() {
  'use strict';

  angular
    .module('evvntfully')
    .config(AppRoutes)
  ;

  AppRoutes.$inject = ['$urlRouterProvider', '$locationProvider'];
  function AppRoutes ($urlRouterProvider, $locationProvider) {
    $locationProvider.html5Mode(true);
    $urlRouterProvider.otherwise('/events');
  }
})();
