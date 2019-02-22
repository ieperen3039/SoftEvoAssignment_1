module steps::detection::TraceLinkConstructor

import steps::detection::SimilarityCalculator;
import List;
import IO;

alias TraceLink = rel[str,str];
alias AllTraceLinks = list[TraceLink];
//alias SimilarityMatrix = rel[str highlevel, str lowlevel, real score];

AllTraceLinks constructLinks(SimilarityMatrix sm, Requirement highlevel, Requirement lowlevel) =
	[constructMethod1(sm), constructMethod2(sm), constructMethod4(sm, highlevel, lowlevel)]; // You can add more constructed trace-links to the list if wanted

TraceLink constructMethod1(SimilarityMatrix sm) {
	TraceLink result = {};
	
	for (<h, l, s> <- sm) {
		if (s > 0){
			result += <h, l>;
		}
	}

	return result;
}

TraceLink constructMethod2(SimilarityMatrix sm) {
  TraceLink result = {};
	
	for (<h, l, s> <- sm) {
		if (s >= 0.25){
			result += <h, l>;
		}
	}

	return result;
} 

TraceLink constructMethod3(SimilarityMatrix sm) {
 	TraceLink result = {};
  	int max = 0;
  	
  	for (<h, l, s> <- sm) {
  		if (s > max) {
  			max = s;
  		}
  	}
	
	int bound = 0.67 * max;
	
	for (<h, l, s> <- sm) {
		if (s > bound){
			result += <h, l>;
		}
	}

	return result;
}

TraceLink constructMethod4(SimilarityMatrix sm, Requirement hl, Requirement ll) {
	list[real] sortScores = sort(sm.score);
	// target minimum is the value of the ith largest element, and is found at the ith index from the last
	int tgtIndex = length(sortScores) - (length(ll) * 1.5); // 1.5 links per low-level requirement
	
	real bound = sortScores[tgtIndex];
	// gather links with scores strictly more than the bound, to reduce links to at most the given fraction of the requirements
	for (<h, l, s> <- sm) {
		if (s > bound){
			result += <h, l>;
		}
	}

	return result;
}
