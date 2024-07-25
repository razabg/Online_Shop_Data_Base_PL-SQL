
[General]
Version=1

[Preferences]
Username=
Password=2687
Database=
DateFormat=dd/mm/yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##RAZ
Name=SELL
Count=500

[Record]
Name=SELLER_ID
Type=NUMBER
Size=
Data=List(select seller_id from sellers)
Master=

[Record]
Name=PRODUCT_ID
Type=NUMBER
Size=
Data=List(select product_id from products)
Master=

