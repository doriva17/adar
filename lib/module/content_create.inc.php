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
        $hash=hash('sha256', file_get_contents($_FILES['file']['tmp_name']));
        $target_path .= $hash;

    $finfo = new finfo(FILEINFO_MIME);
    $mime = $finfo->file($_FILES['file']['tmp_name']);
        if(
        !@getimagesize($_FILES['file']['tmp_name']) &&
        strpos($mime, 'application/pdf') === false &&
        strpos($mime, 'image/png') === false &&
        strpos($mime, 'image/jpeg') === false
    ) {
            $GLOBALS['adlerweb']['tpl']->assign('titel',  'Error in the capture');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The specified file is not a picture or in an unknown format. ('.$mime.')'.$back);
        }elseif(!@move_uploaded_file($_FILES['file']['tmp_name'], $target_path)) {
            $GLOBALS['adlerweb']['tpl']->assign('titel',  'Error in the capture');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'An unknown error occurred during capture. Please contact the operator.'.$back);
        }else{

            if(preg_match('/[A-Z][A-Z]+_(\d{4})\./', $_FILES['file']['name'], $match)) {
                $id=$match[1];
            }else{
                $id=$GLOBALS['adlerweb']['sql']->querystmt_single("SELECT MAX(SUBSTRING(ItemID,4,4)) as UI_ID FROM `Items` WHERE `ItemID` LIKE ?;", 's', $_SESSION['adlerweb']['session']['short'].'_%');
                if($id) {
                    $id=sprintf("%04d", (int)$id['UI_ID']+1);
                }else{
                    $id='0000';
                }
            }

            $dupchk=$GLOBALS['adlerweb']['sql']->querystmt_single("SELECT ItemID FROM `Items` WHERE `SourceSHA256` = ?;", 's', $hash);
            if($dupchk) {
                $dupchk=$dupchk['ItemID'];
                $back2='<div class="centered infobox_addtext"><a href="?m=content_detail&id='.$dupchk.'">&raquo; To the detail page &raquo;</a></div>';
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Error in the capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'This picture already exists in the archive!'.$back2);
            }else{

                $descr='';

                $date = strftime("%Y-%m-%d", time());
                $exif = false;
                if(function_exists('exif_read_data')) {
                    $exif = @exif_read_data($target_path, 0 , true);
                    if($exif && isset($exif["EXIF"]["DateTimeOriginal"])) {
                        $date = str_replace(":","-",substr($exif["EXIF"]["DateTimeOriginal"], 0, 10));
                    }
                }
                $GLOBALS['adlerweb']['tpl']->assign('edate', $date);

                if($exif && isset($exif['EXIF']) && count($exif['EXIF']) > 0) {
                    $descr.='Data of the camera:'."\n";
                    $descr.='================='."\n";
                    foreach($exif["EXIF"] as $key => $value) {
                        if($key != 'MakerNote' && $key != 'ComponentsConfiguration' && $key != 'UserComment')
                            $descr.=$key.' = '.$value."\n";
                    }
                }

                $GLOBALS['adlerweb']['tpl']->assign('hash', $hash);
                $GLOBALS['adlerweb']['tpl']->assign('id', $id);
                $GLOBALS['adlerweb']['tpl']->assign('date', $date);
                $GLOBALS['adlerweb']['tpl']->assign('descr', htmlentities($descr));
                $GLOBALS['adlerweb']['tpl']->assign('ScanDate', strftime("%Y-%m-%d", time()));
                $GLOBALS['adlerweb']['tpl']->assign('ScanUser', $_SESSION['adlerweb']['session']['user']);
                $GLOBALS['adlerweb']['tpl']->assign('ScanUserShort', $_SESSION['adlerweb']['session']['short']);
                $GLOBALS['adlerweb']['tpl']->assign('Format', gettopformat());
                $GLOBALS['adlerweb']['tpl']->assign('titel', 'Capture - Step 2 of 2');
                $GLOBALS['adlerweb']['tpl']->assign('modul', 'create_form');
                $GLOBALS['adlerweb']['tpl']->assign('menue', 'content_create');
            }
        }
    }
}elseif(isset($_REQUEST['a']) && $_REQUEST['a'] == 'To capture' && isset($_REQUEST['SHA256']) && isset($_REQUEST['ItemID'])) {
    $source_path = "data/tmp/";
    $source_path .= $_REQUEST['SHA256'];
    $target_path = "data/org/";
    $cache_path = "data/cache/";
    $itemid = $_SESSION['adlerweb']['session']['short'].'_'.sprintf ("%04d", (int)$_REQUEST['ItemID']);
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
    }elseif(!isset($_REQUEST['Sender']) || !isset($_REQUEST['Receiver']) || !($cids=getcontacts($_REQUEST['Sender'], $_REQUEST['Receiver']))) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The contacts could not be assigned.'.$back);
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
           !isset($_REQUEST['Caption'])
        || !isset($_REQUEST['Description'])
        || !isset($_REQUEST['Date'])) {
            $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'Not all fields were submitted.'.$back);
        }else{

            $format = gettopformat();
            if(isset($_REQUEST['FormatTop']) && $_REQUEST['FormatTop'] != '') $format = $_REQUEST['FormatTop'];
            if(isset($_REQUEST['Format']) && $_REQUEST['Format'] != '') $format = $_REQUEST['Format'];

            if(!$suffix) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The source file has an unknown type.'.$back);
            }elseif(($GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO Items VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, NOW(), ?, ? )", str_repeat('s', 10), array(
                $itemid,
                $_REQUEST['Caption'],
                $_REQUEST['Description'],
                $format,
                $_REQUEST['Date'],
                $cids['s'],
                $cids['r'],
                $_SESSION['adlerweb']['session']['UID'],
                $_REQUEST['SHA256'],
                $_REQUEST['OCR']
            ))) === false) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There was a database error # 103.'.$back);
            }elseif(!rename($source_path, $target_path.'.'.$suffix)) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'File could not be moved to the archive.'.$back);
            }elseif($suffix == 'png' && !copy($target_path.'.'.$suffix, $cache_path.'.png')) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'File could not be copied to the cache (PNG).'.$back);
            }elseif($suffix == 'jpg' && !procimg($target_path.'.'.$suffix, $cache_path.'.png')) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'File could not be cached (JPG).'.$back);
            }elseif($suffix == 'pdf' && !procpdf($target_path.'.'.$suffix, $cache_path.'.png')) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Can not capture');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'File could not be copied to the cache (PDF).'.$back);
            }else{
                $back2='<div class="centered infobox_addtext"><a href="?m=content_detail&id='.$itemid.'">&raquo; To the detail page &raquo;</a></div>';
                $GLOBALS['adlerweb']['tpl']->assign('modul', 'error');
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Archive material successfully recorded!');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The archived material was successfully transferred to the database.'.$back2);
                $GLOBALS['adlerweb']['tpl']->assign('errico', 'information');
                infomail("New Archive AdAR", $_REQUEST['Caption']);
            }
        }
    }
}else{
    $GLOBALS['adlerweb']['tpl']->assign('titel', 'Capture - Step 1 of 2');
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'create_upload');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'content_create');
}

function procimg($src, $trg) {
    $img = imagecreatefromjpeg($src);
    if(!$img) return false;
    return imagepng($img, $trg, 9);
}

function procpdf($src, $trg) {
    if(!file_exists($src)) return false;
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
    $detail=$GLOBALS['adlerweb']['sql']->querystmt_single("SELECT CID FROM `Contacts` WHERE FamilyName LIKE ? AND GivenName LIKE ?", 'ss', array($match[1], $match[2]));
    if(!$detail) return false;
    return $detail['CID'];
}

function gettopformat() {
    $detail=$GLOBALS['adlerweb']['sql']->query("SELECT COUNT(Format) as ANZ, Format FROM `Items` WHERE Format IS NOT NULL GROUP BY Format ORDER BY ANZ DESC LIMIT 1;");
    if($detail->num_rows != 1) return false;
    $detail=$detail->fetch_object();
    return $detail->Format;
}
?>
