    <div class="infobox">
        <div class="infobox_header">
            <img src="vendor/koala-framework/library-silkicons/application_form.png" alt="" /> Student Enrollment Panel
        </div>
        <div class="infobox_content">
            <form method="POST" action="?m=session_login">
			    <label for="user"><b>Students' particular::</b></label>
                <label for="user">Surname:</label>
                <input type="text" name="student_surname" />
                <label for="user">Name:</label>
                <input type="text" name="student_name" />
                <label for="user">Student Number:</label>
                <input type="text" name="student_number" />
                <label for="pass">ID Number:</label>
                <input type="text" name="Student_id" />
				</br>
				</br>
			    <label for="user"><b>About the Research::</b></label>
                <label for="user">Research title:</label>
                <input type="text" name="research_title" />
                <label for="user">Supervisor:</label>
				<select name="supervisor">
				<option value="my_supervisor">---supervisor---</option>
				<option value="Student">Mr A</option>
				<option value="Lecture">Mr B</option>
				<option value="Moderator">Mr C</option>
				<option value="Coordinator">Mr D</option>
				</select>
                <label for="user">Cluster:</label>
				<select name="cluster">
				<option value="my_cluster">---cluster---</option>
				<option value="Student">Cluster A</option>
				<option value="Lecture">Cluster B</option>
				<option value="Moderator">Cluster C</option>
				<option value="Coordinator">Cluster D</option>
				</select>
                <label for="pass">Date:</label>
                <input type="text" name="registry_date" />
				</br>
				</br>
				<label for="user"><b>Student Credentials::<b></label>
                <label for="user">Login User Name:</label>
                <input type="text" name="login_user" />
                <label for="pass">login User Password:</label>
                <input type="password" name="login_pass" />
                </br>
				</br>
				<label for="user"><b>Student Categories::</b></label>
				<select name="student_category">
				<option value="my_student_categories">---student category---</option>
				<option value="Student">Existing Student</option>
				<option value="Lecture">New Student</option>
				</select>
                </br>
				</br>
                <input type="submit" value="Enrol Student" class="spacer" />
                {if isset($errstr)}
                    <div class="errbox spacer"><img src="vendor/koala-framework/library-silkicons/error.png" alt="error" /> {$errstr}</div>
                {/if}
            </form>
        </div>
    </div>