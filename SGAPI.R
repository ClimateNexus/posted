

data <- purrr::map(
  fromJSON(finalurl)$data$survey_data, function(i){
    i <- i %>% 
      dplyr::select(
        question,answer
      ) %>% 
      dplyr::mutate(
        SGid = x$id
      ) %>% 
      dplyr::select(
        SGid, question, answer
      )
    
    qtext <- i$question[1]
    i$question <- NULL
    names(i)[names(i)== "answer"] <- qtext
    names(i) <- stringi::stri_trans_general(names(i), "latin-ascii")
    i
  }) %>% 
  dplyr::bind_cols() %>% 
  dplyr::mutate(
    SGlat    = x$latitude,
    SGlong   = x$longitude,
    SGzip    = x$postal,
    SGstatus = x$status,
    SGdma    = x$dma,
    SGtest   = x$is_test_data,
    SGcity   = x$city,
    SGdate   = x$date_submitted
  )