<table id="itemlist"  cellpadding="0" cellspacing="0" border="0" class="display" width="100%">
    <thead>
        <tr>
		    <th>ID</th>
            <th>Date Upload</th>
            <th>Date Moderated</th>
            <th>My ID</th>
            <th>Moderator ID</th>
            <th>Student's Number</th>
            <th>Coordinator ID</th>
            <th>Cluster ID</th>
            <th>Publish Status</th>
           <!---- <th>Attachments</th> --->
            <th>My Gradings</th>
            <th>Moderator Gradings</th>
            <!----<th>My Mark Sheet</th>
            <th>Moderator Mark Sheet</th>--->
        </tr>
    </thead>
    <thead>
        <tr>
            <td><input type="text" id="0" class="itemlist-input"></td>
            <td><input type="text" id="1" class="itemlist-input"></td>
            <td><input type="text" id="2" class="itemlist-input"></td>
            <td><input type="text" id="3" class="itemlist-input"></td>
            <td><input type="text" id="4" class="itemlist-input"></td>
            <td><input type="text" id="5" class="itemlist-input"></td>
            <td><input type="text" id="6" class="itemlist-input"></td>
            <td><input type="text" id="7" class="itemlist-input"></td>
            <td><input type="text" id="8" class="itemlist-input"></td>
            <td><input type="text" id="9" class="itemlist-input"></td>
            <td><input type="text" id="10" class="itemlist-input"></td>
           <!---- <td><input type="text" id="11" class="itemlist-input"></td>
            <td><input type="text" id="12" class="itemlist-input"></td>
            <td><input type="text" id="13" class="itemlist-input"></td> ---->
        </tr>
    </thead>
</table>

<a href="?m=lecturer_paper_create">
<input type="submit" name="a" value="Mark a Paper" />
</a>

<script type="text/javascript" language="javascript" >
    $(document).ready(function() {
        var dataTable = $('#itemlist').DataTable( {
            /*dom: 'Bfrtipl',
            buttons: [
                'selected',
                'selectAll',
                'selectNone',
            ],*/
            select: false,
            processing: true,
            serverSide: true,
            ajax:{
                //url :"api.php?source=papers", // json datasource
				url :"api.php?source=papers",
                type: "post",  // method  , by default get
                /*error: function(){  // error handling
                    $(".itemlist-error").html("");
                    $("#itemlist").append('<tbody class="itemlist-error"><tr><th colspan="14">No data found in the server</th></tr></tbody>');
                    $("#itemlist_processing").css("display","none");
                }*/
            },
            "order": [[ 3, "desc" ]]
        } );

        $('.itemlist-input').on( 'keyup click change', function () {
            var i =$(this).attr('id');  // getting column index
            var v =$(this).val();  // getting search input value
            dataTable.columns(i).search(v).draw();
        } );
    } );
</script>
