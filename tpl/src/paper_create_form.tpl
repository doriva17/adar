
<form action="index.php" method="POST">
    <fieldset>

        <legend>Paper Information Recording Form</legend>
        <table>
            <!--tr>
                <td><label for="dateUpload">Date Upload:</label></td>
                <td><input type="text" id="dateUpload" {if $details.dateUpload !== null} value="{$details.dateUpload}"{/if}  /></td>
              </tr-->

            <tr>
                <td><label for="lecturerID">LecturerId:</label></td>
                <!--td><input type="text" id="lecturerId" {if $details.lecturerId !== null} value="{$details.lecturerId}"{/if} /></td-->
                <td>
                  <select id="Lecturer ID" name="lecturerId">
                          {foreach from=$users item=c}
                                <option value="{$c.UserID}" {If $lang == $c.UserID}selected="selected"{/if}>{$c.Name}</option>
                            {/foreach}
                            </select>
                          </td>
              </tr>


              <tr>
                <td><label for="studentNumber">Student Number:</label></td>
                <td><input type="text" id="studentNumber" {if $details.studentNumber !== null} value="{$details.studentNumber}"{/if} /></td>
			</tr>
            <tr>
				<td><label for="coordinatorId">CoordinatorId:</label></td>
				<!--td><input type="text" id="coordinatorId" {if $details.coordinatorId !== null} value="{$details.coordinatorId}"{/if} /></td-->
        <td>
          <select id="Coordinator ID" name="coordinatorId">
                  {foreach from=$cuser item=c}
                        <option value="{$c.UserID}" {If $lang == $c.UserID}selected="selected"{/if}>{$c.Name}</option>
                    {/foreach}
                    </select>
                  </td>
      </tr>

        <tr>
				<td><label for="clusterId">ClusterId:</label></td>
				<!--td><input type="text" id="clusterId" {if $details.clusterId !== null} value="{$details.clusterId}"{/if} /></td-->
        <td>
          <select id="Cluser ID" name="clusterId">
                  {foreach from=$clusters item=c}
                        <option value="{$c.clusterId}" {If $lang == $c.clusterId}selected="selected"{/if}>{$c.clustername}</option>
                    {/foreach}
                    </select>
                  </td>
      </tr>
      <tr>
				<td><label for="publishedStatus">Published Status:</label></td>
				<!--td><input type="text" id="publishedStatus" {if $details.publishedStatus !== null} value="{$details.publishedStatus}"{/if} /></td-->
<td>
  <select id="publishedStatus" name="publishedStatus">
      <!--option value="NO" {If $details.publishedStatus !== null}selected="selected"{/if}>NO</option>
      <option value="YES" {If $details.publishedStatus !== null}selected="selected"{/if}>YES</option-->
      foreach($published_status as $p){
            <option value="{$published_status[0]}">{$published_status[0]}</option>
            <option value="{$published_status[1]}">{$published_status[1]}</option>
        }
          </select>
</td>
      </tr>
      <tr>
        <td><label for="abstract">Abstract:</label></td>
        <td><textarea name="abstract" id="abstract" {if $details.abstract !== null} value="{$details.abstract}" rows="4"  cols="50"{/if} ></textarea></td>
      </tr>
        </table>
    </fieldset><br />

    <input type="hidden" name="m" value="paper_create" />
    <input type="hidden" name="id" value="{if $details.paperId !== null}{$details.paperId}{else}0{/if}" />
    <input type="submit" name="a" value="To capture" />
</form>

<a href="?m=paper_list">
<input type="submit" name="a" value="View Papers" />
</a>
