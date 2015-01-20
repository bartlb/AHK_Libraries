/**
 * FuzzySearch is a lightweight function that uses basic 'fuzzy matching' logic to find
 * all possible matches to a query within any custom, string-based dictionary. Currently,
 * the results of this search method are NOT weighted, and matches are returned in an
 * array of no significant order.
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
   * @todo Add match-weight logic to help properly sort the matches returned from the
   *       function.
   */
  StringLower query, query

  tokens  := StrSplit(query)
  matches := []

  for each, string in dict
  {
    tokenIndex := stringIndex := 1, matchPositions := []

    StringLower string, string

    while ((stringIndex - 1) < StrLen(string)) {
      tmp_strToken := StrSplit(string)[stringIndex]

      if (tmp_strToken == tokens[tokenIndex]) {
        matchPositions.Insert({
        (Join
          "index": stringIndex,
          "token": tmp_strToken
        )})

        tokenIndex++

        if (tokenIndex > NumGet(&tokens+4*A_PtrSize)) {
          matches.Insert({
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