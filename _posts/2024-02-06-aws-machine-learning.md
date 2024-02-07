---
title: AWS Machine Learning
tags:
- aws
- Rekognition
- Transcribe
- Polly
- Translate
- Lex& Connect
- Comprehend
- Sage Maker
- Forecast
- Kendra
- Personalize
- Textract
categories:
- Fullstack
- Architect
- AWS
---

# Machine Learning
## Amazon Rekognition
- Find objects, people, text, scenes in images and videos using ML
- Facial analysis and facial search to do user verification, people counting
- Create a database of "familiar faces" or compare against celebrities
- Use case:
    - Labeling
    - Content Moderation
    - Text Detection
    - Face Detection and Analysis (gender, age, range, emotions...)
    - Face Search and Verification
    - Celebrity Recognition
    - Pathing (ex: for sports game analysis)
## Amazon Transcribe
- Automatic convert speech to text
- Uses a deep learning process called automatic speech recognition(ASR) to convert speech to text quickly and accurately
- Use cases:
    - Transcribe customer service calls
    - automate closed caption and subtitling
    - generate metadata for media assets to create a fully searchable archive
## Amazon Polly
- Turn text into lifelike speech using deep learning
- Allowing you to create application that talk
## Amazon Translate
- Nature and accurate language translation
- Amazon Translate allows you to localize content - such as website and applications - for internation users, and to easily translate large volume of text efficiently
## Amazon Lex & Connect
- Amazon Lex: (Same technology that powers Alexa)
    - Automatic Speech Recognition (ASR) to convert speech to text
    - Natural Language Understanding to recognize the intent of text, callers
    - Helps build chatbots, call center bots
- Amazon Connect:
    - Receive calls, create contact flows, cloud-based virtual contact center
    - Can integrate with  other CRM systems  or AWS
    - No upfront payment, 80% cheaper than traditional contact center solutions
## Amazon Comprehend
- For Nature language Processing - NLP
- Fully managed and serverless service
- Uses machine learning to find insight and relationship in text
    - Language of the text
    - Extracts key phrases, places, people, brands, or events
    - Understanding how positive or negative the text is
    - Analysis text using tokenization and parts of speech
    - Automatically organizes a collection of text files by topic
- Sample use cases:
    - analyze customer interaction (email) to find what leads to a positive or negative experience
    - Create and groups articles by topics that Comprehend will uncover
## Amazon SageMaker
- Fully managed service for developers / data scientists to build ML models
- Typically, difficult to do all the processes in one place + provision  servers
- Machine learning process (simplified):  predicting your exam score
## Amazon Forecast
- Fully managed service  that uses ML to deliver highly accurate  forecasts
- Example: predict the future sales of a raincoat
- 50% more accurate than looking at the data itself
- Reduce forecasting time from months to hours
- Use cases: Product Demand Planning, Financial Planning, Resource Planning,...
## Amazon Kendra
- Fully managed document search service powered by Machine Learning
- Extract answer from within a document (text, pdf, HTML, MS Word, ...)
- Natural language search capabilities
- Learn from user interactions/feedback tto promote preferred results (Incremental learning)
- Ability to manually fine-tune search results (importance of data, freshness, custom, ...)
## Amazon Personalize
- Fully managed ML-service to build apps with real-time personalized recommendations
- Example: personalized product recommendations/re-ranking, customized direct marketing
    - Example: User bought gardening tools, provide recommendations on the next one tto buy
- Same technology  used by Amazon.com
- Integrates into existing website, applications, SMS, email marketing systems,...
- Implement in days, ot months (you don't need to build, train, and deploy ML solutions)
- Use cases retail stores, media, and entertainment...
## Amazon Textract
- Automatically extract  text,  handwriting, and data from ay scanned document using AI ad ML
- Extract data from forms and tables
-  Read and  process any type of documents (PDFs, images, ...)
- Use cases:
    - Financial Service (e.g invoice, financial reports)
    - Healthcare (e.g medical records, insurance claims)
    - Public Sector (e.g tax forms, ID documents, passports)
## AWS Machine Learning - Summary
- Rekognition: face detection, labeling, celebrity recognition
- Transcribe: audio to text
- Polly: text to audio
- Translate: translation
- Lex: build conversation bots - chatbots
- Connect: cloud contact  center
- Comprehend: natural language processing
- SageMaker: machine learning for every developer and data scientist
- Forecast: build highly accurate forecast
- Kendra: ML-powered search engine
- Personalize:  real-time personalized recommendation
- Textract: detect text and data in  documents
