/**
 * Created by Daniel on 2016-11-04.
 */
window.requestAnimFrame = (function(){
  return  window.requestAnimationFrame       ||
    window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame    ||
    window.oRequestAnimationFrame      ||
    window.msRequestAnimationFrame     ||
    function(/* function */ callback, /* DOMElement */ element){
      window.setTimeout(callback, 1000 / 60);
    };
})();

(function() {
  var cvs = document.getElementById('cvs'),
      ctx = cvs.getContext('2d'),
      frameHeight = 480,
      frameWidth = 640,
      fps = 0,
      fps_now, fps_last = (new Date),
      fps_el = document.getElementById('fps'),
      x = 0;

  cvs.setAttribute('height', frameHeight);
  cvs.setAttribute('width', frameWidth);

  var render = function() {
    /* FPS setup */
    fps_now=new Date;
    fps = 1000/(fps_now - fps_last);
    fps_last = fps_now;
    /* /FPS setup */

    /* Frame Animation */

    // example animation for fps accuracy and efficiency
    x++;
    if(x > frameWidth){
      x = 0;
    }
    var v = Math.floor(255 * (x/frameWidth));
    ctx.save();
    ctx.fillStyle = "rgb("+v+",0,0)";
    ctx.fillRect(0, 0, frameWidth, frameHeight);
    ctx.fillStyle = "rgb(0,0,0)";
    ctx.fillRect(x, 0, frameWidth, frameHeight);
    ctx.restore();

    /* /Frame Animation */

    /* FPS printout */
    fps_el.innerHTML = Math.round(fps) + " fps";
    /* /FPS printout */
    requestAnimFrame(function(){render()});
  };
  render.call();
}());
