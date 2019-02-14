module steps::detection::VocabularyBuilder

import steps::detection::RequirementsReader;

import List;

  // Extract a list of unique words from the vocabulary.
list[str] extractVocabulary(Requirement reqs) {
  result = {};
  
  for (<id, list[str] req> <- reqs) {
    result += {w | w <- req}; 
  }
  
  return [w | w <- result]; 
}