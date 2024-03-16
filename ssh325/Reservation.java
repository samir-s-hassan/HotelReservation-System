
/***
 * Class to make the Reservation interface access methods
 * @author Samir Hassan
 * @version 0.1
 * Date of creation: April 30, 2023
 * Last Date Modified: 
 */

import java.util.*;
import java.sql.*;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class Reservation {

    BufferedReader in = new BufferedReader(new InputStreamReader(System.in)); // using my BufferedReader and get strings
    String checkInDisplay = ""; // used for display
    String checkOutDisplay = ""; // used for display
    /*
     * The variables listed below will be used to insert a Customer tuple,
     * Reservation tuple, Receipt tuple, and RatesCalc tuple into our tables as
     * these are used for
     * Customer online reservation access
     */
    String hotelName = ""; // used for the hotel query they are making a reservation at
    int reservationID = 0; // reservation attribute
    int hotelID = 0; // reservation attribute
    int roomNumber = 0; // used for the hotel room they are making a reservation at
    String checkInDate = ""; // used for SQL //reservation attribute
    String checkOutDate = ""; // used for SQL //reservation attribute
    int customerID; // reservation & customer attribute
    String fullName = ""; // customer attribute
    String streetAddress = ""; // customer attribute
    String cityAddress = ""; // customer attribute
    String zipAddress = ""; // customer attribute => string because allowed for international customers
    int freqGuestID = 0; // customer attribute
    int freqGuestPoints = 0; // customer attribute
    String primaryPhone = ""; // customer attribute
    long creditCardNumber = 0; // customer attribute
    int confirmationID = 0; // receipt attribute
    int pointsPaid = 0; // receipt attribute
    int dollarsPaid = 0; // receipt attribute
    String exactTime;

    /*
     * Relational data was generated inentionally for IDs. This was done via
     * intentional Mockaroo coding.
     * For example, I had 180 reservationIDs (Reservation) and 180 confirmationID
     * (Receipts) so I simply picked
     * the rowNumber as a way to populate my table. For my 5-digit customerID
     * numbers I generated 140 random customerIDs
     * and 140 random freqGuestIDs with many ended up being null (because not
     * everyone is in the freqGuestProgram)
     * However, this led to the issue that when adding new Customer, Reservation, or
     * Receipt => I cannot intentionally code a
     * value anymore. Therefore, I've created arraylists that will store these
     * values through queries. I will generate
     * random numbers that aren't in this arraylists so I can verify that these
     * haven't been created before.
     * 
     */
    List<Integer> allFreqGuestIDs = new ArrayList<>();
    List<Integer> allCustomerIDs = new ArrayList<>();
    List<Integer> allReservationIDs = new ArrayList<>();
    List<Integer> allConfirmationIDs = new ArrayList<>();

    public void ReservationMenu(Connection connection1) throws Exception, SQLException, IOException {
        try {
            ResultSet allHotelsResult;
            String allHotels;
            Statement allHotels1;

            allHotels = "SELECT DISTINCT hotelCity FROM Hotel";
            allHotels1 = connection1.createStatement();
            allHotelsResult = allHotels1.executeQuery(allHotels);

            System.out.println("===========================================================");
            System.out.println("These are the Hotel California's locations:");

            List<String> hotelNames = new ArrayList<>();

            while (allHotelsResult.next()) { // show the user what cities they can choose from
                String hotelName = allHotelsResult.getString("hotelCity");
                System.out.println(hotelName);
                hotelNames.add(hotelName);
            }
            hotelNames.toArray(new String[0]);
            boolean hotelPicked = false;
            String enteredHotel1;
            do {// menu to get the user to pick a city
                enteredHotel1 = getString1(in, "Please enter a city: ");
                for (String hotelName : hotelNames) {
                    if (enteredHotel1.equalsIgnoreCase(hotelName)) {
                        hotelPicked = true;
                        break;
                    }
                }
            } while (!hotelPicked);

            pickDateIn2023();
            String enteredHotel = toTitleCase(enteredHotel1);
            System.out.println("You picked Hotels in " + enteredHotel + " for dates between " + checkInDisplay + " and "
                    + checkOutDisplay);
            reservationHotelSelection(connection1, enteredHotel, checkInDate, checkOutDate);
            reservationRoomSelection(connection1, enteredHotel, checkInDate, checkOutDate);
            boolean rightChoice = false;
            do {
                validateUniqueID(connection1);
                System.out.println("===========================================================");
                System.out.println(
                        "Let's continue with finishing your reservation. Have you stayed at Hotel California before? ");
                System.out.println("1) New customer");
                System.out.println("2) Existing customer");
                System.out.println("3) Return to previous menu");
                System.out.println("Please select the number associated with your choice: ");
                int userInput = getInt();
                if (userInput == 1) {
                    newCustomerBuilder(connection1); // after newCustomer is built, make their reservation and show it
                                                     // to them
                    newReservationReceiptRatesCalc(connection1);
                    rightChoice = true;
                } else if (userInput == 2) {
                    existingCustomerBuilder(connection1); // after existingCustomer is confirmed, make their reservation
                                                          // and show it to them
                    newReservationReceiptRatesCalc(connection1);
                    rightChoice = true;
                } else if (userInput == 3) {
                    rightChoice = true;
                } else {
                    rightChoice = false;
                }
            } while (!rightChoice);

            // reservationBuilder(connection1);
            // receiptBuilder(connection1);
        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }
    }

    public void reservationHotelSelection(Connection connection1, String enteredHotelCity, String checkInDate,
            String checkOutDate) throws Exception, SQLException, IOException {
        try {
            ResultSet result1;
            String parenthesesPS1;
            PreparedStatement PS1;

            parenthesesPS1 = "SELECT DISTINCT h.hotelName\n"
                    +
                    "FROM Hotel h\n" +
                    "JOIN Room r ON h.hotelID = r.hotelID\n" +
                    "JOIN RoomType rt ON r.roomTypeID = rt.roomTypeID\n" +
                    "WHERE hotelCity = ?  AND NOT EXISTS (\n" +
                    "SELECT 1 FROM Reservation res WHERE res.hotelID = h.hotelID AND res.roomNumber = r.roomNumber\n" +
                    "AND (res.dateCheckIn BETWEEN TO_DATE(?, 'MMDD') AND TO_DATE(?, 'MMDD')\n" +
                    "OR res.dateCheckOut BETWEEN TO_DATE(?, 'MMDD') AND TO_DATE(?, 'MMDD')))\n";
            PS1 = connection1.prepareStatement(parenthesesPS1);
            PS1.setString(1, enteredHotelCity);
            PS1.setString(2, checkInDate);
            PS1.setString(3, checkOutDate);
            PS1.setString(4, checkInDate);
            PS1.setString(5, checkOutDate);
            result1 = PS1.executeQuery();

            ArrayList<String> hotelNames = new ArrayList<>();
            System.out.println("===========================================================");
            System.out.println("These are Hotel California's available hotels in " + enteredHotelCity + ":");
            while (result1.next()) {
                String hotelName = result1.getString("hotelName");
                hotelNames.add(hotelName);
                String row = String.format("%s", hotelName);
                System.out.println(row);
            }
            boolean validHotel = false;
            String hotelName1;
            do {
                hotelName1 = getString1(in, "Enter the hotel name you'd like to make a reservation in: ");
                hotelName1 = toTitleCase(hotelName1);
                if (hotelNames.contains(hotelName1)) {
                    validHotel = true;
                } else {
                    System.out.println("Invalid hotel name. Please try again.");
                }
            } while (!validHotel);
            System.out.println("You selected Hotel California's " + hotelName1 + ".");
            hotelName = hotelName1;

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    public void reservationRoomSelection(Connection connection1, String enteredHotelCity, String checkInDate,
            String checkOutDate) throws Exception, SQLException, IOException {
        try {
            ResultSet result1;
            String parenthesesPS1;
            PreparedStatement PS1;

            parenthesesPS1 = "SELECT r.roomNumber, rt.roomTypeName, rt.totalBathroom, rt.totalBedroom, r.hotelID, rt.dollarDaily, rt.pointDaily\n"
                    +
                    "FROM Hotel h\n" +
                    "JOIN Room r ON h.hotelID = r.hotelID\n" +
                    "JOIN RoomType rt ON r.roomTypeID = rt.roomTypeID\n" +
                    "WHERE hotelCity = ? AND hotelName = ? AND NOT EXISTS (\n" +
                    "SELECT 1 FROM Reservation res WHERE res.hotelID = h.hotelID AND res.roomNumber = r.roomNumber\n" +
                    "AND (res.dateCheckIn BETWEEN TO_DATE(?, 'MMDD') AND TO_DATE(?, 'MMDD')\n" +
                    "OR res.dateCheckOut BETWEEN TO_DATE(?, 'MMDD') AND TO_DATE(?, 'MMDD')))\n";
            PS1 = connection1.prepareStatement(parenthesesPS1);
            PS1.setString(1, enteredHotelCity);
            PS1.setString(2, hotelName);
            PS1.setString(3, checkInDate);
            PS1.setString(4, checkOutDate);
            PS1.setString(5, checkInDate);
            PS1.setString(6, checkOutDate);
            result1 = PS1.executeQuery();
            System.out.println();
            System.out.println("These are the available rooms at Hotel California's " + hotelName + ": ");
            String header = String.format("%-15s%-25s%-15s%-15s%-15s%-15s", "Room Number",
                    "Room Type Name", "Total Bathroom", "Total Bedroom", "Daily Rate ($)", "Daily Rate (points)");
            System.out.println(header);
            ArrayList<Integer> hotelRooms = new ArrayList<>();
            while (result1.next()) {
                hotelID = result1.getInt("hotelID");
                int roomNumber = result1.getInt("roomNumber");
                hotelRooms.add(roomNumber);
                String roomTypeName = result1.getString("roomTypeName");
                int totalBathroom = result1.getInt("totalBathroom");
                int totalBedroom = result1.getInt("totalBedroom");
                int dollarRate = result1.getInt("dollarDaily");
                int pointRate = result1.getInt("pointDaily");

                String row = String.format("%-15d%-25s%-15d%-15d%-15d%-15d", roomNumber,
                        roomTypeName, totalBathroom, totalBedroom, dollarRate, pointRate);
                System.out.println(row);
            }

            boolean validRoom = false;
            int hotelRoom1 = 0;
            do {
                System.out.println("Enter the room number you'd like to make a reservation for: ");
                hotelRoom1 = getInt();
                if (hotelRooms.contains(hotelRoom1)) {
                    validRoom = true;
                } else {
                    System.out.println("Invalid room number. Please try again.");
                }
            } while (!validRoom);

            roomNumber = hotelRoom1;

            System.out.println("You selected Hotel California's " + hotelName + " room " + roomNumber + ".");

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    public void existingCustomerBuilder(Connection connection1)
            throws Exception, SQLException, IOException {
        ResultSet result1;
        String parenthesesPS1;
        PreparedStatement PS1;
        try {
            System.out.println("===========================================================");
            System.out.println(
                    "As a previous customer, We'll ask for you to confirm some information with us before proceeding with your reservation");
            System.out.print("Please enter your 5-digit Customer ID:  ");
            customerID = getInt();

            parenthesesPS1 = "SELECT * FROM Customer WHERE customerID = ?";
            PS1 = connection1.prepareStatement(parenthesesPS1);
            PS1.setInt(1, customerID);
            result1 = PS1.executeQuery();
            int totalFreqPoints = 0;
            while (result1.next()) {
                System.out.println("\nHello, " + result1.getString("fullName"));
                System.out.println("Address: " + result1.getString("streetAddress") + " "
                        + result1.getString("cityAddress") + " " +
                        result1.getString("zipAddress"));
                System.out.println("Phone number: " + result1.getString("primaryPhone"));
                System.out.println("Credit Card number: " + result1.getString("creditCardNumber"));
                totalFreqPoints = result1.getInt(freqGuestPoints);
            }
            boolean rightChoice = true;
            do {
                System.out.println("Would you like to be charged to this credit card and address?");
                System.out.println("1) Yes");
                System.out.println("2) No, use my Frequent Guest points");
                System.out.println("3) Cancel the reservation process, return to previous menu");
                System.out.println("Please select the number associated with your choice: ");
                int userInput = getInt();
                if (userInput == 1) {
                    dollarsPaid = 1;
                    rightChoice = true;
                } else if (userInput == 2 && totalFreqPoints > 0) {
                    pointsPaid = 0;
                    rightChoice = true;
                } else if (userInput == 2 && totalFreqPoints == 0) {
                    System.out.println("\nYou do not have any Frequent Guest Points. Please select another option.\n");
                    rightChoice = false;

                } else if (userInput == 3) {
                    rightChoice = true;
                } else {
                    rightChoice = false;
                }
            } while (!rightChoice);

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    public void newCustomerBuilder(Connection connection1)
            throws Exception, SQLException, IOException {
        try {
            System.out.println("===========================================================");
            System.out.println(
                    "As a new customer, we'll ask for you to enter your details before proceeding with your reservation");
            boolean correct1 = false;
            fullName = getString1(in, "Full Name: ");
            streetAddress = getString1(in, "Street name: ");
            cityAddress = getString1(in, "City: ");
            zipAddress = getString1(in, "Zip: ");
            primaryPhone = getString1(in, "Phone number, please include dashes - - -: ");
            System.out.print("Credit card number: ");
            creditCardNumber = getLong();
            System.out.println(
                    "Would you like to join our Frequent-Guest program? New members receive 25 total points which is almost a free Single room!");
            do {
                String userInput = getString1(in, "Please enter Yes or No: ");
                if ("Yes".equalsIgnoreCase(userInput)) {
                    Random random = new Random();
                    int num = random.nextInt(90000000) + 10000000; // generates a random 8 digit integer
                    while (allFreqGuestIDs.contains(num)) {
                        num = random.nextInt(90000000) + 10000000; // generates a random 8 digit integer
                    }
                    freqGuestID = num;
                    freqGuestPoints = 25;
                    System.out.println("Your Frequent Guest ID is " + freqGuestID);
                    System.out.println("Would you like to be charged to this credit card and address?");
                    boolean rightChoice = true;
                    do {
                        System.out.println("1) Yes");
                        System.out.println("2) No, use my Frequent Guest points");
                        System.out.println("3) Cancel the reservation process, return to previous menu");
                        System.out.println("Please select the number associated with your choice: ");
                        int userInput1 = getInt();
                        if (userInput1 == 1) {
                            dollarsPaid = 1;
                            rightChoice = true;
                        } else if (userInput1 == 2) {
                            pointsPaid = 0;
                            rightChoice = true;
                        } else if (userInput1 == 3) {
                            rightChoice = true;
                        } else {
                            rightChoice = false;
                        }
                    } while (!rightChoice);

                    correct1 = true;
                } else if ("No".equalsIgnoreCase(userInput)) {
                    correct1 = true;
                } else {
                    correct1 = false;
                }
            } while (!correct1);
            Random random = new Random();
            int num = random.nextInt(90000) + 10000; // generates a random 5 digit integer
            while (allCustomerIDs.contains(num)) {
                num = random.nextInt(90000000) + 10000000; // generates a random 5 digit integer
            }
            customerID = num;
            System.out.println("This is your unique Customer ID. Please record it down for future use: " + customerID);
            String parenthesesPS1;
            PreparedStatement PS1;
            parenthesesPS1 = "insert into Customer (customerID, fullName, streetAddress, cityAddress, zipAddress, freqGuestID, freqGuestPoints, primaryPhone, creditCardNumber) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PS1 = connection1.prepareStatement(parenthesesPS1);
            PS1.setInt(1, customerID);
            PS1.setString(2, fullName);
            PS1.setString(3, streetAddress);
            PS1.setString(4, cityAddress);
            PS1.setString(5, zipAddress);
            PS1.setInt(6, freqGuestID);
            PS1.setInt(7, freqGuestPoints);
            PS1.setString(8, primaryPhone);
            PS1.setLong(9, creditCardNumber);
            PS1.executeQuery();

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    public void newReservationReceiptRatesCalc(Connection connection1)
            throws Exception, SQLException, IOException {
        try {
            Random random = new Random();
            int num = random.nextInt(90000) + 10000; // generates a random 5 digit integer
            while (allReservationIDs.contains(num)) {
                num = random.nextInt(90000000) + 10000000; // generates a random 5 digit integer
            }
            reservationID = num;

            Random random1 = new Random();
            int num1 = random1.nextInt(90000) + 10000; // generates a random 5 digit integer
            while (allConfirmationIDs.contains(num1)) {
                num1 = random.nextInt(90000000) + 10000000; // generates a random 5 digit integer
            }
            confirmationID = num;

            String parenthesesPS1;
            PreparedStatement PS1;
            parenthesesPS1 = "INSERT INTO Reservation (reservationID, customerID, hotelID, roomNumber, dateCheckIn, dateCheckOut) VALUES (?, ?, ?, ?, TO_DATE(?, 'MMDD'), TO_DATE(?, 'MMDD'))";
            PS1 = connection1.prepareStatement(parenthesesPS1);
            PS1.setInt(1, reservationID);
            PS1.setInt(2, customerID);
            PS1.setInt(3, hotelID);
            PS1.setInt(4, roomNumber);
            PS1.setString(5, checkInDate);
            PS1.setString(6, checkOutDate);
            PS1.executeQuery();

            // come back to this
            String parenthesesPS2 = "INSERT INTO RateCalc (reservationID, roomTypeID, rateID) SELECT r.reservationID , rt.roomTypeID, 'Normal'"
                    +
                    " FROM Reservation r JOIN Room rm ON r.roomNumber = rm.roomNumber AND r.hotelID = rm.hotelID JOIN RoomType rt ON rm.roomTypeID = rt.roomTypeID"
                    +
                    " WHERE r.reservationID = " + reservationID
                    + " AND NOT EXISTS (\nSELECT 1 FROM Rates ra WHERE (r.dateCheckIn BETWEEN ra.dateRateStart AND ra.dateRateEnd)OR (r.dateCheckOut BETWEEN ra.dateRateStart AND ra.dateRateEnd))";
            Statement PS2 = connection1.createStatement();
            PS2.executeQuery(parenthesesPS2);

            String parenthesesPS3 = "INSERT INTO RateCalc (reservationID, roomTypeID, rateID) SELECT r.reservationID, rt.roomTypeID, ra.rateID"
                    +
                    " FROM Reservation r JOIN Room rm ON r.roomNumber = rm.roomNumber AND r.hotelID = rm.hotelID JOIN RoomType rt ON rm.roomTypeID = rt.roomTypeID"
                    +
                    " JOIN Rates ra ON (r.dateCheckIn BETWEEN ra.dateRateStart AND ra.dateRateEnd)OR (r.dateCheckOut BETWEEN ra.dateRateStart AND ra.dateRateEnd)"
                    +
                    " WHERE r.reservationID = " + reservationID;
            Statement PS3 = connection1.createStatement();
            PS3.executeQuery(parenthesesPS3);

            if (dollarsPaid == 1) {// if customer chooses to pay with dollars
                PreparedStatement PS4;
                String parenthesesPS4 = "INSERT INTO Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
                PS4 = connection1.prepareStatement(parenthesesPS4);
                PS4.setInt(1, confirmationID);
                PS4.setInt(2, reservationID);
                PS4.setInt(3, dollarsPaid);
                PS4.setInt(4, pointsPaid);
                PS4.executeQuery();

                String parenthesesPS7 = "UPDATE Receipt rec\n SET rec.dollarsPaid = ( SELECT SUM(rts.rateMultiplier * rt.dollarDaily * (rs.dateCheckOut - rs.dateCheckIn)) AS total_rate\n"
                        +
                        "FROM Reservation rs \nJOIN RateCalc rc ON rs.reservationID = rc.reservationID \nJOIN RoomType rt ON rt.roomTypeID = rc.roomTypeID \nJOIN Rates rts ON rts.rateID = rc.rateID"
                        +
                        "WHERE rec.reservationID = rs.reservationID)\nWHERE rec.dollarsPaid = 1";
                Statement PS7 = connection1.createStatement();
                PS7.executeQuery(parenthesesPS7);
            } else {// if customer chooses to pay with points
                PreparedStatement PS5;
                String parenthesesPS5 = "INSERT INTO Receipt (confirmationID, reservationID, dollarsPaid, pointsPaid, exactTime) VALUES (?, ?, ?, ?, CURRENT_TIMESTAMP)";
                PS5 = connection1.prepareStatement(parenthesesPS5);
                PS5.setInt(1, confirmationID);
                PS5.setInt(2, reservationID);
                PS5.setInt(3, dollarsPaid);
                PS5.setInt(4, pointsPaid);
                PS5.executeQuery();

                String parenthesesPS8 = "UPDATE Receipt rec\nSET rec.pointsPaid = (\nSELECT SUM(rts.rateMultiplier * rt.pointDaily * (rs.dateCheckOut - rs.dateCheckIn)) AS total_rate"
                        +
                        "\nFROM Reservation rs\nJOIN RateCalc rc ON rs.reservationID = rc.reservationID\nJOIN RoomType rt ON rt.roomTypeID = rc.roomTypeID\nJOIN Rates rts ON rts.rateID = rc.rateID"
                        +
                        "\nWHERE rec.reservationID = rs.reservationID)\nWHERE rec.pointsPaid = 1";
                Statement PS8 = connection1.createStatement();
                PS8.executeQuery(parenthesesPS8);
            }

            String parethesesPS9 = "SELECT r.reservationID, r.roomNumber, h.hotelName, rt.roomTypeName, rt.totalBathroom, rt.totalBedroom, r.dateCheckIn, r.dateCheckOut, rpt.dollarsPaid "
                    +
                    "FROM Reservation r " +
                    "JOIN Receipt rpt ON rpt.reservationID = r.reservationID " +
                    "JOIN Room rm ON r.hotelID = rm.hotelID AND r.roomNumber = rm.roomNumber " +
                    "JOIN RoomType rt ON rm.roomTypeID = rt.roomTypeID " +
                    "JOIN Hotel h ON rm.hotelID = h.hotelID " +
                    "WHERE r.reservationID = ?";
            PreparedStatement PS9 = connection1.prepareStatement(parethesesPS9);

            // Set the reservationID parameter
            PS9.setInt(1, reservationID);

            // Execute the query
            ResultSet rs = PS9.executeQuery();

            System.out.println("\nWe've confirmed your reservation!\n");
            // Loop through the results and print them
            while (rs.next()) {
                int reservationID = rs.getInt("reservationID");
                int roomNumber = rs.getInt("roomNumber");
                String hotelName = rs.getString("hotelName");
                String roomTypeName = rs.getString("roomTypeName");
                int totalBathroom = rs.getInt("totalBathroom");
                int totalBedroom = rs.getInt("totalBedroom");
                Date dateCheckIn = rs.getDate("dateCheckIn");
                Date dateCheckOut = rs.getDate("dateCheckOut");
                double dollarsPaid = rs.getDouble("dollarsPaid");

                System.out.println("Reservation ID: " + reservationID);
                System.out.println("Room Number: " + roomNumber);
                System.out.println("Hotel Name: " + hotelName);
                System.out.println("Room Type Name: " + roomTypeName);
                System.out.println("Total Bathrooms: " + totalBathroom);
                System.out.println("Total Bedrooms: " + totalBedroom);
                System.out.println("Check-in Date: " + dateCheckIn);
                System.out.println("Check-out Date: " + dateCheckOut);
                System.out.println("Dollars Paid: " + dollarsPaid);
            }

        }

        catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    public void validateUniqueID(Connection connection1) throws Exception, SQLException, IOException {
        ResultSet cusResult, resResult, recResult;
        String cusResult1, resResult1, recResult1;
        Statement cusResult2, resResult2, recResult2;

        try {
            cusResult1 = "SELECT DISTINCT customerID, freqGuestID from Customer";
            cusResult2 = connection1.createStatement();
            cusResult = cusResult2.executeQuery(cusResult1);
            while (cusResult.next()) {
                allCustomerIDs.add(cusResult.getInt("customerID"));
                allFreqGuestIDs.add(cusResult.getInt("freqGuestID"));
            }

            resResult1 = "SELECT DISTINCT reservationID from Reservation";
            resResult2 = connection1.createStatement();
            resResult = resResult2.executeQuery(resResult1);
            while (resResult.next()) {
                allReservationIDs.add(resResult.getInt("reservationID"));
            }

            recResult1 = "SELECT DISTINCT confirmationID from Receipt";
            recResult2 = connection1.createStatement();
            recResult = recResult2.executeQuery(recResult1);
            while (recResult.next()) {
                allConfirmationIDs.add(recResult.getInt("confirmationID"));

            }

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    public String pickDateIn2023() {
        boolean datePicked = false;
        String pickedDate = "", userInput = "";
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy");
        boolean checkOutvsIn = true;

        // Get today's date
        Date today = new Date();

        do {
            if (checkOutvsIn) {
                userInput = getString1(in,
                        "Enter a potential Check-In date within this year using this format (MM-DD-2023): ");
            } else {
                userInput = getString1(in,
                        "Enter a potential Check-Out date within this year using this format (MM-DD-2023): ");
            }

            try {
                Date date = dateFormat.parse(userInput);
                Calendar cal = Calendar.getInstance();
                Calendar yesterday = Calendar.getInstance();
                yesterday.add(Calendar.DATE, -1);
                cal.setTime(date);
                int year = cal.get(Calendar.YEAR);

                if (year == 2023) {
                    if (pickedDate.isEmpty()) {
                        // If this is the first date being picked, just store it
                        pickedDate = userInput;
                        checkInDisplay = pickedDate;
                        checkInDate = (dateFormat.format(date).replaceAll("-", "")).substring(0, 4);

                        // Check if the potential check-in date is after today's date
                        if (date.before(yesterday.getTime())) {
                            System.out.println("Check-in date must be today or later.\n");
                            pickedDate = "";
                        } else {
                            checkOutvsIn = false;
                        }
                    } else {
                        // If a date has already been picked, check if the new date is after it
                        Date pickedDateObj = dateFormat.parse(pickedDate);
                        if (date.after(pickedDateObj) || date.equals(pickedDateObj)) {
                            pickedDate = userInput;
                            checkOutDisplay = pickedDate;
                            checkOutDate = (dateFormat.format(date).replaceAll("-", "")).substring(0, 4);
                            datePicked = true;
                        } else {
                            System.out.println("Check-out date must be after check-in date.\n");
                        }
                    }
                } else {
                    System.out.println("Invalid year. Please enter a date in 2023.\n");
                }
            } catch (ParseException e) {
                System.out.println("Invalid date format. Please enter a date in MM-DD-YYYY format.\n");
            }

        } while (!datePicked);

        return pickedDate;
    }

    public static int getInt() {
        Scanner scanner1 = new Scanner(System.in);
        while (true) { // keep looping until a valid integer is entered
            try {
                int num = scanner1.nextInt(); // try to read an integer from the input
                scanner1.nextLine(); // consume the newline character
                return num; // return the integer if successful
            } catch (NumberFormatException e) {
                System.out.println("Invalid input, please try again.");
                scanner1.nextLine(); // consume the invalid input
            } catch (IllegalStateException e) {
                // handle the exception
                System.err.println("IllegalStateException caught: " + e.getMessage());
                scanner1.nextLine(); // consume the invalid input

            } catch (InputMismatchException e) {
                System.out.println("Invalid input. Please enter an integer.");
                scanner1.nextLine(); // consume the invalid input

            }

        }

    }

    public static long getLong() {
        Scanner scanner = new Scanner(System.in);
        while (true) { // keep looping until a valid long is entered
            try {
                long num = scanner.nextLong(); // try to read a long from the input
                scanner.nextLine(); // consume the newline character
                return num; // return the long if successful
            } catch (InputMismatchException e) {
                System.out.println("Invalid input, please try again.");
                scanner.nextLine(); // consume the invalid input
            } catch (NumberFormatException e) {
                System.out.println("Invalid input, please try again.");
                scanner.nextLine(); // consume the invalid input
            }
        }
    }

    public String getString1(BufferedReader in, String message) {// from my CSE017 code
        String s;
        try {
            System.out.print(message);
            s = in.readLine();
        } catch (IOException e) {
            e.printStackTrace();
            return "";
        }
        return s;
    }

    public static String toTitleCase(String str) {
        if (str == null || str.isEmpty()) {
            return str;
        }

        StringBuilder titleCase = new StringBuilder(str.length());
        titleCase.append(Character.toTitleCase(str.charAt(0)));

        for (int i = 1; i < str.length(); i++) {
            char currentChar = str.charAt(i);
            char previousChar = str.charAt(i - 1);

            if (Character.isWhitespace(previousChar) || previousChar == '-') {
                titleCase.append(Character.toTitleCase(currentChar));
            } else {
                titleCase.append(Character.toLowerCase(currentChar));
            }
        }

        return titleCase.toString();
    }
}