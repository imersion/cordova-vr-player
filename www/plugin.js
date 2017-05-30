
var exec = require('cordova/exec');

var PLUGIN_NAME = 'GoogleVRPlayer';

var GoogleVRPlayer = {
  playVideo: function(videoUrl, fallbackVideoUrl, videoType, cb) {
    exec(cb, null, PLUGIN_NAME, 'playVideo', [videoUrl, fallbackVideoUrl, videoType]);
  },
  getDate: function(cb) {
    exec(cb, null, PLUGIN_NAME, 'getDate', []);
  }
};

module.exports = GoogleVRPlayer;
