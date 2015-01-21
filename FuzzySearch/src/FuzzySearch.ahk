/**
 * FuzzySearch is a lightweight function that uses basic 'fuzzy matching' logic to find
 * all possible matches to a query within any custom, string-based dictionary. Results
 * are weighted on a negative scale (the further from 0, the better the match); this was
 * done to provide automatic sorting, so that the results can easily be parsed in a
 * decending order. Yes. There are better ways to do this, but I'm far too lazy at this
 * point in time.
 *
 * @function  FuzzySearch
 * @param     [in]      dict    An array of strings to query against.
 * @param     [in]      query   Any query in the form of a string.
 * @returns   {object}          An array of match objects consisting of the matched
 *                              string and information pertaining to where the match
 *                              occured within the string.
 */
FuzzySearch(dict, query) {
  /**
   * @todo REFACTOR THE HELL OUT OF THIS THING! No bugs have been found yet, but I'm sure
   *       that they're there somewhere... hiding.
   */
  StringLower query, query

  tokens  := StrSplit(query)
  matches := []

  for each, string in dict
  {
    tokenIndex := stringIndex := 1, matchPositions := [], weight := 0

    if (SubStr(string, 1, 1) = tokens[1])
      weight -= 50

    for idx, _substr in StrSplit(string, [" ", "_", "-"])
    {
      if (SubStr(_substr, 1, 1) = tokens[tokenIndex]) {
        weight      -= 10
        stringIndex := (InStr(string, _substr))

        matchPositions.Insert({
        (Join
          "index": stringIndex,
          "token": tokens[tokenIndex]
        )})

        if ( RegExMatch(_substr, "O)\w[a-z0-9]+([A-Z])", chr_match)
          && chr_match[1] = tokens[tokenIndex + 1])
        {
          weight      -= 5
          stringIndex += (InStr(_substr, chr_match[1], true) - 1)
          tokenIndex  += 1

          matchPositions.Insert({
          (Join
            "index": (stringIndex - 1),
            "token": tokens[tokenIndex]
          )})
        }

        tokenIndex++

        if (tokenIndex > NumGet(&tokens+4*A_PtrSize)) {
          matches.Insert(weight, {
          (Join
            "match"         : dict[each],
            "matchedTokens" : matchPositions
          )})

          break
        }
      }
    }

    StringLower string, string

    while ((stringIndex - 1) < StrLen(string)) {
      tmp_strToken := StrSplit(string)[stringIndex]

      if (tmp_strToken == tokens[tokenIndex]) {
        weight--

        matchPositions.Insert({
        (Join
          "index": stringIndex,
          "token": tmp_strToken
        )})

        tokenIndex++

        if (tokenIndex > NumGet(&tokens+4*A_PtrSize)) {
          matches.Insert(weight, {
          (Join
            "match"         : dict[each],
            "matchedTokens" : matchPositions
          )})

          break
        }
      }

      stringIndex++
    }
  }

  return matches
}