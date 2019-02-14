module steps::detection::Vectorizer

import steps::detection::RequirementsReader;

import List;
import util::Math;
import IO;

alias Vector = rel[str name, list[real] freq];

Vector calculateVector(Requirement reqs, list[str] vocabulary) {
	// REMOVE BELOW LINE, ONLY HERE TO MAKE THE TEMPLATES RUNNABLE
	return {};
}

@doc {
  Calculates the Inverse Document Frequency (IDF) of the different words in the vocabulary
  The 'occurences' map should map each word of the vocabulary to the number of times it occurs in the requirements.
  The 'occurences' map should have entries for all the words in the vocabulary, otherwise an exception will be thrown.
}
private map[str,real] calculateInverseDocumentFrequency(map[str,int] occurences, list[str] vocabulary) {
	int vocSize = size(vocabulary);
	map[str,real] idfs = (w : log2(vocSize / occurences[w]) | str w <- vocabulary); 

	return idfs;
}
