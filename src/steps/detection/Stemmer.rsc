module steps::detection::Stemmer

import analysis::stemming::Snowball;
import steps::detection::RequirementsReader;
import IO;

// normalize all words in the given requirement
Requirement stemWords(Requirement reqs) {

  for (<id, list[str] req> <- reqs) {
    list[str] reqWords = [w | w <- req, w notin stopWords];
    
    result += {<id, reqWords>}; 
  }
  reqs.words = stemAll(reqs.words);
  
  return reqs;
}

// TODO: Add extra functions if wanted / needed

@doc {
  Returns the passed in list of words in a stemmed form
}
private list[str] stemAll(list[str] orig) = [porterStemmer(w) | w <- orig];
