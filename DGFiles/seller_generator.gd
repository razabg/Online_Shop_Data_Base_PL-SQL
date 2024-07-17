
[General]
Version=1

[Preferences]
Username=
Password=2197
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##RAZ
Name=CATEGORIES
Count=30

[Record]
Name=CATEGORY_ID
Type=NUMBER
Size=
Data=Sequence(1,, 30)
Master=

[Record]
Name=CATEGORY_NAME
Type=VARCHAR2
Size=50
Data=List('Computer Accessories',
=    'Audio Equipment',
=    'Office Supplies',
=    'Networking',
=    'Gaming Gear',
=    'Headphones & Earbuds',
=    'Mobile Accessories',
=    'Wearable Technology',
=    'Cameras & Photography',
=    'Lighting',
=    'Data Storage',
=    'Health & Fitness',
=    'Smart Home Devices',
=    'Small Kitchen Appliances',
=    'Home Cleaning',
=    'Personal Care',
=    'Medical Devices',
=    'Exercise Equipment',
=    'Television & Home Theater',
=    'Streaming & Media',
=    'Outdoor & Garden',
=    'Tools & Hardware',
=    'Automotive Accessories',
=    'Travel Accessories',
=    'Fashion Accessories',
=    'Luggage & Bags',
=    'Camera Accessories',
=    'Virtual Reality',
=    'Drones',
=    '3D Printing')
Master=

[Record]
Name=INFORMATION
Type=VARCHAR2
Size=50
Data='made in ' + List('China',
=    'USA',
=    'Germany',
=    'Japan',
=    'South Korea',
=    'France',
=    'Taiwan',
=    'Switzerland',
=    'Canada',
=    'Italy',
=    'India',
=    'UK',
=    'Netherlands',
=    'Sweden',
=    'Australia',
=    'Brazil',
=    'Mexico',
=    'Singapore',
=    'Malaysia',
=    'Thailand',
=    'Spain',
=    'Russia',
=    'Turkey',
=    'South Africa',
=    'Poland',
=    'Indonesia',
=    'Vietnam',
=    'Philippines',
=    'Argentina',
=    'Portugal'
=)
Master=

