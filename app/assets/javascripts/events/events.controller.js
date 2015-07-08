(function(){
  'use strict';

  angular
    .module('evvntfully.events')
    .controller('EventListController', EventListController)
  ;

  EventListController.$inject = ['$http'];
  function EventListController ($http) {
    var vm = this;
    vm.events = [];
    vm.page = 1;
    vm.more = false;
    vm.autocompleteTags = [];
    vm.selectedVenues = [];
    vm.searchData = {
      page: vm.page,
      "venues[]": []
    };
    vm.resultsCount = false;

    vm.submitSearchForm = function () {
      vm.searchData.page = 1;
      // angular.forEach(vm.selectedVenues, function(value, key) {
      //   this.push(key);
      //   console.log(key);
      // }, vm.searchData.venue_id);

      $http({
        url: '/api/events',
        method: 'GET',
        params: vm.searchData
      })
      .success(function(data, status, headers, config) {
        vm.more = data.page_size === 20;
        vm.events = data.events;
        vm.resultsCount = data.total_entries;
      })
      .error(function(data, status, headers, config) {
        console.error(data);
      });
    }

    vm.loadEvents = function () {
      $http({
        url: '/api/events',
        method: 'GET',
        params: vm.searchData
      })
      .success(function(data, status, headers, config) {
        vm.more = data.page_size === 20;
        vm.events = vm.events.concat(data.events);
        vm.resultsCount = data.total_entries;
      })
      .error(function(data, status, headers, config) {
        console.error(data);
      });
    }

    vm.loadMore = function () {
      var newPageCount = vm.searchData.page +=1;
      vm.searchData.page = newPageCount;
      vm.loadEvents();
    }

    vm.hasMoreEvents = function () {
      return vm.more;
    }

    vm.loadVenues = function ($query) {
      return $http.get('/api/venues', {cache: true}).then(function(response) {
        var venues = response.data;

        return venues.filter(function(venue) {
          return venue.name.toLowerCase().indexOf($query.toLowerCase()) != -1;
        });
      });
    }

    vm.venueTagAdded = function(venue) {
      vm.searchData["venues[]"].push(venue.id);
      vm.submitSearchForm();
    }

    vm.venueTagRemoved = function(venue) {
      vm.searchData["venues[]"].splice(venue.id);
      vm.submitSearchForm();
    }

    vm.loadEvents();
  }
})();
