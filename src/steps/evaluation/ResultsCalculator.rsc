module steps::evaluation::ResultsCalculator

import steps::detection::RequirementsReader;
import steps::detection::TraceLinkConstructor;

import Set;
import util::Math;
import IO;

alias ConfusionMatrix = tuple[int truePositives, int falsePositives, int trueNegatives, int falseNegatives];
alias EvaluationResult = tuple[ConfusionMatrix cm, real precision, real recall, real Fmeasure];

EvaluationResult evaluateMethod(TraceLink manual, TraceLink fromMethod, Requirement highlevel, Requirement lowlevel) {
	ConfusionMatrix result = calculateConfusionMatrix(manual, fromMethod, highlevel, lowlevel);
	real P = calculatePrecision(result);
	real R = calculateRecall(result);
	return <result, P, R, toReal(2) * ((P * R)/(P + R))>;
}

private real calculatePrecision(ConfusionMatrix cm) {
  return toReal(cm.truePositives) / toReal(cm.truePositives + cm.falsePositives);
}

private real calculateRecall(ConfusionMatrix cm) { 
 return toReal(cm.truePositives) / toReal(cm.truePositives + cm.falseNegatives);
}

private ConfusionMatrix calculateConfusionMatrix(TraceLink manual, TraceLink automatic, Requirement highlevel, Requirement lowlevel) {
	// TODO: Construct the confusion matrix.
	// True positives: Nr of trace-link predicted by the tool AND identified manually  
  // False positives: Nr of trace-link predicted by the tool BUT NOT identified manually
  // True negatives: Nr of trace-link NOT predicted by the tool AND NOT identified manually
  // False negatives: Nr of trace-link NOT predicted by the tool BUT identified manually
  
  set[str] idHs = {idH | (<idH, list[str] words> <- highlevel)};
  set[str] idLs = {idL | (<idL, list[str] words> <- lowlevel)};
  
  int TP = 0;
  int FP = 0;
  int TN = 0;
  int FN = 0;
  for(idH <- idHs){
  
  	set[str] idLsa = {};
  	for(<idHa, idLa> <- automatic, idHa == idH){
  		idLsa += idLa;
  	}
  	
  	set[str] idLsm = {};
  	for(<idHm, idLm> <- manual, idHm == idH){
  		idLsm += idLm;
  	}
  	
  	for(idL <- idLs){
  		if(idL in idLsa && idL in idLsm){
  			TP += 1;
  		}
  		if(idL in idLsa && idL notin idLsm){
  			FP += 1;
  		}
  		if(idL notin idLsa && idL notin idLsm){
  			TN += 1;
  		}
  		if(idL notin idLsa && idL in idLsm){
  			FN += 1;
  		}
  	}
  }
  
  return <TP, FP, TN, FN>;
}