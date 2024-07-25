
[General]
Version=1

[Preferences]
Username=
Password=2264
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##RAZ
Name=ORDERDETAILS
Count=400

[Record]
Name=PRODUCT_ID
Type=NUMBER
Size=
Data=Sequence(1, 494)
Master=

[Record]
Name=QUANTITY
Type=NUMBER
Size=
Data=Random(1,10)
Master=

[Record]
Name=DELIVERY_METHOD
Type=VARCHAR2
Size=20
Data=List('pick up from store', 'home delivery', 'pick up spots')
Master=

