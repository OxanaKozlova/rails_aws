$ ->
  $('.pagination').hide()
  $('.preload').hide()
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_comments_url = $('.pagination .next_page a').attr('href')
      if more_comments_url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
            $('.pagination').html("")
            $('.preload').show()
            $.getScript more_comments_url
        return
      return      
