
[General]
Version=1

[Preferences]
Username=
Password=2361
Database=
DateFormat=dd/mm/yyyy
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##RAZ
Name=ORDERS
Count=10..20

[Record]
Name=ORDER_ID
Type=NUMBER
Size=
Data=Random(9999, 99999)
Master=

[Record]
Name=ORDER_DATE
Type=DATE
Size=
Data=Random(01-01-2023, 01-01-2025)
Master=

[Record]
Name=TRACKING_NUMBER
Type=VARCHAR2
Size=20
Data=Components.Code
Master=

[Record]
Name=PRODUCT_ID
Type=NUMBER
Size=
Data=List(select product_id from OrderDetails)
Master=

[Record]
Name=BUYER_ID
Type=NUMBER
Size=
Data=List(select buyer_id from buyers)
Master=

