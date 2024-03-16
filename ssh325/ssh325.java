
/***
 * Class to make the Hotel main interface
 * @author Samir Hassan
 * @version 0.1
 * Date of creation: April 30, 2023
 * Last Date Modified: 
 */
import java.util.*;
import java.sql.*;
import java.io.*;

public class ssh325 {
    static String hotelName = "";

    static BufferedReader in = new BufferedReader(new InputStreamReader(System.in)); // using my BufferedReader and
                                                                                     // get//
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

    public static String getString1(BufferedReader in, String message) {// from my CSE017 code
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

    public static void main(String[] args) 
            throws Exception, SQLException, IOException {// throws these exceptions -> copied from examples
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in)); // using my BufferedReader and get
                                                                                  // strings
        String userID = getString1(in, "Enter Oracle user ID: ");
        String password = getString1(in, "Enter Oracle password for " + userID + ": ");

        try (// connect to the database with the username and password
                Connection con = DriverManager.getConnection("jdbc:oracle:thin:@edgar1.cse.lehigh.edu:1521:cse241",
                        userID, password);) {// after try initial statement
            System.out.println("connection successfully made.");
            // create statements used for nonparametrized queries, prepared for parametrized

            // <------------------------------------------START OUT MENU
            // CODING--------------------------------------------------->
            mainMenu(con);
            // close all connections
            con.close();

        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }
    }

    public static void mainMenu(Connection connection1) throws Exception, SQLException, IOException {
        boolean customerMenu = false;
        int userClassification;
        do {
            System.out.println();
            System.out.println("===========================================================");
            System.out.println("Welcome to Hotel California!"); // maybe add todays date
            System.out.println(
                    "\nWould you like to login as a Customer or an Employee?\nPlease enter your classification:");
            System.out.println("\n1) Customer");
            System.out.println("2) Employee");
            System.out.println("3) Exit Hotel California services");
            System.out.println("Please select the number associated with your choice: ");
            userClassification = getInt();

            if (userClassification == 1) {// the user is a customer
                // System.out.println("customer approved");
                int userOption2;
                boolean userExit2 = false;

                do {
                    System.out.println("===========================================================");
                    System.out.println("Hello! We'd love for you to be one of our customers!");
                    System.out.println("\n1) Would you like to make a reservation?");
                    System.out.println("2) Would you like to check in?");
                    System.out.println("3) Would you like to check out?");
                    System.out.println("4) Return to previous menu");
                    System.out.println("Please select the number associated with your choice: ");
                    userOption2 = getInt();

                    if (userOption2 == 1) {
                        Reservation Reservation1 = new Reservation(); // creates the catalog object needed to access
                                                                      // customer
                        Reservation1.ReservationMenu(connection1);
                        userExit2 = false;
                    } else if (userOption2 == 2) {
                        Frontdesk frontdesk1 = new Frontdesk(); // creates the catalog object needed to access
                                                                // frontdesk agent => which already has the checkIn
                                                                // function
                        customerHotelAttendance(connection1);
                        frontdesk1.handleCheckOut(connection1, hotelName);
                        userExit2 = false;
                    } else if (userOption2 == 3) {
                        Frontdesk frontdesk2 = new Frontdesk(); // creates the catalog object needed to access
                                                                // frontdesk agent => which already has the checkOut
                                                                // function
                        customerHotelAttendance(connection1);
                        frontdesk2.handleCheckIn(connection1, hotelName);
                        userExit2 = false;

                    } else if (userOption2 == 4) {
                        userExit2 = true;
                    } else {
                        System.out.println("Please select the correct number associated with your choice: ");
                        userExit2 = false;
                    }
                } while (!userExit2);

            } else if (userClassification == 2) {// the user is a hotel staff member
                // System.out.println("employee approved");
                boolean employeeMenu = false;
                int employeeClassification;
                do {
                    System.out.println("===========================================================");
                    System.out.println("Hello Hotel California employee!");
                    System.out.println("Please enter your Employee classification: ");
                    System.out.println("\n1) Frontdesk agent");
                    System.out.println("2) Housekeeping staff");
                    System.out.println("3) Return to previous menu");
                    System.out.println("Please select the number associated with your choice: ");
                    employeeClassification = getInt();

                    if (employeeClassification == 1) {// the user is a customer
                        // System.out.println("customer approved");
                        Frontdesk frontdesk3 = new Frontdesk(); // creates the catalog object needed to access
                                                                // frontdesk agent
                        frontdesk3.FrontdeskMenu(connection1);
                        employeeMenu = false;
                    } else if (employeeClassification == 2) {
                        Housekeeping housekeeping1 = new Housekeeping(); // creates the catalog object needed to
                                                                         // access the housekeeping staff
                        // housekeeping
                        housekeeping1.HousekeepingMenu(connection1);
                        employeeMenu = false;
                    } else if (employeeClassification == 3) {
                        employeeMenu = true;
                    } else {
                        System.out.println("Please select the correct number associated with your choice: ");
                    }

                } while (!employeeMenu);

            } else if (userClassification == 3) {// the user wants to exit
                System.out.println("We'll exit you out the interface.\n\nThank you for choosing Hotel California!");
                customerMenu = true;
            } else {
                System.out.println("Please select the correct number associated with your choice: ");
                customerMenu = false;
            }

        } while (!customerMenu);

    }

    public static void customerHotelAttendance(Connection connection1) throws Exception, SQLException, IOException {
        try {
            ResultSet allHotelsResult;
            String allHotels;
            Statement allHotels1;
            List<String> hotelNames = new ArrayList<>();

            do {
                System.out.println("===========================================================");
                System.out.println("Hello Hotel California customer! These are the Hotel California's locations:");
                allHotels = "SELECT hotelCity, hotelName from Hotel";
                allHotels1 = connection1.createStatement();
                allHotelsResult = allHotels1.executeQuery(allHotels);

                while (allHotelsResult.next()) { // show the user what cities they can choose from
                    String hotelCity1 = allHotelsResult.getString("hotelCity");
                    String hotelName1 = allHotelsResult.getString("hotelName");
                    System.out.println(hotelName1 + " in " + hotelCity1);
                }

                hotelName = toTitleCase(getString1(in, "Which hotel are you staying at (enter the Hotel name)?: "));

            } while (hotelNames.contains(hotelName));
        } catch (SQLException sqle) { // to catch SQL errors so our code doesn't break
            System.out.println("SQLException : " + sqle);
        } catch (Exception e) { // not the best idea to catch all exceptions but let's make the code run
            // handle any other exceptions
            e.printStackTrace(); // this will at least show us where the errors come from
        }
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
