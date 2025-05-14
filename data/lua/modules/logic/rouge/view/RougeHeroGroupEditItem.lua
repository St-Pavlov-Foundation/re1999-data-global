module("modules.logic.rouge.view.RougeHeroGroupEditItem", package.seeall)

local var_0_0 = class("RougeHeroGroupEditItem", RougeLuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._go = arg_1_1
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)

	arg_1_0._gohp = gohelper.findChild(arg_1_1, "#go_hp")

	gohelper.setActive(arg_1_0._gohp, false)

	arg_1_0._goassit = gohelper.findChild(arg_1_1, "assit")
	arg_1_0._sliderhp = gohelper.findChildSlider(arg_1_1, "#go_hp/#slider_hp")
	arg_1_0._godead = gohelper.findChild(arg_1_1, "#go_dead")
	arg_1_0._goframehp = gohelper.findChild(arg_1_1, "frame_hp")
	arg_1_0._itemAnimator = gohelper.onceAddComponent(arg_1_1, gohelper.Type_Animator)

	arg_1_0:_initCapacity()
	arg_1_0:_initObj(arg_1_1)
end

function var_0_0._initCapacity(arg_2_0)
	arg_2_0._gopoint = gohelper.findChild(arg_2_0._go, "volume/point")

	gohelper.setActive(arg_2_0._gopoint, false)

	arg_2_0._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0._go, RougeCapacityComp)

	arg_2_0._capacityComp:setSpriteType("rouge_team_volume_3", "rouge_team_volume_3")
	arg_2_0._capacityComp:setPoint(arg_2_0._gopoint)
	arg_2_0._capacityComp:initCapacity()
end

function var_0_0._initObj(arg_3_0, arg_3_1)
	arg_3_0._heroItem:_setTxtWidth("_nameCnTxt", 180)

	arg_3_0._animator = arg_3_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	arg_3_0._isSelect = false
	arg_3_0._enableDeselect = true

	transformhelper.setLocalScale(arg_3_1.transform, 0.8, 0.8, 1)
	arg_3_0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	arg_3_0._heroItem:_setTxtPos("_nameEnTxt", 0.55, 36.1)
	arg_3_0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	arg_3_0._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	arg_3_0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	arg_3_0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	arg_3_0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)

	arg_3_0._heroGroupEditListModel = RougeHeroGroupEditListModel.instance
	arg_3_0._heroGroupQuickEditListModel = HeroGroupQuickEditListModel.instance
	arg_3_0._heroSingleGroupModel = RougeHeroSingleGroupModel.instance
	arg_3_0._heroGroupModel = RougeHeroGroupModel.instance
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_4_0._onSkinChanged, arg_4_0)
	arg_4_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroEditItemSelectChange, arg_4_0.updateTrialRepeat, arg_4_0)
	arg_4_0:addEventCb(RougeController.instance, RougeEvent.OnSwitchHeroGroupEditMode, arg_4_0._onSwitchHeroGroupEditMode, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0._onSkinChanged(arg_6_0)
	arg_6_0._heroItem:updateHero()
end

function var_0_0.setAdventureBuff(arg_7_0, arg_7_1)
	arg_7_0._heroItem:setAdventureBuff(arg_7_1)
end

function var_0_0.updateLimitStatus(arg_8_0)
	if arg_8_0._heroGroupQuickEditListModel.adventure then
		gohelper.setActive(arg_8_0._gohp, false)

		local var_8_0 = WeekWalkModel.instance:getCurMapHeroCd(arg_8_0._mo.config.id)

		arg_8_0._heroItem:setInjury(var_8_0 > 0)
	else
		gohelper.setActive(arg_8_0._gohp, false)

		if arg_8_0._heroGroupModel:isRestrict(arg_8_0._mo.uid) then
			arg_8_0._heroItem:setRestrict(true)
		else
			arg_8_0._heroItem:setRestrict(false)
		end
	end
end

function var_0_0._updateCapacity(arg_9_0, arg_9_1)
	arg_9_0._capacity = RougeConfig1.instance:getRoleCapacity(arg_9_1.config.rare)

	if arg_9_0._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.FightAssit and RougeController.instance:useHalfCapacity() then
		local var_9_0 = RougeConfig1.instance:getRoleHalfCapacity(arg_9_1.config.rare)

		arg_9_0._capacityComp:updateMaxNumAndOpaqueNum(arg_9_0._capacity, var_9_0)

		arg_9_0._capacity = var_9_0

		return
	end

	arg_9_0._capacityComp:updateMaxNumAndOpaqueNum(arg_9_0._capacity, arg_9_0._capacity)
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1

	arg_10_0._heroItem:onUpdateMO(arg_10_1)
	arg_10_0:_updateCapacity(arg_10_1)

	if not arg_10_1:isTrial() then
		local var_10_0 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(arg_10_1.heroId)

		if var_10_0 > arg_10_1.level then
			arg_10_0._heroItem:setBalanceLv(var_10_0)
		end
	end

	arg_10_0:updateTrialTag()
	arg_10_0:updateTrialRepeat()

	local var_10_1 = arg_10_0._heroGroupEditListModel:isInTeamHero(arg_10_0._mo.uid)
	local var_10_2 = arg_10_0._heroGroupEditListModel:getTeamPosIndex(arg_10_0._mo.uid)
	local var_10_3 = arg_10_0._heroGroupEditListModel:getHeroGroupEditType()

	if var_10_3 == RougeEnum.HeroGroupEditType.FightAssit or var_10_3 == RougeEnum.HeroGroupEditType.Fight then
		local var_10_4 = var_10_1 == 1 and var_10_2 and var_10_2 > RougeEnum.FightTeamNormalHeroNum

		gohelper.setActive(arg_10_0._goassit, var_10_4)

		if var_10_4 then
			var_10_1 = nil
		end
	else
		gohelper.setActive(arg_10_0._goassit, false)
	end

	arg_10_0._heroItem:setNewShow(false)
	arg_10_0._heroItem:setInteam(var_10_1)
	arg_10_0:_updateHp()
	arg_10_0:tickUpdateDLCs(arg_10_1)
end

function var_0_0._isHideHp(arg_11_0)
	if arg_11_0._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.Init or arg_11_0._heroGroupEditListModel:getHeroGroupEditType() == RougeEnum.HeroGroupEditType.SelectHero then
		return true
	end
end

function var_0_0._updateHp(arg_12_0)
	if arg_12_0:_isHideHp() then
		return
	end

	local var_12_0 = RougeModel.instance:getTeamInfo():getHeroHp(arg_12_0._mo.heroId)

	if not var_12_0 then
		return
	end

	local var_12_1 = var_12_0 and var_12_0.life or 0

	gohelper.setActive(arg_12_0._gohp, true)
	arg_12_0._sliderhp:SetValue(var_12_1 / 1000)

	local var_12_2 = var_12_1 <= 0

	gohelper.setActive(arg_12_0._godead, var_12_2)
	arg_12_0._heroItem:setDamage(var_12_2)

	arg_12_0._heroItem._isInjury = false
	arg_12_0._isDead = var_12_2
end

function var_0_0.updateTrialTag(arg_13_0)
	local var_13_0

	if arg_13_0._mo:isTrial() then
		var_13_0 = luaLang("herogroup_trial_tag0")
	end

	arg_13_0._heroItem:setTrialTxt(var_13_0)
end

function var_0_0.updateTrialRepeat(arg_14_0)
	local var_14_0 = arg_14_0._heroSingleGroupModel:getById(arg_14_0._view.viewContainer.viewParam.singleGroupMOId)

	if var_14_0 and not var_14_0:isEmpty() and (var_14_0.trial and var_14_0:getTrialCO().heroId == arg_14_0._mo.heroId or not var_14_0.trial and (not var_14_0:getHeroCO() or var_14_0:getHeroCO().id == arg_14_0._mo.heroId)) then
		if not var_14_0.trial and not var_14_0.aid and not var_14_0:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(var_14_0.id))
		end

		arg_14_0._heroItem:setTrialRepeat(false)

		return
	end

	local var_14_1 = arg_14_0._heroGroupEditListModel:isRepeatHero(arg_14_0._mo.heroId, arg_14_0._mo.uid)

	arg_14_0._heroItem:setTrialRepeat(var_14_1)
end

function var_0_0.onSelect(arg_15_0, arg_15_1)
	arg_15_0._isSelect = arg_15_1

	local var_15_0 = arg_15_0:_isHideHp()

	arg_15_0._heroItem:setSelect(arg_15_1 and var_15_0)
	gohelper.setActive(arg_15_0._goframehp, arg_15_1 and not var_15_0)

	if arg_15_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_15_0._mo)
	end
end

function var_0_0._onItemClick(arg_16_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_16_0._isDead then
		GameFacade.showToast(ToastEnum.V1a6CachotToast04)

		return
	end

	if arg_16_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if not arg_16_0._heroGroupEditListModel:canAddCapacity(arg_16_0._view.viewContainer.viewParam.singleGroupMOId, arg_16_0._mo) then
		GameFacade.showToast(ToastEnum.RougeTeamCapacityFull)

		return
	end

	local var_16_0 = arg_16_0._heroSingleGroupModel:getById(arg_16_0._view.viewContainer.viewParam.singleGroupMOId)

	if arg_16_0._mo:isTrial() and not arg_16_0._heroSingleGroupModel:isInGroup(arg_16_0._mo.uid) and (var_16_0:isEmpty() or not var_16_0.trial) and arg_16_0._heroGroupEditListModel:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_16_0._mo.isPosLock or not var_16_0:isEmpty() and var_16_0.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_16_0._heroGroupModel:isRestrict(arg_16_0._mo.uid) then
		local var_16_1 = arg_16_0._heroGroupModel:getCurrentBattleConfig()
		local var_16_2 = var_16_1 and var_16_1.restrictReason

		if not string.nilorempty(var_16_2) then
			ToastController.instance:showToastWithString(var_16_2)
		end

		return
	end

	if arg_16_0._isSelect and arg_16_0._enableDeselect and not arg_16_0._mo.isPosLock then
		arg_16_0._view:selectCell(arg_16_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_16_0._view:selectCell(arg_16_0._index, true)
	end
end

function var_0_0.enableDeselect(arg_17_0, arg_17_1)
	arg_17_0._enableDeselect = arg_17_1
end

function var_0_0._onSwitchHeroGroupEditMode(arg_18_0)
	arg_18_0._itemAnimator:Play("rougeherogroupedititem_open", 0, 0)
	arg_18_0._animator:Play("open", 0, 0)
end

function var_0_0.onDestroy(arg_19_0)
	var_0_0.super.onDestroy(arg_19_0)
end

function var_0_0.getAnimator(arg_20_0)
	return arg_20_0._animator
end

return var_0_0
