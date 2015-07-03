(function(){
  'use strict';

  angular
    .module('evvntfully.events')
    .controller('EventListController', EventListController)
  ;

  EventListController.$inject = ['Event'];
  function EventListController (Event) {
    var vm = this;
    vm.events = [];
    vm.page = 1;
    vm.more = false;

    vm.loadEvents = function () {
      Event.query({
        page: vm.page
      }).$promise.then(function(data) {
        vm.more = data.length === 5
        vm.events = vm.events.concat(data);
      });
    }

    vm.loadMore = function () {
      vm.page += 1;
      vm.loadEvents();
    }

    vm.hasMoreEvents = function () {
      return vm.more;
    }

    vm.loadEvents();
  }
})();
