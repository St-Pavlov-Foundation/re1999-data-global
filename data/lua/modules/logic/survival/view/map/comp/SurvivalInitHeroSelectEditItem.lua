module("modules.logic.survival.view.map.comp.SurvivalInitHeroSelectEditItem", package.seeall)

local var_0_0 = class("SurvivalInitHeroSelectEditItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)
	arg_1_0._heroItem:setKeepAnim()
	arg_1_0._heroItem:setSelectFrameSize(245, 583, 0, -12)

	arg_1_0._hptextwhite = gohelper.findChildText(arg_1_1, "hpbg/hptextwhite")
	arg_1_0._hptextred = gohelper.findChildText(arg_1_1, "hpbg/hptextred")
	arg_1_0._hpimage = gohelper.findChildImage(arg_1_1, "hpbg/hp")
	arg_1_0._gohp = gohelper.findChild(arg_1_1, "hpbg")
	arg_1_0._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_1, SurvivalHeroHealthPart)

	arg_1_0:_initObj(arg_1_1)
end

function var_0_0._initObj(arg_2_0, arg_2_1)
	arg_2_0._animator = arg_2_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._isSelect = false
	arg_2_0._enableDeselect = true

	transformhelper.setLocalScale(arg_2_1.transform, 0.8, 0.8, 1)
	arg_2_0._heroItem:setStyle_SurvivalHeroGroupEdit()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_3_0._onSkinChanged, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, arg_3_0.updateTrialRepeat, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0._onSkinChanged(arg_5_0)
	arg_5_0._heroItem:updateHero()
end

function var_0_0.setAdventureBuff(arg_6_0, arg_6_1)
	arg_6_0._heroItem:setAdventureBuff(arg_6_1)
end

function var_0_0.updateLimitStatus(arg_7_0)
	gohelper.setActive(arg_7_0._gohp, false)
	arg_7_0._heroItem:setRestrict(false)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0._heroItem:onUpdateMO(arg_8_1)

	if not arg_8_1:isTrial() then
		local var_8_0 = SurvivalBalanceHelper.getHeroBalanceLv(arg_8_1.heroId)

		if var_8_0 > arg_8_1.level then
			arg_8_0._heroItem:setBalanceLv(var_8_0)
		end
	end

	arg_8_0:updateLimitStatus()
	arg_8_0:updateTrialTag()
	arg_8_0:updateTrialRepeat()

	local var_8_1 = arg_8_0:getGroupModel():getMoIndex(arg_8_1)

	arg_8_0._heroItem:setNewShow(false)
	arg_8_0._heroItem:setInteam(var_8_1 > 0 and 1)
	arg_8_0._healthPart:setHeroId(arg_8_1.heroId)
end

function var_0_0.updateTrialTag(arg_9_0)
	local var_9_0

	if arg_9_0._mo:isTrial() then
		var_9_0 = luaLang("herogroup_trial_tag0")
	end

	arg_9_0._heroItem:setTrialTxt(var_9_0)
end

function var_0_0.updateTrialRepeat(arg_10_0)
	arg_10_0._heroItem:setTrialRepeat(false)
end

function var_0_0.onSelect(arg_11_0, arg_11_1)
	arg_11_0._isSelect = arg_11_1

	arg_11_0._heroItem:setSelect(arg_11_1)

	if arg_11_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_11_0._mo)
	end
end

function var_0_0._onItemClick(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_12_0._isSelect then
		arg_12_0._view:selectCell(arg_12_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		if SurvivalShelterModel.instance:getWeekInfo():getHeroMo(arg_12_0._mo.heroId).health == 0 then
			return
		end

		arg_12_0._view:selectCell(arg_12_0._index, true)
	end
end

function var_0_0.enableDeselect(arg_13_0, arg_13_1)
	arg_13_0._enableDeselect = arg_13_1
end

function var_0_0.onDestroy(arg_14_0)
	return
end

function var_0_0.getAnimator(arg_15_0)
	return arg_15_0._animator
end

function var_0_0.getGroupModel(arg_16_0)
	return SurvivalMapModel.instance:getInitGroup()
end

return var_0_0
