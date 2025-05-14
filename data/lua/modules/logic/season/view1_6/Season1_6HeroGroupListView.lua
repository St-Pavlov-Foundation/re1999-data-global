module("modules.logic.season.view1_6.Season1_6HeroGroupListView", package.seeall)

local var_0_0 = class("Season1_6HeroGroupListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goheroarea = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/area")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/hero")
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
	arg_2_0._heroItemDrag = arg_2_0:getUserDataTb_()

	gohelper.setActive(arg_2_0._goheroitem, false)
	gohelper.setActive(arg_2_0._goaidheroitem, false)

	arg_2_0.heroPosTrList = arg_2_0:getUserDataTb_()
	arg_2_0._heroItemPosList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 4 do
		local var_2_2 = gohelper.findChild(arg_2_0._goheroarea, "pos" .. iter_2_0 .. "/container").transform
		local var_2_3 = gohelper.cloneInPlace(arg_2_0._goheroitem, "item" .. iter_2_0)
		local var_2_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_3, Season1_6HeroGroupHeroItem, arg_2_0)

		table.insert(arg_2_0.heroPosTrList, var_2_2)
		table.insert(arg_2_0._heroItemList, var_2_4)
		gohelper.setActive(var_2_3, true)
	end

	for iter_2_1 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_2_5 = arg_2_0._heroItemList[iter_2_1]

		arg_2_0:_setHeroItemPos(var_2_5, iter_2_1)
		table.insert(arg_2_0._heroItemPosList, var_2_5.go.transform)
		var_2_5:setParent(arg_2_0.heroPosTrList[iter_2_1])

		local var_2_6 = SLFramework.UGUI.UIDragListener.Get(var_2_5.go)

		table.insert(arg_2_0._heroItemDrag, var_2_6)
	end

	arg_2_0._bgList = {}

	for iter_2_2 = 1, 4 do
		local var_2_7 = gohelper.findChild(arg_2_0.viewGO, "herogroupcontain/hero/bg" .. iter_2_2 .. "/bg")

		table.insert(arg_2_0._bgList, var_2_7)
	end

	HeroGroupModel.instance:setHeroGroupItemPos(arg_2_0._heroItemPosList)
end

function var_0_0.addEvents(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._heroItemDrag) do
		iter_3_1:AddDragBeginListener(arg_3_0._onBeginDrag, arg_3_0, iter_3_0)
		iter_3_1:AddDragListener(arg_3_0._onDrag, arg_3_0, iter_3_0)
		iter_3_1:AddDragEndListener(arg_3_0._onEndDrag, arg_3_0, iter_3_0)
	end

	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, arg_3_0._onHeroGroupExit, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, arg_3_0._onSnapshotSaveSucc, arg_3_0)
	arg_3_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenSizeChange, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._heroItemDrag) do
		iter_4_1:RemoveDragBeginListener()
		iter_4_1:RemoveDragListener()
		iter_4_1:RemoveDragEndListener()
	end

	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, arg_4_0._onSnapshotSaveSucc, arg_4_0)
	arg_4_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenSizeChange, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._isOpen = true

	arg_5_0:_updateHeroList()
	arg_5_0:_playOpenAnimation()
end

function var_0_0._playOpenAnimation(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.heroPosTrList) do
		if iter_6_1 then
			local var_6_0 = iter_6_1.gameObject:GetComponent(typeof(UnityEngine.Animator))

			var_6_0:Play("open")
			var_6_0:Update(0)

			var_6_0.speed = 1
		end
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._heroItemList) do
		if iter_6_3 then
			local var_6_1 = iter_6_3.anim

			var_6_1:Play("open")
			var_6_1:Update(0)

			var_6_1.speed = 1
		end
	end

	for iter_6_4, iter_6_5 in ipairs(arg_6_0._bgList) do
		if iter_6_5 then
			local var_6_2 = iter_6_5:GetComponent(typeof(UnityEngine.Animator))

			var_6_2:Play("open")
			var_6_2:Update(0)

			var_6_2.speed = 1
		end
	end

	arg_6_0:_checkRestrictHero()
end

function var_0_0._checkRestrictHero(arg_7_0)
	local var_7_0 = {}

	for iter_7_0 = 1, 4 do
		local var_7_1 = HeroSingleGroupModel.instance:getById(iter_7_0)

		if var_7_1 and HeroGroupModel.instance:isRestrict(var_7_1.heroUid) then
			var_7_0[var_7_1.heroUid] = true
		end
	end

	if tabletool.len(var_7_0) <= 0 then
		return
	end

	local var_7_2 = HeroGroupModel.instance:getCurrentBattleConfig()
	local var_7_3 = var_7_2 and var_7_2.restrictReason

	if not string.nilorempty(var_7_3) then
		ToastController.instance:showToastWithString(var_7_3)
	end

	for iter_7_1, iter_7_2 in ipairs(arg_7_0._heroItemList) do
		iter_7_2:playRestrictAnimation(var_7_0)
	end

	arg_7_0.needRemoveHeroUidDict = var_7_0

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(arg_7_0._removeRestrictHero, arg_7_0, 1.5)
end

function var_0_0._removeRestrictHero(arg_8_0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not arg_8_0.needRemoveHeroUidDict then
		return
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0.needRemoveHeroUidDict) do
		HeroSingleGroupModel.instance:remove(iter_8_0)
	end

	HeroGroupModel.instance:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._onHeroGroupExit(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if arg_9_0._openTweenIdList then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_9_1)
		end
	end

	arg_9_0._closeTweenIdList = {}

	for iter_9_2 = 1, 4 do
		local var_9_0 = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - iter_9_2), nil, arg_9_0._closeTweenFinish, arg_9_0, iter_9_2, EaseType.Linear)

		table.insert(arg_9_0._closeTweenIdList, var_9_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(ViewName.Season1_6HeroGroupFightView, false, false)
end

function var_0_0._closeTweenFinish(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.heroPosTrList[arg_10_1]

	if var_10_0 then
		local var_10_1 = var_10_0.gameObject:GetComponent(typeof(UnityEngine.Animator))

		var_10_1:Play("close")

		var_10_1.speed = 1
	end

	local var_10_2 = arg_10_0._heroItemList[arg_10_1]

	if var_10_2 then
		local var_10_3 = var_10_2.anim

		var_10_3:Play("close")

		var_10_3.speed = 1
	end

	local var_10_4 = arg_10_0._bgList[arg_10_1]

	if var_10_4 then
		local var_10_5 = var_10_4:GetComponent(typeof(UnityEngine.Animator))

		var_10_5:Play("close")

		var_10_5.speed = 1
	end
end

function var_0_0.canDrag(arg_11_0, arg_11_1, arg_11_2)
	if UnityEngine.Input.touchCount > 1 then
		return false
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_0._heroItemList[var_11_0]

	if var_11_1.isAid then
		return false
	end

	if var_11_1.isTrialLock then
		return false
	end

	if not arg_11_2 and (var_11_1.mo:isEmpty() or var_11_1.mo.aid == -1 or var_11_0 > HeroGroupModel.instance:positionOpenCount()) then
		return false
	end

	return true
end

function var_0_0._onBeginDrag(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._tweening then
		return
	end

	if not arg_12_0:canDrag(arg_12_1) then
		return
	end

	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_0._heroItemList[var_12_0]

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._heroItemList) do
		iter_12_1:onItemBeginDrag(var_12_0)
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0._heroItemList) do
		iter_12_3:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(var_12_1.go)

	local var_12_2 = recthelper.screenPosToAnchorPos(arg_12_2.position, arg_12_0._goheroarea.transform)

	arg_12_0:_tweenToPos(var_12_1, var_12_2)
end

function var_0_0._onDrag(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0:canDrag(arg_13_1) then
		if arg_13_0._heroItemList[arg_13_1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return
	end

	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_0._heroItemList[var_13_0]
	local var_13_2 = recthelper.screenPosToAnchorPos(arg_13_2.position, arg_13_0._goheroarea.transform)

	arg_13_0:_tweenToPos(var_13_1, var_13_2)
end

function var_0_0._onEndDrag(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0:canDrag(arg_14_1) then
		return
	end

	local var_14_0 = arg_14_1
	local var_14_1 = arg_14_0._heroItemList[var_14_0]
	local var_14_2 = arg_14_0:_calcIndex(arg_14_2.position)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._heroItemList) do
		iter_14_1:onItemEndDrag(var_14_0, var_14_2)
	end

	arg_14_0:_setDragEnabled(false)

	local function var_14_3(arg_15_0, arg_15_1)
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._heroItemList) do
			iter_15_1:onItemCompleteDrag(var_14_0, var_14_2, arg_15_1)
		end

		arg_15_0:_setDragEnabled(true)

		for iter_15_2, iter_15_3 in ipairs(arg_15_0._heroItemList) do
			iter_15_3:flowCurrentParent()
		end
	end

	if var_14_2 <= 0 or not arg_14_0:canDrag(var_14_2, true) then
		arg_14_0:_setHeroItemPos(var_14_1, var_14_0, true, var_14_3, arg_14_0)

		return
	end

	local var_14_4 = HeroGroupModel.instance.battleId
	local var_14_5 = var_14_4 and lua_battle.configDict[var_14_4]

	if var_14_2 > HeroGroupModel.instance:positionOpenCount() then
		arg_14_0:_setHeroItemPos(var_14_1, var_14_0, true, var_14_3, arg_14_0)

		local var_14_6, var_14_7 = HeroGroupModel.instance:getPositionLockDesc(var_14_2)

		GameFacade.showToast(var_14_6, var_14_7)

		return
	end

	local var_14_8 = HeroGroupModel.instance:getBattleRoleNum()

	if var_14_8 and var_14_8 < var_14_2 then
		arg_14_0:_setHeroItemPos(var_14_1, var_14_0, true, var_14_3, arg_14_0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if var_14_5 and var_14_1.mo.aid and var_14_2 > var_14_5.playerMax then
		arg_14_0:_setHeroItemPos(var_14_1, var_14_0, true, var_14_3, arg_14_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local var_14_9 = arg_14_0._heroItemList[var_14_2]

	if var_14_9.mo.aid and var_14_9.mo.aid ~= -1 and var_14_5 and var_14_0 > var_14_5.playerMax then
		arg_14_0:_setHeroItemPos(var_14_1, var_14_0, true, var_14_3, arg_14_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	if var_14_0 ~= var_14_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(var_14_9.go)
	gohelper.setAsLastSibling(var_14_1.go)
	var_14_9:flowOriginParent()

	arg_14_0._tweenId = arg_14_0:_setHeroItemPos(var_14_9, var_14_0, true)

	arg_14_0:_setHeroItemPos(var_14_1, var_14_2, true, function()
		if arg_14_0._tweenId then
			ZProj.TweenHelper.KillById(arg_14_0._tweenId)
		end

		for iter_16_0, iter_16_1 in ipairs(arg_14_0._heroItemList) do
			arg_14_0:_setHeroItemPos(iter_16_1, iter_16_0)
		end

		var_14_3(arg_14_0, true)

		local var_16_0 = HeroGroupModel.instance:getCurGroupMO()
		local var_16_1 = var_14_1.mo.id - 1
		local var_16_2 = var_14_9.mo.id - 1
		local var_16_3 = var_16_0:getPosEquips(var_16_1).equipUid[1]
		local var_16_4 = var_16_0:getPosEquips(var_16_2).equipUid[1]

		var_16_0.equips[var_16_1].equipUid = {
			var_16_4
		}
		var_16_0.equips[var_16_2].equipUid = {
			var_16_3
		}

		local var_16_5 = var_16_0:getAct104PosEquips(var_16_1).equipUid
		local var_16_6 = var_16_0:getAct104PosEquips(var_16_2).equipUid

		var_16_0.activity104Equips[var_16_1].equipUid = var_16_6
		var_16_0.activity104Equips[var_16_2].equipUid = var_16_5

		HeroSingleGroupModel.instance:swap(var_14_0, var_14_2)

		local var_16_7 = HeroSingleGroupModel.instance:getHeroUids()

		for iter_16_2, iter_16_3 in ipairs(var_16_0.heroList) do
			if var_16_7[iter_16_2] ~= iter_16_3 then
				HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				HeroGroupModel.instance:saveCurGroupData()
				arg_14_0:_updateHeroList()

				break
			end
		end
	end)
end

function var_0_0._setHeroItemPos(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = arg_17_0.heroPosTrList[arg_17_2]
	local var_17_1 = recthelper.rectToRelativeAnchorPos(var_17_0.position, arg_17_0._goheroarea.transform)

	if arg_17_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_17_1.go.transform, var_17_1.x, var_17_1.y, 0.2, arg_17_4, arg_17_5)
	else
		recthelper.setAnchor(arg_17_1.go.transform, var_17_1.x, var_17_1.y)

		if arg_17_4 then
			arg_17_4(arg_17_5)
		end
	end
end

function var_0_0._tweenToPos(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = recthelper.getAnchor(arg_18_1.go.transform)

	if math.abs(var_18_0 - arg_18_2.x) > 10 or math.abs(var_18_1 - arg_18_2.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(arg_18_1.go.transform, arg_18_2.x, arg_18_2.y, 0.2)
	else
		recthelper.setAnchor(arg_18_1.go.transform, arg_18_2.x, arg_18_2.y)
	end
end

function var_0_0._setDragEnabled(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._heroItemDrag) do
		iter_19_1.enabled = arg_19_1
	end
end

function var_0_0._updateHeroList(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._heroItemList) do
		local var_20_0 = HeroSingleGroupModel.instance:getById(iter_20_0)

		iter_20_1:onUpdateMO(var_20_0)
	end
end

function var_0_0._onSnapshotSaveSucc(arg_21_0)
	arg_21_0:_updateHeroList()
	gohelper.setActive(arg_21_0._goheroarea, false)
	gohelper.setActive(arg_21_0._goheroarea, true)
	gohelper.setActive(arg_21_0._gohero, false)
	gohelper.setActive(arg_21_0._gohero, true)
end

function var_0_0._calcIndex(arg_22_0, arg_22_1)
	for iter_22_0 = 1, 4 do
		local var_22_0 = arg_22_0.heroPosTrList[iter_22_0].parent
		local var_22_1 = recthelper.screenPosToAnchorPos(arg_22_1, var_22_0)

		if math.abs(var_22_1.x) * 2 < recthelper.getWidth(var_22_0) and math.abs(var_22_1.y) * 2 < recthelper.getHeight(var_22_0) then
			return iter_22_0
		end
	end

	return 0
end

function var_0_0.onDestroyView(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.closeThis, arg_23_0)

	if arg_23_0._openTweenIdList then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_23_1)
		end
	end

	if arg_23_0._closeTweenIdList then
		for iter_23_2, iter_23_3 in ipairs(arg_23_0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(iter_23_3)
		end
	end
end

function var_0_0._onScreenSizeChange(arg_24_0)
	for iter_24_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_24_0 = arg_24_0._heroItemList[iter_24_0]

		arg_24_0:_setHeroItemPos(var_24_0, iter_24_0)
	end
end

function var_0_0.getHeroItemList(arg_25_0)
	return arg_25_0._heroItemList
end

return var_0_0
