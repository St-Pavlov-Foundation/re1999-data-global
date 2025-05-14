module("modules.logic.season.view.SeasonHeroGroupListView", package.seeall)

local var_0_0 = class("SeasonHeroGroupListView", BaseView)

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
		local var_2_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_3, SeasonHeroGroupHeroItem, arg_2_0)

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
	ViewMgr.instance:closeView(ViewName.SeasonHeroGroupFightView, false, false)
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

function var_0_0._onBeginDrag(arg_11_0, arg_11_1, arg_11_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_11_0._tweening then
		return
	end

	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_0._heroItemList[var_11_0]

	if var_11_1.mo:isEmpty() or var_11_1.mo.aid == -1 or arg_11_1 > HeroGroupModel.instance:positionOpenCount() then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._heroItemList) do
		iter_11_1:onItemBeginDrag(var_11_0)
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_0._heroItemList) do
		iter_11_3:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(var_11_1.go)

	local var_11_2 = recthelper.screenPosToAnchorPos(arg_11_2.position, arg_11_0._goheroarea.transform)

	arg_11_0:_tweenToPos(var_11_1, var_11_2)
end

function var_0_0._onDrag(arg_12_0, arg_12_1, arg_12_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_0._heroItemList[var_12_0]

	if var_12_1.mo:isEmpty() or var_12_1.mo.aid == -1 or arg_12_1 > HeroGroupModel.instance:positionOpenCount() then
		return
	end

	local var_12_2 = recthelper.screenPosToAnchorPos(arg_12_2.position, arg_12_0._goheroarea.transform)

	arg_12_0:_tweenToPos(var_12_1, var_12_2)
end

function var_0_0._onEndDrag(arg_13_0, arg_13_1, arg_13_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_0._heroItemList[var_13_0]

	if var_13_1.mo:isEmpty() or var_13_1.mo.aid == -1 or var_13_0 > HeroGroupModel.instance:positionOpenCount() then
		return
	end

	local var_13_2 = arg_13_0:_calcIndex(arg_13_2.position)

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._heroItemList) do
		iter_13_1:onItemEndDrag(var_13_0, var_13_2)
	end

	arg_13_0:_setDragEnabled(false)

	local function var_13_3(arg_14_0, arg_14_1)
		for iter_14_0, iter_14_1 in ipairs(arg_14_0._heroItemList) do
			iter_14_1:onItemCompleteDrag(var_13_0, var_13_2, arg_14_1)
		end

		arg_14_0:_setDragEnabled(true)

		for iter_14_2, iter_14_3 in ipairs(arg_14_0._heroItemList) do
			iter_14_3:flowCurrentParent()
		end
	end

	if var_13_2 <= 0 then
		arg_13_0:_setHeroItemPos(var_13_1, var_13_0, true, var_13_3, arg_13_0)

		return
	end

	local var_13_4 = HeroGroupModel.instance.battleId
	local var_13_5 = var_13_4 and lua_battle.configDict[var_13_4]

	if var_13_2 > HeroGroupModel.instance:positionOpenCount() then
		arg_13_0:_setHeroItemPos(var_13_1, var_13_0, true, var_13_3, arg_13_0)

		local var_13_6, var_13_7 = HeroGroupModel.instance:getPositionLockDesc(var_13_2)

		GameFacade.showToast(var_13_6, var_13_7)

		return
	end

	local var_13_8 = HeroGroupModel.instance:getBattleRoleNum()

	if var_13_8 and var_13_8 < var_13_2 then
		arg_13_0:_setHeroItemPos(var_13_1, var_13_0, true, var_13_3, arg_13_0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if var_13_5 and var_13_1.mo.aid and var_13_2 > var_13_5.playerMax then
		arg_13_0:_setHeroItemPos(var_13_1, var_13_0, true, var_13_3, arg_13_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local var_13_9 = arg_13_0._heroItemList[var_13_2]

	if var_13_9.mo.aid and var_13_9.mo.aid ~= -1 and var_13_5 and var_13_0 > var_13_5.playerMax then
		arg_13_0:_setHeroItemPos(var_13_1, var_13_0, true, var_13_3, arg_13_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	if var_13_0 ~= var_13_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(var_13_9.go)
	gohelper.setAsLastSibling(var_13_1.go)
	var_13_9:flowOriginParent()

	arg_13_0._tweenId = arg_13_0:_setHeroItemPos(var_13_9, var_13_0, true)

	arg_13_0:_setHeroItemPos(var_13_1, var_13_2, true, function()
		if arg_13_0._tweenId then
			ZProj.TweenHelper.KillById(arg_13_0._tweenId)
		end

		for iter_15_0, iter_15_1 in ipairs(arg_13_0._heroItemList) do
			arg_13_0:_setHeroItemPos(iter_15_1, iter_15_0)
		end

		var_13_3(arg_13_0, true)

		local var_15_0 = HeroGroupModel.instance:getCurGroupMO()
		local var_15_1 = var_13_1.mo.id - 1
		local var_15_2 = var_13_9.mo.id - 1
		local var_15_3 = var_15_0:getPosEquips(var_15_1).equipUid[1]
		local var_15_4 = var_15_0:getPosEquips(var_15_2).equipUid[1]

		var_15_0.equips[var_15_1].equipUid = {
			var_15_4
		}
		var_15_0.equips[var_15_2].equipUid = {
			var_15_3
		}

		local var_15_5 = var_15_0:getAct104PosEquips(var_15_1).equipUid
		local var_15_6 = var_15_0:getAct104PosEquips(var_15_2).equipUid

		var_15_0.activity104Equips[var_15_1].equipUid = var_15_6
		var_15_0.activity104Equips[var_15_2].equipUid = var_15_5

		local var_15_7 = var_15_0.heroList[var_15_1 + 1]
		local var_15_8 = var_15_0.heroList[var_15_2 + 1]

		var_15_0.heroList[var_15_1 + 1] = var_15_8
		var_15_0.heroList[var_15_2 + 1] = var_15_7

		arg_13_0:_updateHeroList()

		local var_15_9 = ActivityEnum.Activity.Season
		local var_15_10 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_15_9)
		local var_15_11 = {
			groupIndex = var_15_10,
			heroGroup = var_15_0
		}

		HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, var_15_11)
	end)
end

function var_0_0._setHeroItemPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = arg_16_0.heroPosTrList[arg_16_2]
	local var_16_1 = recthelper.rectToRelativeAnchorPos(var_16_0.position, arg_16_0._goheroarea.transform)

	if arg_16_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_16_1.go.transform, var_16_1.x, var_16_1.y, 0.2, arg_16_4, arg_16_5)
	else
		recthelper.setAnchor(arg_16_1.go.transform, var_16_1.x, var_16_1.y)

		if arg_16_4 then
			arg_16_4(arg_16_5)
		end
	end
end

function var_0_0._tweenToPos(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = recthelper.getAnchor(arg_17_1.go.transform)

	if math.abs(var_17_0 - arg_17_2.x) > 10 or math.abs(var_17_1 - arg_17_2.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(arg_17_1.go.transform, arg_17_2.x, arg_17_2.y, 0.2)
	else
		recthelper.setAnchor(arg_17_1.go.transform, arg_17_2.x, arg_17_2.y)
	end
end

function var_0_0._setDragEnabled(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._heroItemDrag) do
		iter_18_1.enabled = arg_18_1
	end
end

function var_0_0._updateHeroList(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._heroItemList) do
		local var_19_0 = HeroGroupModel.instance:getCurGroupMO()
		local var_19_1 = {}
		local var_19_2 = HeroSingleGroupMO.New()

		var_19_2.id = iter_19_0
		var_19_2.heroUid = var_19_0.heroList[iter_19_0]

		iter_19_1:onUpdateMO(var_19_2)
	end
end

function var_0_0._onSnapshotSaveSucc(arg_20_0)
	arg_20_0:_updateHeroList()
	gohelper.setActive(arg_20_0._goheroarea, false)
	gohelper.setActive(arg_20_0._goheroarea, true)
	gohelper.setActive(arg_20_0._gohero, false)
	gohelper.setActive(arg_20_0._gohero, true)
end

function var_0_0._calcIndex(arg_21_0, arg_21_1)
	for iter_21_0 = 1, 4 do
		local var_21_0 = arg_21_0.heroPosTrList[iter_21_0].parent
		local var_21_1 = recthelper.screenPosToAnchorPos(arg_21_1, var_21_0)

		if math.abs(var_21_1.x) * 2 < recthelper.getWidth(var_21_0) and math.abs(var_21_1.y) * 2 < recthelper.getHeight(var_21_0) then
			return iter_21_0
		end
	end

	return 0
end

function var_0_0.onDestroyView(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0.closeThis, arg_22_0)

	if arg_22_0._openTweenIdList then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_22_1)
		end
	end

	if arg_22_0._closeTweenIdList then
		for iter_22_2, iter_22_3 in ipairs(arg_22_0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(iter_22_3)
		end
	end
end

function var_0_0._onScreenSizeChange(arg_23_0)
	for iter_23_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_23_0 = arg_23_0._heroItemList[iter_23_0]

		arg_23_0:_setHeroItemPos(var_23_0, iter_23_0)
	end
end

function var_0_0.getHeroItemList(arg_24_0)
	return arg_24_0._heroItemList
end

return var_0_0
