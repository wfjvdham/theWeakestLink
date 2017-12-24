/*external js
https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenLite.min.js
https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/plugins/CSSPlugin.min.js
*/

$(document).on('shiny:inputchanged', function(event) {
  var current_scores = document.getElementsByClassName('current_score')
  TweenLite.to(current_scores, 2, {top:"300px", backgroundColor:"black", borderBottomColor:"#90e500", color:"white"})
  /*Array.prototype.forEach.call(current_scores, function(current_score) {
    TweenLite.to(current_score, 2, {left:"300px", backgroundColor:"black", borderBottomColor:"#90e500", color:"white"})
    console.log(current_score.tagName)
  })*/

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
