
/***
 * Class to make the Housekeeping interface methods
 * @author Samir Hassan
 * @version 0.1
 * Date of creation: April 30, 2023
 * Last Date Modified: 
 */

import java.util.*;
import java.sql.*;
import java.io.*;

public class Housekeeping {

    private String hotelName = "Hotel California's ";
    BufferedReader in = new BufferedReader(new InputStreamReader(System.in)); // using my BufferedReader and get strings
    ArrayList<Integer> roomsCleaning = new ArrayList<Integer>();
    ArrayList<Integer> roomsOccupied = new ArrayList<Integer>();

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

    public void HousekeepingMenu(Connection connection1) throws Exception, SQLException, IOException {
        ResultSet allHotelsResult;
        String hotelIDstring, allHotels;
        int userOption;
        int hotelID;
        boolean userExit = false;
        try {
            System.out.println("Hello Hotel California housekeeping staff member!");
            hotelIDstring = getString1(in, "Which hotel are you a part of? Please enter the Hotel ID: ");
            hotelID = Integer.parseInt(hotelIDstring); // convert the Hotel ID taken as a string to an integer
            // make the prepared statment and give the correct hotelID
            allHotels = "SELECT * FROM Hotel WHERE hotelID = ?";
            PreparedStatement allHotels1 = connection1.prepareStatement(allHotels);
            allHotels1.setInt(1, hotelID);
            allHotelsResult = allHotels1.executeQuery();

            while (allHotelsResult.next()) {
                hotelName = hotelName + allHotelsResult.getString("hotelName");
            }

            do {
                System.out.println("===========================================================");
                System.out.println("Welcome Housekeeping-staff member of " + hotelName + " ");
                System.out.println("\n1) Would you like to view current stays at our hotel?");
                System.out.println("2) Would you like to view the rooms in need of cleaning?");
                System.out.println("3) Would you like to update the room(s) that were cleaned?");
                System.out.println("4) Return to previous menu");
                System.out.println("Please select the number associated with your choice: ");
                userOption = getInt();

                if (userOption == 1) {
                    viewCurrentStays(connection1, hotelID);
                } else if (userOption == 2) {
                    viewNeedCleans(connection1, hotelID);
                } else if (userOption == 3) {
                    updateCleans(connection1, hotelID);
                } else if (userOption == 4) {
                    userExit = true;
                } else {
                    System.out.println("Please select the correct number associated with your choice: ");
                }
                // code to be executed
            } while (!userExit);

            // CLOSE ALL RESULTSETS AND STATEMENTS, connections to be closed in

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }
    }

    public void viewCurrentStays(Connection connection1, int hotelID) throws Exception, SQLException, IOException {
        try {
            String allStayRooms = "SELECT r.roomNumber, rt.roomTypeName, rt.totalBathroom, rt.totalBedroom, res.dateCheckIn, res.dateCheckOut "
                    +
                    "\nFROM Room r " +
                    "\nJOIN RoomType rt ON r.roomTypeID = rt.roomTypeID " +
                    "\nJOIN Reservation res ON r.hotelID = res.hotelID AND r.roomNumber = res.roomNumber " +
                    "\nWHERE r.hotelID = " + hotelID
                    + "AND r.statusOccupation = 1 AND TRUNC(SYSDATE) BETWEEN res.dateCheckIn AND res.dateCheckOut";
            Statement allRooms5 = connection1.createStatement();
            ResultSet allRoomsResult6 = allRooms5.executeQuery(allStayRooms);

            if (allRoomsResult6.next()) {
                System.out.println("\nThese are the rooms we are currently booked for:");
                String header = "Room Number  Room Type   Bathrooms  Bedrooms   Check-in Date   Check-out Date";
                System.out.println(header);
                int roomNumber = allRoomsResult6.getInt("roomNumber");
                roomsOccupied.add(roomNumber);
                String roomTypeName = allRoomsResult6.getString("roomTypeName");
                int totalBathroom = allRoomsResult6.getInt("totalBathroom");
                int totalBedroom = allRoomsResult6.getInt("totalBedroom");
                String dateCheckIn = allRoomsResult6.getString("dateCheckIn");
                String dateCheckOut = allRoomsResult6.getString("dateCheckOut");

                String output = String.format("%-12d %-11s  %-9d  %-8d  %-15s  %-15s",
                        roomNumber, roomTypeName, totalBathroom, totalBedroom, dateCheckIn, dateCheckOut);
                System.out.println(output);

            } else {
                System.out.println("There are currently no stays at our hotel");
            }

            while (allRoomsResult6.next()) {
                int roomNumber = allRoomsResult6.getInt("roomNumber");
                roomsOccupied.add(roomNumber);
                String roomTypeName = allRoomsResult6.getString("roomTypeName");
                int totalBathroom = allRoomsResult6.getInt("totalBathroom");
                int totalBedroom = allRoomsResult6.getInt("totalBedroom");
                String dateCheckIn = allRoomsResult6.getString("dateCheckIn");
                String dateCheckOut = allRoomsResult6.getString("dateCheckOut");

                String output = String.format("%-12d %-11s  %-9d  %-8d  %-15s  %-15s",
                        roomNumber, roomTypeName, totalBathroom, totalBedroom, dateCheckIn, dateCheckOut);
                System.out.println(output);

            }

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    public void viewNeedCleans(Connection connection1, int hotelID) throws Exception, SQLException, IOException {
        ResultSet allRoomsResult;
        String allRooms;
        Statement allRooms1;
        try {
            allRooms = "SELECT r.roomNumber, rt.roomTypeName, rt.totalBathroom, rt.totalBedroom\n" +
                    "FROM Room r\nJOIN RoomType rt ON r.roomTypeID = rt.roomTypeID\nWHERE r.hotelID = " + hotelID +
                    "\nAND statusCleaning = 1";
            allRooms1 = connection1.createStatement();
            allRoomsResult = allRooms1.executeQuery(allRooms);
            String statusCleaning1 = "", statusAvailability1 = "";

            if (allRoomsResult.next()) {
                System.out.println("\nThese are the rooms we are currently booked for:");
                String header = "Room Number   Room Type    Bathrooms   Bedrooms   Availability   Cleanliness";
                System.out.println(header);
                int roomNumber = allRoomsResult.getInt("roomNumber");
                roomsCleaning.add(roomNumber);
                String roomTypeName = allRoomsResult.getString("roomTypeName");
                int totalBathroom = allRoomsResult.getInt("totalBathroom");
                int totalBedroom = allRoomsResult.getInt("totalBedroom");
                int statusAvailability = allRoomsResult.getInt("statusOccupation");
                int statusCleaning = allRoomsResult.getInt("statusCleaning");

                if (statusAvailability == 1) {
                    statusAvailability1 = "Not available";
                }
                if (statusCleaning == 0) {
                    statusCleaning1 = "Cleaned";
                }
                if (statusAvailability == 0) {
                    statusAvailability1 = "Available";
                }
                if (statusCleaning == 1) {
                    statusCleaning1 = "Not clean";
                }

                String output = String.format("%-12d %-11s  %-9d  %-8d  %-13s  %-11s",
                        roomNumber, roomTypeName, totalBathroom, totalBedroom, statusAvailability1,
                        statusCleaning1);
                System.out.println(output);

            } else {
                System.out.println("There are currently no rooms in need of cleaning at our hotel");

            }

            while (allRoomsResult.next()) {
                int roomNumber = allRoomsResult.getInt("roomNumber");
                roomsCleaning.add(roomNumber);
                String roomTypeName = allRoomsResult.getString("roomTypeName");
                int totalBathroom = allRoomsResult.getInt("totalBathroom");
                int totalBedroom = allRoomsResult.getInt("totalBedroom");
                int statusAvailability = allRoomsResult.getInt("statusOccupation");
                int statusCleaning = allRoomsResult.getInt("statusCleaning");

                if (statusAvailability == 1) {
                    statusAvailability1 = "Not available";
                }
                if (statusCleaning == 0) {
                    statusCleaning1 = "Cleaned";
                }
                if (statusAvailability == 0) {
                    statusAvailability1 = "Available";
                }
                if (statusCleaning == 1) {
                    statusCleaning1 = "Not clean";
                }

                String output = String.format("%-12d %-11s  %-9d  %-8d  %-13s  %-11s",
                        roomNumber, roomTypeName, totalBathroom, totalBedroom, statusAvailability1,
                        statusCleaning1);
                System.out.println(output);

            }

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

    public void updateCleans(Connection connection1, int hotelID) throws Exception, SQLException, IOException {
        ResultSet allRoomsResult, allRoomsResult2;
        String allRooms;
        PreparedStatement allRooms1, allRooms3;
        try {
            viewNeedCleans(connection1, hotelID);
            boolean userExit = false;
            do {
                if (roomsCleaning.isEmpty()) {
                    userExit = true;
                } else {
                    System.out.println("\nWhich room(s) did you clean?");
                    System.out.println("1) All rooms were cleaned");
                    System.out.println("2) Select a room");
                    System.out.println("3) None, return to previous menu");
                    System.out.println("Please select the number associated with your choice: ");
                    int userOption = getInt();

                    if (userOption == 1) {// all rooms were cleaned, and therefore all rooms at that hotel were changed
                                          // from dirty to clean
                        allRooms = "UPDATE Room SET statusCleaning = 0 WHERE hotelID = ? AND statusCleaning = 1";
                        allRooms1 = connection1.prepareStatement(allRooms);
                        allRooms1.setInt(1, hotelID);
                        allRoomsResult = allRooms1.executeQuery();
                        allRoomsResult.close();
                        allRooms1.close();
                        System.out.println("All rooms at " + hotelName + " were successfully cleaned");
                        // allRooms2.close();
                        // allRoomsResult1.close();
                    } else if (userOption == 2) {
                        int roomNumber = 0;
                        do {
                            System.out.println("Enter the room number that you cleaned: ");
                            roomNumber = getInt();
                            if (!roomsOccupied.contains(roomNumber)) {
                                System.out.println("This room is either already clean or not available at this hotel");
                            }

                        } while (!roomsOccupied.contains(roomNumber));
                        allRooms = "UPDATE Room SET statusCleaning = 0 WHERE hotelID = ? AND roomNumber = ? AND statusCleaning = 1";
                        allRooms3 = connection1.prepareStatement(allRooms);
                        allRooms3.setInt(1, hotelID);
                        allRooms3.setInt(2, roomNumber);
                        allRoomsResult2 = allRooms3.executeQuery();
                        allRoomsResult2.close();
                        allRooms3.close();
                        System.out.println("Room " + roomNumber + " at " + hotelName + " was successfully cleaned");
                        System.out.println("Thanks! Returning you to the previous menu");
                    } else if (userOption == 3) {
                        userExit = true;
                    } else {
                    }

                }
            } while (!userExit);
        }

        catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }

    }

}