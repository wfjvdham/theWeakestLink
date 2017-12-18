$(document).on('shiny:inputchanged', function(event) {
  console.log("start function")
  var myList = $('#playes_list')
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
