module steps::detection::StopWordRemover

import IO;
import String;
import Set;

import steps::detection::RequirementsReader;

// Remove the stop words from the words lists of all the requirements.
Requirement removeStopWords(Requirement reqs) {
	stopWords = readStopwords(); 
	result = {};
	
	// alias Requirement = rel[str name, list[str] words];
	for (<id, list[str] req> <- reqs) {
		list[str] reqWords = [w | w <- req, w notin stopWords];
		
		result += {<id, reqWords>}; 
	}
	return result;
}

// TODO: Add extra functions if wanted / needed

private set[str] readStopwords() =
	{word | /<word:[a-zA-Z\"]+>/ := readFile(|project://assignment1/data/stop-word-list.txt|)};
