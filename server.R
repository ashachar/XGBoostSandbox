library(magrittr)
library(titanic)
library(xgboost)
library(ROCR)
library(pROC)

dataset <<- titanic_train
label_name <<- 'Survived'
train <<- dataset[1:floor(0.8 * nrow(dataset)),]
test <<- dataset[ceiling(0.8 * nrow(dataset)): nrow(dataset),]

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  model <- reactive({
    params <- list(
      eta = input$eta,
      min_child_weight = input$min_child_weight,
      max_depth = input$max_depth,
      max_leaf_nodes = input$max_leaf_nodes,
      gamma = input$gamma,
      subsample = input$subsample,
      colsample_bytree = input$colsample_bytree,
      colsample_bylevel = input$colsample_bylevel,
      colsample_bynode = input$colsample_bynode,
      lambda = input$lambda,
      alpha = input$alpha
    )
    xgboost(data = data.matrix(train[, which(!colnames(train) == label_name)]),
            label = train[[label_name]],
            params = params,
            nrounds = input$nrounds)
  })
  
  output$trainRoc <- renderPlot({
    model <- model()
    predictions <- predict(model, newdata = data.matrix(train[, which(colnames(test) %in% model$feature_names)]))
    cur_labels <- train[[label_name]]
    pred <- prediction(predictions, cur_labels)
    roc_obj <- performance(pred, measure = "tpr", x.measure = "fpr") 
    cur_auc <- auc(cur_labels, predictions)
    plot(roc_obj, col=rainbow(10))
    abline(a = 0, b = 1)
    title(paste('Train AUC: ', round(cur_auc, 3)))
  })
  
  output$testRoc <- renderPlot({
    model <- model()
    predictions <- predict(model, newdata = data.matrix(test[, which(colnames(test) %in% model$feature_names)]))
    cur_labels <- test[[label_name]]
    pred <- prediction(predictions, cur_labels)
    roc_obj <- performance(pred, measure = "tpr", x.measure = "fpr") 
    cur_auc <- auc(cur_labels, predictions)
    plot(roc_obj, col=rainbow(10))
    abline(a = 0, b = 1)
    title(paste('Test AUC: ', round(cur_auc, 3)))
  })
}