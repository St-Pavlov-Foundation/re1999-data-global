module("modules.logic.versionactivity2_5.act186.view.Activity186GameHeroView", package.seeall)

local var_0_0 = class("Activity186GameHeroView", Activity186HeroView)

function var_0_0._onClick(arg_1_0)
	return
end

function var_0_0._onLightSpineLoaded(arg_2_0)
	arg_2_0._uiSpine:showModel()
	arg_2_0._uiSpine:setActionEventCb(arg_2_0._onAnimEnd, arg_2_0)
	arg_2_0._uiSpine:play("b_daoju", true)
	gohelper.setActive(arg_2_0._gocontentbg, true)
end

function var_0_0.showText(arg_3_0, arg_3_1)
	if string.nilorempty(arg_3_1) then
		gohelper.setActive(arg_3_0._gocontentbg, false)
	else
		gohelper.setActive(arg_3_0._gocontentbg, true)

		arg_3_0._txtanacn.text = arg_3_1
	end
end

return var_0_0
