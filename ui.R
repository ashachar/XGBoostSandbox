#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyBS)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   HTML('<center><img src="ds_community.png" height="150" width="260"></center>'),
   titlePanel("XGBoost Sandbox"),

   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        sliderInput("nrounds",
                    "Number of trees",
                    min = 1,
                    max = 100,
                    value = 5),
        
         sliderInput("eta",
                     "Learning Rate (η, Eta)",
                     min = 0.01,
                     max = 0.2,
                     value = 0.3),

         sliderInput("min_child_weight",
                     "Minimal child weight",
                     min = 1,
                     max = 30,
                     value = 1),

        sliderInput("max_depth",
                    "Max depth",
                    min = 3,
                    max = 10,
                    value = 6),
        
        sliderInput("max_leaf_nodes",
                    "Max leaf nodes",
                    min = 8,
                    max = 1024,
                    value = 64),
        
        sliderInput("gamma",
                    "Gamma, γ",
                    min = 0,
                    max = 20,
                    value = 0),
        sliderInput("lambda",
                    "Lambda, λ",
                    min = 0,
                    max = 20,
                    value = 1),
        sliderInput("alpha",
                    "Alpha, α",
                    min = 0,
                    max = 20,
                    value = 1),
        
        
        sliderInput("subsample",
                    "Subsample",
                    min = 0.5,
                    max = 1,
                    value = 1),
        
        sliderInput("colsample_bytree",
                    "Column sample by tree",
                    min = 0.5,
                    max = 1,
                    value = 1),
        sliderInput("colsample_bylevel",
                    "Column sample by level",
                    min = 0.5,
                    max = 1,
                    value = 1),
        sliderInput("colsample_bynode",
                    "Column sample by node",
                    min = 0.5,
                    max = 1,
                    value = 1),
        bsTooltip('nrounds', 'The number of trees the algorithm will build (A.K.A, number of iterations) ', placement = "bottom", trigger = "hover",
                  options = NULL),
        bsTooltip('eta', 'Analogous to learning rate in GBM. Makes the model more robust by shrinking the weights on each step.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('min_child_weight', 'Defines the minimum sum of weights of all observations required in a child. This is similar to min_child_leaf in GBM but not exactly. This refers to min “sum of weights” of observations while GBM has min “number of observations”. Used to control over-fitting. Higher values prevent a model from learning relations which might be highly specific to the particular sample selected for a tree. Too high values can lead to under-fitting hence, it should be tuned using CV.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('max_depth', 'The maximum depth of a tree, same as GBM. Used to control over-fitting as higher depth will allow model to learn relations very specific to a particular sample.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('max_leaf_nodes', 'The maximum number of terminal nodes or leaves in a tree. Can be defined in place of max_depth. Since binary trees are created, a depth of ‘n’ would produce a maximum of 2^n leaves. If this is defined, GBM will ignore max_depth.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('gamma', 'A node is split only when the resulting split gives a positive reduction in the loss function. Gamma specifies the minimum loss reduction required to make a split. Makes the algorithm conservative. The values can vary depending on the loss function and should be tuned.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('max_delta_step', 'In maximum delta step we allow each tree’s weight estimation to be. If the value is set to 0, it means there is no constraint. If it is set to a positive value, it can help making the update step more conservative. Usually this parameter is not needed, but it might help in logistic regression when class is extremely imbalanced. This is generally not used but you can explore further if you wish.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('subsample', 'Same as the subsample of GBM. Denotes the fraction of observations to be randomly samples for each tree. Lower values make the algorithm more conservative and prevents overfitting but too small values might lead to under-fitting.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('colsample_bytree', 'Similar to max_features in GBM. Denotes the fraction of columns to be randomly samples for each tree.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('colsample_bylevel', 'Denotes the subsample ratio of columns for each split, in each level. Not recommended to use this often because subsample and colsample_bytree will do the job for you. but you can explore further if you feel so.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('colsample_bynode', 'Denotes the subsample ratio of columns for each split, in each node. Not recommended to use this often because subsample and colsample_bytree will do the job for you. but you can explore further if you feel so.', placement = "top", trigger = "hover", options = NULL),
        bsTooltip('lambda', 'L2 regularization term on weights (analogous to Ridge regression). This used to handle the regularization part of XGBoost. Though many data scientists don’t use it often, it should be explored to reduce overfitting.', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('alpha', 'L1 regularization term on weight (analogous to Lasso regression). Can be used in case of very high dimensionality so that the algorithm runs faster when implemented', placement = "bottom", trigger = "hover", options = NULL),
        bsTooltip('alpha', 'L1 regularization term on weight (analogous to Lasso regression). Can be used in case of very high dimensionality so that the algorithm runs faster when implemented', placement = "bottom", trigger = "hover", options = NULL)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
          plotOutput("trainRoc"),
          plotOutput("testRoc")
      )
   )
)
