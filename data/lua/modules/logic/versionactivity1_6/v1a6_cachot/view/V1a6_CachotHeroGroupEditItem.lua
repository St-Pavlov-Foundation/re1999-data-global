module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupEditItem", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupEditItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)

	arg_1_0._hptextwhite = gohelper.findChildText(arg_1_1, "hpbg/hptextwhite")
	arg_1_0._hptextred = gohelper.findChildText(arg_1_1, "hpbg/hptextred")
	arg_1_0._hpimage = gohelper.findChildImage(arg_1_1, "hpbg/hp")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "#go_select")
	arg_1_0._gohp = gohelper.findChild(arg_1_1, "#go_hp")
	arg_1_0._sliderhp = gohelper.findChildSlider(arg_1_1, "#go_hp/#slider_hp")
	arg_1_0._godead = gohelper.findChild(arg_1_1, "#go_dead")

	gohelper.setActive(arg_1_0._goselect, false)
	gohelper.setActive(arg_1_0._gohp, false)
	gohelper.setActive(arg_1_0._godead, false)
	arg_1_0:_initObj(arg_1_1)
end

function var_0_0._initObj(arg_2_0, arg_2_1)
	arg_2_0._animator = arg_2_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._isSelect = false
	arg_2_0._enableDeselect = true

	transformhelper.setLocalScale(arg_2_1.transform, 0.8, 0.8, 1)

	arg_2_0._heroGroupModel = V1a6_CachotHeroGroupModel.instance
	arg_2_0._heroSingleGroupModel = V1a6_CachotHeroSingleGroupModel.instance
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
	if HeroGroupQuickEditListModel.instance.adventure then
		gohelper.setActive(arg_7_0._gohp, false)

		local var_7_0 = WeekWalkModel.instance:getCurMapHeroCd(arg_7_0._mo.config.id)

		arg_7_0._heroItem:setInjury(var_7_0 > 0)
	else
		gohelper.setActive(arg_7_0._gohp, false)

		if arg_7_0._heroGroupModel:isRestrict(arg_7_0._mo.uid) then
			arg_7_0._heroItem:setRestrict(true)
		else
			arg_7_0._heroItem:setRestrict(false)
		end
	end
end

function var_0_0._updateBySeatLevel(arg_8_0)
	local var_8_0 = arg_8_0._mo.level
	local var_8_1 = var_8_0
	local var_8_2 = V1a6_CachotHeroGroupEditListModel.instance:getSeatLevel()

	if var_8_2 then
		var_8_1 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_8_0._mo, var_8_2)
	end

	local var_8_3, var_8_4 = HeroConfig.instance:getShowLevel(var_8_1)
	local var_8_5 = var_8_0 ~= var_8_1

	arg_8_0._heroItem._lvTxt.text = tostring(var_8_3)

	local var_8_6
	local var_8_7
	local var_8_8 = "#FFFFFF"
	local var_8_9

	if var_8_5 then
		var_8_6 = "#bfdaff"
		var_8_9 = "#81abe5"
	else
		var_8_6 = "#E9E9E9"
		var_8_9 = "#F6F3EC"
	end

	if arg_8_0._isDead then
		var_8_8 = "#6F6F6F"
		var_8_6 = "#6F6F6F"
		var_8_9 = "#595959"
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._heroItem._lvTxt, var_8_6)
	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._heroItem._lvTxtEn, var_8_6)
	arg_8_0._heroItem:_fillStarContentColor(arg_8_0._mo.config.rare, var_8_4, var_8_9)
	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._heroItem._nameCnTxt, var_8_8)
	gohelper.setActive(arg_8_0._heroItem._maskgray, arg_8_0._isDead)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1

	arg_9_0._heroItem:onUpdateMO(arg_9_1)

	if not arg_9_1:isTrial() then
		local var_9_0 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_9_1.heroId)

		if var_9_0 > arg_9_1.level then
			arg_9_0._heroItem:setBalanceLv(var_9_0)
		end
	end

	arg_9_0:updateLimitStatus()
	arg_9_0:updateTrialTag()
	arg_9_0:updateTrialRepeat()

	local var_9_1 = V1a6_CachotHeroGroupEditListModel.instance:isInTeamHero(arg_9_0._mo.uid)

	arg_9_0._inTeam = var_9_1

	arg_9_0._heroItem:setNewShow(false)
	arg_9_0._heroItem:setInteam(var_9_1)
	arg_9_0:_updateCachot()
	arg_9_0:_updateBySeatLevel()
end

function var_0_0._updateCachot(arg_10_0)
	if V1a6_CachotHeroGroupEditListModel.instance:getHeroGroupEditType() == V1a6_CachotEnum.HeroGroupEditType.Init then
		return
	end

	local var_10_0 = V1a6_CachotModel.instance:getTeamInfo():getHeroHp(arg_10_0._mo.heroId)

	if not var_10_0 then
		return
	end

	local var_10_1 = var_10_0 and var_10_0.life or 0

	gohelper.setActive(arg_10_0._gohp, true)
	arg_10_0._sliderhp:SetValue(var_10_1 / 1000)

	local var_10_2 = var_10_1 <= 0

	gohelper.setActive(arg_10_0._godead, var_10_2)
	arg_10_0._heroItem:setDamage(var_10_2)

	arg_10_0._heroItem._isInjury = false
	arg_10_0._isDead = var_10_2
end

function var_0_0.updateTrialTag(arg_11_0)
	local var_11_0

	if arg_11_0._mo:isTrial() then
		var_11_0 = luaLang("herogroup_trial_tag0")
	end

	arg_11_0._heroItem:setTrialTxt(var_11_0)
end

function var_0_0.updateTrialRepeat(arg_12_0)
	local var_12_0 = arg_12_0._heroSingleGroupModel:getById(arg_12_0._view.viewContainer.viewParam.singleGroupMOId)

	if var_12_0 and not var_12_0:isEmpty() and (var_12_0.trial and var_12_0:getTrialCO().heroId == arg_12_0._mo.heroId or not var_12_0.trial and (not var_12_0:getHeroCO() or var_12_0:getHeroCO().id == arg_12_0._mo.heroId)) then
		if not var_12_0.trial and not var_12_0.aid and not var_12_0:getHeroCO() then
			logError("编队界面角色不存在 uid：" .. tostring(var_12_0.id))
		end

		arg_12_0._heroItem:setTrialRepeat(false)

		return
	end

	local var_12_1 = V1a6_CachotHeroGroupEditListModel.instance:isRepeatHero(arg_12_0._mo.heroId, arg_12_0._mo.uid)

	arg_12_0._heroItem:setTrialRepeat(var_12_1)
end

function var_0_0.onSelect(arg_13_0, arg_13_1)
	arg_13_0._isSelect = arg_13_1

	arg_13_0._heroItem:setSelect(arg_13_1)

	if arg_13_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_13_0._mo)
	end
end

function var_0_0._onItemClick(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_14_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local var_14_0 = arg_14_0._heroSingleGroupModel:getById(arg_14_0._view.viewContainer.viewParam.singleGroupMOId)

	if arg_14_0._mo:isTrial() and not arg_14_0._heroSingleGroupModel:isInGroup(arg_14_0._mo.uid) and (var_14_0:isEmpty() or not var_14_0.trial) and V1a6_CachotHeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_14_0._mo.isPosLock or not var_14_0:isEmpty() and var_14_0.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_14_0._heroGroupModel:isRestrict(arg_14_0._mo.uid) then
		local var_14_1 = arg_14_0._heroGroupModel:getCurrentBattleConfig()
		local var_14_2 = var_14_1 and var_14_1.restrictReason

		if not string.nilorempty(var_14_2) then
			ToastController.instance:showToastWithString(var_14_2)
		end

		return
	end

	if V1a6_CachotHeroGroupEditListModel.instance:getHeroGroupEditType() == V1a6_CachotEnum.HeroGroupEditType.Event and arg_14_0._inTeam then
		GameFacade.showToast(ToastEnum.V1a6CachotToast03)

		return
	end

	if arg_14_0._isSelect and arg_14_0._enableDeselect and not arg_14_0._mo.isPosLock then
		arg_14_0._view:selectCell(arg_14_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_14_0._view:selectCell(arg_14_0._index, true)
	end
end

function var_0_0.enableDeselect(arg_15_0, arg_15_1)
	arg_15_0._enableDeselect = arg_15_1
end

function var_0_0.onDestroy(arg_16_0)
	return
end

function var_0_0.getAnimator(arg_17_0)
	return arg_17_0._animator
end

return var_0_0
