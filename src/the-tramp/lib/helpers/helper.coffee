module.exports = 

  getTextBetweenChars: (string, char1, char2) ->

    start  = string.indexOf(char1) + 1
    end    = string.indexOf(char2, start)
    result = string.substring start, end
