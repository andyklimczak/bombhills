function imageScroll() {
    var header = document.getElementById("header");
    var speed = 5.0;
    var width = window.innerWidth;

    window.onscroll = function() {
        if (width > 565px) {
            var yOffset = window.pageYOffset;
            header.style.backgroundPosition = "0px "+ (yOffset / speed) + "px";
        }
       else {
           
       }
    }
};

$(document).ready(imageScroll);
