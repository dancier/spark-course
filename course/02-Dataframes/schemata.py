from pyspark.sql.types import *

yellow_taxi_schema  =  (  StructType
                        ([ 
                            StructField("VendorId"               , IntegerType()   , True),
                            StructField("tpep_pickup_datetime"   , TimestampType() , True),
                            StructField("tpep_dropoff_datetime"  , TimestampType() , True),
                            StructField("passenger_count"        , DoubleType()    , True),
                            StructField("trip_distance"          , DoubleType()    , True),
                            StructField("RatecodeID"             , DoubleType()    , True),
                            StructField("store_and_fwd_flag"     , StringType()    , True),
                            StructField("PULocationID"           , IntegerType()   , True),
                            StructField("DOLocationID"           , IntegerType()   , True),
                            StructField("payment_type"           , IntegerType()   , True),
                            StructField("fare_amount"            , DoubleType()    , True),
                            StructField("extra"                  , DoubleType()    , True),
                            StructField("mta_tax"                , DoubleType()    , True),
                            StructField("tip_amount"             , DoubleType()    , True),
                            StructField("tolls_amount"           , DoubleType()    , True),
                            StructField("improvement_surcharge"  , DoubleType()    , True),
                            StructField("total_amount"           , DoubleType()    , True),
                            StructField("congestion_surcharge"   , DoubleType()    , True),
                            StructField("airport_fee"            , DoubleType()    , True)
                        ])
                       )



taxi_bases_schema = (
                    StructType
                    ([
                        StructField("License Number"         , StringType()    , True),
                        StructField("Entity Name"            , StringType()    , True),
                        StructField("Telephone Number"       , LongType()      , True),
                        StructField("SHL Endorsed"           , StringType()    , True),
                        StructField("Type of Base"           , StringType()    , True),

                        StructField("Address", 
                                        StructType
                                        ([
                                            StructField("Building"   , StringType(),   True),
                                            StructField("Street"     , StringType(),   True), 
                                            StructField("City"       , StringType(),   True), 
                                            StructField("State"      , StringType(),   True), 
                                            StructField("Postcode"   , StringType(),   True)
                                        ]),
                                    True
                                   ),
                        
                        StructField("GeoLocation", 
                                        StructType
                                        ([
                                            StructField("Latitude"   , StringType(),   True),
                                            StructField("Longitude"  , StringType(),   True), 
                                            StructField("Location"   , StringType(),   True)
                                        ]),
                                    True
                                   )  
                  ])
                )

