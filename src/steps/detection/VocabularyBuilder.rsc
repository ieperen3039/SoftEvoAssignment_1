module steps::detection::VocabularyBuilder

import steps::detection::RequirementsReader;
import IO;
import List;

  // Extract a list of unique words from the vocabulary.
list[str] extractVocabulary(Requirement reqs) {
  result = {};
  
  for (<id, list[str] req> <- reqs) {
  	for (str w <- req) {
  	  result += w;
  	}
  }
  
  return [w | w <- result]; 
}