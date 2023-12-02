:- use_module(library(lists)).

%% https://dmcommunity.org/challenge/challenge-may-2021/


covid19_symptoms([coughing, sneezing]).
threshold(2).

count_covid19_symptoms(Symptoms, N):-
	covid19_symptoms(Covid19_symptoms),
	intersection(Symptoms, Covid19_symptoms,List),
	length(List, N).

has_feaver(Age, Temperature):-
	( Temperature >= 38,   Age >=10 ) ;
	( Temperature >= 37.2, Age < 10 ).

%% No synptoms, "none" result

covid19_diagnosis(_Age, 0, _Temperature, none):- !.

%% At least 1 synptoms (anamnesis): expected results: quarantine or covi19_test

%% At least 2 synptoms (anamnesis), result: covid19_test without checking teh temperature/fever

covid19_diagnosis(_Age, TotSymptoms, _Temperature, covid19_test):-
	threshold(Threshold),
	TotSymptoms >= Threshold, !.

%% 1 syntptom, checking fever

%% At least 2 synptoms (anamnesis + fever)
covid19_diagnosis(Age, _TotSymptoms, Temperature, covid19_test):-
	has_feaver(Age, Temperature), !.

covid19_diagnosis(_Age, _TotSymptoms, _Temperature, quarantine).

diagnosis(Age, Symptoms, Temperature, Diagnosis):-
	count_covid19_symptoms(Symptoms, TotSymptoms),
	covid19_diagnosis(Age, TotSymptoms, Temperature, Diagnosis).