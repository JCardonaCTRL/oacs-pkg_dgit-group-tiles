<div class="col-sm-12">
  <div class="well">
	<if @tiles:rowcount@ gt 0>
	  <table class="table table-borderless" width="100%">
		<thead>
		  <tr>
			<th>Tile Name</th>
			<th>Tile Ref</th>
			<th>Tile Instance</th>
			<th>Version</th>
			<th>Action</th>
		  </tr>
		</thead>
		<tbody>
		  <multiple name="tiles">
			<tr>
			  <td>@tiles.app_code@</td>
			  <td>@tiles.package_key@</td>
			  <td>@tiles.instance_name@</td>
			  <td>@tiles.version_name@</td>
			  <td width="1%">@tiles.remove_link;noquote@</td>
			</tr>
		  </multiple>
		</tbody>
	  </table>
	</if>
	<else>
	  <p>No tiles assigned.</p>
	</else>
  </div>
</div>
