
# BAContacts
- BAContacts requires latest version of Xcode (10.2) and Swift5. 
- To use the app, you need to allow "contacts permission" to fetch contacts and match with server response. Otherwise you will see popup every time you start the app that warns you about "contacts permission".
- MVVM-C patterns is used in this project. I have used many design patterns and I believe MVVM is the most effective and the neatest one. Also I have implemented Coordinator pattern which handles navigation through the app.
- Only complex part is matching employees with contacts. I added optional Contact property to every employee and search each of their name from contacts array. If they have matching name and surname, then I assign that contact property to employee.

