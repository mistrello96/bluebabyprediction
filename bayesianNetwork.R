library(bnlearn)
#load file
MyData <- read.csv(file="BlueBaby.csv", header=TRUE, sep=",")

#x = MyData[MyData$BirthAsphyxia == "yes",]
#y = MyData[MyData$BirthAsphyxia == "no",]
#y = y[sample(nrow(y)), ]
#z = y[0:1028,]
#MyData = merge(x,z, all=TRUE)

dataset <- MyData[sample(nrow(MyData)), ] 
ind <- cut(1:nrow(dataset), breaks = 10, labels = F)
# creating the paper's model
paper_model = model2network("[BirthAsphyxia][Disease|BirthAsphyxia][LVHreport|LVH][LVH|Disease][LowerBodyO2|HypDistrib:HypoxiaInO2][HypDistrib|DuctFlow:CardiacMixing][DuctFlow|Disease][RUQO2|HypoxiaInO2][HypoxiaInO2|CardiacMixing:LungParench][CardiacMixing|Disease][CO2Report|CO2][CO2|LungParench][LungParench|Disease][XrayReport|ChestXray][ChestXray|LungFlow:LungParench][LungFlow|Disease][GruntingReport|Grunting][Grunting|Sick:LungParench][Sick|Disease][Age|Sick:Disease]")
# print model info
paper_model

# creating 10 fold cross validation array
model_diff = c()

paper_accuracy = c()
paper_precision = c()
papar_recall = c()
paper_f1measure = c()

induced_accuracy = c()
induced_precision = c()
induced_recall = c()
induced_f1measure = c()

# performing 10-fold cv
for(i in 1:10){
  trainset = dataset[ind != i, ]
  testset = dataset[ind == i, ]
  testset_cropped = testset
  testset_cropped$Disease <- NULL
  
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
  
  # prediction
  paper_prediction = predict(paper_fit, "Disease", testset_cropped, method = "bayes-lw")
  
  # performance evaluation
  confusion.matrix = table(testset$Disease, paper_prediction)
  accuracy = sum(diag(confusion.matrix))/sum(confusion.matrix)
  paper_accuracy = append(accuracy, paper_accuracy)
  precision = confusion.matrix[1,1] / (confusion.matrix[1,1] + confusion.matrix[2,1])
  paper_precision = append(precision, paper_precision)
  recall = confusion.matrix[1,1] / (confusion.matrix[1,1] + confusion.matrix[1,2])
  papar_recall = append(recall, papar_recall)
  f1measure = 2 * (precision * recall / (precision + recall))
  paper_f1measure = append(f1measure, paper_f1measure)
  }

# debug print
paper_prediction
testset$Disease
confusion.matrix
