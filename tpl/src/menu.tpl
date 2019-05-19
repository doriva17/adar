
    <div id="menu">
        
            <div class="menu_head">▸ Dashboard</div>
            <div class="menu_item {if $menue=='content_list'}menu_item_selected{/if}">
			<a href="?m=content_list"><img src="vendor/koala-framework/library-silkicons/table.png" /> All Reports</a></div>
                  
        {if $loginlevel == ''}
        	<div class="menu_item {if $menue=='session_login'}menu_item_selected{/if}">
			<a href="?m=session_login"><img src="vendor/koala-framework/library-silkicons/key.png" /> Log In</a></div>
        {else}
            <div class="menu_head">▸ To capture</div>

	    <div class="menu_item {if $menue=='paper_create'}menu_item_selected{/if}">
			<a href="?m=paper_create"><img src="vendor/koala-framework/library-silkicons/page_add.png" /> Capture a Paper</a></div>
	    
    	    <div class="menu_head">▸ Students & Papers</div>
                <div class="menu_item {if $menue=='paper_list'}menu_item_selected{/if}">
			    <a href="?m=paper_list"><img src="vendor/koala-framework/library-silkicons/user_add.png" /> View Papers</a></div>

                <div class="menu_item {if $menue=='student_list'}menu_item_selected{/if}">
			    <a href="?m=student_list"><img src="vendor/koala-framework/library-silkicons/table.png" /> Student List</a></div>
                
    	
{if $loginlevel  == 'administrator' || $loginlevel  == 'coordinator' }
        <div class="menu_head">▸ Manage</div>
        
        <div class="menu_item {if $menue=='cluster_create'}menu_item_selected{/if}">
			<a href="?m=cluster_create"><img src="vendor/koala-framework/library-silkicons/page_add.png" /> New Cluster</a></div>

                <div class="menu_item {if $menue=='cluster_list'}menu_item_selected{/if}">
                <a href="?m=cluster_list"><img src="vendor/koala-framework/library-silkicons/user_add.png" /> Cluster Lists</a></div>
{/if}        
        
    	{if $loginlevel  == 'administrator'}
        <div class="menu_head">▸ Administration</div>

            <div class="menu_item {if $menue=='user_list'}menu_item_selected{/if}">
			<a href="?m=user_list">
			<img src="vendor/koala-framework/library-silkicons/user.png" /> User Management</a></div>
            <div class="menu_item"><a href="#" onclick="init();"><img src="vendor/koala-framework/library-silkicons/wrench.png" /> System Parameters</a></div>
    	
        {/if}
        
            <div class="menu_item {if $menue=='session_logout'}menu_item_selected{/if}"><a href="?m=session_logout"><img src="vendor/koala-framework/library-silkicons/lock_break.png" /> Sign out</a></div>        
	    {/if}

    </div>
