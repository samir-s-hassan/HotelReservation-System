
/***
 * Class to make the Frontdesk interface methods
 * @author Samir Hassan
 * @version 0.1
 * Date of creation: April 30, 2023
 * Last Date Modified: 
 */

import java.util.*;
import java.sql.*;
import java.io.*;

public class Frontdesk {
    int hotelID;
    String hotelCity;
    BufferedReader in = new BufferedReader(new InputStreamReader(System.in)); // using my BufferedReader and get//
                                                                              // strings

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

    public void FrontdeskMenu(Connection connection1) throws Exception, SQLException, IOException {
        ResultSet allHotelsResult;
        String hotelIDstring, allHotels;
        int userOption;
        boolean userExit = false;
        String hotelName = "";
        try {
            System.out.println("Hello Hotel California front desk agent!");
            hotelIDstring = getString1(in, "Which hotel are you a part of? Please enter the Hotel ID: ");
            hotelID = Integer.parseInt(hotelIDstring); // convert the Hotel ID taken as a string to an integer
            // make the prepared statment and give the correct hotelID
            allHotels = "SELECT * FROM Hotel WHERE hotelID = ?";
            PreparedStatement allHotels1 = connection1.prepareStatement(allHotels);
            allHotels1.setInt(1, hotelID);
            allHotelsResult = allHotels1.executeQuery();

            while (allHotelsResult.next()) {
                hotelName = allHotelsResult.getString("hotelName");
                hotelCity = allHotelsResult.getString("hotelCity");
            }

            do {
                System.out.println("===========================================================");
                System.out.println("Welcome Front-desk agent of " + hotelName + " ");
                System.out.println("\n1) Would you like to view current stays at our hotel?");
                System.out.println("2) Would you like to check in a customer?");
                System.out.println("3) Would you like to check out a customer?");
                System.out.println("4) Return to previous menu");
                System.out.println("Please select the number associated with your choice: ");
                userOption = getInt();

                if (userOption == 1) {
                    Housekeeping housekeeping2 = new Housekeeping(); // creates the catalog object needed to
                    // access the housekeeping staff
                    housekeeping2.viewCurrentStays(connection1, hotelID);
                } else if (userOption == 2) {
                    handleCheckIn(connection1, hotelName);
                    // System.out.println("Thanks! Returning you to the previous menu");
                } else if (userOption == 3) {
                    handleCheckOut(connection1, hotelName);
                    // System.out.println("Thanks! Returning you to the previous menu");
                } else if (userOption == 4) {
                    // System.out.println("Thanks for cleaning today! Returning you to the previous
                    // menu");
                    // System.out.println("Returning you to the previous menu");
                    userExit = true;
                } else {
                    // handle invalid option
                }
            } while (!userExit);

            // CLOSE ALL RESULTSETS AND STATEMENTS, connections to be closed in
            allHotelsResult.close();

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }
    }

    public void handleCheckIn(Connection connection1, String hotelName)
            throws Exception, SQLException, IOException {
        try {
            int counter = 0;
            int customerID = 0;
            System.out.println("===========================================================");
            System.out.println("Hello Customer! This is Hotel California's " + hotelName + " in the beautiful city of "
                    + hotelCity);
            String fullName = getString1(in, "To check in, Please enter your full name: ");
            // query time
            ResultSet ps1r;
            String parenthesesPS1;
            PreparedStatement PS1;
            parenthesesPS1 = "SELECT customerID FROM Customer WHERE fullName = ?";
            PS1 = connection1.prepareStatement(parenthesesPS1);
            PS1.setString(1, fullName);
            ps1r = PS1.executeQuery();

            while (ps1r.next()) {
                counter++;
                if (counter == 1) {
                    customerID = ps1r.getInt("customerID");
                }
            }
            if (counter == 0) {
                System.out.println("\nSorry, we could not find an account associated with that name");
            } else if (counter == 1) {
                int areReservationsThere = 0;
                ResultSet ps4r;
                String parenthesesPS4;
                PreparedStatement PS4;
                parenthesesPS4 = "SELECT r.reservationID, r.customerID, h.hotelName, h.hotelCity, rt.roomTypeName, r.roomNumber, r.dateCheckIn, r.dateCheckOut\n"
                        + "FROM Reservation r\nJOIN Room rm ON r.hotelID = rm.hotelID \nAND r.roomNumber = rm.roomNumber\n" // add
                                                                                                                            // a
                                                                                                                            // new
                                                                                                                            // line
                                                                                                                                          // here
                        + "JOIN Hotel h ON r.hotelID = h.hotelID\nJOIN RoomType rt ON rm.roomTypeID = rt.roomTypeID " // add
                                                                                                                                               // a
                                                                                                                                                                         // space
                                                                                                                                                                                                                // here
                        + "WHERE r.customerID = ?\nAND r.hotelID = (" +
                        "\nSELECT hotelID FROM Hotel WHERE hotelName = ? AND hotelCity = ?" +
                        "\nAND r.dateCheckIn = TRUNC(SYSDATE))";
                PS4 = connection1.prepareStatement(parenthesesPS4);
                PS4.setInt(1, customerID);        
                PS4.setString(2, hotelName);
                PS4.setString(3, hotelCity);
                ps4r = PS4.executeQuery();
                while (ps4r.next()) { // set the customerID after you've found it
                    areReservationsThere++;
                    if (areReservationsThere == 1) {
                        System.out.println(
                                "These are your reservations at Hotel California's " + hotelName + " in " + hotelCity);
                        customerID = ps4r.getInt("customerID");
                        String formatString = "%-15s %-15s %-20s %-15s %-20s %-20s\n";
                        System.out.printf(formatString, "Reservation ID", "Customer ID",
                                "Room Type", "Room Number", "Check-In Date", "Check-Out Date");

                        int reservationID = ps4r.getInt("reservationID");
                        String roomTypeName = ps4r.getString("roomTypeName");
                        int roomNumber = ps4r.getInt("roomNumber");
                        String dateCheckIn = ps4r.getString("dateCheckIn");
                        String dateCheckOut = ps4r.getString("dateCheckOut");

                        System.out.printf(formatString, reservationID, customerID,
                                roomTypeName, roomNumber, dateCheckIn, dateCheckOut);
                    } else {
                        int reservationID = ps4r.getInt("reservationID");
                        String roomTypeName = ps4r.getString("roomTypeName");
                        int roomNumber = ps4r.getInt("roomNumber");
                        String dateCheckIn = ps4r.getString("dateCheckIn");
                        String dateCheckOut = ps4r.getString("dateCheckOut");
                        String formatString = "%-15s %-15s %-20s %-15s %-20s %-20s\n";

                        System.out.printf(formatString, reservationID, customerID,
                                roomTypeName, roomNumber, dateCheckIn, dateCheckOut);

                    }
                }
                String query1 = "SELECT r.roomNumber, h.hotelName, res.dateCheckOut "
                        + "FROM Room r "
                        + "JOIN Hotel h ON h.hotelID = r.hotelID " +
                        " JOIN Customer c ON c.customerID = res.customerID"
                        + "JOIN Reservation res ON r.roomNumber = res.roomNumber AND r.hotelID = res.hotelID "
                        + "WHERE h.hotelName = ? AND res.dateCheckIn = TRUNC(SYSDATE) AND res.customerID = ?";
                PreparedStatement pstmt = connection1.prepareStatement(query1);
                pstmt.setString(1, hotelName); // set hotelName parameter
                pstmt.setInt(3, customerID); // set customerID parameter
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    int roomNumberUpdate = rs.getInt("roomNumber");
                    String parenthesesPS2 = "UPDATE Room SET statusAvailability = 0 " +
                            "\nWHERE roomNumber = ? AND hotelID = (SELECT hotelID FROM Hotel WHERE hotelName = ?) "
                            +
                            "\nAND EXISTS (SELECT 1 FROM Reservation WHERE roomNumber = ? AND hotelID = Room.hotelID AND dateCheckOut = TRUNC(SYSDATE))";
                    PreparedStatement pstmt1 = connection1.prepareStatement(parenthesesPS2);
                    pstmt1.setInt(1, roomNumberUpdate);
                    pstmt1.setString(2, hotelName);
                    pstmt1.setInt(3, roomNumberUpdate);

                    System.out
                            .println(hotelName + "'s room Number " + roomNumberUpdate + "has been checked in");
                }

            } else if (counter >= 2) {
                System.out.print("Phone number, please include dashes - - -: ");
                System.out.println("We couldn't find the account associated with that name.");
                System.out.println(
                        "Would you like to enter your phone number or if you are a member, Frequent Guest ID?");
                boolean userExit = false;
                do {
                    System.out.println("1) Phone number");
                    System.out.println("2) Frequent Guest ID");
                    System.out.println("Please select the number associated with your choice: ");
                    int userOption = getInt();

                    if (userOption == 1) {
                        String primaryPhone = getString1(in, "Phone number, please include dashes - - -: ");
                        ResultSet ps2r;
                        String parenthesesPS2;
                        PreparedStatement PS2;
                        parenthesesPS2 = "SELECT customerID FROM Customer WHERE fullName = ? AND primaryPhone = ?";
                        PS2 = connection1.prepareStatement(parenthesesPS2);
                        PS2.setString(1, fullName);
                        PS2.setString(2, primaryPhone);
                        ps2r = PS1.executeQuery();
                        while (ps2r.next()) { // set the customerID after you've found it
                            counter++;
                            if (counter == 1) {
                                customerID = ps2r.getInt("customerID");
                            }
                        }
                        String query1 = "SELECT r.roomNumber, h.hotelName, res.dateCheckOut "
                                + "FROM Room r "
                                + "JOIN Hotel h ON h.hotelID = r.hotelID " +
                                " JOIN Customer c ON c.customerID = res.customerID"
                                + "JOIN Reservation res ON r.roomNumber = res.roomNumber AND r.hotelID = res.hotelID "
                                + "WHERE h.hotelName = ? AND res.dateCheckIn = TRUNC(SYSDATE) AND res.customerID = ?";
                        PreparedStatement pstmt = connection1.prepareStatement(query1);
                        pstmt.setString(1, hotelName); // set hotelName parameter
                        pstmt.setInt(3, customerID); // set customerID parameter
                        ResultSet rs = pstmt.executeQuery();
                        while (rs.next()) {
                            int roomNumberUpdate = rs.getInt("roomNumber");
                            String parenthesesPS92 = "UPDATE Room SET statusAvailability = 0 " +
                                    "\nWHERE roomNumber = ? AND hotelID = (SELECT hotelID FROM Hotel WHERE hotelName = ?) "
                                    +
                                    "\nAND EXISTS (SELECT 1 FROM Reservation WHERE roomNumber = ? AND hotelID = Room.hotelID AND dateCheckOut = TRUNC(SYSDATE))";
                            PreparedStatement pstmt1 = connection1.prepareStatement(parenthesesPS92);
                            pstmt1.setInt(1, roomNumberUpdate);
                            pstmt1.setString(2, hotelName);
                            pstmt1.setInt(3, roomNumberUpdate);

                            System.out
                                    .println(hotelName + "'s room Number " + roomNumberUpdate + "has been checked in");

                        }
                    } else if (userOption == 2) {
                        System.out.print("8-digit Frequent Guest ID: ");
                        int freqGuestID = getInt();
                        ResultSet ps3r;
                        String parenthesesPS3;
                        PreparedStatement PS3;
                        parenthesesPS3 = "SELECT customerID FROM Customer WHERE fullName = ? AND primaryPhone = ?";
                        PS3 = connection1.prepareStatement(parenthesesPS3);
                        PS3.setString(1, fullName);
                        PS3.setInt(2, freqGuestID);
                        ps3r = PS3.executeQuery();
                        while (ps3r.next()) { // set the customerID after you've found it
                            counter++;
                            if (counter == 1) {
                                customerID = ps3r.getInt("customerID");
                            }
                        }
                        String query1 = "SELECT r.roomNumber, h.hotelName, res.dateCheckOut "
                                + "FROM Room r "
                                + "JOIN Hotel h ON h.hotelID = r.hotelID " +
                                " JOIN Customer c ON c.customerID = res.customerID"
                                + "JOIN Reservation res ON r.roomNumber = res.roomNumber AND r.hotelID = res.hotelID "
                                + "WHERE h.hotelName = ? AND res.dateCheckIn = TRUNC(SYSDATE) AND res.customerID = ?";
                        PreparedStatement pstmt = connection1.prepareStatement(query1);
                        pstmt.setString(1, hotelName); // set hotelName parameter
                        pstmt.setInt(3, customerID); // set customerID parameter
                        ResultSet rs = pstmt.executeQuery();
                        while (rs.next()) {
                            int roomNumberUpdate = rs.getInt("roomNumber");
                            String parenthesesPS2 = "UPDATE Room SET statusAvailability = 0 " +
                                    "\nWHERE roomNumber = ? AND hotelID = (SELECT hotelID FROM Hotel WHERE hotelName = ?) "
                                    +
                                    "\nAND EXISTS (SELECT 1 FROM Reservation WHERE roomNumber = ? AND hotelID = Room.hotelID AND dateCheckOut = TRUNC(SYSDATE))";
                            PreparedStatement pstmt1 = connection1.prepareStatement(parenthesesPS2);
                            pstmt1.setInt(1, roomNumberUpdate);
                            pstmt1.setString(2, hotelName);
                            pstmt1.setInt(3, roomNumberUpdate);

                            System.out
                                    .println(hotelName + "'s room Number " + roomNumberUpdate + "has been checked in");
                        }

                    } else {
                        System.out.println("Please select the correct number associated with your choice: ");
                    }
                    // code to be executed
                } while (!userExit);

            }

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    // make exact same function for Customer but ask user for what hotel they are
    // in, then do the rest
    public void handleCheckOut(Connection connection1, String hotelName)
            throws Exception, SQLException, IOException {
        ResultSet ps1r;
        String parenthesesPS1;
        PreparedStatement PS1;

        try {
            System.out.println("To check out, please enter your room number: ");
            int roomNumber1 = getInt();
            parenthesesPS1 = "SELECT r.roomNumber, h.hotelName, res.dateCheckOut "
                    + "\nFROM Room r "
                    + "\nJOIN Hotel h ON h.hotelID = r.hotelID "
                    + "\nJOIN Reservation res ON r.roomNumber = res.roomNumber AND r.hotelID = res.hotelID "
                    + "\nWHERE h.hotelName = ? AND r.roomNumber = ? AND res.dateCheckOut = TRUNC(SYSDATE)";

            PS1 = connection1.prepareStatement(parenthesesPS1);
            PS1.setString(1, hotelName);
            PS1.setInt(2, roomNumber1);
            ps1r = PS1.executeQuery();

            int roomNumber2 = 0;
            String hotelName2 = "";

            boolean checker = false;
            if (ps1r.next()) {
                roomNumber2 = ps1r.getInt("roomNumber");
                hotelName2 = ps1r.getString("hotelName");
                checker = true;
                System.out.println(hotelName2 + "'s room Number " + roomNumber2 + "has been checked out");

            } else {
                System.out.println("\nSorry, that room is not available to check out today");
            }
            if (checker) {
                String parenthesesPS2 = "UPDATE Room SET statusAvailability = 0 " +
                        "\nWHERE roomNumber = ? AND hotelID = (SELECT hotelID FROM Hotel WHERE hotelName = ?) " +
                        "\nAND EXISTS (SELECT 1 FROM Reservation WHERE roomNumber = ? AND hotelID = Room.hotelID AND dateCheckOut = TRUNC(SYSDATE))";
                PreparedStatement pstmt = connection1.prepareStatement(parenthesesPS2);
                pstmt.setInt(1, roomNumber2);
                pstmt.setString(2, hotelName2);
                pstmt.setInt(3, roomNumber2);

            }

        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
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

}
