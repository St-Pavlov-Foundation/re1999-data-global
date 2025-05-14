module("modules.logic.versionactivity2_5.challenge.view.Act183HeroGroupEditItem", package.seeall)

local var_0_0 = class("Act183HeroGroupEditItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gorepress = gohelper.findChild(arg_1_1, "go_repress")
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)
	arg_1_0:_initObj(arg_1_1)
end

function var_0_0._initObj(arg_2_0, arg_2_1)
	arg_2_0._heroItem:_setTxtWidth("_nameCnTxt", 180)

	arg_2_0._animator = arg_2_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._isSelect = false
	arg_2_0._enableDeselect = true

	transformhelper.setLocalScale(arg_2_1.transform, 0.8, 0.8, 1)
	arg_2_0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	arg_2_0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	arg_2_0._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	arg_2_0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	arg_2_0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	arg_2_0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
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

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0._heroItem:onUpdateMO(arg_6_1)

	if not arg_6_1:isTrial() then
		local var_6_0 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_6_1.heroId)

		if var_6_0 > arg_6_1.level then
			arg_6_0._heroItem:setBalanceLv(var_6_0)
		end
	end

	arg_6_0:updateTrialTag()
	arg_6_0:updateTrialRepeat()

	local var_6_1 = Act183HeroGroupEditListModel.instance:isInTeamHero(arg_6_0._mo.uid)

	arg_6_0._heroItem:setNewShow(false)
	arg_6_0._heroItem:setInteam(var_6_1)

	local var_6_2 = HeroGroupModel.instance.episodeId

	arg_6_0._isRepress = Act183Model.instance:isHeroRepressInPreEpisode(var_6_2, arg_6_0._mo.heroId)

	gohelper.setActive(arg_6_0._gorepress, arg_6_0._isRepress)
	arg_6_0._heroItem._commonHeroCard:setGrayScale(arg_6_0._isRepress)
end

function var_0_0.updateTrialTag(arg_7_0)
	local var_7_0

	if arg_7_0._mo:isTrial() then
		var_7_0 = luaLang("herogroup_trial_tag0")
	end

	arg_7_0._heroItem:setTrialTxt(var_7_0)
end

function var_0_0.updateTrialRepeat(arg_8_0)
	local var_8_0 = HeroSingleGroupModel.instance:getById(arg_8_0._view.viewContainer.viewParam.singleGroupMOId)

	if var_8_0 and not var_8_0:isEmpty() and (var_8_0.trial and var_8_0:getTrialCO().heroId == arg_8_0._mo.heroId or not var_8_0.trial and (not var_8_0:getHeroCO() or var_8_0:getHeroCO().id == arg_8_0._mo.heroId)) then
		if not var_8_0.trial and not var_8_0.aid and not var_8_0:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(var_8_0.id))
		end

		arg_8_0._heroItem:setTrialRepeat(false)

		return
	end

	local var_8_1 = Act183HeroGroupEditListModel.instance:isRepeatHero(arg_8_0._mo.heroId, arg_8_0._mo.uid)

	arg_8_0._heroItem:setTrialRepeat(var_8_1)
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	arg_9_0._isSelect = arg_9_1

	arg_9_0._heroItem:setSelect(arg_9_1)

	if arg_9_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_9_0._mo)
	end
end

function var_0_0._onItemClick(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_10_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if arg_10_0._isRepress then
		GameFacade.showToast(ToastEnum.Act183HeroRepress)

		return
	end

	local var_10_0 = HeroSingleGroupModel.instance:getById(arg_10_0._view.viewContainer.viewParam.singleGroupMOId)

	if arg_10_0._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(arg_10_0._mo.uid) and (var_10_0:isEmpty() or not var_10_0.trial) and Act183HeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_10_0._mo.isPosLock or not var_10_0:isEmpty() and var_10_0.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if HeroGroupModel.instance:isRestrict(arg_10_0._mo.uid) then
		local var_10_1 = HeroGroupModel.instance:getCurrentBattleConfig()
		local var_10_2 = var_10_1 and var_10_1.restrictReason

		if not string.nilorempty(var_10_2) then
			ToastController.instance:showToastWithString(var_10_2)
		end

		return
	end

	if arg_10_0._isSelect and arg_10_0._enableDeselect and not arg_10_0._mo.isPosLock then
		arg_10_0._view:selectCell(arg_10_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_10_0._view:selectCell(arg_10_0._index, true)
	end
end

function var_0_0.enableDeselect(arg_11_0, arg_11_1)
	arg_11_0._enableDeselect = arg_11_1
end

function var_0_0.onDestroy(arg_12_0)
	return
end

function var_0_0.getAnimator(arg_13_0)
	return arg_13_0._animator
end

return var_0_0
