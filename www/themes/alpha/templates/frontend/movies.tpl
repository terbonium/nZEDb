{if {$site->adbrowse} != ''}
	<div class="container" style="width:500px;">
		<fieldset class="adbanner div-center">
			<legend class="adbanner">Advertisement</legend>
			{$site->adbrowse}
		</fieldset>
	</div>
	<br>
{/if}
<div class="panel">
	<div class="panel-heading">
		<h4 class="panel-title">
			<a
				class="accordion-toggle"
				data-toggle="collapse"
				data-parent="#accordion"
				href="#searchtoggle"
			><i class="icon-search"></i> Search Filter</a>
		</h4>
	</div>
	<div id="searchtoggle" class="panel-collapse collapse">
		<div class="panel-body">
			{include file='search-filter.tpl'}
		</div>
	</div>
</div>
{if $results|@count > 0}
	<form id="nzb_multi_operations_form" action="get">
	<div class="container nzb_multi_operations" style="text-align:right;margin-bottom:5px;">
		View:
		<span><i class="icon-th-list"></i></span>
		&nbsp;&nbsp;
		<a href="{$smarty.const.WWW_TOP}/browse?t={$category}"><i class="icon-align-justify"></i></a>
		{if $isadmin || $ismod}
			&nbsp;&nbsp;
			Admin:
			<button type="button" class="btn btn-warning nzb_multi_operations_edit">Edit</button>
			<button type="button" class="btn btn-danger nzb_multi_operations_delete">Delete</button>
		{/if}
	</div>
	{include file='multi-operations.tpl'}
	<table class="table table-striped table-condensed table-hover data icons" id="coverstable">
		<thead>
			<tr>
				<th><input type="checkbox" class="nzb_check_all"></th>
				<th>title<a title="Sort Descending" href="{$orderbytitle_desc}"><i class="icon-chevron-down icon-black"></i></a><a
							title="Sort Ascending" href="{$orderbytitle_asc}"><i class="icon-chevron-up icon-black"></i></a></th>
				<th>year<a title="Sort Descending" href="{$orderbyyear_desc}"><i class="icon-chevron-down icon-black"></i></a><a
							title="Sort Ascending" href="{$orderbyyear_asc}"><i class="icon-chevron-up icon-black"></i></a></th>
				<th>rating<a title="Sort Descending" href="{$orderbyrating_desc}"><i class="icon-chevron-down icon-black"></i></a><a
							title="Sort Ascending" href="{$orderbyrating_asc}"><i class="icon-chevron-up icon-black"></i></a></th>
			</tr>
		</thead>
		<tbody>
		{foreach from=$results item=result}
			<tr>
				<td colspan="1" style="vertical-align:top;text-align:center;width:160px;padding:10px;">
					<div class="movcover">
						<a
							target="_blank"
							href="{$smarty.const.WWW_TOP}/movies/?imdb={$result.imdbid}"
							name="name{$result.imdbid}"
							title="View movie info"
							class="modal_imdb thumbnail" rel="movie"
						><img
								class="shadow" style="margin: 3px 0;"
								src="{$smarty.const.WWW_TOP}/covers/movies/{if $result.cover == 1}{$result.imdbid}-cover.jpg{else}no-cover.jpg{/if}"
								width="160" border="0" alt="{$result.title|escape:"htmlall"}"
						></a>
						<div class="relextra" style="margin-top:5px;">
							<a
								target="_blank"
								href="{$site->dereferrer_link}http://www.imdb.com/title/tt{$result.imdbid}/"
								name="imdb{$result.imdbid}"
								title="View imdb page"><img src="{$smarty.const.WWW_TOP}/themes_shared/images/icons/imdb.png"></a>
							<a
								target="_blank"
								href="{$site->dereferrer_link}http://trakt.tv/search/imdb/tt{$result.imdbid}/"
								name="trakt{$result.imdbid}"
								title="View trakt page"
							><img src="{$smarty.const.WWW_TOP}/themes_shared/images/icons/trakt.png"></a>
							{if $cpurl != '' && $cpapi != ''}
								<a
									class="sendtocouch"
									target="blackhole"
									href="javascript:;"
									rel="{$cpurl}/api/{$cpapi}/movie.add/?identifier=tt{$result.imdbid}&title={$result.title}"
									name="CP{$result.imdbid}"
									title="Add to CouchPotato"
								><img src="{$smarty.const.WWW_TOP}/themes_shared/images/icons/couch.png"></a>
							{/if}
						</div>
						<hr>
						<div>
							<a
								class="label label-info"
								href="{$smarty.const.WWW_TOP}/search/{$result.title|escape:"url"}?t=2000"
								title="View similar nzbs"
							>Similar</a>
						</div>
					</div>
				</td>
				<td colspan="3" class="left" style="width:auto;white-space:normal;">
					<h2>
						<a
							title="{$result.title|stripslashes|escape:"htmlall"}"
							href="{$smarty.const.WWW_TOP}/movies/?imdb={$result.imdbid}">{$result.title|stripslashes|escape:"htmlall"}
						</a>
						(<a class="title" title="{$result.year}" href="{$smarty.const.WWW_TOP}/movies?year={$result.year}">{$result.year}</a>)
						{if $result.rating != ''}
							{$result.rating}/10
						{/if}
						{foreach from=$result.languages item=movielanguage}
							{release_flag($movielanguage, browse)}
						{/foreach}
					</h2>
					{if $result.tagline != ''}
						<b>{$result.tagline|stripslashes}</b>
						<br>
					{/if}
					{if $result.plot != ''}
						{$result.plot|stripslashes}
						<br>
					{/if}
					<br>
					{if $result.genre != ''}
						<b>Genre:</b>
						{$result.genre|stripslashes}
						<br>
					{/if}
					{if $result.director != ''}
						<b>Director:</b>
						{$result.director}
						<br>
					{/if}
					{if $result.actors != ''}
						<b>Starring:</b>
						{$result.actors}
						<br>
					{/if}
					<br>
					<div class="relextra">
						<table class="table table-condensed table-hover data">
							{assign var="msplits" value=","|explode:$result.grp_release_id}
							{assign var="mguid" value=","|explode:$result.grp_release_guid}
							{assign var="mnfo" value=","|explode:$result.grp_release_nfoid}
							{assign var="mgrp" value=","|explode:$result.grp_release_grpname}
							{assign var="mname" value="#"|explode:$result.grp_release_name}
							{assign var="mpostdate" value=","|explode:$result.grp_release_postdate}
							{assign var="msize" value=","|explode:$result.grp_release_size}
							{assign var="mtotalparts" value=","|explode:$result.grp_release_totalparts}
							{assign var="mcomments" value=","|explode:$result.grp_release_comments}
							{assign var="mgrabs" value=","|explode:$result.grp_release_grabs}
							{assign var="mpass" value=","|explode:$result.grp_release_password}
							{assign var="minnerfiles" value=","|explode:$result.grp_rarinnerfilecount}
							{assign var="mhaspreview" value=","|explode:$result.grp_haspreview}
							<tbody>
							{foreach from=$msplits item=m}
								<tr id="guid{$mguid[$m@index]}" {if $m@index > 1}class="mlextra"{/if}>
									<td style="width: 27px;">
										<input type="checkbox" class="nzb_check" value="{$mguid[$m@index]}">
									</td>
									<td class="name">
										<a href="{$smarty.const.WWW_TOP}/details/{$mguid[$m@index]}">
											<b>{$mname[$m@index]|escape:"htmlall"|wordwrap:80:"\n":true}</b>
										</a>
										<br>
										<div class="resextra">
											<div class="pull-left">
												<i class="icon-calendar"></i> Posted {$mpostdate[$m@index]|timeago} |
												<i class="icon-hdd"></i> {$msize[$m@index]|fsize_format:"MB"} |
												<i class="icon-file"></i>
												<a
													title="View file list"
													href="{$smarty.const.WWW_TOP}/filelist/{$mguid[$m@index]}">{$mtotalparts[$m@index]}
													files
												</a> |
												<i class="icon-comments"></i>
												<a
													title="View comments for {$mname[$m@index]|escape:"htmlall"}"
													href="{$smarty.const.WWW_TOP}/details/{$mguid[$m@index]}#comments">{$mcomments[$m@index]}
													cmt{if $mcomments[$m@index] != 1}s{/if}
												</a> |
												<i class="icon-download"></i> {$mgrabs[$m@index]} grab{if $mgrabs[$m@index] != 1}s{/if}
											</div>
											<div class="pull-right">
												{if $mnfo[$m@index] > 0}
													<span class="label label-default">
														<a
															href="{$smarty.const.WWW_TOP}/nfo/{$mguid[$m@index]}"
															title="View Nfo"
															class="modal_nfo"
															rel="nfo"
														><i class="icon-info-sign"></i></a></span
													>
												{/if}
												{if $mhaspreview[$m@index] == 1 && $userdata.canpreview == 1}
													<span class="label label-default">
														<a
															href="{$smarty.const.WWW_TOP}/covers/preview/{$mguid[$m@index]}_thumb.jpg"
															name="name{$mguid[$m@index]}"
															title="Screenshot of {$mname[$m@index]|escape:"htmlall"}"
															class="modal_prev"
															rel="preview"
														><i class="icon-camera"></i></a></span
													>
												{/if}
												{if $minnerfiles[$m@index] > 0}
													<span class="label label-default">
														<a
															href="#" onclick="return false;" class="mediainfo"
															title="{$mguid[$m@index]}"
														><i class="icon-list-alt"></i></a></span
													>
												{/if}
												<span class="label label-default">
													<a
														href="{$smarty.const.WWW_TOP}/browse?g={$mgrp[$m@index]}"
														title="Browse releases in {$mgrp[$m@index]}"
													><i class="icon-share-alt"></i></a></span
												>
												{if $mpass[$m@index] == 1}
													<span class="icon-stack" title="Potentially Passworded"><i class="icon-check-empty icon-stack-base"></i><i class="icon-unlock-alt"></i></span>
												{elseif $mpass[$m@index] == 2}
													<span class="icon-stack" title="Broken Post"><i class="icon-check-empty icon-stack-base"></i><i class="icon-unlink"></i></span>
												{elseif $mpass[$m@index] == 10}
													<span class="icon-stack" title="Passworded Archive"><i class="icon-check-empty icon-stack-base"></i><i class="icon-lock"></i></span>
												{/if}
											</div>
										</div>
									</td>
									<td class="icons" style="width:90px;">
										<div class="icon icon_nzb float-right">
											<a
												title="Download Nzb"
												href="{$smarty.const.WWW_TOP}/getnzb/{$mguid[$m@index]}"
											></a>
										</div>
										{if $sabintegrated}
											<div class="icon icon_sab float-right" title="Send to my Queue"></div>
										{/if}
										<div class="icon icon_cart float-right" title="Add to Cart"></div>
										<br>
										{*s{if $isadmin || $ismod}
										<a class="label label-warning" href="{$smarty.const.WWW_TOP}/admin/release-edit.php?id={$result.id}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}" title="Edit Release">Edit</a>
										<a class="label confirm_action label-danger" href="{$smarty.const.WWW_TOP}/admin/release-delete.php?id={$result.id}&amp;from={$smarty.server.REQUEST_URI|escape:"url"}" title="Delete Release">Delete</a>
										{/if}*}
									</td>
								</tr>
								{if $m@index == 1 && $m@total > 2}
									<tr>
										<td colspan="5">
											<a class="mlmore" href="#">{$m@total-2} more...</a>
										</td>
									</tr>
								{/if}
							{/foreach}
							</tbody>
						</table>
					</div>
				</td>
			</tr>
		{/foreach}
		</tbody>
	</table>
	{if $results|@count > 10}
		<div class="nzb_multi_operations">
			{include file='multi-operations.tpl'}
		</div>
	{/if}
	</form>
{else}
	<div class="alert alert-link" style="vertical-align:middle;">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<div class="pull-left" style="margin-right: 15px;">
			<h2 style="margin-top: 7px;"> ಠ_ಠ </h2>
		</div>
		<p>No movie releases have IMDB covers.
			<br>This might mean the Administrator's TMDB or TraktTV API keys are wrong, or he has file permission issues, or he has disabled looking up IMDB covers.
			<br>This could also mean there are no movie releases.
			<br>Please try looking in the
			<a href="{$smarty.const.WWW_TOP}/browse?t={$category}" style="font-weight:strong;text-decoration:underline;"
			>list view</a>, which does not require IMDB covers.
		</p>
	</div>
{/if}
