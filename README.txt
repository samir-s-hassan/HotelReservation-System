Hello!

This is the README for my Hotel database management system project. Let's begin!

I've included a MAKEFILE for the project that I used when initially started the project as I made a few different classes. I also hard-coded my user name and 
password to speed up the process. However, if the project was to be recompiled, I don't necessarily require the graders or professor to compile with the MAKEFILE.
My MAKEFILE commands were very simple and I used it to compile my classes with the .jar driver and run my executable with the .jar driver. 

I have four classes: Hotel, Housekeeping, Reservation, Frontdesk
My Hotel.class is the main menu and calls all the different methods.
My Housekeeping.class assumes the user as a housekeeping staff and primarily focuses on the housekeeping interface.
My Reservation.class assumes the user as a customer and primarily focuses on the customer online reservation access.
My Frontdesk.class assumes the user as a front-desk agent and primarily focuses on the check-in and check-out methods.


Overview of policy decisions:
1. Hotel database management system is relative to our current time. Therefore, customers cannot make reservations for the past. However, customers can make reservations
for the future.
2. When interacting with front desk agent or the housekeeping interface, we assume that the staff members already exist in a hotel meaning that they
are already at a specific Hotel California location. A staff member though is not an entity so we enter a hotel ID as the place the staff member works at.
3. When showing the users the rooms they are available to book, we show them the specific room numbers and that they can book those. We believe in transparency
at Hotel California and we want customers to know what number they are at.
4. However, too much transparency can be an issue and that's why we show the dollar rate and points rate as the base rate for a certain room type. I have a 
Rates table that looks at the dates the customer wants to book the hotel and that is where we receive our rate multiplier. Certain dates in the year are more
expensive than others and certain dates are cheaper. The customer though doesn't have to know how much more he's paying for a room compared to the base rate so 
we simply show them the base rate. It's pretty self-explanatory that rooms will cost more in Thanksgiving compared to some random April weekend. 
5. I've included four room types that each have different sets of bedrooms and bathrooms. I did include amenities but as they were not part of any specific interface, I 
did not add it to my general interface due to the reward-risk ratio considering the due date.
6. The hotel addresses do not have America as a country because we assume all hotels to be in the US. However, customers can be all around the world
and that's why many of our variables for creating these entities were strings because we simply cannot limit our worldwide customers.
7. Rooms can be paid for in dollar rate and points rate. I made it an almost 2:1 ratio when considering dollar:points because then it'd be easier for our customers.
I also gave users free points when they get a membership with us on the basis of they can almost buy themselves a free room.
8. Customers do not have anything but a credit card number for simplicity. There isn't much requirement or complexity to add additional info.
9. Customer's points can only be redeemed for rooms as it stands but we might add more later.
10. A room can be reserved for the future or may be occupied in the current moment. It may also be free in the current moment. The data loading was done in a 
way that multiple test cases of variety can be run. Management of future reservation data is a policy decision and we've decided that the customers can 
view the specific room number they are booking. 
11. A customer can both be checked in and checked out through the Front desk or they can go through a different process and check out "themselves".
12. Starting from the initial data-loading process, it is up to the user playing with my Hotel database management system to keep track of room cleaning and 
availability. This is because of the way the Checkout and Checkin system is done. From onwards, the staff should either check in or check out current customers or
the customers themselves should.
13. Business manager interface was NOT DONE/NOT IMPLEMENTED.


Test cases:
When using the Customer interface, here are some 5-digit customer IDs you can use:
42513
82906
67024
91378
24109
50234
86179
14796

When using the Customer interace, here are some full names you can use:
Ezequiel Lansdale
Jenilee Friedank
Malvina Kane
Valentia Rosenstock
Tyrone Strapp
Ax Bithany
Jakob Schiell
Ambrosi Learoyd
Jareb Playford
Sunny Swanton
Hilton Cork
Cleve Duchateau
Blondell Garmon
Samir Hassan
Mamoona Hassan
Sharnom Alkaderi

When using the Employee interface, here are some hotel IDs you can use:
45671
45678
34560
12345
78901
67890
23459

Changes to E-R diagram:
I removed the relation between roomType and Reservation. I found that this relation was redundant and unnecessary. This is because I have a ratesCalc ternary relation
table that helps me with the process of calculating the cost based on a Reservation, roomType, and Rates. I added a relation between Reservation and roomNumber though
because it makes sense for the Reservation to include the specific room at the specific Hotel the customer is booking. I also removed the derived attributes
costDollar(), costPoints(), and costCancel() from my Reservation table. Since the Receipt table and Reservation table have a one to one relationship and are always
updated at the same time (once the user books the Reservation, he pays and therefore we insert a tuple into Receipt as well). Since this update is done simultaneously,
I realized that this derived attribute was redundant and not necessary.

Data generation and population of relations:
Mockaroo was my primary source of data. I used custom lists to generate realistic data such as having multiple hotels in one city, Hotels having similar room structure, etc.
I also used SQL after generating my initial data to create data for my tables and then filling up my other tables of RatesCalc, Receipt. I also used SQL to 
update room status based on the current date. I left comments on my data generation code and more can be found there. 


