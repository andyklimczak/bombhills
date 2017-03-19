function initPostScroll() {
  let content = $('#posts-container');    // where to load new content
  let viewMore = $('#view-more'); // tag containing the "View More" link

  let isLoadingNextPage = false;  // keep from loading two pages at once
  let lastLoadAt = null;          // when you loaded the last page
  let minTimeBetweenPages = 1000; // milliseconds to wait between loading pages
  let loadNextPageAt = 500;      // pixels above the bottom

  let waitedLongEnoughBetweenPages = () => (lastLoadAt === null) || ((new Date() - lastLoadAt) > minTimeBetweenPages);

  let approachingBottomOfPage = function() {
    let viewMore = $('#view-more'); // tag containing the "View More" link
    if(viewMore.length < 1) { return false; }
    return (document.documentElement.clientHeight + $(document).scrollTop()) > (content.height() - loadNextPageAt);
  }

  let nextPage = function() {
    let url = viewMore.find('a').attr('href');

    if (isLoadingNextPage || !url) { return; }

    viewMore.addClass('loading');
    isLoadingNextPage = true;
    lastLoadAt = new Date();

    return $.ajax({
      url,
      method: 'GET',
      dataType: 'script',
      success() {
        viewMore.removeClass('loading');
        isLoadingNextPage = false;
        return lastLoadAt = new Date();
      }
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

document.addEventListener('turbolinks:load', initPostScroll);
