library(bnlearn)
#load file
MyData <- read.csv(file="BlueBaby.csv", header=TRUE, sep=",")
dataset <- MyData[sample(nrow(MyData)), ] 
ind <- cut(1:nrow(dataset), breaks = 10, labels = F)
# creating the paper's model
paper_model = model2network("[BirthAsphyxia][Disease|BirthAsphyxia][LVHreport|LVH][LVH|Disease][LowerBodyO2|HypDistrib:HypoxiaInO2][HypDistrib|DuctFlow:CardiacMixing][DuctFlow|Disease][RUQO2|HypoxiaInO2][HypoxiaInO2|CardiacMixing:LungParench][CardiacMixing|Disease][CO2Report|CO2][CO2|LungParench][LungParench|Disease][XrayReport|ChestXray][ChestXray|LungFlow:LungParench][LungFlow|Disease][GruntingReport|Grunting][Grunting|Sick:LungParench][Sick|Disease][Age|Sick:Disease]")
# print model info
paper_model
model_diff = c()

for(i in 1:10){
  trainset = dataset[ind != i, ]
  testset = dataset[ind == i, ]

  # learn the structure from data
  induced_model = tabu(trainset, score = "k2")
  induced_model
  
  #compare models
  #the true positive (tp) arcs, which appear both in induced_model and in paper_model
  #the false positive (fp) arcs, which appear in paper_model but not in induced_model
  #the false negative (fn) arcs, which appear in induced_model but not in paper_model
  all.equal(induced_model, paper_model)
  model_diff = append(compare(induced_model, paper_model), model_diff)
  
  # fitting the paper model
  paper_fit = bn.fit(paper_model, trainset, method = "mle")
  
  # fitting the induced model
  induced_fit = bn.fit(induced_model, trainset, method = "mle")
  }
