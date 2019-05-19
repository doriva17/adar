<?PHP
    if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
        $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
        $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
        $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to access this page.');
    }else{
        if(!isset($_GET['id']) || $_GET['id'] ==0) {
            $GLOBALS['adlerweb']['tpl']->assign('titel',  'No entries');
            $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
            $GLOBALS['adlerweb']['tpl']->assign('errico', 'Exclamation');
            $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There are no entries in our database that match your search criteria.');
        }else{
            $id=$_GET['id'];
            $sqlq="SELECT
                    `Users`.*,
                    `Roles`.*
                FROM
                    `Users`
                    LEFT JOIN `Roles` ON `Users`.`Level` = `Roles`.`roleID`
                    WHERE `Users`.`UserID` = ?";
            $sqlq.=" LIMIT 1;";
            $detail=$GLOBALS['adlerweb']['sql']->querystmt_single($sqlq, 's', $id);
            if(!$detail) {
                $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
                $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
                $GLOBALS['adlerweb']['tpl']->assign('errico', 'Exclamation');
                $GLOBALS['adlerweb']['tpl']->assign('errstr', 'There are no entries in our database that match your search criteria.');
            }else{
                if(isset($_REQUEST['action']) && $_REQUEST['action'] == 'addtag' && $GLOBALS['adlerweb']['session']->session_isloggedin()) {
                    //
                }elseif(isset($_REQUEST['action']) && $_REQUEST['action'] == 'deluser' && isset($_REQUEST['tag']) && $GLOBALS['adlerweb']['session']->session_isloggedin()) {
                    if(!$GLOBALS['adlerweb']['sql']->querystmt("DELETE FROM `Users` WHERE UserID = ? LIMIT 1;", 'i', $detail['UserID'])) {
                        http_response_code(400);
                        die();
                    }
                    infomail("User deleted ".$detail['UserID'], $_REQUEST['tag']);
                    http_response_code(200);
                    echo '[]';
                    die();
                }


				$rlist = $GLOBALS['adlerweb']['sql']->query("SELECT roleID, roleName FROM roles;");
				$roles = array();
				$allowed = array();
				while($item = $rlist->fetch_assoc()) {
					$roles[]=$item;
					$allowed[]=strtolower($item['roleID']);
				}

				$dummy = array(
					'Title' => '',
					'Name' => '',
					'Surname' => '',
					'Gender' => '',
					'Username' => '',
					'Password' => '',
					'EMail' => '',
					'ContactNo' => '',
					'Active' => '',
					'Level' => '',
					'UserID' => 0
				);

				$details = $dummy;
				if(isset($_REQUEST['id'])) {
					$details = $GLOBALS['adlerweb']['sql']->querystmt_single("SELECT * FROM Users WHERE `UserID` = ?;", 'i', $_REQUEST['id']);
				}

				if(!isset($details['Level']) || $details['Level'] == '') {
					$lang = strtoupper(lang_getfrombrowser ($allowed, 'na', null, false));
				}else{
					$lang = $details['Level'];
				}

				$GLOBALS['adlerweb']['tpl']->assign('details', $details);
				$GLOBALS['adlerweb']['tpl']->assign('roles', $roles);
				$GLOBALS['adlerweb']['tpl']->assign('lang', $lang);


                $GLOBALS['adlerweb']['tpl']->assign('titel', 'Detail View'.htmlentities($id));
                $GLOBALS['adlerweb']['tpl']->assign('modul', 'user_create_form');
                $GLOBALS['adlerweb']['tpl']->assign('REQUEST_URI', $_SERVER["REQUEST_URI"]);
            }
        }
    }
?>
