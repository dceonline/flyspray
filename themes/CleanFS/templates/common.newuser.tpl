<?php
/* Note: This template file is currently in dual use for one of two guest register configurations
and also in admin area for admins.
May change in future because this sharing adds more complexity compared to little gain.
*/
if ($do === 'admin'): echo tpl_form(Filters::noXSS(CreateURL($do, 'newuser')),null,null,null,'id="registernewuser"');
                else: echo tpl_form(Filters::noXSS(CreateURL($do, 'newuser')),null,null,null,'id="registernewuser"');
endif; ?>
<ul class="form_elements">
		<li class="required">
			<?php if ($do === 'admin'): ?>
				<input type="hidden" name="action" value="admin.newuser" />
				<input type="hidden" name="do" value="admin" />
				<input type="hidden" name="area" value="newuser" />
			<?php else: ?>
				<input type="hidden" name="action" value="register.newuser" />
			<?php endif; ?>
			<label for="username"><?php echo Filters::noXSS(L('username')); ?>*</label>
			<input id="username" name="user_name" value="<?php echo Filters::noXSS(Req::val('user_name')); ?>" class="required text" type="text" size="20" maxlength="32" onblur="checkname(this.value);" />
			<br /><span id="errormessage"></span>
		</li>

	<?php if (!$fs->prefs['disable_changepw']): ?>
		<li>
			<label for="userpass"><?php echo Filters::noXSS(L('password')); ?></label>
			<input id="userpass" class="password" name="user_pass" value="<?php echo Filters::noXSS(Req::val('user_pass')); ?>" type="password" size="20" maxlength="100" /> <em><?php echo Filters::noXSS(L('minpwsize')); ?></em>
			<span class="note"><?php echo Filters::noXSS(L('leaveemptyauto')); ?></span>
		</li>
		<?php if( $do==='register' && $fs->prefs['repeat_password'] ): ?>
		<li>
			<label for="userpass2"><?php echo Filters::noXSS(L('confirmpass')); ?></label>
			<input id="userpass2" class="password" name="user_pass2" value="<?php echo Filters::noXSS(Req::val('user_pass2')); ?>" type="password" size="20" maxlength="100" /><br />
		</li>
		<?php endif; ?>
	<?php endif; ?>

		<li class="required">
			<label for="realname"><?php echo Filters::noXSS(L('realname')); ?>*</label>
			<input id="realname" name="real_name" class="required text" value="<?php echo Filters::noXSS(Req::val('real_name')); ?>" type="text" size="20" maxlength="100" />
		</li>
		
		<li class="required">
			<label for="emailaddress"><?php echo Filters::noXSS(L('emailaddress')); ?>*</label>
			<input id="emailaddress" name="email_address" class="text required" value="<?php echo Filters::noXSS(Req::val('email_address')); ?>" type="text" size="20" maxlength="100" />
			<!-- <em><?php echo Filters::noXSS(L('validemail')); ?></em> -->
		</li>

	<?php if( $do==='register' && $fs->prefs['repeat_emailaddress'] ): ?>
		<li>
			<label for="verifyemailaddress"><?php echo Filters::noXSS(L('verifyemailaddress')); ?></label>
			<input id="verifyemailaddress" value="<?php echo Filters::noXSS(Req::val('verify_email_address')); ?>" name="verify_email_address" class="required text" type="text" size="20" maxlength="100" />
		</li>
	<?php endif; ?>

	<?php if (!empty($fs->prefs['jabber_server'])): ?>
		<li>
			<label for="jabberid"><?php echo Filters::noXSS(L('jabberid')); ?></label>
			<input id="jabberid" name="jabber_id" class="text" type="text" value="<?php echo Filters::noXSS(Req::val('jabber_id')); ?>" size="20" maxlength="100" />
		</li>
	<?php endif ?>

	<?php if ($fs->prefs['enable_avatars']): ?>
		<li>
			<label for="profileimage"><?php echo Filters::noXSS(L('profileimage')); ?></label>
			<input id="profileimage" name="profile_image" type="file" value="<?php echo Filters::noXSS(Req::val('profile_image')); ?>"/>
		</li>
	<?php endif ?>

		<li>
			<label for="notify_type"><?php echo Filters::noXSS(L('notifications')); ?></label>
			<select id="notify_type" name="notify_type">
			<?php echo tpl_options($fs->GetNotificationOptions(), Req::val('notify_type')); ?>
			</select>
		</li>

		<li>
			<label for="time_zone"><?php echo Filters::noXSS(L('timezone')); ?></label>
			<select id="time_zone" name="time_zone">
			<?php
				$times = array();
				for ($i = -12; $i <= 13; $i++) {
					$times[$i] = L('GMT') . (($i == 0) ? ' ' : (($i > 0) ? '+' . $i : $i));
				}
			?>
			<?php echo tpl_options($times, Req::val('time_zone', 0)); ?>
			</select>
		</li>
		
		<?php if (isset($groups)): ?>
		<li>
			<label for="groupin"><?php echo Filters::noXSS(L('globalgroup')); ?></label>
			<select id="groupin" class="adminlist" name="group_in">
			<?php echo tpl_options($groups, Req::val('group_in', $fs->prefs['anon_group'])); ?>
			</select>
		</li>
		<?php endif; ?>

		<?php if($do==='register' && $fs->prefs['captcha_securimage']) : ?>
		<li class="captchali">
			<style>
			#captcha_code{width:100px;}
			.captchali .securimage label{width:auto;}
			.captchali .securimage {display:inline-block; width:300px;}
			</style>
			<label for="captcha_code"><?php echo Filters::noXSS(L('registercaptcha')); ?></label>
			<div class="securimage"><?php echo $captcha_securimage_html; ?></div>
		</li>
		<?php endif; ?>
	</ul>
	<?php
	/* only guests need captcha, not admins that currently this template file to add a user too. */
	if( $do==='register'
	    && isset($fs->prefs['captcha_recaptcha']) && $fs->prefs['captcha_recaptcha']
	    && isset($fs->prefs['captcha_recaptcha_sitekey']) && $fs->prefs['captcha_recaptcha_sitekey']
	    && isset($fs->prefs['captcha_recaptcha_secret']) && $fs->prefs['captcha_recaptcha_secret']): ?>
	<div class="g-recaptcha" data-sitekey="<?php echo Filters::noXSS($fs->prefs['captcha_recaptcha_sitekey']); ?>"></div>
	<noscript>Javascript is required for this Google reCAPTCHA.</noscript>     
	<?php endif; ?>
	<p><button type="submit" id="buSubmit"><?php echo Filters::noXSS(L('registeraccount')); ?></button></p>
</form>
