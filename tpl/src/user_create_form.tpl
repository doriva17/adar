
<form action="index.php" method="POST">
    <fieldset>

        <legend>User Information</legend>

        <table style="width:100%">			
            <tr>
				<td><label for="Title">Title:</label></td>
				<td>
				<select id="Title" name="Title">
                    <option value="0" {If $details.Title == '0'}selected="selected"{/if}>Not specified</option>
                    <option value="Mr." {If $details.Title == 'Mr.'}selected="selected"{/if}>Mr.</option>
                    <option value="Ms." {If $details.Title == 'Ms.'}selected="selected"{/if}>Ms.</option>
                    <option value="Dr." {If $details.Title == 'Dr.'}selected="selected"{/if}>Dr.</option>
                    <option value="Prof." {If $details.Title == 'Prof.'}selected="selected"{/if}>Prof.</option>
                </select>
				</td>
			</tr>
            <tr>
                <td><label for="Name">First Name:</label></td>
                <td><input type="text" id="Name" {if $details.Name !== null} value="{$details.Name}"{/if} size="50" /></td>
            </tr>
            <tr>  
                <td><label for="Surname">Surname:</label></td>
                <td><input type="text" id="Surname" {if $details.Surname !== null} value="{$details.Surname}"{/if} size="50" /></td>
            </tr>
            <tr>  
                <td><label for="Gender">Gender:</label></td>
                <td><input type="radio" name="Gender" value="male"> Male<br>
				<input type="radio" name="Gender" value="female"> Female<br></td>
            </tr>
            <tr>
                <td><label for="Username">Username:</label></td>
                <td><input type="text" id="Username" {if $details.Username !== null} value="{$details.Username}"{/if} size="50" /></td>
                                
            </tr>
            <tr>
                <td><label for="Password">Password:</label></td>
                <td><input type="password" id="Password" {if $details.Password !== null} value="{$details.Password}"{/if} size="50" /></td>
            </tr>  
            <tr>
				<td><label for="EMail">EMail:</label></td>
				<td><input type="email" id="EMail" {if $details.EMail !== null} value="{$details.EMail}"{/if} size="50" /></td>
				<td></td>
			</tr>
            <tr>  
                <td><label for="ContactNo">ContactNo:</label></td>
                <td><input type="text" id="ContactNo" {if $details.ContactNo !== null} value="{$details.ContactNo}"{/if} size="50" /></td>
            </tr>
            <tr>
				<td><label for="Level">Register As:</label></td>
				<td>
				<select id="Level" name="Level">
                	{foreach from=$roles item=c}
                        <option value="{$c.roleID}" {If $lang == $c.roleID}selected="selected"{/if}>{$c.roleName}</option>
                    {/foreach}
                </select>
				</td>
			</tr>
            <tr>
				<td><label for="Image">Image:</label></td>
				<td><input type="file" id="Image" {if $details.Image !== null} value="{$details.Image}"{/if} /></td>
			</tr>
            <tr>
				<td><label for="Active">Active:</label></td>
				<td><input type="radio" name="Active" value="Yes"> Yes<br>
				<input type="radio" name="Active" value="No"> No<br></td>
			</tr>

        </table>
    </fieldset><br />

    <input type="hidden" name="m" value="user_create" />
    <input type="hidden" name="id" value="{if $details.UserID !== null}{$details.UserID}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>

<script>

function displayMsg() {
  alert("Hello World!")
}

</script> 