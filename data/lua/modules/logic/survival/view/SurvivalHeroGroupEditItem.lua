module("modules.logic.survival.view.SurvivalHeroGroupEditItem", package.seeall)

local var_0_0 = class("SurvivalHeroGroupEditItem", HeroGroupEditItem)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)
	arg_1_0._heroItem:setSelectFrameSize(245, 583, 0, -12)

	arg_1_0._hptextwhite = gohelper.findChildText(arg_1_1, "hpbg/hptextwhite")
	arg_1_0._hptextred = gohelper.findChildText(arg_1_1, "hpbg/hptextred")
	arg_1_0._hpimage = gohelper.findChildImage(arg_1_1, "hpbg/hp")
	arg_1_0._gohp = gohelper.findChild(arg_1_1, "hpbg")

	arg_1_0:_initObj(arg_1_1)

	arg_1_0._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_1, SurvivalHeroHealthPart)
	arg_1_0._goRound = gohelper.findChild(arg_1_1, "#go_round")
	arg_1_0._roundText = gohelper.findChildText(arg_1_1, "#go_round/#txt_round")
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

	local var_8_1 = SurvivalHeroGroupEditListModel.instance:isInTeamHero(arg_8_0._mo.uid)

	arg_8_0._heroItem:setNewShow(false)
	arg_8_0._heroItem:setInteam(var_8_1)
	arg_8_0._healthPart:setHeroId(arg_8_0._mo.heroId)
	arg_8_0:refreshRound()
end

function var_0_0.updateTrialTag(arg_9_0)
	local var_9_0

	if arg_9_0._mo:isTrial() then
		var_9_0 = luaLang("herogroup_trial_tag0")
	end

	arg_9_0._heroItem:setTrialTxt(var_9_0)
end

function var_0_0.updateTrialRepeat(arg_10_0)
	local var_10_0 = HeroSingleGroupModel.instance:getById(arg_10_0._view.viewContainer.viewParam.singleGroupMOId)

	if var_10_0 and not var_10_0:isEmpty() and (var_10_0.trial and var_10_0:getTrialCO().heroId == arg_10_0._mo.heroId or not var_10_0.trial and (not var_10_0:getHeroCO() or var_10_0:getHeroCO().id == arg_10_0._mo.heroId)) then
		if not var_10_0.trial and not var_10_0.aid and not var_10_0:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(var_10_0.id))
		end

		arg_10_0._heroItem:setTrialRepeat(false)

		return
	end

	local var_10_1 = SurvivalHeroGroupEditListModel.instance:isRepeatHero(arg_10_0._mo.heroId, arg_10_0._mo.uid)

	arg_10_0._heroItem:setTrialRepeat(var_10_1)
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

	if arg_12_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if SurvivalHeroGroupEditListModel.instance:getSelectByIndex(arg_12_0._mo.heroId) ~= nil then
		GameFacade.showToast(ToastEnum.SurvivalOtherRoundSelect)

		return
	end

	local var_12_0 = HeroSingleGroupModel.instance:getById(arg_12_0._view.viewContainer.viewParam.singleGroupMOId)

	if arg_12_0._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(arg_12_0._mo.uid) and (var_12_0:isEmpty() or not var_12_0.trial) and SurvivalHeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_12_0._mo.isPosLock or not var_12_0:isEmpty() and var_12_0.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if HeroGroupModel.instance:isRestrict(arg_12_0._mo.uid) then
		local var_12_1 = HeroGroupModel.instance:getCurrentBattleConfig()
		local var_12_2 = var_12_1 and var_12_1.restrictReason

		if not string.nilorempty(var_12_2) then
			ToastController.instance:showToastWithString(var_12_2)
		end

		return
	end

	local var_12_3 = SurvivalShelterModel.instance:getWeekInfo()

	if arg_12_0._mo and var_12_3:getHeroMo(arg_12_0._mo.heroId).health == 0 then
		GameFacade.showToast(ToastEnum.SurvivalHeroDead)

		return
	end

	if arg_12_0._isSelect and arg_12_0._enableDeselect and not arg_12_0._mo.isPosLock then
		arg_12_0._view:selectCell(arg_12_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_12_0._view:selectCell(arg_12_0._index, true)
	end
end

function var_0_0.refreshRound(arg_13_0)
	local var_13_0 = SurvivalHeroGroupEditListModel.instance:getSelectByIndex(arg_13_0._mo.heroId)

	gohelper.setActive(arg_13_0._goRound, var_13_0 ~= nil)

	if var_13_0 ~= nil then
		arg_13_0._roundText.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_herogroup_round"), GameUtil.getNum2Chinese(var_13_0))
	end
end

function var_0_0.enableDeselect(arg_14_0, arg_14_1)
	arg_14_0._enableDeselect = arg_14_1
end

function var_0_0.onDestroy(arg_15_0)
	return
end

function var_0_0.getAnimator(arg_16_0)
	return arg_16_0._animator
end

return var_0_0
