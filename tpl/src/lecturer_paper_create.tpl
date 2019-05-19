
<form id="searching" method="POST">
    <fieldset>
        <legend><b>Supervisor Marking Frame</b></legend>
	
    <fieldset>
		<legend><b> About Student</b></legend>
        <table>
            <tr>
                <td><label for="studentNumber">Student Number:</label></td>
                <td><input type="text" class="searchbox" name="id" id="id"  /></td>
			</tr>
			</tr>

	<td></br></br></br>
    <input type="submit" class="searchbtn" name="searchdata"  id="searchdata" value="SEARCH" />
	</td>
    </table>
	</fieldset></br></br>
</form>



	
	
	<!--this is the second display-->
    
	
<form id="displaying" method="POST">	

		<!--This is where the content is being displayed--->
		
</form>

  <!---This is the third from for displaying the blob content--->
  
<form id="marking" method="POST">	

		<!--This is where the content is being displayed--->
		
</form>

<!---Link to the past paper--->

	<td></br></br></br>
		<input type="hidden" name="m" value="lecturer_paper_create" />
		<input type="hidden" name="id" value="lecturer_paper_create" />
		<a href="?m=lecturer_paper_list">
		<input type="submit" name="a" value="VIEW PAPER LISTS" />
		</a>
	</td>	
<script type="text/javascript" language="javascript"> 
$(document).ready(function(){ 
	$('#searchdata').click(function(e){ 
	
		e.preventDefault();
		
		var id = $('input[name=id]').val();
		
      $.ajax({ 
	  method: "POST", 
	  url: "lib/module/view_student.php", 
	  data: {
		  "search_post_btn" : 1,
		  "id" : id,
	  },
	  dataType: "text",
          success: function(response) { 
		  
		  $("#displaying").html(response);
		  
		  }

        }); 
     });
});	 
</script>


