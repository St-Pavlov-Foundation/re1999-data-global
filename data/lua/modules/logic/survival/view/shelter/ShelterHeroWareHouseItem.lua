module("modules.logic.survival.view.shelter.ShelterHeroWareHouseItem", package.seeall)

local var_0_0 = class("ShelterHeroWareHouseItem", HeroGroupEditItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)
	arg_1_0._heroItem:setSelectFrameSize(245, 583, 0, -12)

	arg_1_0._gohp = gohelper.findChild(arg_1_1, "hpbg")

	arg_1_0:_initObj(arg_1_1)

	arg_1_0._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_1, SurvivalHeroHealthPart)
	arg_1_0._goRepreat = gohelper.findChild(arg_1_1, "#go_repeat")
	arg_1_0._goRound = gohelper.findChild(arg_1_1, "#go_round")
end

function var_0_0._initObj(arg_2_0, arg_2_1)
	arg_2_0._animator = arg_2_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
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
	arg_5_0._heroItem:setNewShow(false)
	arg_5_0._healthPart:setHeroId(arg_5_0._mo.heroId)
	arg_5_0._healthPart:setTxtHealthWhite()
	gohelper.setActive(arg_5_0._goRepreat, false)
	gohelper.setActive(arg_5_0._goRound, false)
end

function var_0_0._onItemClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	CharacterController.instance:openCharacterView(arg_6_0._mo)
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.getAnimator(arg_8_0)
	return arg_8_0._animator
end

return var_0_0
