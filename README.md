
## Notes App

This project builds a notes app using a provided JSON API. Users can register, log in, manage their profile, create/ view notes, and delete them.

**Features:**

- **Authentication:** Register new accounts and log in using email/password. (Logout functionality is simulated locally due to API limitations.)
- **Profile Management:** View profile details after logging in.
- **Notes Management:**
    - View a list of all created notes.
    - Create new notes with optional multiline input using `UITextView`.
    - Delete notes.
- **Persistence (Optional, Extra Credit):** Attempt to retain the logged-in state using `UserDefaults` for a better user experience.

**API Details:**

The application interacts with a JSON API.

**Usage:**

1. When launch, the app will display the login screen.
   
2. **Register** if you're a new user:
   - Enter name, email, and password.
   - Validation ensures a valid email format and prevents duplicate user creation (based on API limitations).

3. **Log in:**
   - Enter your registered email and password.
   - Validation checks for incorrect credentials or user non-existence.

4. Once logged in, you'll see your notes list.

5. **Create a New Note:**
   - Tap the "Add Note" button.
   - Enter your note content in the UITextView.
   - Tap "Save" to create the note.
   
7. **View Notes:**
   - Notes are displayed in a list.
   - Tap a note to view its details.

8. **Delete Note:**
   - On viewing note details, a delete button has functionality to delete a note from the database.
   - Confirm deletion.

9. **UserDefaults**
   - The app will keep your logged-in state using UserDefaults.



