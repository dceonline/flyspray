<h3><?php echo Filters::noXSS(L('changepass')); ?></h3>
<div class="box">
    <?php echo tpl_form(Filters::noXSS(CreateUrl('lostpw'))); ?>
    <ul class="form_elements wide">
      <li>
        <label for="pass1"><?php echo Filters::noXSS(L('changepass')); ?></label>
        <input class="password" id="pass1" type="password" value="<?php echo Filters::noXSS(Req::val('pass1')); ?>" name="pass1" size="20" />
      </li>
<?php if($fs->prefs['repeat_password']): ?>
      <li>
        <label for="pass2"><?php echo Filters::noXSS(L('confirmpass')); ?></label>
        <input class="password" id="pass2" type="password" value="<?php echo Filters::noXSS(Req::val('pass2')); ?>" name="pass2" size="20" />
      </li>
    </ul>
<?php endif;?>
      <div>
        <input type="hidden" name="action" value="lostpw.chpass" />
        <input type="hidden" name="magic_url" value="<?php echo Filters::noXSS(Req::val('magic_url')); ?>" />
        <button type="submit"><?php echo Filters::noXSS(L('savenewpass')); ?></button>
      </div>
    </form>
</div>

