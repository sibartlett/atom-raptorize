{Disposable} = require 'atom'
$ = require 'jquery'

clippy = null

locked = false

quotes = [
  'Clever girl'
  'Shoot her! Shoot her!'
  'Hold on to your butts'
  'Spared no expense'
  'Life finds a way'
  'It\'s a unix system! I know this!'
  'God help us, we\'re in the hands of engineers.'
]

playSound = ->
  sound = require './assets/raptor-sound'
  audio = new Audio(sound())
  audio.play()

animateRaptor = ->
  $(document.body).append '<img id="elRaptor" style="display: none" src="atom://raptorize/assets/raptor.png" />'
  raptor = $(document.body).find '#elRaptor'
  raptor.css
    position: 'fixed'
    bottom: '-700px'
    right: '0'
    display: 'block'
  raptor.animate bottom: '0', ->
    raptor.animate bottom: '-130px', 100, ->
      offset = raptor.position().left + 400
      raptor.delay 300
        .animate right: offset, 2200, ->
          raptor.css
            bottom: '-700px'
            right: '0'
          raptor.remove()
          locked = false

run = ->
  if !locked
    locked = true
    playSound()
    animateRaptor()
    if clippy
      quote = quotes[Math.floor(Math.random() * quotes.length)];
      clippy.speak quote

module.exports =

  consumeClippyService: (service) ->
    clippy = service
    new Disposable -> clippy = null

  activate: ->
    atom.commands.add 'atom-workspace', 'raptorize', run
