
    <div id="menu">
        {if $loginlevel >= 1}
            <div class="menu_head">▸ Main Menu</div>
            <!--div class="menu_item {if $menue=='content_list'}menu_item_selected{/if}">
			<a href="?m=content_list"><img src="vendor/koala-framework/library-silkicons/table.png" /> All Entries</a></div-->
            <div class="menu_head">▸ For capture</div>
            <!--div class="menu_item {if $menue=='content_create'}menu_item_selected{/if}">
			<a href="?m=content_create"><img src="vendor/koala-framework/library-silkicons/page_add.png" /> New Data Set</a></div-->

	    <div class="menu_item {if $menue=='paper_create'}menu_item_selected{/if}">
			<a href="?m=paper_create"><img src="vendor/koala-framework/library-silkicons/page_add.png" /> Capture a Paper</a></div>

	    <div class="menu_item {if $menue=='cluster_create'}menu_item_selected{/if}">
			<a href="?m=cluster_create"><img src="vendor/koala-framework/library-silkicons/page_add.png" /> New Cluster</a></div>

    	    <div class="menu_head">▸ For Viewing</div>
                <!--div class="menu_item {if $menue=='contact_create'}menu_item_selected{/if}">
			    <a href="?m=contact_create"><img src="vendor/koala-framework/library-silkicons/user_add.png" /> New contact</a></div-->

                <div class="menu_item {if $menue=='paper_list'}menu_item_selected{/if}">
			    <a href="?m=paper_list"><img src="vendor/koala-framework/library-silkicons/user_add.png" /> View Papers</a></div>

                <div class="menu_item {if $menue=='cluster_list'}menu_item_selected{/if}">
                <a href="?m=cluster_list"><img src="vendor/koala-framework/library-silkicons/user_add.png" /> Cluster Lists</a></div>

                <div class="menu_item {if $menue=='student_list'}menu_item_selected{/if}">
			    <a href="?m=student_list"><img src="vendor/koala-framework/library-silkicons/user_add.png" /> Student List</a></div>

    	{/if}
        <div class="menu_head">▸ Administration</div>
        {if $loginlevel <1}
        	<div class="menu_item {if $menue=='session_login'}menu_item_selected{/if}">
			<a href="?m=session_login"><img src="vendor/koala-framework/library-silkicons/key.png" /> Log In</a></div>
	    {/if}
    	{if $loginlevel >= 1}
            <div class="menu_item {if $menue=='session_logout'}menu_item_selected{/if}"><a href="?m=session_logout"><img src="vendor/koala-framework/library-silkicons/lock_break.png" /> Sign out</a></div>
    	{/if}
    	{if $loginlevel >= 1}
            <div class="menu_item {if $menue=='user_list'}menu_item_selected{/if}">
			<a href="?m=user_list">
			<img src="vendor/koala-framework/library-silkicons/user.png" /> User Management</a></div>
            <div class="menu_item"><a href="#" onclick="init();"><img src="vendor/koala-framework/library-silkicons/wrench.png" /> System Parameters</a></div>
    	{/if}
      {if $loginlevel >= 1}
      <div class="menu_item {if $menue=='student_register'}menu_item_selected{/if}">
			<a href="?m=student_register"><img src="vendor/koala-framework/library-silkicons/page_add.png" />Register Student</a></div>
      {/if}

    </div>
