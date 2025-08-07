module("modules.logic.sp01.odyssey.view.OdysseyHeroListView", package.seeall)

local var_0_0 = class("OdysseyHeroListView", BaseView)
local var_0_1 = 5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goheroarea = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/area")
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/hero")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/hero/heroitem")
	arg_1_0._heroGroupContainer = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.heroGroupWidth = recthelper.getWidth(arg_2_0._heroGroupContainer.transform)

	arg_2_0:initItemPos()
	arg_2_0:refreshHeroGroupWidth()
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
	arg_3_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_3_0._checkRestrictHero, arg_3_0)
	arg_3_0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, arg_3_0._onSnapshotSaveSucc, arg_3_0)
	arg_3_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenSizeChange, arg_3_0)
	arg_3_0:addEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_3_0._updateHeroList, arg_3_0)
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
	arg_4_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, arg_4_0._checkRestrictHero, arg_4_0)
	arg_4_0:removeEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, arg_4_0._onSnapshotSaveSucc, arg_4_0)
	arg_4_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_4_0._onScreenSizeChange, arg_4_0)
	arg_4_0:removeEventCb(OdysseyHeroGroupController.instance, OdysseyEvent.OnHeroGroupUpdate, arg_4_0._updateHeroList, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._isOpen = true

	arg_5_0:_updateHeroList()
	arg_5_0:_playOpenAnimation()
	CommonDragHelper.instance:setGlobalEnabled(true)
end

function var_0_0.initItemPos(arg_6_0)
	arg_6_0._heroItemList = {}
	arg_6_0._heroItemDrag = arg_6_0:getUserDataTb_()

	gohelper.setActive(arg_6_0._goheroitem, false)
	gohelper.setActive(arg_6_0._goaidheroitem, false)

	arg_6_0.heroPosTrList = arg_6_0:getUserDataTb_()
	arg_6_0._heroItemPosList = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, var_0_1 do
		local var_6_0 = gohelper.findChild(arg_6_0._goheroarea, "pos" .. iter_6_0 .. "/container").transform
		local var_6_1 = gohelper.cloneInPlace(arg_6_0._goheroitem, "item" .. iter_6_0)
		local var_6_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, OdysseyHeroGroupItem, arg_6_0)

		table.insert(arg_6_0.heroPosTrList, var_6_0)
		table.insert(arg_6_0._heroItemList, var_6_2)
		var_6_2:initEquipItem(arg_6_0.getEquipPrefab, arg_6_0)
		gohelper.setActive(var_6_1, true)
	end

	for iter_6_1 = 1, var_0_1 do
		local var_6_3 = arg_6_0._heroItemList[iter_6_1]

		arg_6_0:_setHeroItemPos(var_6_3, iter_6_1)
		table.insert(arg_6_0._heroItemPosList, var_6_3.go.transform)
		var_6_3:setParent(arg_6_0.heroPosTrList[iter_6_1])

		local var_6_4 = SLFramework.UGUI.UIDragListener.Get(var_6_3.go)

		table.insert(arg_6_0._heroItemDrag, var_6_4)
	end

	arg_6_0._bgList = {}

	for iter_6_2 = 1, var_0_1 do
		local var_6_5 = gohelper.findChild(arg_6_0.viewGO, "herogroupcontain/hero/bg" .. iter_6_2 .. "/bg")

		table.insert(arg_6_0._bgList, var_6_5)
	end

	HeroGroupModel.instance:setHeroGroupItemPos(arg_6_0._heroItemPosList)

	arg_6_0.odysseyEquipPosList = {}
	arg_6_0.odysseyEquipItemList = {}

	for iter_6_3 = 1, var_0_1 do
		local var_6_6 = arg_6_0._heroItemList[iter_6_3]:getOdysseyEquipItem()

		for iter_6_4, iter_6_5 in ipairs(var_6_6) do
			table.insert(arg_6_0.odysseyEquipPosList, iter_6_5.go.transform)
			table.insert(arg_6_0.odysseyEquipItemList, iter_6_5)
		end
	end

	arg_6_0._orderList = {}
	arg_6_0._bgList = {}

	for iter_6_6 = 1, var_0_1 do
		local var_6_7 = gohelper.findChild(arg_6_0.viewGO, "herogroupcontain/hero/bg" .. iter_6_6 .. "/bg")

		table.insert(arg_6_0._bgList, var_6_7)

		local var_6_8 = gohelper.findChildTextMesh(arg_6_0.viewGO, "herogroupcontain/hero/bg" .. iter_6_6 .. "/bg/#txt_order")

		var_6_8.text = tostring(iter_6_6) or ""

		table.insert(arg_6_0._orderList, var_6_8)
	end
end

function var_0_0.refreshHeroGroupWidth(arg_7_0)
	local var_7_0 = OdysseyHeroGroupModel.instance:getCurHeroGroup()

	if arg_7_0.haveSuit == nil or arg_7_0.haveSuit ~= var_7_0.haveSuit then
		local var_7_1 = var_7_0.haveSuit and arg_7_0.heroGroupWidth or 2321

		recthelper.setWidth(arg_7_0._heroGroupContainer.transform, var_7_1)
		recthelper.setWidth(arg_7_0._gohero.transform, var_7_1)
		recthelper.setWidth(arg_7_0._goheroarea.transform, var_7_1)
		logNormal("refreshHeroGroupWidth")

		for iter_7_0 = 1, var_0_1 do
			local var_7_2 = arg_7_0._heroItemList[iter_7_0]

			arg_7_0:_setHeroItemPos(var_7_2, iter_7_0)
		end

		arg_7_0.haveSuit = var_7_0.haveSuit
	end
end

function var_0_0._playOpenAnimation(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.heroPosTrList) do
		if iter_8_1 then
			local var_8_0 = iter_8_1.gameObject:GetComponent(typeof(UnityEngine.Animator))

			var_8_0:Play("open")
			var_8_0:Update(0)

			var_8_0.speed = 1
		end
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0._heroItemList) do
		if iter_8_3 then
			local var_8_1 = iter_8_3.anim

			var_8_1:Play("open")
			var_8_1:Update(0)

			var_8_1.speed = 1
		end
	end

	for iter_8_4, iter_8_5 in ipairs(arg_8_0._bgList) do
		if iter_8_5 then
			local var_8_2 = iter_8_5:GetComponent(typeof(UnityEngine.Animator))

			var_8_2:Play("open")
			var_8_2:Update(0)

			var_8_2.speed = 1
		end
	end

	arg_8_0:_checkRestrictHero()
end

function var_0_0._checkRestrictHero(arg_9_0)
	local var_9_0 = {}

	for iter_9_0 = 1, var_0_1 do
		local var_9_1 = HeroSingleGroupModel.instance:getById(iter_9_0)

		if var_9_1 and HeroGroupModel.instance:isRestrict(var_9_1.heroUid) then
			var_9_0[var_9_1.heroUid] = true
		end
	end

	if tabletool.len(var_9_0) <= 0 then
		return
	end

	local var_9_2 = HeroGroupModel.instance:getCurrentBattleConfig()
	local var_9_3 = var_9_2 and var_9_2.restrictReason

	if not string.nilorempty(var_9_3) then
		ToastController.instance:showToastWithString(var_9_3)
	end

	for iter_9_1, iter_9_2 in ipairs(arg_9_0._heroItemList) do
		iter_9_2:playRestrictAnimation(var_9_0)
	end

	arg_9_0.needRemoveHeroUidDict = var_9_0

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(arg_9_0._removeRestrictHero, arg_9_0, 1.5)
end

function var_0_0._removeRestrictHero(arg_10_0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not arg_10_0.needRemoveHeroUidDict then
		return
	end

	for iter_10_0, iter_10_1 in pairs(arg_10_0.needRemoveHeroUidDict) do
		HeroSingleGroupModel.instance:remove(iter_10_0)
	end

	HeroGroupModel.instance:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._onHeroGroupExit(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if arg_11_0._openTweenIdList then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_11_1)
		end
	end

	arg_11_0._closeTweenIdList = {}

	for iter_11_2 = 1, var_0_1 do
		local var_11_0 = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (var_0_1 - iter_11_2), nil, arg_11_0._closeTweenFinish, arg_11_0, iter_11_2, EaseType.Linear)

		table.insert(arg_11_0._closeTweenIdList, var_11_0)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(ViewName.OdysseyHeroGroupView, false, false)
end

function var_0_0._closeTweenFinish(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.heroPosTrList[arg_12_1]

	if var_12_0 then
		local var_12_1 = var_12_0.gameObject:GetComponent(typeof(UnityEngine.Animator))

		var_12_1:Play("close")

		var_12_1.speed = 1
	end

	local var_12_2 = arg_12_0._heroItemList[arg_12_1]

	if var_12_2 then
		local var_12_3 = var_12_2.anim

		var_12_3:Play("close")

		var_12_3.speed = 1
	end

	local var_12_4 = arg_12_0._bgList[arg_12_1]

	if var_12_4 then
		local var_12_5 = var_12_4:GetComponent(typeof(UnityEngine.Animator))

		var_12_5:Play("close")

		var_12_5.speed = 1
	end
end

function var_0_0.canDrag(arg_13_0, arg_13_1, arg_13_2)
	if UnityEngine.Input.touchCount > 1 then
		return false
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_0._heroItemList[var_13_0]

	if var_13_1.isAid then
		return false
	end

	if var_13_1.isTrialLock then
		return false
	end

	if not arg_13_2 and (var_13_1.mo:isEmpty() or var_13_1.mo.aid == -1 or var_13_0 > OdysseyEnum.MaxHeroGroupCount) then
		return false
	end

	return true
end

function var_0_0._onBeginDrag(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0._tweening then
		return
	end

	if not arg_14_0:canDrag(arg_14_1) then
		return
	end

	local var_14_0 = arg_14_1
	local var_14_1 = arg_14_0._heroItemList[var_14_0]

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._heroItemList) do
		iter_14_1:onItemBeginDrag(var_14_0)
	end

	for iter_14_2, iter_14_3 in ipairs(arg_14_0._heroItemList) do
		iter_14_3:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(var_14_1.go)

	local var_14_2 = recthelper.screenPosToAnchorPos(arg_14_2.position, arg_14_0._goheroarea.transform)

	arg_14_0:_tweenToPos(var_14_1, var_14_2)
end

function var_0_0._onDrag(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:canDrag(arg_15_1) then
		if arg_15_0._heroItemList[arg_15_1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return
	end

	local var_15_0 = arg_15_1
	local var_15_1 = arg_15_0._heroItemList[var_15_0]
	local var_15_2 = recthelper.screenPosToAnchorPos(arg_15_2.position, arg_15_0._goheroarea.transform)

	arg_15_0:_tweenToPos(var_15_1, var_15_2)
end

function var_0_0._onEndDrag(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0:canDrag(arg_16_1) then
		return
	end

	local var_16_0 = arg_16_1
	local var_16_1 = arg_16_0._heroItemList[var_16_0]
	local var_16_2 = arg_16_0:_calcIndex(arg_16_2.position)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._heroItemList) do
		iter_16_1:onItemEndDrag(var_16_0, var_16_2)
	end

	arg_16_0:_setDragEnabled(false)

	local function var_16_3(arg_17_0, arg_17_1)
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._heroItemList) do
			iter_17_1:onItemCompleteDrag(var_16_0, var_16_2, arg_17_1)
		end

		arg_17_0:_setDragEnabled(true)

		for iter_17_2, iter_17_3 in ipairs(arg_17_0._heroItemList) do
			iter_17_3:flowCurrentParent()
		end
	end

	if var_16_2 <= 0 or not arg_16_0:canDrag(var_16_2, true) then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_0, true, var_16_3, arg_16_0)

		return
	end

	local var_16_4 = HeroGroupModel.instance.battleId
	local var_16_5 = var_16_4 and lua_battle.configDict[var_16_4]
	local var_16_6 = HeroGroupModel.instance:getBattleRoleNum()

	if var_16_6 and var_16_6 < var_16_2 then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_0, true, var_16_3, arg_16_0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if var_16_5 and var_16_1.mo.aid and var_16_2 > var_16_5.playerMax then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_0, true, var_16_3, arg_16_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	local var_16_7 = arg_16_0._heroItemList[var_16_2]

	if var_16_7.mo.aid and var_16_7.mo.aid ~= -1 and var_16_5 and var_16_0 > var_16_5.playerMax then
		arg_16_0:_setHeroItemPos(var_16_1, var_16_0, true, var_16_3, arg_16_0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	if var_16_0 ~= var_16_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(var_16_7.go)
	gohelper.setAsLastSibling(var_16_1.go)
	var_16_7:flowOriginParent()

	arg_16_0._tweenId = arg_16_0:_setHeroItemPos(var_16_7, var_16_0, true)

	arg_16_0:_setHeroItemPos(var_16_1, var_16_2, true, function()
		if arg_16_0._tweenId then
			ZProj.TweenHelper.KillById(arg_16_0._tweenId)
		end

		for iter_18_0, iter_18_1 in ipairs(arg_16_0._heroItemList) do
			arg_16_0:_setHeroItemPos(iter_18_1, iter_18_0)
		end

		var_16_3(arg_16_0, true)

		local var_18_0 = HeroGroupModel.instance:getCurGroupMO()
		local var_18_1 = var_16_1.mo.id - 1
		local var_18_2 = var_16_7.mo.id - 1
		local var_18_3 = var_18_0:getPosEquips(var_18_1).equipUid[1]
		local var_18_4 = var_18_0:getPosEquips(var_18_2).equipUid[1]

		var_18_0.equips[var_18_1].equipUid = {
			var_18_4
		}
		var_18_0.equips[var_18_2].equipUid = {
			var_18_3
		}

		local var_18_5 = var_18_0:getAct104PosEquips(var_18_1).equipUid
		local var_18_6 = var_18_0:getAct104PosEquips(var_18_2).equipUid

		var_18_0.activity104Equips[var_18_1].equipUid = var_18_6
		var_18_0.activity104Equips[var_18_2].equipUid = var_18_5

		var_18_0:swapOdysseyEquips(var_18_1, var_18_2)
		HeroSingleGroupModel.instance:swap(var_16_0, var_16_2)

		local var_18_7 = HeroSingleGroupModel.instance:getHeroUids()

		for iter_18_2, iter_18_3 in ipairs(var_18_0.heroList) do
			if var_18_7[iter_18_2] ~= iter_18_3 then
				HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				HeroGroupModel.instance:saveCurGroupData()
				arg_16_0:_updateHeroList()

				break
			end
		end
	end)
end

function var_0_0._setHeroItemPos(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0 = arg_19_0.heroPosTrList[arg_19_2]
	local var_19_1 = recthelper.rectToRelativeAnchorPos(var_19_0.position, arg_19_0._goheroarea.transform)

	if arg_19_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_19_1.go.transform, var_19_1.x, var_19_1.y, 0.2, arg_19_4, arg_19_5)
	else
		recthelper.setAnchor(arg_19_1.go.transform, var_19_1.x, var_19_1.y)

		if arg_19_4 then
			arg_19_4(arg_19_5)
		end
	end
end

function var_0_0._tweenToPos(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0, var_20_1 = recthelper.getAnchor(arg_20_1.go.transform)

	if math.abs(var_20_0 - arg_20_2.x) > 10 or math.abs(var_20_1 - arg_20_2.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(arg_20_1.go.transform, arg_20_2.x, arg_20_2.y, 0.2)
	else
		recthelper.setAnchor(arg_20_1.go.transform, arg_20_2.x, arg_20_2.y)
	end
end

function var_0_0._setDragEnabled(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0._heroItemDrag) do
		iter_21_1.enabled = arg_21_1
	end
end

function var_0_0._updateHeroList(arg_22_0)
	arg_22_0:refreshHeroGroupWidth()

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._heroItemList) do
		local var_22_0 = HeroSingleGroupModel.instance:getById(iter_22_0)

		iter_22_1:onUpdateMO(var_22_0)
	end
end

function var_0_0._onSnapshotSaveSucc(arg_23_0)
	arg_23_0:_updateHeroList()
	gohelper.setActive(arg_23_0._goheroarea, false)
	gohelper.setActive(arg_23_0._goheroarea, true)
	gohelper.setActive(arg_23_0._gohero, false)
	gohelper.setActive(arg_23_0._gohero, true)
end

function var_0_0._calcIndex(arg_24_0, arg_24_1)
	for iter_24_0 = 1, OdysseyEnum.MaxHeroGroupCount do
		local var_24_0 = arg_24_0.heroPosTrList[iter_24_0].parent
		local var_24_1 = recthelper.screenPosToAnchorPos(arg_24_1, var_24_0)

		if math.abs(var_24_1.x) * 2 < recthelper.getWidth(var_24_0) and math.abs(var_24_1.y) * 2 < recthelper.getHeight(var_24_0) then
			return iter_24_0
		end
	end

	return 0
end

function var_0_0.onDestroyView(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.closeThis, arg_25_0)

	if arg_25_0._openTweenIdList then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0._openTweenIdList) do
			ZProj.TweenHelper.KillById(iter_25_1)
		end
	end

	if arg_25_0._closeTweenIdList then
		for iter_25_2, iter_25_3 in ipairs(arg_25_0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(iter_25_3)
		end
	end

	CommonDragHelper.instance:setGlobalEnabled(true)
end

function var_0_0._onScreenSizeChange(arg_26_0)
	for iter_26_0 = 1, var_0_1 do
		local var_26_0 = arg_26_0._heroItemList[iter_26_0]

		arg_26_0:_setHeroItemPos(var_26_0, iter_26_0)
	end
end

function var_0_0.getHeroItemList(arg_27_0)
	return arg_27_0._heroItemList
end

function var_0_0.getEquipPrefab(arg_28_0, arg_28_1)
	return arg_28_0:getResInst(arg_28_0.viewContainer:getSetting().otherRes[2], arg_28_1)
end

return var_0_0
