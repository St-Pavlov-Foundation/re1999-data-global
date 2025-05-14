module("modules.logic.seasonver.act166.view.Season166HeroGroupListView", package.seeall)

local var_0_0 = class("Season166HeroGroupListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.heroContainer = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/area")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/hero/heroitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	local var_2_0 = Season166HeroGroupModel.instance.battleId
	local var_2_1 = lua_battle.configDict[var_2_0]
	local var_2_2 = Season166Model.instance:getBattleContext()

	arg_2_0.episodeType = Season166HeroGroupModel.instance.episodeType
	arg_2_0._playerMax = var_2_1.playerMax
	arg_2_0._roleNum = var_2_1.roleNum
	arg_2_0._heroItemList = {}

	gohelper.setActive(arg_2_0._goheroitem, false)

	arg_2_0.heroPosTrList = arg_2_0:getUserDataTb_()
	arg_2_0._heroItemPosList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, arg_2_0._roleNum do
		local var_2_3 = gohelper.findChild(arg_2_0.heroContainer, "pos" .. iter_2_0 .. "/container").transform
		local var_2_4 = gohelper.cloneInPlace(arg_2_0._goheroitem, "item" .. iter_2_0)
		local var_2_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_4, arg_2_0:_getHeroItemCls(), arg_2_0)

		var_2_5:setIndex(iter_2_0)

		local var_2_6 = var_2_2 and var_2_2.teachId and var_2_2.teachId > 0

		var_2_5:setIsTeachItem(var_2_6)
		table.insert(arg_2_0.heroPosTrList, var_2_3)
		table.insert(arg_2_0._heroItemList, var_2_5)
		gohelper.setActive(var_2_4, true)
		arg_2_0:_setHeroItemPos(var_2_5, iter_2_0)
		table.insert(arg_2_0._heroItemPosList, var_2_5.go.transform)
		var_2_5:setParent(arg_2_0.heroPosTrList[iter_2_0])
		CommonDragHelper.instance:registerDragObj(var_2_5.go, arg_2_0._onBeginDrag, nil, arg_2_0._onEndDrag, arg_2_0._checkCanDrag, arg_2_0, iter_2_0)
	end

	arg_2_0._bgList = arg_2_0:getUserDataTb_()
	arg_2_0._orderList = arg_2_0:getUserDataTb_()

	local var_2_7 = Season166HeroGroupModel.instance:positionOpenCount()
	local var_2_8 = Season166HeroGroupModel.instance:getBattleRoleNum()

	if var_2_8 then
		var_2_7 = math.min(var_2_8, var_2_7)
	end

	arg_2_0._openCount = var_2_7

	for iter_2_1 = 1, arg_2_0._roleNum do
		local var_2_9 = gohelper.findChild(arg_2_0.viewGO, "herogroupcontain/hero/bg" .. iter_2_1 .. "/bg")

		table.insert(arg_2_0._bgList, var_2_9)

		local var_2_10 = gohelper.findChildTextMesh(arg_2_0.viewGO, "herogroupcontain/hero/bg" .. iter_2_1 .. "/bg/txt_order")

		var_2_10.text = iter_2_1 <= var_2_7 and tostring(iter_2_1) or ""

		table.insert(arg_2_0._orderList, var_2_10)
	end

	Season166HeroGroupController.instance:dispatchEvent(Season166Event.OnCreateHeroItemDone)
	Season166HeroGroupModel.instance:setHeroGroupItemPos(arg_2_0._heroItemPosList)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(Season166Controller.instance, Season166Event.OpenPickAssistView, arg_3_0.openPickAssistView, arg_3_0)
	arg_3_0:addEventCb(Season166Controller.instance, Season166Event.CleanAssistData, arg_3_0.cleanAssistData, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_3_0._updateHeroList, arg_3_0)
	arg_3_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenSizeChange, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeEventCb(Season166Controller.instance, Season166Event.OpenPickAssistView, arg_4_0.openPickAssistView, arg_4_0)
	arg_4_0:removeEventCb(Season166Controller.instance, Season166Event.CleanAssistData, arg_4_0.cleanAssistData, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_4_0._updateHeroList, arg_4_0)
	arg_4_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenSizeChange, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0.actId = arg_5_0.viewParam.actId

	arg_5_0:_updateHeroList()
	arg_5_0:_playOpenAnimation()
	arg_5_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, arg_5_0._onHeroGroupExit, arg_5_0)
end

function var_0_0._getHeroItemCls(arg_6_0)
	return Season166HeroGroupHeroItem
end

function var_0_0._updateHeroList(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._heroItemList) do
		if Season166HeroGroupModel.instance:isSeason166Episode() then
			local var_7_0 = Season166HeroGroupModel.instance:getCurGroupMO()
			local var_7_1 = Season166HeroSingleGroupModel.instance:getById(iter_7_0)
			local var_7_2 = Season166HeroSingleGroupModel.instance.assistMO

			if var_7_2 and var_7_2.pickAssistHeroMO.heroUid == var_7_1.heroUid then
				var_7_1 = var_7_2
			end

			var_7_1.id = iter_7_0
			var_7_1.heroUid = var_7_0.heroList[iter_7_0]

			iter_7_1:onUpdateMO(var_7_1)

			if not arg_7_0._nowDragingIndex and iter_7_0 <= arg_7_0._openCount then
				arg_7_0._orderList[iter_7_0].text = var_7_1:isEmpty() and iter_7_0 or ""
			end
		end
	end
end

function var_0_0._playOpenAnimation(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.heroPosTrList) do
		if iter_8_1 then
			local var_8_0 = iter_8_1.gameObject:GetComponent(typeof(UnityEngine.Animator))

			var_8_0:Play(UIAnimationName.Open)
			var_8_0:Update(0)

			var_8_0.speed = 1
		end
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0._heroItemList) do
		if iter_8_3 then
			local var_8_1 = iter_8_3.anim

			var_8_1:Play(UIAnimationName.Open)
			var_8_1:Update(0)

			var_8_1.speed = 1
		end
	end

	for iter_8_4, iter_8_5 in ipairs(arg_8_0._bgList) do
		if iter_8_5 then
			local var_8_2 = iter_8_5:GetComponent(typeof(UnityEngine.Animator))

			var_8_2:Play(UIAnimationName.Open)
			var_8_2:Update(0)

			var_8_2.speed = 1
		end
	end
end

function var_0_0.openPickAssistView(arg_9_0)
	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.Activity166, arg_9_0.actId, nil, arg_9_0.pickOverCallBack, arg_9_0, true)
end

function var_0_0.cleanAssistData(arg_10_0)
	arg_10_0._assistMO = nil
end

function var_0_0.pickOverCallBack(arg_11_0, arg_11_1)
	if not arg_11_1 then
		arg_11_0._assistMO = nil

		return
	end

	local var_11_0 = arg_11_0._assistMO and arg_11_0._assistMO.id or arg_11_0:_getAssistIndex(arg_11_1.heroMO.heroId)

	if not var_11_0 then
		return
	end

	arg_11_0._assistMO = arg_11_0._assistMO or Season166AssistHeroSingleGroupMO.New()

	arg_11_0._assistMO:init(var_11_0, arg_11_1)
	Season166HeroSingleGroupModel.instance:setAssistHeroGroupMO(arg_11_0._assistMO)
	Season166HeroSingleGroupModel.instance:addTo(arg_11_1.heroMO.uid, var_11_0)
	Season166HeroGroupModel.instance:replaceSingleGroup()
	Season166HeroGroupModel.instance:saveCurGroupData()
	Season166Controller.instance:dispatchEvent(Season166Event.OnSelectPickAssist, arg_11_0._assistMO)
end

function var_0_0._getAssistIndex(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._heroItemList) do
		local var_12_0 = Season166HeroSingleGroupModel.instance:getById(iter_12_0):getHeroMO()

		if var_12_0 and var_12_0.heroId == arg_12_1 and arg_12_1 then
			Season166HeroSingleGroupModel.instance:removeFrom(iter_12_0)

			return iter_12_0
		end
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0._heroItemList) do
		if not Season166HeroSingleGroupModel.instance:getById(iter_12_2):getHeroMO() then
			return iter_12_2
		end
	end
end

function var_0_0._checkCanDrag(arg_13_0, arg_13_1)
	if not arg_13_0:canDrag(arg_13_1) then
		if arg_13_0._heroItemList[arg_13_1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return true
	end
end

function var_0_0.canDrag(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1
	local var_14_1 = arg_14_0._heroItemList[var_14_0]

	if var_14_1.isAid then
		return false
	end

	if var_14_1.isTrialLock then
		return false
	end

	if not arg_14_2 and (var_14_1.mo:isEmpty() or var_14_1.mo.aid == -1 or arg_14_1 > Season166HeroGroupModel.instance:positionOpenCount()) then
		return false
	end

	return true
end

function var_0_0._onBeginDrag(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:canDrag(arg_15_1) then
		return
	end

	if arg_15_0._nowDragingIndex then
		return
	end

	if arg_15_1 <= arg_15_0._openCount then
		arg_15_0._orderList[arg_15_1].text = arg_15_1
	end

	arg_15_0._nowDragingIndex = arg_15_1

	local var_15_0 = arg_15_0._heroItemList[arg_15_1]

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._heroItemList) do
		iter_15_1:onItemBeginDrag(arg_15_1)
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0._heroItemList) do
		iter_15_3:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(var_15_0.go)
end

function var_0_0._onEndDrag(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0:canDrag(arg_16_1) then
		return
	end

	if arg_16_0._nowDragingIndex ~= arg_16_1 then
		return
	end

	arg_16_0._nowDragingIndex = nil

	local var_16_0 = arg_16_0:_calcIndex(arg_16_2.position)
	local var_16_1 = arg_16_0._heroItemList[arg_16_1]
	local var_16_2 = arg_16_1

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._heroItemList) do
		iter_16_1:onItemEndDrag(var_16_2, var_16_0)
	end

	CommonDragHelper.instance:setGlobalEnabled(false)

	if var_16_0 == arg_16_1 or var_16_0 <= 0 then
		arg_16_0._orderList[arg_16_1].text = ""
	end

	local function var_16_3(arg_17_0, arg_17_1)
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._heroItemList) do
			iter_17_1:onItemCompleteDrag(var_16_2, var_16_0, arg_17_1)
		end

		CommonDragHelper.instance:setGlobalEnabled(true)

		for iter_17_2, iter_17_3 in ipairs(arg_17_0._heroItemList) do
			iter_17_3:flowCurrentParent()
		end
	end

	if var_16_0 <= 0 then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_2, true, var_16_3, arg_16_0)

		return
	end

	if not arg_16_0:canDrag(var_16_0, true) then
		local var_16_4 = arg_16_0._heroItemList[var_16_0]

		if var_16_4 and var_16_4.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		arg_16_0:_setHeroItemPos(var_16_1, var_16_2, true, var_16_3, arg_16_0)

		return
	end

	if var_16_0 <= 0 then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_2, true, var_16_3, arg_16_0)

		return
	end

	local var_16_5 = Season166HeroGroupModel.instance.battleId
	local var_16_6 = var_16_5 and lua_battle.configDict[var_16_5]

	if var_16_0 > Season166HeroGroupModel.instance:positionOpenCount() then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_2, true, var_16_3, arg_16_0)
		logError("drag to Error OpenCount Pos")

		return
	end

	local var_16_7 = Season166HeroGroupModel.instance:getBattleRoleNum()

	if var_16_7 and var_16_7 < var_16_0 then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_2, true, var_16_3, arg_16_0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if var_16_6 and var_16_1.mo.aid and var_16_0 > var_16_6.playerMax then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_2, true, var_16_3, arg_16_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local var_16_8 = arg_16_0._heroItemList[var_16_0]

	if var_16_8.mo.aid then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_2, true, var_16_3, arg_16_0)

		return
	end

	if var_16_2 ~= var_16_0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(var_16_8.go)
	gohelper.setAsLastSibling(var_16_1.go)
	var_16_8:flowOriginParent()

	arg_16_0._tweenId = arg_16_0:_setHeroItemPos(var_16_8, var_16_2, true)

	arg_16_0:_setHeroItemPos(var_16_1, var_16_0, true, function()
		if arg_16_0._tweenId then
			ZProj.TweenHelper.KillById(arg_16_0._tweenId)
		end

		for iter_18_0, iter_18_1 in ipairs(arg_16_0._heroItemList) do
			arg_16_0:_setHeroItemPos(iter_18_1, iter_18_0)
		end

		var_16_3(arg_16_0, true)

		local var_18_0 = Season166HeroGroupModel.instance:getCurGroupMO()
		local var_18_1 = var_16_1.mo.id - 1
		local var_18_2 = var_16_8.mo.id - 1
		local var_18_3 = var_18_0:getPosEquips(var_18_1).equipUid[1]
		local var_18_4 = var_18_0:getPosEquips(var_18_2).equipUid[1]

		var_18_0.equips[var_18_1].equipUid = {
			var_18_4
		}
		var_18_0.equips[var_18_2].equipUid = {
			var_18_3
		}

		Season166HeroSingleGroupModel.instance:swap(var_16_2, var_16_0)

		local var_18_5 = Season166HeroSingleGroupModel.instance:getHeroUids()

		for iter_18_2, iter_18_3 in ipairs(var_18_0.heroList) do
			if var_18_5[iter_18_2] ~= iter_18_3 then
				Season166HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				Season166HeroGroupModel.instance:saveCurGroupData()
				arg_16_0:_updateHeroList()

				break
			end
		end
	end, arg_16_0)
end

function var_0_0._calcIndex(arg_19_0, arg_19_1)
	for iter_19_0 = 1, arg_19_0._roleNum do
		local var_19_0 = arg_19_0.heroPosTrList[iter_19_0].parent

		if gohelper.isMouseOverGo(var_19_0, arg_19_1) then
			return iter_19_0
		end
	end

	return 0
end

function var_0_0._setHeroItemPos(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = arg_20_0.heroPosTrList[arg_20_2]
	local var_20_1 = recthelper.rectToRelativeAnchorPos(var_20_0.position, arg_20_0.heroContainer.transform)

	if arg_20_1 then
		arg_20_1:resetEquipPos()
	end

	if arg_20_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_20_1.go.transform, var_20_1.x, var_20_1.y, 0.2, arg_20_4, arg_20_5)
	else
		recthelper.setAnchor(arg_20_1.go.transform, var_20_1.x, var_20_1.y)

		if arg_20_4 then
			arg_20_4(arg_20_5)
		end
	end
end

function var_0_0._onHeroGroupExit(arg_21_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	arg_21_0._closeTweenIdList = {}

	for iter_21_0 = 1, 4 do
		local var_21_0 = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - iter_21_0), nil, arg_21_0._closeTweenFinish, arg_21_0, iter_21_0, EaseType.Linear)

		table.insert(arg_21_0._closeTweenIdList, var_21_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(arg_21_0.viewName, false, false)
end

function var_0_0._closeTweenFinish(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.heroPosTrList[arg_22_1]

	if var_22_0 then
		local var_22_1 = var_22_0.gameObject:GetComponent(typeof(UnityEngine.Animator))

		var_22_1:Play(UIAnimationName.Close)

		var_22_1.speed = 1
	end

	local var_22_2 = arg_22_0._heroItemList[arg_22_1]

	if var_22_2 then
		local var_22_3 = var_22_2.anim

		var_22_3:Play(UIAnimationName.Close)

		var_22_3.speed = 1
	end

	local var_22_4 = arg_22_0._bgList[arg_22_1]

	if var_22_4 then
		local var_22_5 = var_22_4:GetComponent(typeof(UnityEngine.Animator))

		var_22_5:Play(UIAnimationName.Close)

		var_22_5.speed = 1
	end
end

function var_0_0.onDestroyView(arg_23_0)
	CommonDragHelper.instance:setGlobalEnabled(true)

	for iter_23_0 = 1, arg_23_0._roleNum do
		CommonDragHelper.instance:unregisterDragObj(arg_23_0._heroItemList[iter_23_0].go)
	end

	if arg_23_0._closeTweenIdList then
		for iter_23_1, iter_23_2 in ipairs(arg_23_0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(iter_23_2)
		end
	end
end

function var_0_0._onScreenSizeChange(arg_24_0)
	for iter_24_0 = 1, arg_24_0._roleNum do
		local var_24_0 = arg_24_0._heroItemList[iter_24_0]

		arg_24_0:_setHeroItemPos(var_24_0, iter_24_0)
	end
end

return var_0_0
