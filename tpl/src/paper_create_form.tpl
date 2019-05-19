
<form action="index.php" method="POST">
    <fieldset>

        <legend>Paper Information</legend>
        <table width="100%">
              <tr><td><label for="student">Student Name:</label></td><td>
              
                      <input name="student" value="{$fullname}" size="80" readonly="readonly" /></td></tr>
          <tr>
              <td><label for="Caption">Title:</label></td>
              <td> <input name="title" id="title" {if $details.title !== null} value="{$details.title}" {/if} size="80"></input>
              </td>
          </tr>
            <tr>
          <td><input type="hidden" name="paperId" id="paperId" value="{$id}" onkeyup="dynReq(this, 'v', 'paperId');" readonly="readonly"/>
</td>
</tr>
                <tr><td><label for="sourceSHA256">Hashed Doc Info:</label></td>
                <td><input type="text" id="sourceSHA256" name="sourceSHA256" value="{$hash}" size="80" readonly="readonly"/></td><td></td></tr>

            <tr><td><label for="Sender">Supervisor:</label></td><td>
              <select id="Lecturer ID" name="lecturerId" style="width: 200px;">
                      {foreach from=$users item=c}
                            <option value="{$c.UserID}" {If $lang == $c.UserID}selected="selected"{/if}>{$c.Name} {$c.Surname}</option>
                        {/foreach}
                        </select></td></tr>
                        
            <tr><td><label for="Receiver">Coordinator:</label></td><td>
              <select id="Coordinator ID" name="coordinatorId" style="width: 200px;">
                      {foreach from=$cuser item=c}
                            <option value="{$c.UserID}" {If $lang == $c.UserID}selected="selected"{/if}>{$c.Name} {$c.Surname}</option>
                        {/foreach}
                        </select></td></tr>
                        
                        <tr><td><label for="Receiver">Cluster:</label></td><td>
                          <select id="Cluser ID" name="clusterId" style="width: 200px;">
                                  {foreach from=$clusters item=c}
                                        <option value="{$c.clusterId}" {If $lang == $c.clusterId}selected="selected"{/if}>{$c.clustername}</option>
                                    {/foreach}
                                    </select></td></tr>
                                    
      <tr>
              <td><label for="publishedStatus">Published Status:</label></td>
            <td>
            <select id="publishedStatus" name="publishedStatus" style="width: 200px;">
                foreach($published_status as $p){
                  <option value="{$published_status[0]}">{$published_status[0]}</option>
                  <option value="{$published_status[1]}">{$published_status[1]}</option>
              }
                </select>
            </td>
            </tr>
		<tr><td><label for="Description">Abstract</label></td><td>
  <textarea name="abstract" id="abstract" {if $details.abstract !== null} value="{$details.abstract}" rows="10"  cols="80"{/if} ></textarea>
  </td></tr>
        </table>

    <input type="hidden" name="m" value="paper_create" />
    <input type="submit" name="a" value="To capture" />
</form>
