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
    vm.searchData = {
      page: vm.page
    };

    vm.submitSearchForm = function () {
      vm.searchData.page = 1;

      $http({
        url: '/api/events',
        method: 'GET',
        params: vm.searchData
      })
      .success(function(data, status, headers, config) {
        vm.more = data.page_size === 20;
        vm.events = data.events;
        console.log(data);
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

    vm.loadEvents();
  }
})();
