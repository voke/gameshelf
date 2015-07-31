'use strict';

var gameApp = angular.module('gameApp', []);

gameApp.controller('GameListCtrl', ['$scope', '$http',
  function($scope, $http) {

    var path = window.location.pathname;
    var username = path.slice(1, path.length);
    var url = 'api/v1/games?username=' + username;

    $http.get(url).success(function(data) {
      $scope.games = data;
    }).error(function(error) {
      console.log('error');
    })

    $scope.orderProp = 'year';

  }]);
