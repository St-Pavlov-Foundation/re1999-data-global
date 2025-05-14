module("modules.logic.herogroup.view.HeroGroupListView", package.seeall)

local var_0_0 = class("HeroGroupListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.heroContainer = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/area")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/hero/heroitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	local var_2_0 = HeroGroupModel.instance.battleId
	local var_2_1 = lua_battle.configDict[var_2_0]

	arg_2_0._playerMax = var_2_1.playerMax
	arg_2_0._roleNum = var_2_1.roleNum
	arg_2_0._heroItemList = {}

	gohelper.setActive(arg_2_0._goheroitem, false)

	arg_2_0.heroPosTrList = arg_2_0:getUserDataTb_()
	arg_2_0._heroItemPosList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_2_2 = gohelper.findChild(arg_2_0.heroContainer, "pos" .. iter_2_0 .. "/container").transform
		local var_2_3 = gohelper.cloneInPlace(arg_2_0._goheroitem, "item" .. iter_2_0)
		local var_2_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_3, arg_2_0:_getHeroItemCls(), arg_2_0)

		var_2_4:setIndex(iter_2_0)
		table.insert(arg_2_0.heroPosTrList, var_2_2)
		table.insert(arg_2_0._heroItemList, var_2_4)
		gohelper.setActive(var_2_3, true)
		arg_2_0:_setHeroItemPos(var_2_4, iter_2_0)
		table.insert(arg_2_0._heroItemPosList, var_2_4.go.transform)
		var_2_4:setParent(arg_2_0.heroPosTrList[iter_2_0])
		CommonDragHelper.instance:registerDragObj(var_2_4.go, arg_2_0._onBeginDrag, nil, arg_2_0._onEndDrag, arg_2_0._checkCanDrag, arg_2_0, iter_2_0)
	end

	arg_2_0._bgList = arg_2_0:getUserDataTb_()
	arg_2_0._orderList = arg_2_0:getUserDataTb_()

	local var_2_5 = HeroGroupModel.instance:positionOpenCount()
	local var_2_6 = HeroGroupModel.instance:getBattleRoleNum()

	if var_2_6 then
		var_2_5 = math.min(var_2_6, var_2_5)
	end

	local var_2_7 = math.min(arg_2_0._playerMax, var_2_5)

	arg_2_0._openCount = var_2_7

	for iter_2_1 = 1, 4 do
		local var_2_8 = gohelper.findChild(arg_2_0.viewGO, "herogroupcontain/hero/bg" .. iter_2_1 .. "/bg")

		table.insert(arg_2_0._bgList, var_2_8)

		local var_2_9 = gohelper.findChildTextMesh(arg_2_0.viewGO, "herogroupcontain/hero/bg" .. iter_2_1 .. "/bg/#txt_order")

		var_2_9.text = iter_2_1 <= var_2_7 and tostring(iter_2_1) or ""

		table.insert(arg_2_0._orderList, var_2_9)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(arg_2_0._heroItemPosList)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_3_0._checkRestrictHero, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_3_0._checkRestrictHero, arg_3_0)
	arg_3_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenSizeChange, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenSizeChange, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_4_0._checkRestrictHero, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_4_0._checkRestrictHero, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._isOpen = true

	arg_5_0:_updateHeroList()
	arg_5_0:_playOpenAnimation()
	arg_5_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, arg_5_0._onHeroGroupExit, arg_5_0)
end

function var_0_0._playOpenAnimation(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.heroPosTrList) do
		if iter_6_1 then
			local var_6_0 = iter_6_1.gameObject:GetComponent(typeof(UnityEngine.Animator))

			var_6_0:Play(UIAnimationName.Open)
			var_6_0:Update(0)

			var_6_0.speed = 1
		end
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._heroItemList) do
		if iter_6_3 then
			local var_6_1 = iter_6_3.anim

			var_6_1:Play(UIAnimationName.Open)
			var_6_1:Update(0)

			var_6_1.speed = 1
		end
	end

	for iter_6_4, iter_6_5 in ipairs(arg_6_0._bgList) do
		if iter_6_5 then
			local var_6_2 = iter_6_5:GetComponent(typeof(UnityEngine.Animator))

			var_6_2:Play(UIAnimationName.Open)
			var_6_2:Update(0)

			var_6_2.speed = 1
		end
	end

	arg_6_0:_checkRestrictHero()
end

function var_0_0._getHeroItemCls(arg_7_0)
	return HeroGroupHeroItem
end

function var_0_0._checkRestrictHero(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, 4 do
		local var_8_1 = HeroSingleGroupModel.instance:getById(iter_8_0)

		if var_8_1 and HeroGroupModel.instance:isRestrict(var_8_1.heroUid) then
			var_8_0[var_8_1.heroUid] = true
		end
	end

	if tabletool.len(var_8_0) <= 0 then
		return
	end

	local var_8_2 = HeroGroupModel.instance:getCurrentBattleConfig()
	local var_8_3 = var_8_2 and var_8_2.restrictReason

	if not string.nilorempty(var_8_3) then
		ToastController.instance:showToastWithString(var_8_3)
	end

	for iter_8_1, iter_8_2 in ipairs(arg_8_0._heroItemList) do
		iter_8_2:playRestrictAnimation(var_8_0)
	end

	arg_8_0.needRemoveHeroUidDict = var_8_0

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(arg_8_0._removeRestrictHero, arg_8_0, 1.5)
end

function var_0_0._removeRestrictHero(arg_9_0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not arg_9_0.needRemoveHeroUidDict then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0.needRemoveHeroUidDict) do
		HeroSingleGroupModel.instance:remove(iter_9_0)
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0._heroItemList) do
		iter_9_3:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._onHeroGroupExit(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if arg_10_0._openTweenIdList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_10_1)
		end
	end

	arg_10_0._closeTweenIdList = {}

	for iter_10_2 = 1, 4 do
		local var_10_0 = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - iter_10_2), nil, arg_10_0._closeTweenFinish, arg_10_0, iter_10_2, EaseType.Linear)

		table.insert(arg_10_0._closeTweenIdList, var_10_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(arg_10_0.viewName, false, false)
end

function var_0_0._closeTweenFinish(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.heroPosTrList[arg_11_1]

	if var_11_0 then
		local var_11_1 = var_11_0.gameObject:GetComponent(typeof(UnityEngine.Animator))

		var_11_1:Play(UIAnimationName.Close)

		var_11_1.speed = 1
	end

	local var_11_2 = arg_11_0._heroItemList[arg_11_1]

	if var_11_2 then
		local var_11_3 = var_11_2.anim

		var_11_3:Play(UIAnimationName.Close)

		var_11_3.speed = 1
	end

	local var_11_4 = arg_11_0._bgList[arg_11_1]

	if var_11_4 then
		local var_11_5 = var_11_4:GetComponent(typeof(UnityEngine.Animator))

		var_11_5:Play(UIAnimationName.Close)

		var_11_5.speed = 1
	end
end

function var_0_0.canDrag(arg_12_0, arg_12_1, arg_12_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_0._heroItemList[var_12_0]

	if var_12_1.isAid then
		return false
	end

	if var_12_1.isTrialLock then
		return false
	end

	if not arg_12_2 and (var_12_1.mo:isEmpty() or var_12_1.mo.aid == -1 or arg_12_1 > HeroGroupModel.instance:positionOpenCount()) then
		return false
	end

	return true
end

function var_0_0._checkCanDrag(arg_13_0, arg_13_1)
	if not arg_13_0:canDrag(arg_13_1) then
		if arg_13_0._heroItemList[arg_13_1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return true
	end
end

function var_0_0._onBeginDrag(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._tweening then
		return
	end

	if not arg_14_0:canDrag(arg_14_1) then
		return
	end

	if arg_14_0._nowDragingIndex then
		return
	end

	if arg_14_1 <= arg_14_0._openCount then
		arg_14_0._orderList[arg_14_1].text = arg_14_1
	end

	arg_14_0._nowDragingIndex = arg_14_1

	local var_14_0 = arg_14_0._heroItemList[arg_14_1]

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._heroItemList) do
		iter_14_1:onItemBeginDrag(arg_14_1)
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_0._heroItemList) do
		iter_14_3:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(var_14_0.go)
end

function var_0_0._onEndDrag(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:canDrag(arg_15_1) then
		return
	end

	if arg_15_0._nowDragingIndex ~= arg_15_1 then
		return
	end

	arg_15_0._nowDragingIndex = nil

	local var_15_0 = arg_15_0:_calcIndex(arg_15_2.position)
	local var_15_1 = arg_15_0._heroItemList[arg_15_1]
	local var_15_2 = arg_15_1

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._heroItemList) do
		iter_15_1:onItemEndDrag(var_15_2, var_15_0)
	end

	CommonDragHelper.instance:setGlobalEnabled(false)

	if var_15_0 == arg_15_1 or var_15_0 <= 0 then
		arg_15_0._orderList[arg_15_1].text = ""
	end

	local function var_15_3(arg_16_0, arg_16_1)
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._heroItemList) do
			iter_16_1:onItemCompleteDrag(var_15_2, var_15_0, arg_16_1)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)

		for iter_16_2, iter_16_3 in ipairs(arg_16_0._heroItemList) do
			iter_16_3:flowCurrentParent()
		end
	end

	if var_15_0 <= 0 then
		arg_15_0:_setHeroItemPos(var_15_1, var_15_2, true, var_15_3, arg_15_0)

		return
	end

	if not arg_15_0:canDrag(var_15_0, true) then
		local var_15_4 = arg_15_0._heroItemList[var_15_0]

		if var_15_4 and var_15_4.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		arg_15_0:_setHeroItemPos(var_15_1, var_15_2, true, var_15_3, arg_15_0)

		return
	end

	if var_15_0 <= 0 then
		arg_15_0:_setHeroItemPos(var_15_1, var_15_2, true, var_15_3, arg_15_0)

		return
	end

	local var_15_5 = HeroGroupModel.instance.battleId
	local var_15_6 = var_15_5 and lua_battle.configDict[var_15_5]

	if var_15_0 > HeroGroupModel.instance:positionOpenCount() then
		arg_15_0:_setHeroItemPos(var_15_1, var_15_2, true, var_15_3, arg_15_0)

		local var_15_7, var_15_8 = HeroGroupModel.instance:getPositionLockDesc(var_15_0)

		GameFacade.showToast(var_15_7, var_15_8)

		return
	end

	local var_15_9 = HeroGroupModel.instance:getBattleRoleNum()

	if var_15_9 and var_15_9 < var_15_0 then
		arg_15_0:_setHeroItemPos(var_15_1, var_15_2, true, var_15_3, arg_15_0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if var_15_6 and var_15_1.mo.aid and var_15_0 > var_15_6.playerMax then
		arg_15_0:_setHeroItemPos(var_15_1, var_15_2, true, var_15_3, arg_15_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local var_15_10 = arg_15_0._heroItemList[var_15_0]

	if var_15_10.mo.aid then
		arg_15_0:_setHeroItemPos(var_15_1, var_15_2, true, var_15_3, arg_15_0)

		return
	end

	if var_15_2 ~= var_15_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(var_15_10.go)
	gohelper.setAsLastSibling(var_15_1.go)
	var_15_10:flowOriginParent()

	arg_15_0._tweenId = arg_15_0:_setHeroItemPos(var_15_10, var_15_2, true)

	arg_15_0:_setHeroItemPos(var_15_1, var_15_0, true, function()
		if arg_15_0._tweenId then
			ZProj.TweenHelper.KillById(arg_15_0._tweenId)
		end

		for iter_17_0, iter_17_1 in ipairs(arg_15_0._heroItemList) do
			arg_15_0:_setHeroItemPos(iter_17_1, iter_17_0)
		end

		var_15_3(arg_15_0, true)

		local var_17_0 = HeroGroupModel.instance:getCurGroupMO()
		local var_17_1 = var_15_1.mo.id - 1
		local var_17_2 = var_15_10.mo.id - 1
		local var_17_3 = var_17_0:getPosEquips(var_17_1).equipUid[1]
		local var_17_4 = var_17_0:getPosEquips(var_17_2).equipUid[1]

		var_17_0.equips[var_17_1].equipUid = {
			var_17_4
		}
		var_17_0.equips[var_17_2].equipUid = {
			var_17_3
		}

		HeroSingleGroupModel.instance:swap(var_15_2, var_15_0)

		local var_17_5 = HeroSingleGroupModel.instance:getHeroUids()

		for iter_17_2, iter_17_3 in ipairs(var_17_0.heroList) do
			if var_17_5[iter_17_2] ~= iter_17_3 then
				HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				HeroGroupModel.instance:saveCurGroupData()
				arg_15_0:_updateHeroList()

				break
			end
		end
	end, arg_15_0)
end

function var_0_0._setHeroItemPos(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	local var_18_0 = arg_18_0.heroPosTrList[arg_18_2]
	local var_18_1 = recthelper.rectToRelativeAnchorPos(var_18_0.position, arg_18_0.heroContainer.transform)

	if arg_18_1 then
		arg_18_1:resetEquipPos()
	end

	if arg_18_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_18_1.go.transform, var_18_1.x, var_18_1.y, 0.2, arg_18_4, arg_18_5)
	else
		recthelper.setAnchor(arg_18_1.go.transform, var_18_1.x, var_18_1.y)

		if arg_18_4 then
			arg_18_4(arg_18_5)
		end
	end
end

function var_0_0._tweenToPos(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0, var_19_1 = recthelper.getAnchor(arg_19_1.go.transform)

	if math.abs(var_19_0 - arg_19_2.x) > 10 or math.abs(var_19_1 - arg_19_2.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(arg_19_1.go.transform, arg_19_2.x, arg_19_2.y, 0.2)
	else
		recthelper.setAnchor(arg_19_1.go.transform, arg_19_2.x, arg_19_2.y)
	end
end

function var_0_0._updateHeroList(arg_20_0)
	local var_20_0 = arg_20_0.viewContainer:getHeroGroupFightView():isReplayMode()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._heroItemList) do
		local var_20_1 = HeroSingleGroupModel.instance:getById(iter_20_0)

		iter_20_1:onUpdateMO(var_20_1)

		if not arg_20_0._nowDragingIndex and iter_20_0 <= arg_20_0._openCount then
			arg_20_0._orderList[iter_20_0].text = var_20_1:isEmpty() and iter_20_0 or ""
		end

		if not iter_20_1.isLock and not HeroSingleGroupModel.instance:isTemp() and not var_20_0 and arg_20_0._isOpen then
			if iter_20_0 == 3 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnThirdPosOpen)
			elseif iter_20_0 == 4 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFourthPosOpen)
			end
		end
	end
end

function var_0_0._calcIndex(arg_21_0, arg_21_1)
	for iter_21_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_21_0 = arg_21_0.heroPosTrList[iter_21_0].parent

		if gohelper.isMouseOverGo(var_21_0, arg_21_1) then
			return iter_21_0
		end
	end

	return 0
end

function var_0_0.onDestroyView(arg_22_0)
	CommonDragHelper.instance:setGlobalEnabled(true)

	for iter_22_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		CommonDragHelper.instance:unregisterDragObj(arg_22_0._heroItemList[iter_22_0].go)
	end

	if arg_22_0._openTweenIdList then
		for iter_22_1, iter_22_2 in ipairs(arg_22_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_22_2)
		end
	end

	if arg_22_0._closeTweenIdList then
		for iter_22_3, iter_22_4 in ipairs(arg_22_0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(iter_22_4)
		end
	end
end

function var_0_0._onScreenSizeChange(arg_23_0)
	for iter_23_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_23_0 = arg_23_0._heroItemList[iter_23_0]

		arg_23_0:_setHeroItemPos(var_23_0, iter_23_0)
	end
end

return var_0_0
