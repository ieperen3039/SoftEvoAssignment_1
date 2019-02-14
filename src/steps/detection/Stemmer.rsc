module steps::detection::Stemmer

import analysis::stemming::Snowball;
import steps::detection::RequirementsReader;
import IO;

// normalize all words in the given requirement
Requirement stemWords(Requirement reqs) {
  Requirement result = {};

  for (<id, list[str] req> <- reqs) {
    list[str] reqWords = stemAll(req);
    result += <id, reqWords>;
  }
  
  return result;
}

// TODO: Add extra functions if wanted / needed

@doc {
  Returns the passed in list of words in a stemmed form
}
private list[str] stemAll(list[str] orig) = [porterStemmer(w) | w <- orig];
