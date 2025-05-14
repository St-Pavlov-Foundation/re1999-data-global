module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupListView", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.heroContainer = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/area")
	arg_1_0.heroGo = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/hero")
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
		local var_2_2 = gohelper.findChild(arg_2_0.heroContainer, "pos" .. iter_2_0 .. "/container").transform
		local var_2_3 = gohelper.cloneInPlace(arg_2_0._goheroitem, "item" .. iter_2_0)
		local var_2_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_3, V1a6_CachotHeroGroupHeroItem, arg_2_0)

		var_2_4:setIndex(iter_2_0)
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

	gohelper.setAsLastSibling(arg_2_0._heroItemList[1].go)

	arg_2_0._bgList = {}

	for iter_2_2 = 1, 4 do
		local var_2_7 = gohelper.findChild(arg_2_0.viewGO, "herogroupcontain/hero/bg" .. iter_2_2 .. "/bg")

		table.insert(arg_2_0._bgList, var_2_7)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(arg_2_0._heroItemPosList)
end

function var_0_0.addEvents(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._heroItemDrag) do
		iter_3_1:AddDragBeginListener(arg_3_0._onBeginDrag, arg_3_0, iter_3_0)
		iter_3_1:AddDragListener(arg_3_0._onDrag, arg_3_0, iter_3_0)
		iter_3_1:AddDragEndListener(arg_3_0._onEndDrag, arg_3_0, iter_3_0)
	end

	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_3_0._checkRestrictHeroAndWeekWalk, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_3_0._checkRestrictHeroAndWeekWalk, arg_3_0)
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
	arg_4_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenSizeChange, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_4_0._checkRestrictHeroAndWeekWalk, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_4_0._checkRestrictHeroAndWeekWalk, arg_4_0)
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

	arg_6_0:_checkRestrictHeroAndWeekWalk()
end

function var_0_0._checkDead(arg_7_0)
	local var_7_0 = V1a6_CachotModel.instance:getTeamInfo()
	local var_7_1 = {}

	for iter_7_0 = 1, 4 do
		local var_7_2 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_7_0)

		if var_7_2 then
			local var_7_3 = var_7_2:getHeroMO()

			if var_7_3 then
				local var_7_4 = var_7_0:getHeroHp(var_7_3.heroId)

				if var_7_4 and var_7_4.life <= 0 then
					var_7_1[var_7_2.heroUid] = true
				end
			end
		end
	end

	if tabletool.len(var_7_1) <= 0 then
		return
	end

	for iter_7_1, iter_7_2 in ipairs(arg_7_0._heroItemList) do
		iter_7_2:playRestrictAnimation(var_7_1)
	end

	arg_7_0.needRemoveHeroUidDict = var_7_1

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(arg_7_0._removeDeadHero, arg_7_0, 1.5)
end

function var_0_0._removeDeadHero(arg_8_0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not arg_8_0.needRemoveHeroUidDict then
		return
	end

	for iter_8_0, iter_8_1 in pairs(arg_8_0.needRemoveHeroUidDict) do
		V1a6_CachotHeroSingleGroupModel.instance:remove(iter_8_0)
	end

	V1a6_CachotHeroGroupModel.instance:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
end

function var_0_0._checkRestrictHeroAndWeekWalk(arg_9_0)
	arg_9_0:_checkDead()
end

function var_0_0._checkRestrictHero(arg_10_0)
	local var_10_0 = {}

	for iter_10_0 = 1, 4 do
		local var_10_1 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_10_0)

		if var_10_1 and HeroGroupModel.instance:isRestrict(var_10_1.heroUid) then
			var_10_0[var_10_1.heroUid] = true
		end
	end

	if tabletool.len(var_10_0) <= 0 then
		return
	end

	local var_10_2 = HeroGroupModel.instance:getCurrentBattleConfig()
	local var_10_3 = var_10_2 and var_10_2.restrictReason

	if not string.nilorempty(var_10_3) then
		ToastController.instance:showToastWithString(var_10_3)
	end

	for iter_10_1, iter_10_2 in ipairs(arg_10_0._heroItemList) do
		iter_10_2:playRestrictAnimation(var_10_0)
	end

	arg_10_0.needRemoveHeroUidDict = var_10_0

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(arg_10_0._removeRestrictHero, arg_10_0, 1.5)
end

function var_0_0._removeRestrictHero(arg_11_0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not arg_11_0.needRemoveHeroUidDict then
		return
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.needRemoveHeroUidDict) do
		V1a6_CachotHeroSingleGroupModel.instance:remove(iter_11_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._onHeroGroupExit(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if arg_12_0._openTweenIdList then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_12_1)
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0._heroItemList) do
		iter_12_3:resetQualityParent()
	end

	arg_12_0._closeTweenIdList = {}

	for iter_12_4 = 1, 4 do
		local var_12_0 = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - iter_12_4), nil, arg_12_0._closeTweenFinish, arg_12_0, iter_12_4, EaseType.Linear)

		table.insert(arg_12_0._closeTweenIdList, var_12_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)

	local var_12_1 = arg_12_0.viewContainer:getHeroGroupFightView()

	ViewMgr.instance:closeView(var_12_1.viewName, false, false)
end

function var_0_0._closeTweenFinish(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.heroPosTrList[arg_13_1]

	if var_13_0 then
		local var_13_1 = var_13_0.gameObject:GetComponent(typeof(UnityEngine.Animator))

		var_13_1:Play(UIAnimationName.Close)

		var_13_1.speed = 1
	end

	local var_13_2 = arg_13_0._heroItemList[arg_13_1]

	if var_13_2 then
		local var_13_3 = var_13_2.anim

		var_13_3:Play(UIAnimationName.Close)

		var_13_3.speed = 1
	end

	local var_13_4 = arg_13_0._bgList[arg_13_1]

	if var_13_4 then
		local var_13_5 = var_13_4:GetComponent(typeof(UnityEngine.Animator))

		var_13_5:Play(UIAnimationName.Close)

		var_13_5.speed = 1
	end
end

function var_0_0._isCurEpisodeTeachNote(arg_14_0)
	return true
end

function var_0_0._isAct114Battle(arg_15_0)
	local var_15_0 = DungeonModel.instance.curSendEpisodeId

	if DungeonConfig.instance:getEpisodeCO(var_15_0).type == DungeonEnum.EpisodeType.Jiexika then
		return true
	end
end

function var_0_0.canDrag(arg_16_0, arg_16_1, arg_16_2)
	if V1a6_CachotHeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_0._heroItemList[var_16_0]

	if var_16_1.isAid and arg_16_0:_isCurEpisodeTeachNote() then
		return false
	end

	if var_16_1.isAid and arg_16_0:_isAct114Battle() then
		return false
	end

	if var_16_1.isTrialLock then
		return false
	end

	if not arg_16_2 and (var_16_1.mo:isEmpty() or var_16_1.mo.aid == -1 or arg_16_1 > HeroGroupModel.instance:positionOpenCount()) then
		return false
	end

	return true
end

function var_0_0._onBeginDrag(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0._tweening then
		return
	end

	if not arg_17_0:canDrag(arg_17_1) then
		return
	end

	if arg_17_0._nowDragingIndex then
		return
	end

	arg_17_0._nowDragingIndex = arg_17_1

	local var_17_0 = arg_17_0._heroItemList[arg_17_1]

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._heroItemList) do
		iter_17_1:onItemBeginDrag(arg_17_1)
		iter_17_1:moveQuality()
		gohelper.setAsLastSibling(iter_17_1:getQualityGo())
	end

	for iter_17_2, iter_17_3 in ipairs(arg_17_0._heroItemList) do
		iter_17_3:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(var_17_0.go)

	local var_17_1 = recthelper.screenPosToAnchorPos(arg_17_2.position, arg_17_0.heroContainer.transform)

	arg_17_0:_tweenToPos(var_17_0, var_17_1)
end

function var_0_0._onDrag(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0:canDrag(arg_18_1) then
		if arg_18_0._heroItemList[arg_18_1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return
	end

	if arg_18_0._nowDragingIndex ~= arg_18_1 then
		return
	end

	local var_18_0 = arg_18_0._heroItemList[arg_18_1]
	local var_18_1 = recthelper.screenPosToAnchorPos(arg_18_2.position, arg_18_0.heroContainer.transform)

	arg_18_0:_tweenToPos(var_18_0, var_18_1)
end

function var_0_0._onEndDrag(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0:canDrag(arg_19_1) then
		return
	end

	if arg_19_0._nowDragingIndex ~= arg_19_1 then
		return
	end

	arg_19_0._nowDragingIndex = nil

	local var_19_0 = arg_19_0:_calcIndex(arg_19_2.position)
	local var_19_1 = arg_19_0._heroItemList[arg_19_1]
	local var_19_2 = arg_19_1

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._heroItemList) do
		iter_19_1:onItemEndDrag(var_19_2, var_19_0)
		gohelper.setAsLastSibling(iter_19_1:getQualityGo())
	end

	arg_19_0:_setDragEnabled(false)

	local function var_19_3(arg_20_0, arg_20_1)
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._heroItemList) do
			iter_20_1:onItemCompleteDrag(var_19_2, var_19_0, arg_20_1)
		end

		arg_20_0:_setDragEnabled(true)

		for iter_20_2, iter_20_3 in ipairs(arg_20_0._heroItemList) do
			iter_20_3:flowCurrentParent()
		end
	end

	if var_19_0 <= 0 then
		arg_19_0:_setHeroItemPos(var_19_1, var_19_2, true, var_19_3, arg_19_0)

		return
	end

	if not arg_19_0:canDrag(var_19_0, true) then
		local var_19_4 = arg_19_0._heroItemList[var_19_0]

		if var_19_4 and var_19_4.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		arg_19_0:_setHeroItemPos(var_19_1, var_19_2, true, var_19_3, arg_19_0)

		return
	end

	if var_19_0 <= 0 then
		arg_19_0:_setHeroItemPos(var_19_1, var_19_2, true, var_19_3, arg_19_0)

		return
	end

	local var_19_5 = HeroGroupModel.instance.battleId
	local var_19_6 = var_19_5 and lua_battle.configDict[var_19_5]

	if var_19_0 > V1a6_CachotHeroGroupModel.instance:positionOpenCount() then
		arg_19_0:_setHeroItemPos(var_19_1, var_19_2, true, var_19_3, arg_19_0)

		local var_19_7, var_19_8 = V1a6_CachotHeroGroupModel.instance:getPositionLockDesc(var_19_0)

		GameFacade.showToast(var_19_7, var_19_8)

		return
	end

	local var_19_9 = V1a6_CachotHeroGroupModel.instance:getBattleRoleNum()

	if var_19_9 and var_19_9 < var_19_0 then
		arg_19_0:_setHeroItemPos(var_19_1, var_19_2, true, var_19_3, arg_19_0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if var_19_6 and var_19_1.mo.aid and var_19_0 > var_19_6.playerMax then
		arg_19_0:_setHeroItemPos(var_19_1, var_19_2, true, var_19_3, arg_19_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local var_19_10 = arg_19_0._heroItemList[var_19_0]

	if var_19_10.mo.aid then
		arg_19_0:_setHeroItemPos(var_19_1, var_19_2, true, var_19_3, arg_19_0)

		return
	end

	if var_19_2 ~= var_19_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(var_19_10.go)
	gohelper.setAsLastSibling(var_19_1.go)

	for iter_19_2, iter_19_3 in ipairs(arg_19_0._heroItemList) do
		gohelper.setAsLastSibling(iter_19_3:getQualityGo())
	end

	var_19_10:flowOriginParent()

	arg_19_0._tweenId = arg_19_0:_setHeroItemPos(var_19_10, var_19_2, true)

	arg_19_0:_setHeroItemPos(var_19_1, var_19_0, true, function()
		if arg_19_0._tweenId then
			ZProj.TweenHelper.KillById(arg_19_0._tweenId)
		end

		for iter_21_0, iter_21_1 in ipairs(arg_19_0._heroItemList) do
			arg_19_0:_setHeroItemPos(iter_21_1, iter_21_0)
		end

		var_19_3(arg_19_0, true)

		local var_21_0 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()
		local var_21_1 = var_19_1.mo.id - 1
		local var_21_2 = var_19_10.mo.id - 1
		local var_21_3 = var_21_0:getPosEquips(var_21_1).equipUid[1]
		local var_21_4 = var_21_0:getPosEquips(var_21_2).equipUid[1]

		var_21_0.equips[var_21_1].equipUid = {
			var_21_4
		}
		var_21_0.equips[var_21_2].equipUid = {
			var_21_3
		}

		V1a6_CachotHeroSingleGroupModel.instance:swap(var_19_2, var_19_0)

		local var_21_5 = V1a6_CachotHeroSingleGroupModel.instance:getHeroUids()

		for iter_21_2, iter_21_3 in ipairs(var_21_0.heroList) do
			if var_21_5[iter_21_2] ~= iter_21_3 then
				V1a6_CachotHeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				V1a6_CachotHeroGroupModel.instance:saveCurGroupData()
				V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
				arg_19_0:_updateHeroList()

				break
			end
		end
	end, arg_19_0)
end

function var_0_0._setHeroItemPos(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	local var_22_0 = arg_22_0.heroPosTrList[arg_22_2]
	local var_22_1 = recthelper.rectToRelativeAnchorPos(var_22_0.position, arg_22_0.heroContainer.transform)

	if arg_22_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_22_1.go.transform, var_22_1.x, var_22_1.y, 0.2, arg_22_4, arg_22_5)
	else
		recthelper.setAnchor(arg_22_1.go.transform, var_22_1.x, var_22_1.y)

		if arg_22_4 then
			arg_22_4(arg_22_5)
		end
	end
end

function var_0_0._tweenToPos(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0, var_23_1 = recthelper.getAnchor(arg_23_1.go.transform)

	if math.abs(var_23_0 - arg_23_2.x) > 10 or math.abs(var_23_1 - arg_23_2.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(arg_23_1.go.transform, arg_23_2.x, arg_23_2.y, 0.2)
	else
		recthelper.setAnchor(arg_23_1.go.transform, arg_23_2.x, arg_23_2.y)
	end
end

function var_0_0._setDragEnabled(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0._heroItemDrag) do
		iter_24_1.enabled = arg_24_1
	end
end

function var_0_0._updateHeroList(arg_25_0)
	local var_25_0 = arg_25_0.viewContainer:getHeroGroupFightView():isReplayMode()

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._heroItemList) do
		local var_25_1 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_25_0)

		iter_25_1:onUpdateMO(var_25_1)

		if not iter_25_1.isLock and not V1a6_CachotHeroSingleGroupModel.instance:isTemp() and not var_25_0 and arg_25_0._isOpen then
			if iter_25_0 == 3 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnThirdPosOpen)
			elseif iter_25_0 == 4 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFourthPosOpen)
			end
		end
	end
end

function var_0_0._checkWeekWalkCd(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._heroItemList) do
		local var_26_1 = iter_26_1:checkWeekWalkCd()

		if var_26_1 then
			table.insert(var_26_0, var_26_1)
		end
	end

	if #var_26_0 == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeWeekWalkInCdHero")

	arg_26_0._heroInCdList = var_26_0

	TaskDispatcher.runDelay(arg_26_0._removeWeekWalkInCdHero, arg_26_0, 1.5)
end

function var_0_0._removeWeekWalkInCdHero(arg_27_0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if not arg_27_0._heroInCdList then
		return
	end

	local var_27_0 = arg_27_0._heroInCdList

	arg_27_0._heroInCdList = nil

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		V1a6_CachotHeroSingleGroupModel.instance:remove(iter_27_1)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._calcIndex(arg_28_0, arg_28_1)
	for iter_28_0 = 1, 4 do
		local var_28_0 = arg_28_0.heroPosTrList[iter_28_0].parent
		local var_28_1 = recthelper.screenPosToAnchorPos(arg_28_1, var_28_0)

		if math.abs(var_28_1.x) * 2 < recthelper.getWidth(var_28_0) and math.abs(var_28_1.y) * 2 < recthelper.getHeight(var_28_0) then
			return iter_28_0
		end
	end

	return 0
end

function var_0_0.onDestroyView(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.closeThis, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._removeWeekWalkInCdHero, arg_29_0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if arg_29_0._openTweenIdList then
		for iter_29_0, iter_29_1 in ipairs(arg_29_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_29_1)
		end
	end

	if arg_29_0._closeTweenIdList then
		for iter_29_2, iter_29_3 in ipairs(arg_29_0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(iter_29_3)
		end
	end
end

function var_0_0._onScreenSizeChange(arg_30_0)
	for iter_30_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_30_0 = arg_30_0._heroItemList[iter_30_0]

		arg_30_0:_setHeroItemPos(var_30_0, iter_30_0)
	end
end

return var_0_0
