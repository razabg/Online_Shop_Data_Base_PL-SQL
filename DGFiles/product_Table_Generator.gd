
[General]
Version=1

[Preferences]
Username=
Password=2887
Database=
DateFormat=
CommitCount=0
CommitDelay=0
InitScript=

[Table]
Owner=C##RAZ
Name=PRODUCTS
Count=600..800

[Record]
Name=PRODUCT_ID
Type=NUMBER
Size=
Data=Random(111,9 )
Master=

[Record]
Name=PRODUCT_NAME
Type=VARCHAR2
Size=200
Data=List( 'Wireless Mouse',
=    'Bluetooth Speaker',
=    'Laptop Stand',
=    'USB-C Hub',
=    'Gaming Keyboard',
=    'Noise Cancelling Headphones',
=    'Portable Charger',
=    'Smart Watch',
=    'Digital Camera',
=    'LED Desk Lamp',
=    'External Hard Drive',
=    'Smartphone Case',
=    'Fitness Tracker',
=    'Wireless Earbuds',
=    'Graphic Tablet',
=    'Electric Kettle',
=    'Coffee Maker',
=    'Blender',
=    'Air Fryer',
=    'Pressure Cooker',
=    'Robot Vacuum',
=    'Electric Toothbrush',
=    'Hair Dryer',
=    'Beard Trimmer',
=    'Water Flosser',
=    'Infrared Thermometer',
=    'Blood Pressure Monitor',
=    'Pulse Oximeter',
=    'Electric Shaver',
=    'Massage Gun',
=    'Yoga Mat',
=    'Dumbbell Set',
=    'Resistance Bands',
=    'Treadmill',
=    'Exercise Bike',
=    'Elliptical Machine',
=    'Home Gym Set',
=    'Jump Rope',
=    'Foam Roller',
=    'Smart TV',
=    'Streaming Device',
=    'Sound Bar',
=    'Projector',
=    'Gaming Console',
=    'Wireless Router',
=    'Smart Light Bulbs',
=    'Smart Thermostat',
=    'Security Camera',
=    'Video Doorbell',
=    'Baby Monitor',
=    'Smart Plug',
=    'Smart Lock',
=    'Indoor Plant',
=    'Garden Tools Set',
=    'Outdoor Grill',
=    'Patio Furniture',
=    'Hammock',
=    'Fire Pit',
=    'Lawn Mower',
=    'Leaf Blower',
=    'Pressure Washer',
=    'Tool Kit',
=    'Cordless Drill',
=    'Saw',
=    'Workbench',
=    'Safety Goggles',
=    'Work Gloves',
=    'Paint Sprayer',
=    'Air Compressor',
=    'Wrench Set',
=    'Screwdriver Set',
=    'Socket Set',
=    'Measuring Tape',
=    'Car Vacuum',
=    'Car Charger',
=    'GPS Navigator',
=    'Dash Cam',
=    'Car Seat Cover',
=    'Steering Wheel Cover',
=    'Car Air Purifier',
=    'Tire Pressure Gauge',
=    'Jump Starter',
=    'Toolbox',
=    'Sunglasses',
=    'Wristwatch',
=    'Wallet',
=    'Backpack',
=    'Handbag',
=    'Suitcase',
=    'Travel Pillow',
=    'Camera Bag',
=    'Tripod',
=    'Photo Printer',
=    'Memory Card',
=    'Smartphone Gimbal',
=    'VR Headset',
=    'Drone',
=    'Action Camera',
=    '3D Printer',
=    'Electric Scooter')
Master=

[Record]
Name=INFORMATION
Type=VARCHAR2
Size=50
Data=Components.Description
Master=

[Record]
Name=PRICE
Type=NUMBER
Size=10,2
Data=Components.Price
Master=

[Record]
Name=CATEGORY_ID
Type=NUMBER
Size=
Data=Random(1,10)
Master=

