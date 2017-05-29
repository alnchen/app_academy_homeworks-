document.addEventListener("DOMContentLoaded", function(){
  var canvas = document.getElementById('mycanvas');
  canvas.width = 500;
  canvas.height = 500;
  var ctx = canvas.getContext('2d');
  ctx.fillStyle = 'brown';//'rgb(200,0,0)';
  ctx.fillRect(10, 10, 100, 100);

  ctx.beginPath();
  ctx.arc(300, 100, 90, 0, 50);
  ctx.strokeStyle = 'blue';
  ctx.stroke();
  ctx.fillStyle = 'teal';
  ctx.fill();
});


/*
Pick a color (e.g. 'red', rgb(255,255,255), etc. ) to set as the fillStyle attribute for ctx
Call fillRect with the appropriate dimensions to draw the rectangle on the canvas
Check that everything's working by executing open index.html in your terminal
*/
