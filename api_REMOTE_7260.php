<?PHP

/**
 * AdAr - Another dumb Archive
 *
 * AJAX API
 *
 * @package adar
 * @author Florian Knodt <adar@adlerweb.info>
 */

if(!file_exists('config.php') ||!is_readable('config.php')) {
    die('Missing configuration');
}

require_once('config.php');                 //Config
require_once('lib/mysql.wrapper.php');      //ATools->MySQL
require_once('vendor/adlerweb/awtools/session.php');    //ATools->Session-Manager

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    echo 'Invalid session';
    header('HTTP/1.0 403 Forbidden');
}

$requestData= $_REQUEST;
if($requestData['source']=="content"){
$columns = array(
// datatable column index  => database column name
	0 => array(false, 'ItemID', array('<a href="?m=content_detail&id=%s">%s</a>', array('ItemID', 'ItemID'))),
	1 => array(false, 'Caption', false),
	2 => array(false, 'Format', false),
	3 => array(false, 'Date', false),
	4 => array('CONCAT(`Sender`.`FamilyName`,", ",`Sender`.`GivenName`)', 'S_Sender', array('<a href="?m=contact_create&id=%s">%s</a>', array('Sender', 'S_Sender'))),
	5 => array('CONCAT(`Receiver`.`FamilyName`,", ",`Receiver`.`GivenName`)', 'S_Receiver', array('<a href="?m=contact_create&id=%s">%s</a>', array('Receiver', 'S_Receiver')))
);

$colout = array();
$colout_f = array();
$colout_done = array();
foreach($columns as $col) {
    $colout_done[] = $col[1];
    if($col[0]) {
        $colout[] = $col[0].' AS `'.$col[1].'`';
        $colout_f[] = $col[0].' AS `'.$col[1].'`';
    }else{
        $colout[] = '`'.$col[1].'`';
    }

    if($col[2]) { //if format
        foreach($col[2][1] as $tcol) {
            if(!in_array($tcol, $colout_done)) {
                $colout[] = $tcol;
                $colout_done[] = $tcol;
            }
        }
    }
}

$sql_data = "SELECT ";
$sql_data .= implode(", ", $colout);
$sql_data .= " FROM Items
LEFT JOIN `Contacts` AS `Sender` ON `Items`.`Sender` = `Sender`.`CID`
LEFT JOIN `Contacts` AS `Receiver` ON `Items`.`Receiver` = `Receiver`.`CID` ";

$sql_anz = "SELECT COUNT(`Items`.`ItemID`) as anz ";

$sql_anz .= " FROM Items
LEFT JOIN `Contacts` AS `Sender` ON `Items`.`Sender` = `Sender`.`CID`
LEFT JOIN `Contacts` AS `Receiver` ON `Items`.`Receiver` = `Receiver`.`CID` ";

// getting total number records without any external filters
//$anzq=$GLOBALS['adlerweb']['sql']->query($sql_anz.$sql_filter);
$anzq=$GLOBALS['adlerweb']['sql']->query_single($sql_anz);
if(!$anzq) {
    $totalData=0;
}else{
    $totalData=$anzq['anz'];
}
$totalFiltered = $totalData;

$sql_filter_data = array();
$sql_filter = " WHERE 1 = ?";
$sql_filter_data[] = 1;

// getting records as per search parameters
for($i=0; $i<count($columns); $i++) {
    if( !empty($requestData['columns'][$i]['search']['value']) ){
        if($columns[$i][0]) {
            $sql_filter.=" AND (".$columns[$i][0].") LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }else{
            $sql_filter.=" AND `".$columns[$i][1]."` LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }
    }
}

if(!empty($requestData['search']['value'])) {
    $sql_filter.="
        AND (
            `ItemID` LIKE ? OR
            `Caption` LIKE ? OR
            `Description` LIKE ? OR
            `Format` LIKE ? OR
            CONCAT(`Sender`.`FamilyName`,\", \",`Sender`.`GivenName`) LIKE ? OR
            CONCAT(`Receiver`.`FamilyName`,\", \",`Receiver`.`GivenName`) LIKE ?
        ) ";
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
}

if(count($sql_filter_data) > 1) {
    $anzq=$GLOBALS['adlerweb']['sql']->querystmt_single($sql_anz.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
    if(!$anzq) {
        $totalFiltered=0;
    }else{
        $totalFiltered=$anzq['anz'];
    }
}

if(isset($requestData['order'][0]['column']) && isset($requestData['order'][0]['dir'])) {
    if(!in_array($requestData['order'][0]['dir'], array('ASC', 'DESC', 'asc', 'desc'))) die('Errr?');
    $sql_filter.=" ORDER BY ". $columns[$requestData['order'][0]['column']][1]."   ".$requestData['order'][0]['dir'].' ';
}
if(isset($requestData['start']) && isset($requestData['length']) && $requestData['length'] > 0)
    $sql_filter.="LIMIT ".(int)$requestData['start']." ,".(int)$requestData['length']."   ";  // adding length

$query = $GLOBALS['adlerweb']['sql']->querystmt($sql_data.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
$data = array();
if($query) {
    foreach($query as $row) {  // preparing an array
        $nestedData=array();

        foreach($columns as $col) {
            if($col[2]) {
                $argdata = array(
                    $col[2][0]
                );
                foreach($col[2][1] as $in) {
                    $argdata[] = $row[$in];
                }
                $nestedData[] = call_user_func_array('sprintf', $argdata);
            }else{
                $nestedData[] = $row[$col[1]];
            }
        }

        $data[] = $nestedData;
    }
}

$json_data = array(
    "recordsTotal"    => intval( $totalData ),  // total number of records
    "recordsFiltered" => intval( $totalFiltered ), // total number of records after searching, if there is no searching then totalFiltered = totalData
    "data"            => $data   // total data array
);

if(isset($requestData['draw'])) $json_data['draw'] = $requestData['draw'];


}
//============================================================================================
elseif($requestData['source']=="users"){
	//user management
	$columns = array(
// datatable column index  => database column name
	0 => array(false, 'UserID', false),
	1 => array(false, 'Title', false),
	2 => array('CONCAT(`Users`.`Name`,", ",`Users`.`Surname`)', 'Users', array('<a href="?m=user_create&id=%s">%s</a>', array('UserID', 'Users'))),
	3 => array(false, 'Username', false),
	4 => array(false, 'EMail', false),
	5 => array(false, 'ContactNo', false),
	6 => array(false, 'roleName', false),
	7 => array(false, 'Active', false)

);

$colout = array();
$colout_f = array();
$colout_done = array();
foreach($columns as $col) {
    $colout_done[] = $col[1];
    if($col[0]) {
        $colout[] = $col[0].' AS `'.$col[1].'`';
        $colout_f[] = $col[0].' AS `'.$col[1].'`';
    }else{
        $colout[] = '`'.$col[1].'`';
    }

    if($col[2]) { //if format
        foreach($col[2][1] as $tcol) {
            if(!in_array($tcol, $colout_done)) {
                $colout[] = $tcol;
                $colout_done[] = $tcol;
            }
        }
    }
}

$sql_data = "SELECT ";
$sql_data .= implode(", ", $colout);
$sql_data .= " FROM Users
LEFT JOIN `Roles` AS `r` ON `r`.`roleID` = `users`.`Level` ";

$sql_anz = "SELECT COUNT(`Users`.`UserID`) as anz ";

$sql_anz .= " FROM Users
LEFT JOIN `Roles` AS `r` ON `r`.`roleID` = `users`.`Level` ";
//join roles as r on r.roleID = users.Level

// getting total number records without any external filters
//$anzq=$GLOBALS['adlerweb']['sql']->query($sql_anz.$sql_filter);
$anzq=$GLOBALS['adlerweb']['sql']->query_single($sql_anz);
if(!$anzq) {
    $totalData=0;
}else{
    $totalData=$anzq['anz'];
}
$totalFiltered = $totalData;

$sql_filter_data = array();
$sql_filter = " WHERE 1 = ?";
$sql_filter_data[] = 1;

// getting records as per search parameters
for($i=0; $i<count($columns); $i++) {
    if( !empty($requestData['columns'][$i]['search']['value']) ){
        if($columns[$i][0]) {
            $sql_filter.=" AND (".$columns[$i][0].") LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }else{
            $sql_filter.=" AND `".$columns[$i][1]."` LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }
    }
}

if(!empty($requestData['search']['value'])) {
    $sql_filter.="
        AND (
            `UserID` LIKE ? OR
            `Title` LIKE ? OR
            CONCAT(`Users`.`Name`,\", \",`Users`.`Surname`) LIKE ? OR
            `Username` LIKE ? OR
            `EMail` LIKE ? OR
            `ContactNo` LIKE ? OR
			     `roleName` LIKE ? OR
			     `Active` LIKE ? OR
        ) ";
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
}

if(count($sql_filter_data) > 1) {
    $anzq=$GLOBALS['adlerweb']['sql']->querystmt_single($sql_anz.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
    if(!$anzq) {
        $totalFiltered=0;
    }else{
        $totalFiltered=$anzq['anz'];
    }
}

if(isset($requestData['order'][0]['column']) && isset($requestData['order'][0]['dir'])) {
    if(!in_array($requestData['order'][0]['dir'], array('ASC', 'DESC', 'asc', 'desc'))) die('Errr?');
    $sql_filter.=" ORDER BY ". $columns[$requestData['order'][0]['column']][1]."   ".$requestData['order'][0]['dir'].' ';
}
if(isset($requestData['start']) && isset($requestData['length']) && $requestData['length'] > 0)
    $sql_filter.="LIMIT ".(int)$requestData['start']." ,".(int)$requestData['length']."   ";  // adding length

$query = $GLOBALS['adlerweb']['sql']->querystmt($sql_data.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
$data = array();
if($query) {
    foreach($query as $row) {  // preparing an array
        $nestedData=array();

        foreach($columns as $col) {
            if($col[2]) {
                $argdata = array(
                    $col[2][0]
                );
                foreach($col[2][1] as $in) {
                    $argdata[] = $row[$in];
                }
                $nestedData[] = call_user_func_array('sprintf', $argdata);
            }else{
                $nestedData[] = $row[$col[1]];
            }
        }

        $data[] = $nestedData;
    }
}

$json_data = array(
    "recordsTotal"    => intval( $totalData ),  // total number of records
    "recordsFiltered" => intval( $totalFiltered ), // total number of records after searching, if there is no searching then totalFiltered = totalData
    "data"            => $data   // total data array
);

if(isset($requestData['draw'])) $json_data['draw'] = $requestData['draw'];
}

//============================================================================================
elseif($requestData['source']=="papers"){
	//paper management
	$columns = array(
// datatable column index  => database column name
  0 => array(false, 'paperId', array('<a href="?m=content_detail&id=%s">%s</a>', array('paperId', 'paperId'))),
  1=> array(false, 'dateUpload', false),
  2 => array(false, 'title', false),
  3 => array(false, 'publishedStatus', false),
  4 => array(false, 'abstract', false),
  5 => array(false, 'dateModerated', false),
	6 => array(false, 'studentNumber', false),
  7 => array(false, 'coordinatorId', false),
  8 => array(false, 'lecturerId', false),
  9 => array(false, 'moderatorId', false),
  10 => array(false, 'clusterId', false)


);

$colout = array();
$colout_f = array();
$colout_done = array();
foreach($columns as $col) {
    $colout_done[] = $col[1];
    if($col[0]) {
        $colout[] = $col[0].' AS `'.$col[1].'`';
        $colout_f[] = $col[0].' AS `'.$col[1].'`';
    }else{
        $colout[] = '`'.$col[1].'`';
    }

    if($col[2]) { //if format
        foreach($col[2][1] as $tcol) {
            if(!in_array($tcol, $colout_done)) {
                $colout[] = $tcol;
                $colout_done[] = $tcol;
            }
        }
    }
}

$sql_data = "SELECT ";
$sql_data .= implode(", ", $colout);
$sql_data .= " FROM papers";

$sql_anz = "SELECT COUNT(`papers`.`paperId`) as anz ";

$sql_anz .= " FROM papers ";

// getting total number records without any external filters
//$anzq=$GLOBALS['adlerweb']['sql']->query($sql_anz.$sql_filter);
$anzq=$GLOBALS['adlerweb']['sql']->query_single($sql_anz);
if(!$anzq) {
    $totalData=0;
}else{
    $totalData=$anzq['anz'];
}
$totalFiltered = $totalData;

$sql_filter_data = array();
$sql_filter = " WHERE 1 = ?";
$sql_filter_data[] = 1;

// getting records as per search parameters
for($i=0; $i<count($columns); $i++) {
    if( !empty($requestData['columns'][$i]['search']['value']) ){
        if($columns[$i][0]) {
            $sql_filter.=" AND (".$columns[$i][0].") LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }else{
            $sql_filter.=" AND `".$columns[$i][1]."` LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }
    }
}

if(!empty($requestData['search']['value'])) {
    $sql_filter.="
        AND (
            `paperId` LIKE ? OR
            `dateModerated` LIKE ? OR
            `dateUpload` LIKE ? OR
            `publishedStatus` LIKE ? OR
            `studentNumber` LIKE ? OR
            `abstract` LIKE ? OR
            `coordinatorId` LIKE ? OR
            `lecturerId` LIKE ? OR
            `moderatorId` LIKE ? OR
            `clusterId` LIKE ? OR

        ) ";
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        //$sql_filter_data[] = '%'.$requestData['search']['value'].'%';

}

if(count($sql_filter_data) > 1) {
    $anzq=$GLOBALS['adlerweb']['sql']->querystmt_single($sql_anz.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
    if(!$anzq) {
        $totalFiltered=0;
    }else{
        $totalFiltered=$anzq['anz'];
    }
}

if(isset($requestData['order'][0]['column']) && isset($requestData['order'][0]['dir'])) {
    if(!in_array($requestData['order'][0]['dir'], array('ASC', 'DESC', 'asc', 'desc'))) die('Errr?');
    $sql_filter.=" ORDER BY ". $columns[$requestData['order'][0]['column']][1]."   ".$requestData['order'][0]['dir'].' ';
}
if(isset($requestData['start']) && isset($requestData['length']) && $requestData['length'] > 0)
    $sql_filter.="LIMIT ".(int)$requestData['start']." ,".(int)$requestData['length']."   ";  // adding length

$query = $GLOBALS['adlerweb']['sql']->querystmt($sql_data.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
$data = array();
if($query) {
    foreach($query as $row) {  // preparing an array
        $nestedData=array();

        foreach($columns as $col) {
            if($col[2]) {
                $argdata = array(
                    $col[2][0]
                );
                foreach($col[2][1] as $in) {
                    $argdata[] = $row[$in];
                }
                $nestedData[] = call_user_func_array('sprintf', $argdata);
            }else{
                $nestedData[] = $row[$col[1]];
            }
        }

        $data[] = $nestedData;
    }
}

$json_data = array(
    "recordsTotal"    => intval( $totalData ),  // total number of records
    "recordsFiltered" => intval( $totalFiltered ), // total number of records after searching, if there is no searching then totalFiltered = totalData
    "data"            => $data   // total data array
);

if(isset($requestData['draw'])) $json_data['draw'] = $requestData['draw'];
}

elseif($requestData['source']=="cluster"){
    //student management
    $columns = array(
// datatable column index  => database column name
    0 => array(false, 'clusterId', false),
    1 => array(false, 'clustername', false),
    2 => array(false, 'Description', false)
);

$colout = array();
$colout_f = array();
$colout_done = array();
foreach($columns as $col) {
    $colout_done[] = $col[1];
    if($col[0]) {
        $colout[] = $col[0].' AS `'.$col[1].'`';
        $colout_f[] = $col[0].' AS `'.$col[1].'`';
    }else{
        $colout[] = '`'.$col[1].'`';
    }

    if($col[2]) { //if format
        foreach($col[2][1] as $tcol) {
            if(!in_array($tcol, $colout_done)) {
                $colout[] = $tcol;
                $colout_done[] = $tcol;
            }
        }
    }
}

$sql_data = "SELECT ";
$sql_data .= implode(", ", $colout);

$sql_data .= " FROM cluster";

$sql_anz = "SELECT COUNT(`cluster`.`clusterId`) as anz ";

$sql_anz .= " FROM cluster ";


// getting total number records without any external filters
//$anzq=$GLOBALS['adlerweb']['sql']->query($sql_anz.$sql_filter);
$anzq=$GLOBALS['adlerweb']['sql']->query_single($sql_anz);
if(!$anzq) {
    $totalData=0;
}else{
    $totalData=$anzq['anz'];
}
$totalFiltered = $totalData;

$sql_filter_data = array();
$sql_filter = " WHERE 1 = ?";
$sql_filter_data[] = 1;

// getting records as per search parameters
for($i=0; $i<count($columns); $i++) {
    if( !empty($requestData['columns'][$i]['search']['value']) ){
        if($columns[$i][0]) {
            $sql_filter.=" AND (".$columns[$i][0].") LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }else{
            $sql_filter.=" AND `".$columns[$i][1]."` LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }
    }
}

if(!empty($requestData['search']['value'])) {
    $sql_filter.="
        AND (
            `studentID` LIKE ? OR
            `studentNumber` LIKE ? OR
            `firstName` LIKE ? OR
            `surname` LIKE ? OR
            `gender` LIKE ? OR
            `course` LIKE ? OR
        ) ";
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
}

if(count($sql_filter_data) > 1) {
    $anzq=$GLOBALS['adlerweb']['sql']->querystmt_single($sql_anz.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
    if(!$anzq) {
        $totalFiltered=0;
    }else{
        $totalFiltered=$anzq['anz'];
    }
}

if(isset($requestData['order'][0]['column']) && isset($requestData['order'][0]['dir'])) {
    if(!in_array($requestData['order'][0]['dir'], array('ASC', 'DESC', 'asc', 'desc'))) die('Errr?');
    $sql_filter.=" ORDER BY ". $columns[$requestData['order'][0]['column']][1]."   ".$requestData['order'][0]['dir'].' ';
}
if(isset($requestData['start']) && isset($requestData['length']) && $requestData['length'] > 0)
    $sql_filter.="LIMIT ".(int)$requestData['start']." ,".(int)$requestData['length']."   ";  // adding length

$query = $GLOBALS['adlerweb']['sql']->querystmt($sql_data.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
$data = array();
if($query) {
    foreach($query as $row) {  // preparing an array
        $nestedData=array();

        foreach($columns as $col) {
            if($col[2]) {
                $argdata = array(
                    $col[2][0]
                );
                foreach($col[2][1] as $in) {
                    $argdata[] = $row[$in];
                }
                $nestedData[] = call_user_func_array('sprintf', $argdata);
            }else{
                $nestedData[] = $row[$col[1]];
            }
        }

        $data[] = $nestedData;
    }
}

$json_data = array(
    "recordsTotal"    => intval( $totalData ),  // total number of records
    "recordsFiltered" => intval( $totalFiltered ), // total number of records after searching, if there is no searching then totalFiltered = totalData
    "data"            => $data   // total data array
);

if(isset($requestData['draw'])) $json_data['draw'] = $requestData['draw'];

}

//=================================================================================================
elseif($requestData['source']=="student"){
	//student management
	$columns = array(
// datatable column index  => database column name
	0 => array(false, 'studentID', false),
	1 => array(false, 'studentNumber', false),
	2 => array(false, 'firstName', false),
	3 => array(false, 'surname', false),
	4 => array(false, 'gender', false),
	5 => array(false, 'course', false)
);

$colout = array();
$colout_f = array();
$colout_done = array();
foreach($columns as $col) {
    $colout_done[] = $col[1];
    if($col[0]) {
        $colout[] = $col[0].' AS `'.$col[1].'`';
        $colout_f[] = $col[0].' AS `'.$col[1].'`';
    }else{
        $colout[] = '`'.$col[1].'`';
    }

    if($col[2]) { //if format
        foreach($col[2][1] as $tcol) {
            if(!in_array($tcol, $colout_done)) {
                $colout[] = $tcol;
                $colout_done[] = $tcol;
            }
        }
    }
}

$sql_data = "SELECT ";
$sql_data .= implode(", ", $colout);

$sql_data .= " FROM Student";

$sql_anz = "SELECT COUNT(`Student`.`studentID`) as anz ";

$sql_anz .= " FROM Student ";


// getting total number records without any external filters
//$anzq=$GLOBALS['adlerweb']['sql']->query($sql_anz.$sql_filter);
$anzq=$GLOBALS['adlerweb']['sql']->query_single($sql_anz);
if(!$anzq) {
    $totalData=0;
}else{
    $totalData=$anzq['anz'];
}
$totalFiltered = $totalData;

$sql_filter_data = array();
$sql_filter = " WHERE 1 = ?";
$sql_filter_data[] = 1;

// getting records as per search parameters
for($i=0; $i<count($columns); $i++) {
    if( !empty($requestData['columns'][$i]['search']['value']) ){
        if($columns[$i][0]) {
            $sql_filter.=" AND (".$columns[$i][0].") LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }else{
            $sql_filter.=" AND `".$columns[$i][1]."` LIKE ? ";
            $sql_filter_data[] = '%'.$requestData['columns'][$i]['search']['value'].'%';
        }
    }
}

if(!empty($requestData['search']['value'])) {
    $sql_filter.="
        AND (
            `studentID` LIKE ? OR
            `studentNumber` LIKE ? OR
            `firstName` LIKE ? OR
            `surname` LIKE ? OR
            `gender` LIKE ? OR
            `course` LIKE ? OR
        ) ";
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
        $sql_filter_data[] = '%'.$requestData['search']['value'].'%';
}

if(count($sql_filter_data) > 1) {
    $anzq=$GLOBALS['adlerweb']['sql']->querystmt_single($sql_anz.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
    if(!$anzq) {
        $totalFiltered=0;
    }else{
        $totalFiltered=$anzq['anz'];
    }
}

if(isset($requestData['order'][0]['column']) && isset($requestData['order'][0]['dir'])) {
    if(!in_array($requestData['order'][0]['dir'], array('ASC', 'DESC', 'asc', 'desc'))) die('Errr?');
    $sql_filter.=" ORDER BY ". $columns[$requestData['order'][0]['column']][1]."   ".$requestData['order'][0]['dir'].' ';
}
if(isset($requestData['start']) && isset($requestData['length']) && $requestData['length'] > 0)
    $sql_filter.="LIMIT ".(int)$requestData['start']." ,".(int)$requestData['length']."   ";  // adding length

$query = $GLOBALS['adlerweb']['sql']->querystmt($sql_data.$sql_filter, str_repeat('s', count($sql_filter_data)), $sql_filter_data);
$data = array();
if($query) {
    foreach($query as $row) {  // preparing an array
        $nestedData=array();

        foreach($columns as $col) {
            if($col[2]) {
                $argdata = array(
                    $col[2][0]
                );
                foreach($col[2][1] as $in) {
                    $argdata[] = $row[$in];
                }
                $nestedData[] = call_user_func_array('sprintf', $argdata);
            }else{
                $nestedData[] = $row[$col[1]];
            }
        }

        $data[] = $nestedData;
    }
}

$json_data = array(
    "recordsTotal"    => intval( $totalData ),  // total number of records
    "recordsFiltered" => intval( $totalFiltered ), // total number of records after searching, if there is no searching then totalFiltered = totalData
    "data"            => $data   // total data array
);

if(isset($requestData['draw'])) $json_data['draw'] = $requestData['draw'];

}

echo json_encode($json_data);  // send data as json format

?>