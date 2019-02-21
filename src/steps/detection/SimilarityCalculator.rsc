module steps::detection::SimilarityCalculator

import steps::detection::RequirementsReader;
import steps::detection::Vectorizer;

import util::Math;
import IO;
import Set;
import List;

alias SimilarityMatrix = rel[str highlevel, str lowlevel, real score];

SimilarityMatrix calculateSimilarityMatrix(Requirement highlevel, Requirement lowlevel, Vector vec) {
	SimilarityMatrix result = {};
	
	for (<idH, list[str] reqH> <- highlevel) {
		list[real] freqH;
		for(<id, list[real] freq> <- vec, id == idH){
			freqH = freq;
		}
		for (<idL, list[str] reqL> <- lowlevel) {
			list[real] freqL;
			for(<id, list[real] freq> <- vec, id == idL){
				freqL = freq;
			}
			result += <idH, idL, cos(freqH, freqL)>;
		};
  	}
  
	return result;
}

// TODO: Add extra functions if wanted / needed

@doc {
  Calculate the cosinus of two (real) vectors.
}
real cos(list[real] high, list[real] low) {
	real top = (0. | it + high[i] * low[i] | int i <- [0..size(high)]);
	
	real x = sqrt((0. | it + h * h | real h <- high));
	real y = sqrt((0. | it + l * l | real l <- low));

	
	return top / (x * y);
}