{
    "analysis": {
        "analyzer": {
            "keyword_lowercase": {
                "filter": "lowercase",
                "tokenizer": "keyword"
            },
            "gsearch_finnish_analyzer": {
                "type": "custom",
                "tokenizer": "standard",
                "filter": [
                    "lowercase",
		            "gsearch_finnish_stop",
		            "gsearch_finnish_stemmer",
                    "gsearch_finnish_voikko",
                    "asciifolding" 
                ]
            },
            "gsearch_english_analyzer": {
                "type": "custom",
                "tokenizer": "standard",
                "filter": [
                    "gsearch_english_possessive_stemmer",
                    "lowercase",
                    "gsearch_english_stop",
                    "gsearch_english_light_stemmer", 
                    "asciifolding" 
                ]
            },
            "gsearch_swedish_analyzer": {
                "type": "custom",
                "tokenizer": "standard",
                "filter": [
					"lowercase",
					"gsearch_swedish_stop",
					"gsearch_swedish_stemmer",
                    "asciifolding" 
                ]
            },
            "gsearch_standard_analyzer": {
                "type": "custom",
                "tokenizer": "standard",
                "filter": [
                    "lowercase",
                    "asciifolding"
                ]
            }
        },
        "filter": {
            "gsearch_english_light_stemmer": {
              "type":       "stemmer",
              "language":   "light_english" 
            },
            "gsearch_english_possessive_stemmer": {
              "type":       "stemmer",
              "language":   "possessive_english"
            },
            "gsearch_english_stop": {
              "type":       "stop",
              "stopwords":  "_english_"
            },
			"gsearch_finnish_stemmer": {
			  "type":       "stemmer",
			  "language":   "finnish"
			},
			"gsearch_finnish_stop": {
              "type":       "stop",
              "stopwords":  "_finnish_"
	        },
	       	"gsearch_finnish_voikko": {
	          "type": "voikko",
	          "libraryPath": "/usr/lib/x86_64-linux-gnu",
			  "dictionaryPath": "/opt/software/voikko/dictionary"
	        },
	        "gsearch_swedish_stemmer": {
	          "type":       "stemmer",
	          "language":   "swedish"
	        },
	        "gsearch_swedish_stop": {
	          "type":       "stop",
	          "stopwords":  "_swedish_" 
	        }
        }         
    }
}
