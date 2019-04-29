<?PHP
    if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to access this page.');
    }else{
        if(!isset($_GET['id'])) {
            $GLOBALS['adlerweb']['tpl']->assign('titel',  'No entries');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errico', 'Exclamation');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There are no entries in our archive that match your search criteria.');
        }else{
            $id=$_GET['id'];
            $sqlq="SELECT
                    `papers`.*,
                    `Users`.*,
                    `papers`.`studentNumber` as 'StudentId',
                    `papers`.`lecturerId` as 'LecturerId',
                    `papers`.`dateUpload` as 'DateUpload',
                    `papers`.`publishedStatus` as 'PublishedStatus',
                    `papers`.`clusterId` as 'ClusterId',
                    `papers`.`sourceSHA256` as 'SourceSHA256',
                    `papers`.`abstract` as 'Abstract'
                FROM
                    `papers`
                    LEFT JOIN `Users` ON `papers`.`studentNumber` = `Users`.`UserID`

                    WHERE `paperId` = ?";
            $sqlq.=" LIMIT 1;";
            $detail=$GLOBALS['adlerweb']['sql']->querystmt_single($sqlq, 's', $id);
            if(!$detail) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errico', 'Exclamation');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There are no entries in our archive that match your search criteria.');
            }elseif(!file_exists('data/tmp/'.$detail["SourceSHA256"].'')) {
              echo 'data/tmp/'.$id.'.pdf';
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'Data Error');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errico', 'Exclamation');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'The record is corrupt');
            }else{
                if(isset($_REQUEST['action']) && $_REQUEST['action'] == 'addtag' && $GLOBALS['adlerweb']['session']->session_isloggedin()) {
                    if(!isset($_REQUEST['tag'])) {
                        http_response_code(400);
                        die();
                    }
                    if(!$GLOBALS['adlerweb']['sql']->querystmt("INSERT INTO `Tags` VALUES ( NULL , ?, ?);", 'ss', array($detail['ItemID'], $_REQUEST['tag']))) {
                        http_response_code(400);
                        die();
                    }
                    infomail("New day picture ".$detail['ItemID'], $_REQUEST['tag']);
                    http_response_code(200);
                    echo '[]';
                    die();
                }elseif(isset($_REQUEST['action']) && $_REQUEST['action'] == 'deltag' && isset($_REQUEST['tag']) && $GLOBALS['adlerweb']['session']->session_isloggedin()) {
                    if(!$GLOBALS['adlerweb']['sql']->querystmt("DELETE FROM `Tags` WHERE ItemID = ? AND TagValue = ? LIMIT 1;", 'ss', array($detail['ItemID'], $_REQUEST['tag']))) {
                        http_response_code(400);
                        die();
                    }
                    infomail("Tag deleted image ".$detail['ItemID'], $_REQUEST['tag']);
                    http_response_code(200);
                    echo '[]';
                    die();
                }

              /*  $tags = $GLOBALS['adlerweb']['sql']->querystmt("SELECT TagValue FROM Tags WHERE ItemID = ?;", 's', $detail['ItemID']);
                $tagarr=array();
                if($tags) {
                    foreach($tags as $tag) {
                        $tagarr[] = $tag['TagValue'];
                    }
                }*/

                if(file_exists('data/cache/'.$id.'.png')) {
                    $multi=false;
                }else{
                    $multi=0;
                    while(file_exists('data/cache/'.$id.'-'.$multi.'.png')) {
                        $multi++;
                    }
                }

              //  if(isset($tagarr)) $GLOBALS['adlerweb']['tpl']->assign('Tags', implode(',', $tagarr));

                $GLOBALS['adlerweb']['tpl']->assign('ItemID', htmlentities($detail['paperId'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('StudentId', htmlentities($detail['StudentId'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('LecturerId', htmlentities($detail['LecturerId'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('Abstract', htmlentities($detail['Abstract'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('DateUpload', ($detail['DateUpload'] !== NULL) ? htmlentities(strftime("%d.%m.%Y", strtotime($detail['DateUpload'])), ENT_COMPAT, 'UTF-8') : '' );
                $GLOBALS['adlerweb']['tpl']->assign('ClusterId', htmlentities($detail['ClusterId'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('PublishedStatus', htmlentities($detail['PublishedStatus'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('SourceSHA256', htmlentities($detail['SourceSHA256'], ENT_COMPAT, 'UTF-8'));
                $GLOBALS['adlerweb']['tpl']->assign('pages', $multi);
                $GLOBALS['adlerweb']['tpl']->assign('titel', 'Detailansicht '.htmlentities($id));
                $GLOBALS['adlerweb']['tpl']->assign('modul', 'content_detail');
                $GLOBALS['adlerweb']['tpl']->assign('REQUEST_URI', $_SERVER["REQUEST_URI"]);
            }
        }
    }
?>
