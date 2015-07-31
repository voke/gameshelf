'use strict';

var gameApp = angular.module('gameApp', []);

gameApp.controller('GameListCtrl', function($scope, $http) {

  $http.get('api/v1/games').success(function(data) {
    $scope.games = data;
  });

  $scope.orderProp = 'year';
});
