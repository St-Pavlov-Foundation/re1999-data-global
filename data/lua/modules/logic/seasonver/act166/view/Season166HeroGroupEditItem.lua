module("modules.logic.seasonver.act166.view.Season166HeroGroupEditItem", package.seeall)

local var_0_0 = class("Season166HeroGroupEditItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)

	arg_1_0._goSelectState = gohelper.findChild(arg_1_1, "selectState")
	arg_1_0._goCurSelect = gohelper.findChild(arg_1_1, "selectState/go_currentSelect")
	arg_1_0._goMainSelect = gohelper.findChild(arg_1_1, "selectState/go_mainSelect")
	arg_1_0._goHelpSelect = gohelper.findChild(arg_1_1, "selectState/go_helpSelect")

	arg_1_0:_initObj(arg_1_1)
end

function var_0_0._initObj(arg_2_0, arg_2_1)
	arg_2_0._animator = arg_2_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._itemAnim = arg_2_1:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._itemAnim.keepAnimatorControllerStateOnDisable = true
	arg_2_0._itemAnim.speed = 0
	arg_2_0._isFirstEnter = true
	arg_2_0._isSelect = false
	arg_2_0._enableDeselect = true

	transformhelper.setLocalScale(arg_2_1.transform, 0.8, 0.8, 1)
end

var_0_0.CurSelectItem = 2
var_0_0.OtherSelectItem = 1

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_3_0._onAttributeChanged, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_3_0._onSkinChanged, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, arg_3_0.updateTrialRepeat, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_4_0._onAttributeChanged, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_4_0._onSkinChanged, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, arg_4_0.updateTrialRepeat, arg_4_0)
end

function var_0_0._onSkinChanged(arg_5_0)
	arg_5_0._heroItem:updateHero()
end

function var_0_0._onAttributeChanged(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._heroItem:setLevel(arg_6_1, arg_6_2)
end

function var_0_0.setAdventureBuff(arg_7_0, arg_7_1)
	arg_7_0._heroItem:setAdventureBuff(arg_7_1)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0._heroItem:onUpdateMO(arg_8_1)

	if arg_8_0._isFirstEnter then
		arg_8_0._isFirstEnter = false

		local var_8_0 = Season166HeroGroupEditModel.instance:getIndex(arg_8_0._mo)

		TaskDispatcher.runDelay(arg_8_0.playEnterAnim, arg_8_0, math.ceil((var_8_0 - 1) % 5) * 0.001)
	end

	if not arg_8_1:isTrial() then
		local var_8_1 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_8_1.heroId)

		if var_8_1 > arg_8_1.level then
			arg_8_0._heroItem:setBalanceLv(var_8_1)
		end
	end

	local var_8_2 = Season166HeroGroupEditModel.instance:isInTeamHero(arg_8_0._mo.uid)

	arg_8_0._heroItem:setNewShow(false)
	arg_8_0:refreshSelectState(var_8_2)
	arg_8_0:updateTrialTag()
	arg_8_0:updateTrialRepeat()
end

function var_0_0.playEnterAnim(arg_9_0)
	arg_9_0._itemAnim.speed = 1

	TaskDispatcher.cancelTask(arg_9_0.playEnterAnim, arg_9_0)
end

function var_0_0.checkIsAssist(arg_10_0)
	local var_10_0 = Season166HeroSingleGroupModel.instance.assistMO

	return var_10_0 and arg_10_0._mo.uid == var_10_0.heroUid
end

function var_0_0.updateTrialTag(arg_11_0)
	local var_11_0

	if arg_11_0._mo:isTrial() then
		var_11_0 = luaLang("herogroup_trial_tag0")
	end

	arg_11_0._heroItem:setTrialTxt(var_11_0)
end

function var_0_0.updateTrialRepeat(arg_12_0)
	local var_12_0 = Season166HeroSingleGroupModel.instance.assistMO
	local var_12_1 = Season166HeroSingleGroupModel.instance:getById(arg_12_0._view.viewContainer.viewParam.singleGroupMOId)

	if var_12_0 and var_12_1 and var_12_1.heroUid == var_12_0.heroUid then
		return
	end

	if var_12_1 and not var_12_1:isEmpty() and (var_12_1.trial and var_12_1:getTrialCO().heroId == arg_12_0._mo.heroId or not var_12_1.trial and (not var_12_1:getHeroCO() or var_12_1:getHeroCO().id == arg_12_0._mo.heroId)) then
		if not var_12_1.trial and not var_12_1.aid and not var_12_1:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(var_12_1.id))
		end

		arg_12_0._heroItem:setTrialRepeat(false)

		return
	end

	local var_12_2 = Season166HeroGroupEditModel.instance:isRepeatHero(arg_12_0._mo.heroId, arg_12_0._mo.uid)

	arg_12_0._heroItem:setTrialRepeat(var_12_2)
end

function var_0_0.refreshSelectState(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._goCurSelect, arg_13_1 == var_0_0.CurSelectItem)

	local var_13_0, var_13_1 = Season166HeroSingleGroupModel.instance:checkIsMainHero(arg_13_0._mo.uid)

	gohelper.setActive(arg_13_0._goMainSelect, var_13_0 and arg_13_1 == var_0_0.OtherSelectItem)
	gohelper.setActive(arg_13_0._goHelpSelect, not var_13_0 and var_13_1 ~= 0 and arg_13_1 == var_0_0.OtherSelectItem)
end

function var_0_0.onSelect(arg_14_0, arg_14_1)
	arg_14_0._isSelect = arg_14_1

	arg_14_0._heroItem:setSelect(arg_14_1)

	if arg_14_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_14_0._mo)
	end
end

function var_0_0._onItemClick(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_15_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local var_15_0 = Season166HeroSingleGroupModel.instance:getById(arg_15_0._view.viewContainer.viewParam.singleGroupMOId)

	if arg_15_0._mo:isTrial() and not Season166HeroSingleGroupModel.instance:isInGroup(arg_15_0._mo.uid) and (var_15_0:isEmpty() or not var_15_0.trial) and Season166HeroGroupEditModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_15_0._mo.isPosLock or not var_15_0:isEmpty() and var_15_0.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_15_0._isSelect and arg_15_0._enableDeselect then
		arg_15_0._view:selectCell(arg_15_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_15_0._view:selectCell(arg_15_0._index, true)
	end
end

function var_0_0.enableDeselect(arg_16_0, arg_16_1)
	arg_16_0._enableDeselect = arg_16_1
end

function var_0_0.onDestroy(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.playEnterAnim, arg_17_0)
end

function var_0_0.getAnimator(arg_18_0)
	return arg_18_0._animator
end

return var_0_0
