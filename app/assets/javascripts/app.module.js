(function() {
  'use strict';

  angular
    .module('evvntfully', [
      'ngResource',
      'ui.router',
      'evvntfully.event',
      'evvntfully.venue',
      'evvntfully.events'
    ]);
})();
