locked = false
audioContext = new (webkitAudioContext || AudioContext)()

playSound = ->
    request = new XMLHttpRequest()
    request.open 'GET', 'atom://raptorize/assets/raptor-sound.ogg', true
    request.responseType = 'arraybuffer'
    request.onload = ->
      audioContext.decodeAudioData request.response, (buffer) ->
        source = audioContext.createBufferSource()
        source.buffer = buffer
        source.connect(audioContext.destination)
        source.start(0)
    request.send()

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
