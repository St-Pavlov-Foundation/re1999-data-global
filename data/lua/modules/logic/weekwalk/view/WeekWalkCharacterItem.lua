module("modules.logic.weekwalk.view.WeekWalkCharacterItem", package.seeall)

local var_0_0 = class("WeekWalkCharacterItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)
	arg_1_0._heroItem:setStyle_CharacterBackpack()

	arg_1_0._goAnim = arg_1_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._hpbg = gohelper.findChild(arg_1_1, "hpbg")

	gohelper.setActive(arg_1_0._hpbg, false)

	arg_1_0._hptextwhite = gohelper.findChildText(arg_1_1, "hpbg/hptextwhite")
	arg_1_0._hptextred = gohelper.findChildText(arg_1_1, "hpbg/hptextred")
	arg_1_0._hpimage = gohelper.findChildImage(arg_1_1, "hpbg/hp")

	arg_1_0:_initObj()
end

function var_0_0._initObj(arg_2_0)
	return
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0._mo = arg_5_1

	arg_5_0._heroItem:onUpdateMO(arg_5_1)

	local var_5_0 = 1
	local var_5_1 = WeekWalkModel.instance:getInfo()

	if var_5_1 then
		local var_5_2 = var_5_1:getHeroHp(arg_5_0._mo.config.id)

		if var_5_2 then
			var_5_0 = var_5_2 / arg_5_0._mo.baseAttr.hp
		end
	end

	local var_5_3 = math.min(var_5_0, 1)

	arg_5_0._heroItem:setInjury(var_5_3 <= 0)

	local var_5_4 = var_5_1:getHeroBuff(arg_5_0._mo.heroId)

	arg_5_0._heroItem:setAdventureBuff(var_5_4)
end

function var_0_0._onItemClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_6_0 = {}
	local var_6_1 = arg_6_0._mo

	CharacterController.instance:openCharacterView(arg_6_0._mo)
end

function var_0_0.getAnimator(arg_7_0)
	return arg_7_0._goAnim
end

function var_0_0.onDestroy(arg_8_0)
	return
end

return var_0_0
