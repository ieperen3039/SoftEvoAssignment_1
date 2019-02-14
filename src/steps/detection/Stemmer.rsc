module steps::detection::Stemmer

import analysis::stemming::Snowball;

import steps::detection::RequirementsReader;

import IO;

Requirement stemWords(Requirement reqs) {
  // TODO: Stem the word list of the requirement. 
  // You can stem a list of words using the given method 'stemAll'.
  
  // REMOVE BELOW LINE, ONLY HERE TO MAKE THE TEMPLATES RUNNABLE
  return reqs;
}

// TODO: Add extra functions if wanted / needed

@doc {
  Returns the passed in list of words in a stemmed form
}
private list[str] stemAll(list[str] orig) = [porterStemmer(w) | w <- orig];
