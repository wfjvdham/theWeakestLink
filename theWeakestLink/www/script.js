var tweens = []
var nCorrect = 0

window.onload = function() {
  var correct_buttons = document.querySelectorAll('.btn-default')
  Array.prototype.forEach.call(correct_buttons, function(correct_button) {
    correct_button.onclick = function() {
      nCorrect++
      tweens[8 - nCorrect].play()
    }
  })

  var reset_tweens = function() {
    nCorrect = 0
    Array.prototype.forEach.call(tweens, function(tween) {
      tween.restart()
      tween.pause()
    })
  }
  var error_buttons = document.querySelectorAll('.btn-danger')
  Array.prototype.forEach.call(error_buttons, function(error_button) {
    error_button.onclick = reset_tweens
  })

  var bank_buttons = document.querySelectorAll('.btn-warning')
  Array.prototype.forEach.call(bank_buttons, function(bank_button) {
    bank_button.onclick = reset_tweens
  })
}

$(document).on('shiny:inputchanged', function(event) {
  var scores = document.getElementsByClassName('scores')
  if (tweens.length == 0) {
    Array.prototype.forEach.call(scores, function(score, index) {
      var tween = TweenLite.to(score, 2, {top:"50px", backgroundColor: "#99565D"})
      if (index == 8) {
        tween.play(2)
      } else {
        tween.pause()
        tweens.push(tween)
      }
    })
  }

  var myList = $('#players_list')
  var listItems = myList.children('div').get()
  listItems.sort(function(a, b) {
    var percA = Number($(a).find('tr:nth-child(3) td+ td').text())
    var percB = Number($(b).find('tr:nth-child(3) td+ td').text())
    var cashA = Number($(a).find('tr:nth-child(4) td+ td').text())
    var cashB = Number($(b).find('tr:nth-child(4) td+ td').text())
    var result = 0
    if (percA < percB) {
      result = 1
    } else if (percA > percB) {
      result = -1
    } else if (cashA < cashB) {
      result = 1
    } else if (cashA > cashB) {
      result = -1
    }
    return result
  })
  $(myList).append(listItems)
})
