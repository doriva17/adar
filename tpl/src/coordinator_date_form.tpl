    <div class="infobox">
        <div class="infobox_header">
            <img src="vendor/koala-framework/library-silkicons/application_form.png" alt="" /> Coordinator Date Setup Panel
        </div>
        <div class="infobox_content">
            <form method="POST" action="?m=session_login">
                <label for="user">Starting Date:</label>
                <input type="text" name="date_from" />
                <br />
				</br>
                <label for="pass">Ending Date:</label>
                <input type="text" name="date_to" />
				</br>
				</br>
                <input type="submit" value="Set Date" class="spacer" />
                {if isset($errstr)}
                    <div class="errbox spacer"><img src="vendor/koala-framework/library-silkicons/error.png" alt="error" /> {$errstr}</div>
                {/if}
            </form>
        </div>
    </div>
