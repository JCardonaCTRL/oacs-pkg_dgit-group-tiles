<div class="col-sm-12">
  <div class="well">
	<if @groups:rowcount@ gt 0>
	  <table class="table table-borderless" width="100%">
		<thead>
		  <tr>
			<th>Group Name</th>
			<th>No. of Users</th>
            <th>Action</th>
		  </tr>
		</thead>
		<tbody>
		  <multiple name="groups">
			<tr>
			  <td>@groups.group_name@</td>
			  <td>@groups.num_of_users@</td>
              <td width="1%">@groups.remove_link;noquote@</td>
			</tr>
		  </multiple>
		</tbody>
	  </table>
	</if>
	<else>
	  <p>No groups assigned.</p>
	</else>
  </div>
</div>
