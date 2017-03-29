function initPostScroll() {
  var content = $('#posts-container');    // where to load new content
  if(content.length > 0) {
    var viewMore = $('#view-more'); // tag containing the "View More" link

    var isLoadingNextPage = false;  // keep from loading two pages at once
    var lastLoadAt = null;          // when you loaded the last page
    var minTimeBetweenPages = 1000; // milliseconds to wait between loading pages
    var loadNextPageAt = 500;      // pixels above the bottom

    var waitedLongEnoughBetweenPages = function() {
      return (lastLoadAt === null) || ((new Date() - lastLoadAt) > minTimeBetweenPages);
    };

    var approachingBottomOfPage = function() {
      var viewMore = $('#view-more'); // tag containing the "View More" link
      if(viewMore.length < 1) { return false; }
      return (document.documentElement.clientHeight + $(document).scrollTop()) > (content.height() - loadNextPageAt);
    }

    var nextPage = function() {
      var url = viewMore.find('a').attr('href');

      if (isLoadingNextPage || !url) { return; }

      viewMore.addClass('loading');
      isLoadingNextPage = true;
      lastLoadAt = new Date();

      return $.ajax({
        url: url,
        method: 'GET',
        dataType: 'script',
      }).done(function() {
        viewMore.removeClass('loading');
        isLoadingNextPage = false;
        return lastLoadAt = new Date();
      });
    };

    // watch the scrollbar
    $(window).scroll(function() {
      if (approachingBottomOfPage() && waitedLongEnoughBetweenPages()) {
        return nextPage();
      }
    });

    // failsafe in case the user gets to the bottom
    // without infinite scrolling taking affect.
    return viewMore.find('a').click(function(e) {
      nextPage();
      return e.preventDefault();
    });
  }
}

document.addEventListener('turbolinks:load', initPostScroll);
