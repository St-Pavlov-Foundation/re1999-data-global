module("modules.logic.rouge.view.RougeHeroGroupListView", package.seeall)

local var_0_0 = class("RougeHeroGroupListView", BaseView)

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
	arg_2_0._heroItemDrag = arg_2_0:getUserDataTb_()

	gohelper.setActive(arg_2_0._goheroitem, false)
	gohelper.setActive(arg_2_0._goaidheroitem, false)

	arg_2_0.heroPosTrList = arg_2_0:getUserDataTb_()
	arg_2_0._heroItemPosList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 4 do
		local var_2_2 = gohelper.findChild(arg_2_0.heroContainer, "pos" .. iter_2_0 .. "/container").transform
		local var_2_3 = gohelper.cloneInPlace(arg_2_0._goheroitem, "item" .. iter_2_0)
		local var_2_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_3, RougeHeroGroupHeroItem, arg_2_0)

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

	arg_2_0._bgList = arg_2_0:getUserDataTb_()
	arg_2_0._orderList = arg_2_0:getUserDataTb_()

	local var_2_7 = HeroGroupModel.instance:positionOpenCount()
	local var_2_8 = HeroGroupModel.instance:getBattleRoleNum()

	if var_2_8 then
		var_2_7 = math.min(var_2_8, var_2_7)
	end

	local var_2_9 = math.min(arg_2_0._playerMax, var_2_7)

	arg_2_0._openCount = var_2_9

	for iter_2_2 = 1, 4 do
		local var_2_10 = gohelper.findChild(arg_2_0.viewGO, "herogroupcontain/hero/bg" .. iter_2_2 .. "/bg")

		table.insert(arg_2_0._bgList, var_2_10)

		local var_2_11 = gohelper.findChildTextMesh(arg_2_0.viewGO, "herogroupcontain/hero/bg" .. iter_2_2 .. "/bg/#txt_order")

		var_2_11.text = iter_2_2 <= var_2_9 and tostring(iter_2_2) or ""

		table.insert(arg_2_0._orderList, var_2_11)
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

function var_0_0._checkRestrictHeroAndWeekWalk(arg_7_0)
	arg_7_0:_checkDead()
end

function var_0_0._checkDead(arg_8_0)
	local var_8_0 = RougeModel.instance:getTeamInfo()
	local var_8_1 = {}

	for iter_8_0 = 1, RougeEnum.FightTeamHeroNum do
		local var_8_2 = RougeHeroSingleGroupModel.instance:getById(iter_8_0)

		if var_8_2 then
			local var_8_3 = var_8_2:getHeroMO()

			if var_8_3 then
				local var_8_4 = var_8_0:getHeroHp(var_8_3.heroId)

				if var_8_4 and var_8_4.life <= 0 then
					var_8_1[var_8_2.heroUid] = true
				end
			end
		end
	end

	if tabletool.len(var_8_1) <= 0 then
		return
	end

	for iter_8_1, iter_8_2 in ipairs(arg_8_0._heroItemList) do
		iter_8_2:playRestrictAnimation(var_8_1)
	end

	if tabletool.len(var_8_1) <= 0 then
		arg_8_0:_saveAfterRemoveDead()

		return
	end

	arg_8_0.needRemoveHeroUidDict = var_8_1

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(arg_8_0._removeDeadHero, arg_8_0, 1.5)
end

function var_0_0._removeDeadHero(arg_9_0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not arg_9_0.needRemoveHeroUidDict then
		return
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0.needRemoveHeroUidDict) do
		RougeHeroSingleGroupModel.instance:remove(iter_9_0)
	end

	arg_9_0:_saveAfterRemoveDead()
end

function var_0_0._saveAfterRemoveDead(arg_10_0)
	RougeHeroGroupModel.instance:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	RougeHeroGroupModel.instance:rougeSaveCurGroup()
end

function var_0_0._checkRestrictHero(arg_11_0)
	local var_11_0 = {}

	for iter_11_0 = 1, 4 do
		local var_11_1 = RougeHeroSingleGroupModel.instance:getById(iter_11_0)

		if var_11_1 and HeroGroupModel.instance:isRestrict(var_11_1.heroUid) then
			var_11_0[var_11_1.heroUid] = true
		end
	end

	if tabletool.len(var_11_0) <= 0 then
		return
	end

	local var_11_2 = HeroGroupModel.instance:getCurrentBattleConfig()
	local var_11_3 = var_11_2 and var_11_2.restrictReason

	if not string.nilorempty(var_11_3) then
		ToastController.instance:showToastWithString(var_11_3)
	end

	for iter_11_1, iter_11_2 in ipairs(arg_11_0._heroItemList) do
		iter_11_2:playRestrictAnimation(var_11_0)
	end

	arg_11_0.needRemoveHeroUidDict = var_11_0

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(arg_11_0._removeRestrictHero, arg_11_0, 1.5)
end

function var_0_0._removeRestrictHero(arg_12_0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not arg_12_0.needRemoveHeroUidDict then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.needRemoveHeroUidDict) do
		RougeHeroSingleGroupModel.instance:remove(iter_12_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._onHeroGroupExit(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if arg_13_0._openTweenIdList then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_13_1)
		end
	end

	arg_13_0._closeTweenIdList = {}

	for iter_13_2 = 1, 4 do
		local var_13_0 = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - iter_13_2), nil, arg_13_0._closeTweenFinish, arg_13_0, iter_13_2, EaseType.Linear)

		table.insert(arg_13_0._closeTweenIdList, var_13_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)

	local var_13_1 = arg_13_0.viewContainer:getHeroGroupFightView()

	ViewMgr.instance:closeView(var_13_1.viewName, false, false)
end

function var_0_0._closeTweenFinish(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.heroPosTrList[arg_14_1]

	if var_14_0 then
		local var_14_1 = var_14_0.gameObject:GetComponent(typeof(UnityEngine.Animator))

		var_14_1:Play(UIAnimationName.Close)

		var_14_1.speed = 1
	end

	local var_14_2 = arg_14_0._heroItemList[arg_14_1]

	if var_14_2 then
		local var_14_3 = var_14_2.anim

		var_14_3:Play(UIAnimationName.Close)

		var_14_3.speed = 1

		local var_14_4 = var_14_2.anim2

		var_14_4:Play(UIAnimationName.Close)

		var_14_4.speed = 1
	end

	local var_14_5 = arg_14_0._bgList[arg_14_1]

	if var_14_5 then
		local var_14_6 = var_14_5:GetComponent(typeof(UnityEngine.Animator))

		var_14_6:Play(UIAnimationName.Close)

		var_14_6.speed = 1
	end
end

function var_0_0._isCurEpisodeTeachNote(arg_15_0)
	return true
end

function var_0_0._isAct114Battle(arg_16_0)
	local var_16_0 = DungeonModel.instance.curSendEpisodeId

	if DungeonConfig.instance:getEpisodeCO(var_16_0).type == DungeonEnum.EpisodeType.Jiexika then
		return true
	end
end

function var_0_0.canDrag(arg_17_0, arg_17_1, arg_17_2)
	if RougeHeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local var_17_0 = arg_17_1
	local var_17_1 = arg_17_0._heroItemList[var_17_0]

	if var_17_1.isAid and arg_17_0:_isCurEpisodeTeachNote() then
		return false
	end

	if var_17_1.isAid and arg_17_0:_isAct114Battle() then
		return false
	end

	if var_17_1.isTrialLock then
		return false
	end

	if not arg_17_2 and (var_17_1.mo:isEmpty() or var_17_1.mo.aid == -1 or arg_17_1 > HeroGroupModel.instance:positionOpenCount()) then
		return false
	end

	return true
end

function var_0_0._onBeginDrag(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._tweening then
		return
	end

	if not arg_18_0:canDrag(arg_18_1) then
		return
	end

	if arg_18_0._nowDragingIndex then
		return
	end

	if arg_18_1 <= arg_18_0._openCount then
		arg_18_0._orderList[arg_18_1].text = arg_18_1
	end

	arg_18_0._nowDragingIndex = arg_18_1

	local var_18_0 = arg_18_0._heroItemList[arg_18_1]

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._heroItemList) do
		iter_18_1:onItemBeginDrag(arg_18_1)
	end

	for iter_18_2, iter_18_3 in ipairs(arg_18_0._heroItemList) do
		iter_18_3:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(var_18_0.go)

	local var_18_1 = recthelper.screenPosToAnchorPos(arg_18_2.position, arg_18_0.heroContainer.transform)

	arg_18_0:_tweenToPos(var_18_0, var_18_1)
end

function var_0_0._onDrag(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0:canDrag(arg_19_1) then
		if arg_19_0._heroItemList[arg_19_1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return
	end

	if arg_19_0._nowDragingIndex ~= arg_19_1 then
		return
	end

	local var_19_0 = arg_19_0._heroItemList[arg_19_1]
	local var_19_1 = recthelper.screenPosToAnchorPos(arg_19_2.position, arg_19_0.heroContainer.transform)

	arg_19_0:_tweenToPos(var_19_0, var_19_1)
end

function var_0_0._onEndDrag(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0:canDrag(arg_20_1) then
		return
	end

	if arg_20_0._nowDragingIndex ~= arg_20_1 then
		return
	end

	arg_20_0._nowDragingIndex = nil

	local var_20_0 = arg_20_0:_calcIndex(arg_20_2.position)
	local var_20_1 = arg_20_0._heroItemList[arg_20_1]
	local var_20_2 = arg_20_1

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._heroItemList) do
		iter_20_1:onItemEndDrag(var_20_2, var_20_0)
	end

	arg_20_0:_setDragEnabled(false)

	local function var_20_3(arg_21_0, arg_21_1)
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._heroItemList) do
			iter_21_1:onItemCompleteDrag(var_20_2, var_20_0, arg_21_1)
		end

		arg_21_0:_setDragEnabled(true)

		for iter_21_2, iter_21_3 in ipairs(arg_21_0._heroItemList) do
			iter_21_3:flowCurrentParent()
		end
	end

	if var_20_0 == arg_20_1 or var_20_0 <= 0 then
		arg_20_0._orderList[arg_20_1].text = ""
	end

	if var_20_0 <= 0 then
		arg_20_0:_setHeroItemPos(var_20_1, var_20_2, true, var_20_3, arg_20_0)

		return
	end

	if not arg_20_0:canDrag(var_20_0, true) then
		local var_20_4 = arg_20_0._heroItemList[var_20_0]

		if var_20_4 and var_20_4.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		arg_20_0:_setHeroItemPos(var_20_1, var_20_2, true, var_20_3, arg_20_0)

		return
	end

	if var_20_0 <= 0 then
		arg_20_0:_setHeroItemPos(var_20_1, var_20_2, true, var_20_3, arg_20_0)

		return
	end

	local var_20_5 = HeroGroupModel.instance.battleId
	local var_20_6 = var_20_5 and lua_battle.configDict[var_20_5]

	if var_20_0 > HeroGroupModel.instance:positionOpenCount() then
		arg_20_0:_setHeroItemPos(var_20_1, var_20_2, true, var_20_3, arg_20_0)

		local var_20_7, var_20_8 = HeroGroupModel.instance:getPositionLockDesc(var_20_0)

		GameFacade.showToast(var_20_7, var_20_8)

		return
	end

	local var_20_9 = HeroGroupModel.instance:getBattleRoleNum()

	if var_20_9 and var_20_9 < var_20_0 then
		arg_20_0:_setHeroItemPos(var_20_1, var_20_2, true, var_20_3, arg_20_0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if var_20_6 and var_20_1.mo.aid and var_20_0 > var_20_6.playerMax then
		arg_20_0:_setHeroItemPos(var_20_1, var_20_2, true, var_20_3, arg_20_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local var_20_10 = arg_20_0._heroItemList[var_20_0]

	if var_20_10.mo.aid then
		arg_20_0:_setHeroItemPos(var_20_1, var_20_2, true, var_20_3, arg_20_0)

		return
	end

	if var_20_2 ~= var_20_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(var_20_10.go)
	gohelper.setAsLastSibling(var_20_1.go)
	var_20_10:flowOriginParent()

	arg_20_0._tweenId = arg_20_0:_setHeroItemPos(var_20_10, var_20_2, true)

	arg_20_0:_setHeroItemPos(var_20_1, var_20_0, true, function()
		if arg_20_0._tweenId then
			ZProj.TweenHelper.KillById(arg_20_0._tweenId)
		end

		for iter_22_0, iter_22_1 in ipairs(arg_20_0._heroItemList) do
			arg_20_0:_setHeroItemPos(iter_22_1, iter_22_0)
		end

		var_20_3(arg_20_0, true)

		local var_22_0 = RougeHeroGroupModel.instance:getCurGroupMO()
		local var_22_1 = var_20_1.mo.id - 1
		local var_22_2 = var_20_10.mo.id - 1
		local var_22_3 = var_22_0:getPosEquips(var_22_1).equipUid[1]
		local var_22_4 = var_22_0:getPosEquips(var_22_2).equipUid[1]

		var_22_0.equips[var_22_1].equipUid = {
			var_22_4
		}
		var_22_0.equips[var_22_2].equipUid = {
			var_22_3
		}

		RougeHeroSingleGroupModel.instance:swap(var_20_2, var_20_0)
		RougeHeroSingleGroupModel.instance:swap(var_20_2 + RougeEnum.FightTeamNormalHeroNum, var_20_0 + RougeEnum.FightTeamNormalHeroNum)

		local var_22_5 = RougeHeroSingleGroupModel.instance:getHeroUids()

		for iter_22_2, iter_22_3 in ipairs(var_22_0.heroList) do
			if var_22_5[iter_22_2] ~= iter_22_3 then
				RougeHeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				RougeHeroGroupModel.instance:saveCurGroupData()
				RougeHeroGroupModel.instance:rougeSaveCurGroup()
				arg_20_0:_updateHeroList()

				break
			end
		end
	end, arg_20_0)
end

function var_0_0._setHeroItemPos(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	local var_23_0 = arg_23_0.heroPosTrList[arg_23_2]
	local var_23_1 = recthelper.rectToRelativeAnchorPos(var_23_0.position, arg_23_0.heroContainer.transform)

	if arg_23_1 then
		arg_23_1:resetEquipPos()
	end

	if arg_23_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_23_1.go.transform, var_23_1.x, var_23_1.y, 0.2, arg_23_4, arg_23_5)
	else
		recthelper.setAnchor(arg_23_1.go.transform, var_23_1.x, var_23_1.y)

		if arg_23_4 then
			arg_23_4(arg_23_5)
		end
	end
end

function var_0_0._tweenToPos(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0, var_24_1 = recthelper.getAnchor(arg_24_1.go.transform)

	if math.abs(var_24_0 - arg_24_2.x) > 10 or math.abs(var_24_1 - arg_24_2.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(arg_24_1.go.transform, arg_24_2.x, arg_24_2.y, 0.2)
	else
		recthelper.setAnchor(arg_24_1.go.transform, arg_24_2.x, arg_24_2.y)
	end
end

function var_0_0._setDragEnabled(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0._heroItemDrag) do
		iter_25_1.enabled = arg_25_1
	end
end

function var_0_0._updateHeroList(arg_26_0)
	local var_26_0 = arg_26_0.viewContainer:getHeroGroupFightView():isReplayMode()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._heroItemList) do
		local var_26_1 = RougeHeroSingleGroupModel.instance:getById(iter_26_0)

		iter_26_1:onUpdateMO(var_26_1)

		if not arg_26_0._nowDragingIndex and iter_26_0 <= arg_26_0._openCount then
			arg_26_0._orderList[iter_26_0].text = var_26_1:isEmpty() and iter_26_0 or ""
		end

		if not iter_26_1.isLock and not RougeHeroSingleGroupModel.instance:isTemp() and not var_26_0 and arg_26_0._isOpen then
			if iter_26_0 == 3 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnThirdPosOpen)
			elseif iter_26_0 == 4 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFourthPosOpen)
			end
		end
	end
end

function var_0_0._checkWeekWalkCd(arg_27_0)
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_0._heroItemList) do
		local var_27_1 = iter_27_1:checkWeekWalkCd()

		if var_27_1 then
			table.insert(var_27_0, var_27_1)
		end
	end

	if #var_27_0 == 0 then
		return
	end

	UIBlockMgr.instance:startBlock("removeWeekWalkInCdHero")

	arg_27_0._heroInCdList = var_27_0

	TaskDispatcher.runDelay(arg_27_0._removeWeekWalkInCdHero, arg_27_0, 1.5)
end

function var_0_0._removeWeekWalkInCdHero(arg_28_0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if not arg_28_0._heroInCdList then
		return
	end

	local var_28_0 = arg_28_0._heroInCdList

	arg_28_0._heroInCdList = nil

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		RougeHeroSingleGroupModel.instance:remove(iter_28_1)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._calcIndex(arg_29_0, arg_29_1)
	for iter_29_0 = 1, 4 do
		local var_29_0 = arg_29_0.heroPosTrList[iter_29_0].parent
		local var_29_1 = recthelper.screenPosToAnchorPos(arg_29_1, var_29_0)

		if math.abs(var_29_1.x) * 2 < recthelper.getWidth(var_29_0) and math.abs(var_29_1.y) * 2 < recthelper.getHeight(var_29_0) then
			return iter_29_0
		end
	end

	return 0
end

function var_0_0.onDestroyView(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.closeThis, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._removeWeekWalkInCdHero, arg_30_0)
	UIBlockMgr.instance:endBlock("removeWeekWalkInCdHero")

	if arg_30_0._openTweenIdList then
		for iter_30_0, iter_30_1 in ipairs(arg_30_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_30_1)
		end
	end

	if arg_30_0._closeTweenIdList then
		for iter_30_2, iter_30_3 in ipairs(arg_30_0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(iter_30_3)
		end
	end
end

function var_0_0._onScreenSizeChange(arg_31_0)
	for iter_31_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_31_0 = arg_31_0._heroItemList[iter_31_0]

		arg_31_0:_setHeroItemPos(var_31_0, iter_31_0)
	end
end

return var_0_0
