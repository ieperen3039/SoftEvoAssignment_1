module steps::detection::TraceLinkConstructor

import steps::detection::SimilarityCalculator;
import steps::detection::RequirementsReader;
import List;
import IO;
import Set;

import util::Math;

alias TraceLink = rel[str,str];
alias AllTraceLinks = list[TraceLink];
//alias SimilarityMatrix = rel[str highlevel, str lowlevel, real score];

AllTraceLinks constructLinks(SimilarityMatrix sm, Requirement highlevel, Requirement lowlevel) =
	[constructMethod1(sm), constructMethod2(sm), constructMethod3(sm), constructMethod4(sm, highlevel, lowlevel)]; // You can add more constructed trace-links to the list if wanted

TraceLink constructMethod1(SimilarityMatrix sm) {
  TraceLink result = {};
  for(<idH, idL, score> <- sm, score > 0){
	result += <idH, idL>;
  }
  return result; 
  // return {<idH, idL> | <idH, idL> <- (<idH, idL, score> <- sm, score > 0)};
}

TraceLink constructMethod2(SimilarityMatrix sm) {
  TraceLink result = {};
  //for(<idH, idL, score> <- sm, abs(score) > 0.25){
  for(<idH, idL, score> <- sm, score > 0.25){
	result += <idH, idL>;
  }
  return result; 
  // return {<idH, idL> | <idH, idL> <- (<idH, idL, score> <- sm, score > 0.25)};
} 

TraceLink constructMethod3(SimilarityMatrix sm) {
  TraceLink result = {};
  set[str] idHs = {idH | (<idH, idL, score> <- sm)};
  for(curr <- idHs){
      set[real] scores = {};
      for(<idH, idL, score> <- sm, idH == curr){
      	scores += score;
      }
      for(<idH, idL, score> <- sm, (idH == curr) && (score > 0.67 * max(scores))){
      	result += <idH, idL>;
      }
  }
  return result;
}

TraceLink constructMethod4(SimilarityMatrix sm, Requirement hl, Requirement ll) {
	//list[real] sortScores = sort([score | <idH, idL, score> <- sm]);
	// target minimum is the value of the ith largest element, and is found at the ith index from the last
	//int tgtIndex = toInt(size(sortScores) - (size(ll) * 1)); // x links per low-level requirement
	
	//real bound = sortScores[tgtIndex];
 	//TraceLink result = {};
	// gather links with scores strictly more than the bound, to reduce links to at most the given fraction of the requirements
	//for (<h, l, s> <- sm, s > bound) {
		//result += <h, l>;
	//}

	//return result;
	
	real allMax = max([score | <idH, idL, score> <- sm]);
	TraceLink result = {};
	  set[str] idHs = {idH | (<idH, idL, score> <- sm)};
	  for(curr <- idHs){
	      set[real] scores = {};
	      for(<idH, idL, score> <- sm, idH == curr){
	      	scores += score;
	      }
	      if(max(scores) > 0.25){
		      for(<idH, idL, score> <- sm, (idH == curr) && (score > 0.67 * max(scores))){
		      	result += <idH, idL>;
		      }
	      }
	  }
	  return result;
}
