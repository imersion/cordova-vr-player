Cordova VR Player
======

A simple cordova plugin playing a video in a native [Google VR View](https://developers.google.com/vr/concepts/vrview) for Android and iOS. It supports both mono and stereo videos through compatibility with Google Cardboard.

### Usage
-----

**GoogleVRPlayer.playVideo(videoUrl, fallbackVideoUrl, GVRVideoType)**

`videoUrl, fallbackVideoUrl`

Opens a view and starts playing video available under `videoUrl` parameter. The video is played in full screen mode by default. When user exits the full screen mode, the view automatically closes. Some older devices cannot decode video larger than 1080p (1920x1080). In case the video fails to play the plugin will attempt to play the video available under `fallbackVideoUrl` parameter.


`GVRVideoType` - _default to StereoOverUnder_

**"Mono"** = **kGVRVideoTypeMono** - Each video frame is a monocular equirectangular panorama. Each frame image is expected to cover 360 degrees along its horizontal axis

**"StereoOverUnder"** = **kGVRVideoTypeStereoOverUnder** - Each video frame contains two vertically-stacked equirectangular panoramas. The top part of the frame contains pixels for the left eye, while the bottom part of the frame contains pixels for the right eye.

**"SphericalV2"** = **kGVRVideoTypeSphericalV2** - The video contains metadata in the spherical v2 format which describes how to render it. See https://github.com/google/spatial-media/blob/master/docs/spherical-video-v2-rfc.md.

[Taken from official SDK info here](https://developers.google.com/vr/ios/reference/g_v_r_video_view_8h#a7cb3bbc06fa053a4d1ade6014a3ac6ec)

example:

```javascript
iOS
GoogleVRPlayer.playVideo("videos/360.mp4", "videos/backup.mp4", "Mono");
GoogleVRPlayer.playVideo("videos/360.mp4", null); // defaults to StereoOverUnder

Android
GoogleVRPlayer.playVideo(fileUri, null, 'FULLSCREEN_STEREO'); // or 'Stereo'
GoogleVRPlayer.playVideo(fileUri, null, 'FULLSCREEN_MONO'); // or 'Mono'
GoogleVRPlayer.playVideo(fileUri, null, 'FULLSCREEN_EMBEDDED');
default: mono
```
