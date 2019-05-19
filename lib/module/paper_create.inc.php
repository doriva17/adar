<?PHP

$back='<div class="centered infobox_addtext"><a href="javascript:history.go(-1)">&laquo; To main navigation &laquo;</a></div>';

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to record new archive tracks.'.$back);

}elseif(isset($_REQUEST['a']) && $_REQUEST['a'] == 'Upload') {
    //File

    $target_path = "data/tmp/";

    if(!isset($_FILES['file']['tmp_name']) || $_FILES['file']['tmp_name'] == '') {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Error in the capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'No file was specified.'.$back);
    }else{

        $hash=hash('sha256', file_get_contents($_FILES['file']['tmp_name'])).".pdf";
        $target_path .= $hash;

    $finfo = new finfo(FILEINFO_MIME);
    $mime = $finfo->file($_FILES['file']['tmp_name']);
        if(
        !@getimagesize($_FILES['file']['tmp_name']) &&
        strpos($mime, 'application/pdf') === false
    ) {
            $GLOBALS['adlerweb']['tpl']->assign('titel',  'Error in the capture');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The specified file format is not allowed. ('.$mime.') Upload pdf'.$back);
        }elseif(!@move_uploaded_file($_FILES['file']['tmp_name'], $target_path)) {
            $GLOBALS['adlerweb']['tpl']->assign('titel',  'Error in the capture');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'An unknown error occurred during capture.'.$back);

        }else{

            if(preg_match('/[A-Z][A-Z]+_(\d{4})\./', $_FILES['file']['name'], $match)) {
                $id=$match[1];
            }else{

                $id=$GLOBALS['adlerweb']['sql']->querystmt_single("SELECT MAX(paperId) as UI_ID FROM `papers` WHERE `paperId` LIKE ?;", 's', '%%');

                if($id) {
                    $id=$id['UI_ID']+1;
                    //die("id: ".($id));
                }else{
                    $id=1;
                }
            }

            $dupchk=$GLOBALS['adlerweb']['sql']->querystmt_single("SELECT paperId FROM `papers` WHERE `sourceSHA256` = ?;", 's', $hash);
            if($dupchk) {
                $dupchk=$dupchk['paperId'];
                $back2='<div class="centered infobox_addtext"><a href="?m=paper_detail&id='.$dupchk.'">&raquo; To the detail page &raquo;</a></div>';
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Error in the capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'This document already exists in the system!'.$back2);
            }else{

                $abstract='';

                $date = strftime("%Y-%m-%d", time());
                $exif = false;
                if(function_exists('exif_read_data')) {
                    $exif = @exif_read_data($target_path, 0 , true);
                    if($exif && isset($exif["EXIF"]["DateTimeOriginal"])) {
                        $date = str_replace(":","-",substr($exif["EXIF"]["DateTimeOriginal"], 0, 10));
                    }
                }
                $GLOBALS['adlerweb']['tpl']->assign('edate', $date);

               /* if($exif && isset($exif['EXIF']) && count($exif['EXIF']) > 0) {
                    $descr.='Daten der Kamera:'."\n";
                    $descr.='================='."\n";
                    foreach($exif["EXIF"] as $key => $value) {
                        if($key != 'MakerNote' && $key != 'ComponentsConfiguration' && $key != 'UserComment')
                            $abstract.=$key.' = '.$value."\n";
                    }
                }*/
                $lmlist = $GLOBALS['adlerweb']['sql']->query("SELECT UserID, Name, Surname FROM users where Level = '1';");
                $users = array();
                $allowed = array();
                while($item = $lmlist->fetch_assoc()) {
                    $users[]=$item;
                    $allowed[]=strtolower($item['UserID']);
                }

                    $clist = $GLOBALS['adlerweb']['sql']->query("SELECT UserID, Name, Surname FROM users where Level = '4';");
                    $cuser = array();
                    $allowed = array();
                    while($item = $clist->fetch_assoc()) {
                        $cuser[]=$item;
                        $allowed[]=strtolower($item['UserID']);
                    }

                    $clusterslist = $GLOBALS['adlerweb']['sql']->query("SELECT clusterId, clustername FROM cluster;");
                    $clusters = array();
                    $allowed = array();
                    while($item = $clusterslist->fetch_assoc()) {
                        $clusters[]=$item;
                        $allowed[]=strtolower($item['clusterId']);
                    }
                    $name = $_SESSION['adlerweb']['session']['user'];
                    $loginuser = $GLOBALS['adlerweb']['sql']->query("SELECT UserID, Username FROM users WHERE Username = '$name';");
                    //$GLOBALS['adlerweb']['tpl']->assign('loginuser',  $loginuser);
                    $inuser = array();
                    $allowed = array();
                    while($item = $loginuser->fetch_assoc()) {
                        $inuser[]=$item;
                        $allowed[]=strtolower($item['UserID']);
                    }
                    //die (var_dump($))

                    $published_status = array("NO","YES");

                    $dummy = array(
                        'dateUpload' => '',
                        //'dateModerated' => '',
                        'lecturerId' => '',
                        'title' => '',
                        'studentNumber' => '',
                        'coordinatorId' => '',
                        'clusterId' => '',
                        'publishedStatus' => '',
                        'abstract' => '',
                        'paperId' => ''
                    );

                    $details = $dummy;
                    if(isset($_REQUEST['id'])) {
                        $details = $GLOBALS['adlerweb']['sql']->querystmt_single("SELECT * FROM papers WHERE `paperId` = ?;", 'i', $_REQUEST['id']);
                    }

                    if(!isset($details['Country']) || $details['Country'] == '') {
                        $lang = strtoupper(lang_getfrombrowser ($allowed, 'na', null, false));
                    }
                    else{
                        $lang = $details['Country'];
                    }
                    //die ("id : ".$id);
                $GLOBALS['adlerweb']['tpl']->assign('hash', $hash);
                $GLOBALS['adlerweb']['tpl']->assign('id', $id);
                $GLOBALS['adlerweb']['tpl']->assign('date', $date);
                $GLOBALS['adlerweb']['tpl']->assign('$abstract', htmlentities($abstract));
                $GLOBALS['adlerweb']['tpl']->assign('ScanUser', $_SESSION['adlerweb']['session']['user']);
                $GLOBALS['adlerweb']['tpl']->assign('modul', 'paper_create_form');
                $GLOBALS['adlerweb']['tpl']->assign('menue', 'paper_create');
                $GLOBALS['adlerweb']['tpl']->assign('users', $users);
                $GLOBALS['adlerweb']['tpl']->assign('cuser', $cuser);
                $GLOBALS['adlerweb']['tpl']->assign('clusters', $clusters);
                $GLOBALS['adlerweb']['tpl']->assign('inuser', $inuser);
                $GLOBALS['adlerweb']['tpl']->assign('published_status', $published_status);
                $GLOBALS['adlerweb']['tpl']->assign('details', $details);
                $GLOBALS['adlerweb']['tpl']->assign('lang', $lang);
            }


        }

    }
}elseif(isset($_REQUEST['a']) && $_REQUEST['a'] == 'To capture' && isset($_REQUEST['sourceSHA256'])) {
    $source_path = "data/tmp/";
    $source_path .= $_REQUEST['sourceSHA256'];
    $target_path = "data/org/";
    $cache_path = "data/cache/";
    $itemid = $_REQUEST['paperId'];
    //die("id: $itemid");

    $target_path .= $itemid;
    $cache_path .= $itemid;

    if(!file_exists($source_path)) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The source file was not found.'.$back);
    }elseif(file_exists($target_path)){
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The destination file already exists.'.$back);
    }elseif(file_exists($cache_path)){
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The cache file already exists.'.$back);
    }else{
        $finfo = new finfo(FILEINFO_MIME);
        $mime = $finfo->file($source_path);
        $suffix=false;
        if(strpos($mime, 'application/pdf') !== false) $suffix = 'pdf';
        if(strpos($mime, 'image/png') !== false) $suffix = 'png';
        if(strpos($mime, 'image/jpeg') !== false) $suffix = 'jpg';

        if(!isset($_REQUEST['OCR'])) $_REQUEST['OCR'] = 0;

        $success = false;

        if(
           !isset($_REQUEST['lecturerId'])
        || !isset($_REQUEST['abstract'])
        || !isset($_REQUEST['studentNumber'])
        || !isset($_REQUEST['title'])
        || !isset($_REQUEST['coordinatorId'])) {
            $GLOBALS['adlerweb']['tpl']->assign ('titel',  'Can not capture');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Not all fields were submitted.'.$back);
        }else{
//Die("here");
            $format = gettopformat();

            if(isset($_REQUEST['FormatTop']) && $_REQUEST['FormatTop'] != '') $format = $_REQUEST['FormatTop'];
            if(isset($_REQUEST['Format']) && $_REQUEST['Format'] != '') $format = $_REQUEST['Format'];

            if(!$suffix) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The specified file format is not allowed. Upload pdf'.$back);
            }elseif(($GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO papers(paperId, dateUpload, lecturerId,
              studentNumber, clusterId, publishedStatus, coordinatorId, abstract, sourceSHA256, title)
              VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, ?, ? )", str_repeat('s', 9), array(
                $_REQUEST['paperId'],
                $_REQUEST['lecturerId'],
                $_REQUEST['studentNumber'],
                $_REQUEST['clusterId'],
                $_REQUEST['publishedStatus'],
                $_REQUEST['coordinatorId'],
                $_REQUEST['abstract'],
                $_REQUEST['sourceSHA256'],
                $_REQUEST['title']
            ))) === false) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'A database error has occurred #103.'.$back);
            }else{

                $back2='<div class="centered infobox_addtext"><a href="?m=paper_detail&id='.$itemid.'">&raquo; To the detail page &raquo;</a></div>';
                $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Archive records successfully!');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The paper was successfully uploaded to the database'.$back2);
                $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
                infomail("New Paper Uploaded", "A new student report has been uploaded to the Honours Project Report Repository");
            }
        }
    }
}else{


    $GLOBALS['adlerweb']['tpl']->assign('titel', 'Capture - Step 1 of 2');
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'create_upload');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'paper_create');
}

function procimg($src, $trg) {
//  die("procimg");
return true;
    $img = imagecreatefromjpeg($src);
    if(!$img) return false;
    return imagepng($img, $trg, 9);
}

function procpdf($src, $trg) {
  return true;
    if(!file_exists($src)) return false;
    //die("src: $src trg: $trg");
    exec('convert '.escapeshellarg($src).' '.escapeshellarg($trg), $dummy, $return);
    if($return != 0) return false;
    return true;
}

function getcontacts($s, $r) {
    $out['s'] = getcontact($s);
    $out['r'] = getcontact($r);
    if($out['s'] == false || $out['r'] == false) return false;
    return $out;
}

function getcontact($name) {
    if(!preg_match("|^(.+), ([^,]*)$|", $name, $match)) return false;
    $detail=$GLOBALS['adlerweb']['sql']->querystmt_single("SELECT UserID FROM `users` WHERE Surname LIKE ? AND Username LIKE ?", 'ss', array($match[1], $match[2]));
    if(!$detail) return false;
    return $detail['UserID'];
}

function gettopformat() {
    $detail=$GLOBALS['adlerweb']['sql']->query("SELECT COUNT(Format) as ANZ, Format FROM `Items` WHERE Format IS NOT NULL GROUP BY Format ORDER BY ANZ DESC LIMIT 1;");
    if($detail->num_rows != 1) return false;
    $detail=$detail->fetch_object();
    return $detail->Format;
}
?>
