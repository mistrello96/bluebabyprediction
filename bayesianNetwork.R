library(bnlearn)

# funzione che valuta le performance medie al termine della 10-fold cross validation
evaluatePerformance = function(accuracy, precision, recall, f1measure){
  print(paste("Accuracy mean:",  mean(accuracy)))
  print(paste("Accuracy sd:",  sd(accuracy)))
  print(paste("Precision mean:",  mean(precision)))
  print(paste("Precision sd:",  sd(precision)))
  print(paste("Recall mean:", mean(recall)))
  print(paste("Recall sd:", sd(recall)))
  print(paste("F1measure mean:", mean(f1measure)))
  print(paste("F1measure sd:", sd(f1measure)))
}

#load file
MyData <- read.csv(file="BlueBaby.csv", header=TRUE, sep=",")

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
  induced_prediction = predict(induced_fit, "Disease", testset_cropped, method = "bayes-lw")
  
  # performance evaluation paper
  confusion.matrix = table(testset$Disease, paper_prediction)
  accuracy = sum(diag(confusion.matrix))/sum(confusion.matrix)
  paper_accuracy = append(accuracy, paper_accuracy)
  precision = 0
  recall = 0
  for (i in 1:6){
    precision = precision + (confusion.matrix[i,i] / sum(confusion.matrix[,i]))
    recall = recall + (confusion.matrix[i,i] / sum(confusion.matrix[i,]))
    
  }
  precision = precision / 6
  recall = recall / 6
  paper_precision = append(precision, paper_precision)
  papar_recall = append(recall, papar_recall)
  f1measure = 2 * (precision * recall / (precision + recall))
  paper_f1measure = append(f1measure, paper_f1measure)
  
  # performance evaluation induced
  confusion.matrix = table(testset$Disease, induced_prediction)
  accuracy = sum(diag(confusion.matrix))/sum(confusion.matrix)
  induced_accuracy = append(accuracy, induced_accuracy)
  precision = 0
  recall = 0
  for (i in 1:6){
    precision = precision + (confusion.matrix[i,i] / sum(confusion.matrix[,i]))
    recall = recall + (confusion.matrix[i,i] / sum(confusion.matrix[i,]))
    
  }
  precision = precision / 6
  recall = recall / 6
  induced_precision = append(precision, induced_precision)
  induced_recall = append(recall, induced_recall)
  f1measure = 2 * (precision * recall / (precision + recall))
  induced_f1measure = append(f1measure, induced_f1measure)
}

# Performance plot
pdf("paper_performance.pdf", width = 8, height = 8)
# boxplot delle misure di performance
par(mfrow=c(2,2))
boxplot(paper_accuracy, main = "Accuracy")
boxplot(paper_precision, main = "Precision")
boxplot(papar_recall, main = "Recall")
boxplot(paper_f1measure, main = "F1Measure")
dev.off()
print("Evaluating paper performance:")
evaluatePerformance(paper_accuracy, paper_precision, papar_recall, paper_f1measure)

pdf("induced_performance.pdf", width = 8, height = 8)
# boxplot delle misure di performance
par(mfrow=c(2,2))
boxplot(induced_accuracy, main = "Accuracy")
boxplot(induced_precision, main = "Precision")
boxplot(induced_recall, main = "Recall")
boxplot(induced_f1measure, main = "F1Measure")
dev.off()
print("Evaluating induced performance:")
evaluatePerformance(induced_accuracy, induced_precision, induced_recall, induced_f1measure)

# plots of network
pdf("induced_fitted.pdf", width = 10, height = 10, onefile=FALSE)
par(mar = c(0,0,0,0)+0.1)
graphviz.chart(induced_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
dev.off()
png("induced_fitted.png", width = 800, height = 900)
par(mar = c(0,0,0,0)+0.1)
graphviz.chart(induced_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
dev.off()
#pdf("paper_fitted.pdf", width = 15, height = 14)
graphviz.chart(paper_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
#dev.off()
#pdf("paper_structure.pdf", width = 5, height = 5)
graphviz.plot(paper_model, main = "Representation of the paper network structure")
#dev.off()
#pdf("induced_structure.pdf", width = 5, height = 5)
graphviz.plot(induced_model, main = "Representation of the inducded network structure")
#dev.off()
