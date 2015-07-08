(function() {
  'use strict';

  angular
    .module('evvntfully.event', [])
    .factory('Event', EventFactory)
  ;

  EventFactory.$inject = ['$resource'];
  function EventFactory ($resource) {
    var Event = $resource('/api/events/:id', {}, {
      'query': {method: 'GET', isArray: true},
    });

    return Event;
  }
})();
