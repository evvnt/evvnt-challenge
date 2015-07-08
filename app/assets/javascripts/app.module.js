(function() {
  'use strict';

  angular
    .module('evvntfully', [
      'ngResource',
      'ui.router',
      'ui.bootstrap.datetimepicker',
      'ngTagsInput',
      'evvntfully.event',
      'evvntfully.venue',
      'evvntfully.events'
    ]);
})();
