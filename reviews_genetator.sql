
[General]
Version=1

[Preferences]
Username=
Password=2128
Database=
DateFormat=dd-mm-yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##RAZ
Name=REVIEWS
Count=400

[Record]
Name=REVIEW_ID
Type=NUMBER
Size=
Data=Sequence(1, [1], [WithinParent])
Master=

[Record]
Name=RATING
Type=NUMBER
Size=10,1
Data=Random(1, 10)
Master=

[Record]
Name=COMMENT_TEXT
Type=VARCHAR2
Size=2000
Data=List('Great product!',
='Very satisfied',
='Excellent quality',
='Not as expected',
='Highly recommend',
='Good value',
='Fast shipping',
='Will buy again',
='Decent purchase',
='Not worth it',
='Superb performance',
='Love this item',
='Works perfectly',
='Cheap but good',
='Disappointed',
='Too expensive',
='Well made',
='Very useful',
='Impressed',
='Amazing service',
='Would recommend',
='High quality',
='Terrible purchase',
='Fast delivery',
='Value for money',
='Top-notch item',
='Subpar quality',
='Fantastic buy',
='Just okay',
='Returned it',
='Exceeded expectations',
='Great features',
='Low quality',
='Happy customer',
='Does the job',
='Not impressed',
='Excellent service',
='Great design',
='Will return',
='Five stars'
=)
Master=

[Record]
Name=REVIEW_DATE
Type=DATE
Size=
Data=Random(1-1-2023, 1-1-2025)
Master=

[Record]
Name=PRODUCT_ID
Type=NUMBER
Size=
Data=List(select product_id from Products)
Master=

[Record]
Name=BUYER_ID
Type=NUMBER
Size=
Data=List(select buyer_id from Buyers)
Master=

