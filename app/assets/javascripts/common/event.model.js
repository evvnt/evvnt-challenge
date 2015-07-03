(function(){
  'use strict';

  function EventFactory ($resource) {
    var Event = $resource('/api/events/:id', {}, {
      'query': {method: 'GET', isArray: true},
    });

    return Event;
  }

  EventFactory.$inject = ['$resource'];

  angular
    .module('evvntfully.event', [])
    .factory('Event', EventFactory)
  ;
})();
