class window.Preview
  constructor:(form) ->
    @input = form.find('input[type="file"]')
    @image = form.find('img#img_prev')

    @hideIfEmptyImage()
    @changeImage()

  hideIfEmptyImage: =>
    unless @image.attr('src')?
      $('.preview').hide()

  changeImage: =>
    $(@input).on 'change', ->
      $('.preview').show()
      if @files and @files[0]
        reader = new FileReader
        reader.onload = (e) ->
          $('#img_prev').attr 'src', e.target.result
          return
        reader.readAsDataURL @files[0]
      return

$ ->
  if $('.preview-container')[0]
    new window.Preview($('.preview-container'))
