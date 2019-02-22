module steps::detection::Vectorizer

import steps::detection::RequirementsReader;

import List;
import util::Math;
import IO;
import Set;

alias Vector = rel[str name, list[real] freq];

Vector calculateVector(Requirement reqs, list[str] vocabulary) {
	
	map[str, int] occ = (word: 0 | word <- vocabulary);
	
	for (<id, list[str] req> <- reqs) {
		for (word <- req) {
			occ[word] += 1;
		}
	}
	map[str, real] idf = calculateInverseDocumentFrequency(occ, vocabulary, reqs);
		
	Vector result = {};
	
	for (<id, list[str] req> <- reqs) {
		list[real] freqs = [];
		for (word <- vocabulary){
			if(word in req){
				real count = toReal(0);
				for(word2 <- req, word2 == word){
					count += 1;
				}
				freqs += count * idf[word];
			} else{
				freqs += toReal(0);
			}
		}
		
		result += <id, freqs>;
  	}
  
	return result;
}

@doc {
  Calculates the Inverse Document Frequency (IDF) of the different words in the vocabulary
  The 'occurences' map should map each word of the vocabulary to the number of times it occurs in the requirements.
  The 'occurences' map should have entries for all the words in the vocabulary, otherwise an exception will be thrown.
}
private map[str,real] calculateInverseDocumentFrequency(map[str,int] occurences, list[str] vocabulary, Requirement reqs) {
	num nrOfReqs = size(reqs);
	map[str,real] idfs = (w : log2(nrOfReqs / occurences[w]) | str w <- vocabulary); 
	
	return idfs;
}
