# Define the compiler to use
JAVAC = javac

# Define the classpath for running the program
CLASSPATH = .:ojdbc8.jar

# Define the target executable
TARGET = ssh325

# Define the source files to compile
SOURCES = ssh325.java Housekeeping.java Reservation.java Frontdesk.java

# Default target: build and run the program
all: $(TARGET)
	java -cp $(CLASSPATH) $(TARGET)

# Target to build the program
$(TARGET): $(SOURCES)
	$(JAVAC) -cp $(CLASSPATH) $(SOURCES)

# Target to clean up the build directory
clean:
	rm -f $(TARGET).class
