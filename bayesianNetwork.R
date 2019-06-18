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

# learn the structure from data
induced_model = tabu(dataset, score = "k2")
induced_model

# Trying to reverse the structure
reversed_model = empty.graph(nodes(paper_model))
amat(reversed_model) = t(amat(paper_model))
reversed_model

#compare models
#the true positive (tp) arcs, which appear both in induced_model and in paper_model
#the false positive (fp) arcs, which appear in paper_model but not in induced_model
#the false negative (fn) arcs, which appear in induced_model but not in paper_model
all.equal(induced_model, paper_model)
model_diff = compare(induced_model, paper_model)

paper_accuracy_repeated= c()
paper_precision_repeated = c()
paper_recall_repeated = c()
paper_f1measure_repeated = c()

induced_accuracy_repeated = c()
induced_precision_repeated = c()
induced_recall_repeated = c()
induced_f1measure_repeated = c()

reversed_accuracy_repeated = c()
reversed_precision_repeated = c()
reversed_recall_repeated = c()
reversed_f1measure_repeated = c()

for (j in 1:10){  
  # creating 10 fold cross validation array
  
  paper_accuracy = c()
  paper_precision = c()
  paper_recall = c()
  paper_f1measure = c()
  
  induced_accuracy = c()
  induced_precision = c()
  induced_recall = c()
  induced_f1measure = c()
  
  reversed_accuracy = c()
  reversed_precision = c()
  reversed_recall = c()
  reversed_f1measure = c()
  
  # performing 10-fold cv
  for(i in 1:10){
    trainset = dataset[ind != i, ]
    testset = dataset[ind == i, ]
    testset_cropped = testset
    testset_cropped$Disease <- NULL
    
    # fitting the paper model
    paper_fit = bn.fit(paper_model, trainset, method = "mle")
    # fitting the induced model
    induced_fit = bn.fit(induced_model, trainset, method = "mle")
    #fitting the reversed model
    reversed_fit = bn.fit(reversed_model, trainset, method = "mle")
    
    # prediction
    paper_prediction = predict(paper_fit, "Disease", testset_cropped, method = "bayes-lw")
    induced_prediction = predict(induced_fit, "Disease", testset_cropped, method = "bayes-lw")
    reversed_prediction = predict(reversed_fit, "Disease", testset_cropped, method = "bayes-lw")
    
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
    paper_recall = append(recall, paper_recall)
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
    
    # performance evaluation reversed
    confusion.matrix = table(testset$Disease, reversed_prediction)
    accuracy = sum(diag(confusion.matrix))/sum(confusion.matrix)
    reversed_accuracy = append(accuracy, reversed_accuracy)
    precision = 0
    recall = 0
    for (i in 1:6){
      precision = precision + (confusion.matrix[i,i] / sum(confusion.matrix[,i]))
      recall = recall + (confusion.matrix[i,i] / sum(confusion.matrix[i,]))
      
    }
    precision = precision / 6
    recall = recall / 6
    reversed_precision = append(precision, reversed_precision)
    reversed_recall = append(recall, reversed_recall)
    f1measure = 2 * (precision * recall / (precision + recall))
    reversed_f1measure = append(f1measure, reversed_f1measure)
  }
  paper_accuracy_repeated =append(mean(paper_accuracy), paper_accuracy_repeated)
  paper_precision_repeated =append(mean(paper_precision), paper_precision_repeated)
  paper_recall_repeated =append(mean(paper_recall), paper_recall_repeated)
  paper_f1measure_repeated =append(mean(paper_f1measure), paper_f1measure_repeated)
  
  induced_accuracy_repeated =append(mean(induced_accuracy), induced_accuracy_repeated)
  induced_precision_repeated =append(mean(induced_precision), induced_precision_repeated)
  induced_recall_repeated =append(mean(induced_recall), induced_recall_repeated)
  induced_f1measure_repeated =append(mean(induced_f1measure), induced_f1measure_repeated)
  
  reversed_accuracy_repeated =append(mean(reversed_accuracy), reversed_accuracy_repeated)
  reversed_precision_repeated =append(mean(reversed_precision), reversed_precision_repeated)
  reversed_recall_repeated =append(mean(reversed_recall), reversed_recall_repeated)
  reversed_f1measure_repeated =append(mean(reversed_f1measure), reversed_f1measure_repeated)
}

# Performance plot
pdf("paper_performance.pdf", width = 8, height = 8)
# boxplot delle misure di performance
par(mfrow=c(2,2))
boxplot(paper_accuracy_repeated, main = "Accuracy")
boxplot(paper_precision_repeated, main = "Precision")
boxplot(paper_recall_repeated, main = "Recall")
boxplot(paper_f1measure_repeated, main = "F1Measure")
dev.off()
print("Evaluating paper performance:")
evaluatePerformance(paper_accuracy_repeated, paper_precision_repeated, paper_recall_repeated, paper_f1measure_repeated)

pdf("induced_performance.pdf", width = 8, height = 8)
# boxplot delle misure di performance
par(mfrow=c(2,2))
boxplot(induced_accuracy_repeated, main = "Accuracy")
boxplot(induced_precision_repeated, main = "Precision")
boxplot(induced_recall_repeated, main = "Recall")
boxplot(induced_f1measure_repeated, main = "F1Measure")
dev.off()
print("Evaluating induced performance:")
evaluatePerformance(induced_accuracy_repeated, induced_precision_repeated, induced_recall_repeated, induced_f1measure_repeated)

pdf("reversed_performance.pdf", width = 8, height = 8)
# boxplot delle misure di performance
par(mfrow=c(2,2))
boxplot(reversed_accuracy_repeated, main = "Accuracy")
boxplot(reversed_precision_repeated, main = "Precision")
boxplot(reversed_recall_repeated, main = "Recall")
boxplot(reversed_f1measure_repeated, main = "F1Measure")
dev.off()
print("Evaluating reversed performance:")
evaluatePerformance(reversed_accuracy_repeated, reversed_precision_repeated, reversed_recall_repeated, reversed_f1measure_repeated)

# t-test
t.test(paper_accuracy_repeated, induced_accuracy_repeated, paired = TRUE, conf.level = 0.95)
t.test(paper_precision_repeated, induced_precision_repeated, paired = TRUE, conf.level = 0.95)
t.test(paper_recall_repeated, induced_recall_repeated, paired = TRUE, conf.level = 0.95)
t.test(paper_f1measure_repeated, induced_f1measure_repeated, paired = TRUE, conf.level = 0.95)
# the results shows that the two models ARE NOT statistically different

# t-test
t.test(paper_accuracy_repeated, reversed_accuracy_repeated, paired = TRUE, conf.level = 0.95)
t.test(paper_precision_repeated, reversed_precision_repeated, paired = TRUE, conf.level = 0.95)
t.test(paper_recall_repeated, reversed_recall_repeated, paired = TRUE, conf.level = 0.95)
t.test(paper_f1measure_repeated, reversed_f1measure_repeated, paired = TRUE, conf.level = 0.95)
# the results shows that the two models ARE statistically different

# plots of network
paper_fit = bn.fit(paper_model, dataset, method = "mle")
induced_fit = bn.fit(induced_model, dataset, method = "mle")
reversed_fit = bn.fit(reversed_model, dataset, method = "mle")
# induced network
pdf("images/pdf/induced_fitted.pdf", width = 10, height = 10, onefile = FALSE)
par(mar = c(0,0,0,0) + 0.1)
graphviz.chart(induced_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
dev.off()
png("images/png/induced_fitted.png", width = 800, height = 900)
par(mar = c(0,0,0,0) + 0.1)
graphviz.chart(induced_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
dev.off()

pdf("images/pdf/paper_fitted.pdf", width = 10, height = 10, onefile = FALSE)
par(mar = c(0,0,0,0) + 0.1)
graphviz.chart(paper_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
dev.off()
png("images/png/paper_fitted.png", width = 800, height = 900)
par(mar = c(0,0,0,0) + 0.1)
graphviz.chart(paper_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
dev.off()

pdf("images/pdf/reverse_fitted.pdf", width = 10, height = 10, onefile = FALSE)
par(mar = c(0,0,0,0) + 0.1)
graphviz.chart(reversed_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
dev.off()
png("images/png/reversed_fitted.png", width = 800, height = 900)
par(mar = c(0,0,0,0) + 0.1)
graphviz.chart(reversed_fit, grid = TRUE, main = "Rappresentazione della rete fittata")
dev.off()

pdf("images/pdf/paper_structure.pdf", width = 10, height = 10, onefile = FALSE)
par(mar = c(0,0,0,0) + 0.1)
graphviz.plot(paper_model, main = "Representation of the paper network structure")
dev.off()
png("images/png/paper_structure.png", width = 800, height = 900)
par(mar = c(0,0,0,0) + 0.1)
graphviz.plot(paper_model, main = "Rappresentazione della rete fittata")
dev.off()

pdf("images/pdf/induced_structure.pdf", width = 10, height = 10, onefile = FALSE)
par(mar = c(0,0,0,0) + 0.1)
graphviz.plot(induced_model, main = "Representation of the inducded network structure")
dev.off()
png("images/png/induced_structure.png", width = 800, height = 900)
par(mar = c(0,0,0,0) + 0.1)
graphviz.plot(induced_model, main = "Rappresentazione della rete fittata")
dev.off()

pdf("images/pdf/reversed_structure.pdf", width = 10, height = 10, onefile = FALSE)
par(mar = c(0,0,0,0) + 0.1)
graphviz.plot(reversed_model, main = "Representation of the inducded network structure")
dev.off()
png("images/png/reversed_structure.png", width = 800, height = 900)
par(mar = c(0,0,0,0) + 0.1)
graphviz.plot(reversed_model, main = "Rappresentazione della rete fittata")
dev.off()

### INFERENCE
# estimating Disease probability given evidence
# training the network with the full dataset
# we use the learne dstructure
paper_full_trained = bn.fit(paper_model, dataset, method = "mle")

# creating structure node=evidence
ev = list(LVHreport = "yes")
# variable to store the most likelly disease
max_value = 0
max_name = ""
new_cpt = list()
for (i in levels(dataset$Disease)){
  res = cpquery(paper_full_trained, event=Disease==i, method="lw", evidence = ev)
  new_cpt[[i]] = res
  if (res > max_value){
    max_value = res
    max_name = i
  }
}
sprintf("The most probable disease given the evidence is %s with a probability of %f", max_name, max_value)

### D-SEPARATION
# Testing d-separation betweens variables
# Since the strucutre of the BN, we can make some exams indipendent to Disease given the observation of a symptom
source = "Disease"
destination = "CO2"
given = c("LungParench")
dsep(paper_model, source, destination, given)

source = "Disease"
destination = "XrayReport"
given = c("LungParench", "LungFlow")
dsep(paper_model, source, destination, given)

# but in a real situation, we cannot determin if a symptom is present if we dont' perform the exams.
# the only think we can observ are the exams results
source = "Disease"
destination = "CO2"
given = c("LowerBodyO2", "RUQO2", "GruntingReport", "Age", "CO2Report", "XrayReport", "LVHreport", "BirthAsphyxia")
dsep(paper_model, source, destination, given)
# in this way, no d-separation is possible