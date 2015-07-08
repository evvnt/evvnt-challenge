(function() {
  'use strict';

  angular
    .module('evvntfully.venue', [])
    .factory('Venue', VenueFactory)
  ;

  VenueFactory.$inject = ['$resource', '$http'];
  function VenueFactory ($resource, $http) {
    var Venue = $resource('/api/venues/:id', {}, {
      'query': {method: 'GET', isArray: true},
      'autocompleteTags': {method: 'GET', isArray: true}
    });

    return Venue;
  }
})();
