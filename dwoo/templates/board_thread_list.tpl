<form id="delform_instant" action="{%KU_CGIPATH}/board.php" method="post">
<input type="hidden" name="board" value="{$board.name}" />
{foreach name=thread item=postsa from=$posts}
	{foreach key=postkey item=post from=$postsa}
		{if $post.parentid eq 0}
			<span id="unhidethread{$post.id}{$board.name}" style="display: none;">
			{t}Thread{/t} <a href="{%KU_BOARDSFOLDER}{$board.name}/res/{$post.id}.html">{$post.id}</a> {t}hidden.{/t}
			<a href="#" onclick="javascript:togglethread('{$post.id}');return false;" title="{t}Un-Hide Thread{/t}">
				<svg class="icon b-icon"><use xlink:href="#i-unhide"></use></svg>
			</a>
	</span>
	{if $post.IS_DELETED}
	{$thread_deleted = 1}
	<details class="deleted">
		<summary class="deleted" title="Тред удалён"></summary>
	{/if}
	<div id="thread{$post.id}{$board.name}" class="deleted_{$post.IS_DELETED}">
	<div class="postnode op">
	<script type="text/javascript"><!--
		if (localStorage['hiddenThreads.' + '{$board.name}'] && in_array('{$post.id}', localStorage['hiddenThreads.' + '{$board.name}'].split(',') ) ) {
			document.getElementById('unhidethread{$post.id}{$board.name}').style.display = 'inline-block';
			document.getElementById('thread{$post.id}{$board.name}').style.display = 'none';
		}
		//--></script>
			<a name="s{$.foreach.thread.iteration}"></a>
			
			{if ($post.file neq '' || $post.file_type neq '' ) && (($post.videobox eq '' && $post.file neq '') && $post.file neq 'removed')}
				<span class="filesize">
				{if $post.file_type eq 'mp3' or $post.file_type eq 'ogg'}
					{t}Audio{/t}
				{else}
					{t}File{/t}
				{/if}
				<a {if %KU_NEWWINDOW}target="_blank"{/if}	href="{$file_path}/src/{$post.file}.{$post.file_type}">
				{if isset($post.id3.comments_html)}
					{if $post.id3.comments_html.artist.0 neq ''}
					{$post.id3.comments_html.artist.0} -
					{/if}
					{if $post.id3.comments_html.title.0 neq ''}
						{$post.id3.comments_html.title.0}{else}{$post.file_original}{if $post.id3.comments_html.artist.0 eq ''}.{$post.file_type}{/if}{/if}</a>
				{else}
					{if $post.file_type eq 'mp3' or $post.file_type eq 'ogg' or $post.file_type eq 'swf'}{$post.file_original}{else}{$post.file}{/if}.{$post.file_type}</a>
				{/if}
				- ({$post.file_size_formatted}
				{if $post.id3.comments_html.bitrate neq 0 || $post.id3.audio.sample_rate neq 0}
					{if $post.id3.audio.bitrate neq 0}
						- {round($post.id3.audio.bitrate / 1000)} kbps
						{if $post.id3.audio.sample_rate neq 0}
							- 
						{/if}
					{/if}
					{if $post.id3.audio.sample_rate neq 0}
						{$post.id3.audio.sample_rate / 1000} kHz
					{/if}
				{/if}
				{if $post.image_w > 0 && $post.image_h > 0}
					, {$post.image_w}x{$post.image_h}
				{/if}
				)
				{if $post.id3.playtime_string neq ''}
					{t}Length{/t}: {$post.id3.playtime_string}
				{/if}
				</span>
				{if %KU_THUMBMSG}
					<span class="thumbnailmsg"> 
					{if $post.file_type neq 'jpg' && $post.file_type neq 'gif' && $post.file_type neq 'png' && $post.videobox eq ''}
						{t}Extension icon displayed, click image to open file.{/t}
					{else}
						{t}Thumbnail displayed, click image for full size.{/t}
					{/if}
					</span>
				{/if}
				<br />
			{/if}
			{if $post.videobox eq '' && $post.file neq '' && ( $post.file_type eq 'jpg' || $post.file_type eq 'gif' || $post.file_type eq 'png')}
				{if $post.file eq 'removed'}
					<div class="nothumb">
						{t}File<br />Removed{/t}
					</div>
				{else}
					<a 
					{if %KU_NEWWINDOW}
						target="_blank" 
					{/if}
					onclick="javascript: return expandimg('{$post.id}', '{$file_path}/src/{$post.file}.{$post.file_type}', '{$file_path}/thumb/{$post.file}s.{$post.file_type}', '{$post.image_w}', '{$post.image_h}', '{$post.thumb_w}', '{$post.thumb_h}');" 
					href="{$file_path}/src/{$post.file}.{$post.file_type}">
					<span id="thumb{$post.id}"><img loading="lazy" src="{$file_path}/thumb/{$post.file}s.{$post.file_type}" alt="{$post.id}" class="thumb" height="{$post.thumb_h}" width="{$post.thumb_w}" /></span>
					</a>
				{/if}
			{elseif $post.nonstandard_file neq ''}
				{if $post.file eq 'removed'}
					<div class="nothumb">
						{t}File<br />Removed{/t}
					</div>
				{else}
					<a
					{if $post.file_type eq 'webm'} class="movie" data-id="{$post.id}" data-thumb="{$post.nonstandard_file}" data-width="{$post.image_w}" data-height="{$post.image_h}"{/if}
					{if $post.file_type eq 'mp3' or $post.file_type eq 'ogg'} class="audiowrap" {/if}
					{if $post.file_type eq 'css'} class="csswrap" {/if}
					{if %KU_NEWWINDOW}
						target="_blank" 
					{/if}								
					href="{$file_path}/src/{$post.file}.{$post.file_type}">
					<span id="thumb{$post.id}"><img loading="lazy" src="{$post.nonstandard_file}" alt="{$post.id}" class="thumb" height="{$post.thumb_h}" width="{$post.thumb_w}" /></span>
					</a>
				{/if}
			{/if}
			<a name="{$post.id}"></a>
			<label class="postinfo">
			<input type="checkbox" name="post[]" value="{$post.id}" />
			{if $post.subject neq ''}
				<span class="filetitle">
					{$post.subject}
				</span>
			{/if}
			{strip}
				<span class="postername">
				
				{if $post.name eq '' && $post.tripcode eq ''}
					{$board.anonymous}
				{elseif $post.name eq '' && $post.tripcode neq ''}
				{else}
					{$post.name}
				{/if}

				</span>

				{if $post.tripcode neq ''}
					<span class="postertrip">!{$post.tripcode}</span>
				{/if}
			{/strip}
			{if $post.posterauthority eq 1}
				<span class="admin">
					&#35;&#35;&nbsp;{t}Admin{/t}&nbsp;&#35;&#35;
				</span>
			{elseif $post.posterauthority eq 4}
				<span class="mod">
					&#35;&#35;&nbsp;{t}Super Mod{/t}&nbsp;&#35;&#35;
				</span>
			{elseif $post.posterauthority eq 2}
				<span class="mod">
					&#35;&#35;&nbsp;{t}Mod{/t}&nbsp;&#35;&#35;
				</span>
			{/if}
			{$post.timestamp_formatted}
			</label>
			<span class="reflink">
				{$post.reflink}
			</span>
			{if $board.showid}<img src="data:image/png;base64,{rainbow($post.ipmd5, $post.id);}" />{/if}
			<span class="extrabtns">
			{if $post.locked eq 1}
				<svg class="icon i-icon i-lock"><use xlink:href="#i-lock"></use></svg>
			{/if}
			{if $post.stickied eq 1}
				<svg class="icon i-icon i-pin"><use xlink:href="#i-pin"></use></svg>
			{/if}
			<span id="hide{$post.id}">
			<a href="#" onclick="javascript:togglethread('{if $post.parentid eq 0}{$post.id}{else}{$post.parentid}{/if}');return false;" title="Hide Thread">
			<svg class="icon b-icon"><use xlink:href="#i-hide"></use></svg>
			</a>
			</span>
			{if %KU_QUICKREPLY}
				<a href="#" data-parent="{if $post.parentid eq 0}{$post.id}{else}{$post.parentid}{/if}" class="qrl" title="{t}Quick Reply{/t}">
				<svg class="icon b-icon"><use xlink:href="#i-qr"></use></svg>
				</a>
			{/if}
			{if $board.balls}
			<img loading="lazy" class="_country_" src="{%KU_WEBPATH}/images/flags/{$post.country}.png">
			{/if}
			</span>
			<span id="dnb-{$board.name}-{$post.id}-y"></span>
			[<a href="{%KU_BOARDSFOLDER}{$board.name}/res/{if $post.parentid eq 0}{$post.id}{else}{$post.parentid}{/if}.html">{if $post.locked eq 1}{t}Enter{/t}{else}{t}Reply{/t}{/if}</a>]
			{if %KU_FIRSTLAST && (($post.stickied eq 1 && $post.replies + %KU_REPLIESSTICKY > 50) || ($post.stickied eq 0 && $post.replies + %KU_REPLIES > 50))}
				{if (($post.stickied eq 1 && $post.replies + %KU_REPLIESSTICKY > 100) || ($post.stickied eq 0 && $post.replies + %KU_REPLIES > 100))}
					[<a href="{%KU_BOARDSFOLDER}{$board.name}/res/{if $post.parentid eq 0}{$post.id}{else}{$post.parentid}{/if}-100.html">{t}First 100 posts{/t}</a>]
				{/if}
				[<a href="{%KU_BOARDSFOLDER}{$board.name}/res/{$post.id}+50.html">{t}Last 50 posts{/t}</a>]
			{/if}
			<br />
		{else}
			{if $post.IS_DELETED}
			{$post_deleted = 1}
			<details class="deleted">
				<summary class="deleted" title="Пост удалён"></summary>
			{/if}
			<table class="postnode deleted_{$post.IS_DELETED}">
				<tbody>
				<tr>
					<td class="doubledash">
						&gt;&gt;
					</td>
					<td class="reply" id="reply{$post.id}">
						<a name="{$post.id}"></a>
						<label class="postinfo">
						<input type="checkbox" name="post[]" value="{$post.id}" />
						
						
						{if $post.subject neq ''}
							<span class="filetitle">
								{$post.subject}
							</span>
						{/if}
						{strip}
								<span class="postername">
								
								{if $post.name eq '' && $post.tripcode eq ''}
									{$board.anonymous}
								{elseif $post.name eq '' && $post.tripcode neq ''}
								{else}
									{$post.name}
								{/if}

								</span>

							{if $post.tripcode neq ''}
								<span class="postertrip">!{$post.tripcode}</span>
							{/if}
						{/strip}
						{if $post.posterauthority eq 1}
							<span class="admin">
								&#35;&#35;&nbsp;{t}Admin{/t}&nbsp;&#35;&#35;
							</span>
						{elseif $post.posterauthority eq 4}
							<span class="mod">
								&#35;&#35;&nbsp;{t}Super Mod{/t}&nbsp;&#35;&#35;
							</span>
						{elseif $post.posterauthority eq 2}
							<span class="mod">
								&#35;&#35;&nbsp;{t}Mod{/t}&nbsp;&#35;&#35;
							</span>
						{/if}

						{$post.timestamp_formatted}
						</label>
						<span class="reflink">
							{$post.reflink}
						</span>
						{if $board.showid}<img src="data:image/png;base64,{rainbow($post.ipmd5, $post.parentid);}" />{/if}
						<span class="extrabtns">
						{if %KU_QUICKREPLY}
						<a href="#" data-parent="{$post.parentid}" data-postnum="{$post.id}" class="qrl" title="{t}Quick Reply{/t} в тред {$post.parentid}">
							<svg class="icon b-icon"><use xlink:href="#i-qr"></use></svg>
						</a>
						{/if}
						{if $board.balls}
						<img loading="lazy" class="_country_" src="{%KU_WEBPATH}/images/flags/{$post.country}.png">
						{/if}
						{if $post.locked eq 1}
							<svg class="icon i-icon i-lock"><use xlink:href="#i-lock"></use></svg>
						{/if}
						{if $post.stickied eq 1}
							<svg class="icon i-icon i-pin"><use xlink:href="#i-pin"></use></svg>
						{/if}
						</span>
						<span id="dnb-{$board.name}-{$post.id}-n"></span>
						{if ($post.file neq '' || $post.file_type neq '' ) && (( $post.videobox eq '' && $post.file neq '') && $post.file neq 'removed')}
							<br />
							<span class="filesize">
							{if $post.file_type eq 'mp3' or $post.file_type eq 'ogg'}
								{t}Audio{/t}
							{else}
								{t}File{/t}
							{/if}
							<a {if %KU_NEWWINDOW}target="_blank"{/if}	href="{$file_path}/src/{$post.file}.{$post.file_type}">
							{if isset($post.id3.comments_html)}
								{if $post.id3.comments_html.artist.0 neq ''}
								{$post.id3.comments_html.artist.0} -
								{/if}
								{if $post.id3.comments_html.title.0 neq ''}
									{$post.id3.comments_html.title.0}{else}{$post.file_original}{if $post.id3.comments_html.artist.0 eq ''}.{$post.file_type}{/if}{/if}</a>
							{else}
								{if $post.file_type eq 'mp3' or $post.file_type eq 'ogg' or $post.file_type eq 'swf'}{$post.file_original}{else}{$post.file}{/if}.{$post.file_type}</a>
							{/if}
							- ({$post.file_size_formatted}
							{if $post.id3.comments_html.bitrate neq 0 || $post.id3.audio.sample_rate neq 0}
								{if $post.id3.audio.bitrate neq 0}
									- {round($post.id3.audio.bitrate / 1000)} kbps
									{if $post.id3.audio.sample_rate neq 0}
										- 
									{/if}
								{/if}
								{if $post.id3.audio.sample_rate neq 0}
									{$post.id3.audio.sample_rate / 1000} kHz
								{/if}
							{/if}
							{if $post.image_w > 0 && $post.image_h > 0}
								, {$post.image_w}x{$post.image_h}
							{/if}
							)
							{if $post.id3.playtime_string neq ''}
								{t}Length{/t}: {$post.id3.playtime_string}
							{/if}
							</span>
							{if %KU_THUMBMSG}
								<span class="thumbnailmsg"> 
								{if $post.file_type neq 'jpg' && $post.file_type neq 'gif' && $post.file_type neq 'png' && $post.videobox eq ''}
									{t}Extension icon displayed, click image to open file.{/t}
								{else}
									{t}Thumbnail displayed, click image for full size.{/t}
								{/if}
								</span>
							{/if}

						{/if}
						{if $post.videobox eq '' && $post.file neq '' && ( $post.file_type eq 'jpg' || $post.file_type eq 'gif' || $post.file_type eq 'png')}
							<br />
							{if $post.file eq 'removed'}
								<div class="nothumb">
									{t}File<br />Removed{/t}
								</div>
							{else}
								<a 
								{if %KU_NEWWINDOW}
									target="_blank" 
								{/if}
								onclick="javascript:return expandimg('{$post.id}', '{$file_path}/src/{$post.file}.{$post.file_type}', '{$file_path}/thumb/{$post.file}s.{$post.file_type}', '{$post.image_w}', '{$post.image_h}', '{$post.thumb_w}', '{$post.thumb_h}');" 
								href="{$file_path}/src/{$post.file}.{$post.file_type}">
								<span id="thumb{$post.id}"><img loading="lazy" src="{$file_path}/thumb/{$post.file}s.{$post.file_type}" alt="{$post.id}" class="thumb" height="{$post.thumb_h}" width="{$post.thumb_w}" /></span>
								</a>
							{/if}
						{elseif $post.nonstandard_file neq ''}
							<br />
							{if $post.file eq 'removed'}
								<div class="nothumb">
									{t}File<br />Removed{/t}
								</div>
							{else}
					{else}
					<a
					{if $post.file_type eq 'webm'} class="movie" data-id="{$post.id}" data-thumb="{$post.nonstandard_file}" data-width="{$post.image_w}" data-height="{$post.image_h}"{/if}
					{if $post.file_type eq 'mp3' or $post.file_type eq 'ogg'} class="audiowrap" {/if}
					{if $post.file_type eq 'css'} class="csswrap" {/if}
					{if %KU_NEWWINDOW}
						target="_blank" 
					{/if}								
					href="{$file_path}/src/{$post.file}.{$post.file_type}">
					<span id="thumb{$post.id}"><img loading="lazy" src="{$post.nonstandard_file}" alt="{$post.id}" class="thumb" height="{$post.thumb_h}" width="{$post.thumb_w}" /></span>
					</a>
							{/if}
						{/if}

		{/if}
		<blockquote class="postmessage">
		{if $post.videobox}
			{$post.videobox}
		{/if}
		{$post.message}
		<div class="replieslist"></div>
		</blockquote>
		{if not $post.stickied && $post.parentid eq 0 && (($board.maxage > 0 && ($post.timestamp + ($board.maxage * 3600)) < (time() + 7200 ) ) || ($post.deleted_timestamp > 0 && $post.deleted_timestamp <= (time() + 7200)))}
			<span class="oldpost">
				{t}Marked for deletion (old){/t}
			</span>
			<br />
		{/if}
		{if $post.parentid eq 0}
		</div>
			<div id="replies{$post.id}{$board.name}" class="replies deleted_{$post.IS_DELETED}">
			{if $post.replies}
				<span class="omittedposts">
				{if %KU_EXPAND}<a href="{%KU_BOARDSFOLDER}{$board.name}/res/{if $post.parentid eq 0}{$post.id}{else}{$post.parentid}{/if}.html" onclick="return expandthread('{if $post.parentid eq 0}{$post.id}{else}{$post.parentid}{/if}','{$board.name}', event)" title="{t}Expand Thread{/t}">{/if}
					{if $locale == 'ru'}
					{omitted_syntax($post.replies, $post.images)}
					{else}
						{if $post.stickied eq 0}
							{$post.replies}
							{if $post.replies eq 1}
								{t lower="yes"}Post{/t} 
							{else}
								{t lower="yes"}Posts{/t} 
							{/if}
						{else}
							{$post.replies}
							{if $post.replies eq 1}
								{t lower="yes"}Post{/t} 
							{else}
								{t lower="yes"}Posts{/t} 
							{/if}
						{/if}
						{if $post.images > 0}
							{t}and{/t} {$post.images}
							{if $post.images eq 1}
								{t lower="yes"}Image{/t} 
							{else}
								{t lower="yes"}Images{/t} 
							{/if}
						{/if}
					{t}omitted{/t}.{/if}{if %KU_EXPAND}</a>{/if}
					</span>
				{/if}
			{if $thread_deleted}
			</details>
			{/if}
			{else}
				</td>
			</tr>
		</tbody>
		</table>
		{if $post_deleted}
		{$post_deleted = 0}
		</details>
		{/if}
		{/if}
	{/foreach}
			</div>
			</div>

		{if $thread_deleted}
		<br clear="left deleted" />
		<hr class="deleted" />
		{else}
		<br clear="left" />
		<hr />
		{/if}
		{if $thread_deleted}
			{$thread_deleted = 0}
		{/if}

{/foreach}