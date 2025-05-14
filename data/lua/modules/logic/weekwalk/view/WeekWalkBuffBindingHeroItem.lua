module("modules.logic.weekwalk.view.WeekWalkBuffBindingHeroItem", package.seeall)

local var_0_0 = class("WeekWalkBuffBindingHeroItem", HeroGroupEditItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)
	arg_1_0:enableDeselect(false)
end

function var_0_0._onItemClick(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_2_0._mo)
end

function var_0_0.onDestroy(arg_3_0)
	return
end

return var_0_0
