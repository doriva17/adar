
<?PHP

if(!$GLOBALS['adlerweb']['session']->session_isloggedin()) {
    $GLOBALS['adlerweb']['tpl']->assign('titel',  'No authorization');
    $GLOBALS['adlerweb']['tpl']->assign('modul',  'error');
    $GLOBALS['adlerweb']['tpl']->assign('errstr', 'You do not have the required rights to access this page.');
}else{
    $titel = 'Supervisor Paper List'; //list view

    $GLOBALS['adlerweb']['tpl']->assign('titel', $titel);
    $GLOBALS['adlerweb']['tpl']->assign('modul', 'lecturer_paper_list');
    $GLOBALS['adlerweb']['tpl']->assign('menue', 'lecturer_paper_list');

}

?>
