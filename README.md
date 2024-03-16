# Hotel Reservation System

Hotel Reservation System is a command-line app that facilitates booking experiences for customers, allowing them to reserve rooms for hotel stays. The application has interfaces for customers, front-desk agents, and a housekeeping staff. The interface for front desk agents allow them to manage check-ins and check-outs while the housekeeping staff interface allows them to monitor room status and cleanliness. 

Within their interface, customers can view available room options with their respective room numbers and base rates. Though, the base rate isn't the final price as the price is dependent on the season and time of the booking. Payment options include both dollar and points rates, with a redemption process for customer points.

## Required Features

The following functionality is completed:

- [X] User can navigate easily between different interfaces, managing reservations, housekeeping, and front desk tasks
- [X] User can easily search for available rooms on specified future dates.
- [X] User can make multiple reservations for different dates or room types within a single booking session.
- [X] User can select room preferences such as bed type, view, and amenities during the reservation process.
- [X] User can check the availability of specific room types and view their respective rates.
- [X] User can handle multiple reservations efficiently, modifying or canceling bookings as needed.
- [X] User can view real-time availability and rates for specific room types.

## How to run

1. Within the ssh325/ directory, run the makefile with "make"
2. There will now be a jar file compiled, which we can run with "java -jar ssh325.jar"
3. This should run the project, Use the app! OR
4. I provided an already compiled jar version within the root directory named "ssh325.jar"
5. We can run this with "java -jar ssh325.jar"
6. Use the app!

## Video Walkthrough

N/A

## Notes

Unfortunately, the server that hosted the backend no longer holds the database that I built this project on. I am working on moving all the data into another database. I can then modify the source code with the new database connection and get the project up and running again -> WORK IN PROGRESS

If you browse through this repository, you can read on a lot of the conceptual and creative decisions that went into this project. This is a Database-forward project in which I was focusing on making a perfect Database that would make the most sense for a Hotel reservation system. 

## License

    Copyright 2023 Samir Hassan

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

