library(readr)
library(dplyr)
library(tidyverse)
library(feather)

download_mnist_data <- function() {
  if (!file.exists('data/mnist_raw.csv')){
    #mnist_raw <- read_csv("https://pjreddie.com/media/files/mnist_train.csv", col_names = FALSE)
    write_csv(read_csv("https://pjreddie.com/media/files/mnist_train.csv", col_names = FALSE),"data/mnist_raw.csv")
  }
  else {print("mnist_raw.csv already downloaded")}
} #This function might seem to freze for one or two mins. Give it time


download_chissl_mongodb <- function() {
  if (!file.exists('data/chissl.agz')){
    download.file("https://github.com/pnnl/chissl/raw/e20193546b2a81f4906fa5316868181e527e1fc2/dumps/chissl", destfile="data/chissl.agz", method="libcurl")
  }
  else {print("chissl.agz already downloaded")}
}

download_newsgroups_byDate <- function() {
  if (!file.exists('data/20news-bydate.tar.gz')){
    download.file("http://qwone.com/~jason/20Newsgroups/20news-bydate.tar.gz", destfile = "data/20news-bydate.tar.gz", method="libcurl")
  }
  else {print("20news-bydate.tar.gz already downloaded")}
}

extract_newsgroups_byDate <- function() {
  if (!dir.exists("data/20news-bydate/")){
    untar("data/20news-bydate.tar.gz", compressed = 'gzip', exdir = "data/20news-bydate/")
  }
}

train_newsgroups_model <- function() {
  training_folder <- "data/20news-bydate/20news-bydate-train/"
  
  if (!dir.exists("data/feathers/newsgroups")){
    dir.create("data/feathers/newsgroups")
    
    raw_text_feather_path <- "data/feathers/newsgroups/raw_text.feather"
    
    if (!file.exists(raw_text_feather_path)){
      # Define a function to read all files from a folder into a data frame
      read_folder <- function(infolder) {
        tibble(file = dir(infolder, full.names = TRUE)) %>%
          mutate(text = map(file, read_lines)) %>%
          transmute(id = basename(file), text) %>%
          unnest(text)
      }
      # Use unnest() and map() to apply read_folder to each subfolder
      raw_text <- tibble(folder = dir(training_folder, full.names = TRUE)) %>%
        mutate(folder_out = map(folder, read_folder)) %>%
        unnest(cols = c(folder_out)) %>%
        transmute(newsgroup = basename(folder), id, text)
      
      write_feather(raw_text, raw_text_feather_path)
      
      print(paste0("Wrote feather: " + raw_text_feather_path))
      
    }
    else {
      raw_text <- read_feather(raw_text_feather_path)
      print(paste0("Read feather: " + raw_text_feather_path))
    }
    
    usenet_words_feather_path <- "data/feathers/newsgroups/usenet_words.feather"
    
    if (!file.exists(usenet_words_feather_path)){
      # Cleaning text
      cleaned_text <- raw_text %>%
        group_by(newsgroup, id) %>%
        filter(cumsum(text == "") > 0,
               cumsum(str_detect(text, "^--")) == 0) %>%
        ungroup()
      
      cleaned_text <- cleaned_text %>%
        filter(str_detect(text, "^[^>]+[A-Za-z\\d]") | text == "",
               !str_detect(text, "writes(:|\\.\\.\\.)$"),
               !str_detect(text, "^In article <"),
               !id %in% c(9704, 9985))
      usenet_words <- cleaned_text %>%
        unnest_tokens(word, text) %>%
        filter(str_detect(word, "[a-z']$"),
               !word %in% stop_words$word)
      
      write_feather(usenet_words, usenet_words_feather_path)
      print(paste0("Wrote feather: " + usenet_words_feather_path))
      
    }
    else {
      usenet_words <- read_feather(usenet_words_feather_path)
      print(paste0("Read feather: " + usenet_words_feather_path))
      
    }
    
    print('Cleaning text done')
  }
  
  
  if (!file.exists('data/feathers/newsgroups/top_sentiment_words.feather')){
    ## Assume if the last one doens't exist then they all need to be created ##
    
    # Most used words
    usenet_words %>%
      count(word, sort = TRUE)
    
    # Words by newsgroup
    words_by_newsgroup <- usenet_words %>%
      count(newsgroup, word, sort = TRUE) %>%
      ungroup()
    
    
    # tf-idf
    tf_idf <- words_by_newsgroup %>%
      bind_tf_idf(word, newsgroup, n) %>%
      arrange(desc(tf_idf))
    print('got tf-idf')
    write_feather(tf_idf, "data/feathers/newsgroups/tf_idf.feather")
    print("Wrote feather: " + "data/feathers/newsgroups/tf_idf.feather")
    
    # topic modeling include only words that occur at least 50 times
    word_sci_newsgroups <- usenet_words %>%
      filter(str_detect(newsgroup, "^sci")) %>%
      group_by(word) %>%
      mutate(word_total = n()) %>%
      ungroup() %>%
      filter(word_total > 50)
    write_feather(word_sci_newsgroups, "data/feathers/newsgroups/word_sci_newsgroups.feather")
    print("Wrote feather: " + "data/feathers/newsgroups/word_sci_newsgroups.feather")
    
    # convert into a document-term matrix with document names such as sci.crypt_14147
    sci_dtm <- word_sci_newsgroups %>%
      unite(document, newsgroup, id) %>%
      count(document, word) %>%
      cast_dtm(document, word, n)
    write_feather(sci_dtm, "data/feathers/newsgroups/sci_dtm.feather")
    print("Wrote feather: " + "data/feathers/newsgroups/sci_dtm.feather")
    
    # build topic model
    sci_lda <- LDA(sci_dtm, k = 4, control = list(seed = 2016))
    print('got topic model')
    write_feather(sci_lda, "data/feathers/newsgroups/sci_lda.feather")
    print("Wrote feather: " + "data/feathers/newsgroups/sci_lda.feather")
    
    # sentiment analysis
    newsgroup_sentiments <- words_by_newsgroup %>%
      inner_join(get_sentiments("afinn"), by = "word") %>%
      group_by(newsgroup) %>%
      summarize(value = sum(value * n) / sum(n))
    write_feather(newsgroup_sentiments, "data/feathers/newsgroups/newsgroup_sentiments.feather")
    print("Wrote feather: " + "data/feathers/newsgroups/newsgroup_sentiments.feather")
    
    contributions <- usenet_words %>%
      inner_join(get_sentiments("afinn"), by = "word") %>%
      group_by(word) %>%
      summarize(occurences = n(),
                contribution = sum(value))
    write_feather(contributions, "data/feathers/newsgroups/contributions.feather")
    print("Wrote feather: " + "data/feathers/newsgroups/contributions.feather")
    
    top_sentiment_words <- words_by_newsgroup %>%
      inner_join(get_sentiments("afinn"), by = "word") %>%
      mutate(contribution = value * n / sum(n))
    write_feather(top_sentiment_words, "data/feathers/newsgroups/top_sentiment_words.feather")
    print("Wrote feather: " + "data/feathers/newsgroups/top_sentiment_words.feather")
    
  }else {
    tf_idf <- read_feather("data/feathers/newsgroups/tf_idf.feather")
    print("Read feather: data/feathers/newsgroups/tf_idf.feather")
    
    word_sci_newsgroups <- read_feather("data/feathers/newsgroups/word_sci_newsgroups.feather")
    print("Read feather: data/feathers/newsgroups/word_sci_newsgroups.feather")
    
    sci_dtm <- read_feather("data/feathers/newsgroups/sci_dtm.feather")
    print("Read feather: data/feathers/newsgroups/sci_dtm.feather")
    
    sci_lda <- read_feather("data/feathers/newsgroups/sci_lda.feather")
    print("Read feather: data/feathers/newsgroups/sci_lda.feather")
    
    newsgroup_sentiments <- read_feather("data/feathers/newsgroups/newsgroup_sentiments.feather")
    print("Read feather: data/feathers/newsgroups/newsgroup_sentiments.feather")
    
    contributions <- read_feather("data/feathers/newsgroups/contributions.feather")
    print("Read feather: data/feathers/newsgroups/contributions.feather")
    
    top_sentiment_words <- read_feather("data/feathers/newsgroups/top_sentiment_words.feather")
    print("Read feather: data/feathers/newsgroups/top_sentiment_words.feather")
  }
  
  print('got senitments')
  
}


