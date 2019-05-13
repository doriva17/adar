<table id="itemlist"  cellpadding="0" cellspacing="0" border="0" class="display" width="100%">
    <thead>
        <tr>
           <th>LINK</th>
           <th>Date Uploaded</th>
            <th>Title</th>
            <th>Published Status</th>
            <th>Abstract</th>


        </tr>
    </thead>
    <!--thead>
        <tr>
            <td><input type="text" id="0" class="itemlist-input"></td>
            <td><input type="text" id="1" class="itemlist-input"></td>
            <td><input type="text" id="2" class="itemlist-input" ></td>
            <td><input type="text" id="3" class="itemlist-input" ></td>
            <td><input type="text" id="4" class="itemlist-input" ></td>

        </tr>
    </thead-->
</table>

<a href="?m=paper_create">
<input type="submit" name="a" value="Record a Paper" />
</a>

<script type="text/javascript" language="javascript" >
    $(document).ready(function() {
        var dataTable = $('#itemlist').DataTable( {

            select: false,
            processing: true,
            serverSide: true,
            ajax:{
                url :"api.php?source=papers", // json datasource
                type: "post",  // method  , by default get

            },
            "order": [[ 3, "desc" ]]
        } );


    } );
</script>
