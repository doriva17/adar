<?php 
$host         = "localhost";
$username     = "root";
$password     = "";
$dbname       = "adar";
$result_array = array();
/* Create connection */
$conn = new mysqli($host, $username, $password, $dbname);
/* Check connection  */
if ($conn->connect_error) {
     die("Connection to database failed: " . $conn->connect_error);
}

if(isset($_POST['search_post_btn'])){
	$id = $_POST['id'];

		/* SQL query to get results from database */
		//$query = "SELECT dateUpload, studentNumber,clusterId FROM papers WHERE `studentNumber` = '$id'";
		$query = "SELECT * FROM papers WHERE `studentNumber` = '$id'";
		$result = mysqli_query($conn,$query);
		
		/* If there are results from database push to result array */
		if ($result) {
			while($row = mysqli_fetch_array($result)){
				?>
				<fieldset>
					<legend><b> About The paper</b></legend>
					<table>
						<tr>
							<td><label for="dateUpload">Date Upload:</label></td>
							<td><input type="text" id="dateUpload" value="<?php echo $row['dateUpload']?>"></td>
						  </tr>

						</tr>
						<tr>
							<td><label for="moderatorId">Moderator's ID:</label></td>
							<td><input type="text" id="moderatorId"  value="<?php echo $row['moderatorId']?>"></td>
							</tr>
						  </tr>
					<tr>
							<td><label for="clusterId">ClusterId:</label></td>
							<td><input type="text" id="clusterId"  value="<?php echo $row['clusterId']?>"></td>
				  </tr>

				</table>
				</fieldset></br></br>

				<fieldset>
					<legend><b>Student Contents</b></legend>
					<table >
						<tr>
							<td><label for="dateModerated">Marking Date:</label></td>
							<td><p id="dateModerated" ></p></td>
							<script>
							var d = new Date();
							document.getElementById("dateModerated").innerHTML = d.toLocaleDateString();
							</script>
						</tr>
						<tr>
							<td><label for="lecturerID">Student file Content:</label></td>
						</tr>
						<tr>
							<td>
								<?php
								//download.php
									$files_field= $row['sourceSHA256'];
									$files_show= "data/tmp/$files_field";
								?>
							<a href="http://data/tmp/<?php echo $files_field?>">Download File </a>
							<embed src="/data/tmp/<?php echo $files_field?>" type="application/pdf"   height="300px" width="1000px" class="responsive">
							</td>
							
						</tr>
					</table>
				</fieldset></br></br>
				
				<fieldset>
					<legend><b>Mark Fill</b></legend>
					<table >
						<tr>
							<td><label for="lecturerID">My ID:</label></td>
							<td><input type="text" id="LecturerId" /></td>
						</tr>
						<tr>
							<td><label for="studentNumber">Student Number:</label></td>
							<td><input type="text" class="searchbox" name="id" id="studentNumber"  /></td>
						</tr>
						<tr>
							<td><label for="dateModerated">Primarily Analysis:</label></td>
							<td><input type="text" id="Primarily_analysis" ></td>
						</tr>
						<tr>
							<td><label for="lecturerID">State of Art:</label></td>
							<td><input type="text" id="State_of_Art" /></td>
						</tr>
						<tr>
							<tr>
							<td><label for="lecturerID">Methodologies:</label></td>
							<td><input type="text" id="Methodologies" /></td>
							</tr>
							<tr>
							<td><label for="lecturerID">Design:</label></td>
							<td><input type="text" id="Design" /></td>
							</tr>
						</tr>
						<tr>
							<td><label for="lecturerID">Application Development:</label></td>
							<td><input type="text" id="Application_developmment" /></td>
						</tr>
						<tr>
							<td><label for="lecturerID">Demonstration and Testing:</label></td>
							<td><input type="text" id="Demonstration_and_testing" /></td>
						</tr>
						<tr>
							<td><label for="lecturerID">Production and Evaluation:</label></td>
							<td><input type="text" id="Production_and_evaluation" /></td>
						</tr>
						<tr>
							<td><label for="lecturerID">Summary and Future work:</label></td>
							<td><input type="text" id="Summary_and_Future" /></td>
						</tr>
						<tr>
							<td><label for="lecturerID">Conclusion:</label></td>
							<td><input type="text" id="Conclusion" /></td>
						</tr>
						<tr>
							<td><label for="lecturerID">Glossary:</label></td>
							<td><input type="text" id="Glossary" /></td>
						</tr>
						<tr><br/>
							<td><label for="lecturerID">Application Screenshots:</label></td>
							<td><input type="text" id="Application_Screenshots" /></td>
						</tr>
						<tr>
							<td><label for="lecturerID">Total:</label></td>
							<td><input type="text" id="Total" /></td>
						</tr>
					</table><br/><br/><br/>
		                  <input type="submit" name="submit" value="GRADE THIS STUDENT" />
				</fieldset>

				<?php 
					if(isset($_POST['submit'])){
						
						$LecturerId =$_POST['LecturerId'];
						$studentNumber =$_POST['studentNumber'];		
						$Primarily_analysis =$_POST['Primarily_analysis'];
						$State_of_Art =$_POST['State_of_Art'];
						$Methodologies =$_POST['Methodologies'];
						$Design =$_POST['Design'];
						$Application_developmment =$_POST['Application_developmment'];
						$Demontration_and_testing =$_POST['Demontration_and_testing'];
						$Production_and_evaluation =$_POST['Production_and_evaluation'];
						$Summary_and_Future =$_POST['Summary_and_Future'];
						$Conclusion =$_POST['Conclusion'];
						$Glossary =$_POST['Glossary'];
						$Total =$_POST['Total'];
						
							mysql_query("INSERT INTO student_marks(LecturerId,studentNumber,Primarily_analysis,State_of_Art, Methodologies,Design,Application_developmment,Demontration_and_testing, Production_and_evaluation,Summary_and_Future,Conclusion,Glossary,Total ) VALUES ('$LecturerId', '$studentNumber,$Primarily_analysis','$State_of_Art','$Methodologies,$Design','$Application_developmment','$Demontration_and_testing','$Production_and_evaluation','$Summary_and_Future', '$Conclusion', '$Glossary', '$Total')"); 

							echo " Added Successfully ";
						
					}
				
				
				?>
				<?php
			}
		}else{
			echo "no data found";
		}

}
$conn->close();
?>

