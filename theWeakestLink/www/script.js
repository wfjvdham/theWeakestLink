/*external js
https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenLite.min.js
https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/plugins/CSSPlugin.min.js
*/

var tweens = []
var nGoed = 0

window.onload = function() {
  var goed_buttons = document.querySelectorAll('.btn-default')
  Array.prototype.forEach.call(goed_buttons, function(goed_button) {
    goed_button.onclick = function() {
      nGoed++
      for (i = 7; i >= (8 - nGoed); i--) {
        tweens[i].play()
      }
    }
  })

  var fout_buttons = document.querySelectorAll('.btn-danger')
  Array.prototype.forEach.call(fout_buttons, function(fout_button) {
    fout_button.onclick = function() {
      nGoed = 0
      Array.prototype.forEach.call(tweens, function(tween) {
        tween.restart()
        tween.pause()
      })
    }
  })

  var bank_buttons = document.querySelectorAll('.btn-warning')
  Array.prototype.forEach.call(bank_buttons, function(bank_button) {
    bank_button.onclick = function() {
      nGoed = 0
      Array.prototype.forEach.call(tweens, function(tween) {
        tween.restart()
        tween.pause()
      })
    }
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
