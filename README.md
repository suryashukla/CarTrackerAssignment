# Software Specification
1. Development IDE:  Xcode Version 13.4.1 
2. Language used: Swift 5


# Interviewee’s Name: Surya Prakash Shukla

# Login Screen:
    
    1. SQLite database is there to validate the user's credentials.
    2. When user will be login at first time (with empty info in sqlite database) then entered "User Name" & "Password" will
       be captured in the sqlite database.
    3. Captured credential will be validate on every attempt of login
    4. If entered User Name & Password doesn't match from the sqlite database, error alert will be displayed
    5. All fields are mandatory on login page (User Name, Password, Country)
    5. No forget password feature supporting so to test please remember / note the user credentials 
    
    
# User List Screen:
    
    On this screen data is displaying from the API endppoint (https://jsonplaceholder.typicode.com/users)
    
    1. User list screen displaying the username & email ID from address object 
    2. On selection of any row navigate to the map view there displying the users API response lat long on map with custom
       image callout
    3. On map screen, tap on image location callout view is dispalying 
    
    

    

            
