locked = false

playSound = ->
  sound = require './assets/raptor-sound'
  audio = new Audio(sound())
  audio.play()

animateRaptor = ->
  atom.workspaceView.append '<img id="elRaptor" style="display: none" src="atom://raptorize/assets/raptor.png" />'
  raptor = atom.workspaceView.find '#elRaptor'
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

module.exports =
  activate: ->
    atom.workspaceView.command 'raptorize', '.editor', run
