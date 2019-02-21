module steps::detection::TraceLinkConstructor

import steps::detection::SimilarityCalculator;
import List;
import IO;
import Set;

import util::Math;

alias TraceLink = rel[str,str];
alias AllTraceLinks = list[TraceLink];

AllTraceLinks constructLinks(SimilarityMatrix sm) =
	[constructMethod1(sm), constructMethod2(sm), constructMethod3(sm)]; // You can add more constructed trace-links to the list if wanted

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
  //for(<idH, idL, score> <- sm, score > 0.25){
  for(<idH, idL, score> <- sm, abs(score) > 0.25){
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
      real maxiumum = max(scores);
      for(<idH, idL, score> <- sm, (idH == curr) && (score > 0.67 * max(scores))){
      	result += <idH, idL>;
      }
  }
  return result;
}
