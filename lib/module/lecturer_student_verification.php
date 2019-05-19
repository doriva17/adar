<?php
echo "you about to be connected";
		$_studentNumber = $_POST['studentNumber'];	
	if(!empty($_studentNumber)){	
		$result = mysql_query("select ('dateUpload','studentNumber','clusterId') from papers where studentNumber ='$_studentNumber'");
		mysqli_query($result,$connect);
		while($row=mysql_fetch_array($result)){
			$dateUpload = $row["dateUpload"];
			$dateUpload = $row["studentNumber"];
			$dateUpload = $row["clusterId"];	
		}
	}else{
		echo "invalid student number please double check!!!";
		//require_once("lecturer_paper_create.inc.php");
		//echo '<a href="/tpl/src/lacturer_paper_create_form.tp"><b>Back to the form</b></a>';
	}
	///tpl/src
?>



