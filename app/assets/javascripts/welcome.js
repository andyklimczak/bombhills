
function imageScroll() {
    if(document.getElementById("header")) {
        var header = document.getElementById("header");
        var speed = 5.0;
        var width = window.innerWidth;
        window.onscroll = function() {
            var yOffset = window.pageYOffset;
            header.style.backgroundPosition = "0px "+ (yOffset / speed) + "px";
        }
    }
};

$(document).ready(imageScroll);

