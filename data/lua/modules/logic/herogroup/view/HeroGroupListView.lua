module("modules.logic.herogroup.view.HeroGroupListView", package.seeall)

slot0 = class("HeroGroupListView", BaseView)

function slot0.onInitView(slot0)
	slot0.heroContainer = gohelper.findChild(slot0.viewGO, "herogroupcontain/area")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/heroitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot2 = lua_battle.configDict[HeroGroupModel.instance.battleId]
	slot0._playerMax = slot2.playerMax
	slot0._roleNum = slot2.roleNum
	slot0._heroItemList = {}
	slot6 = false

	gohelper.setActive(slot0._goheroitem, slot6)

	slot0.heroPosTrList = slot0:getUserDataTb_()
	slot0._heroItemPosList = slot0:getUserDataTb_()

	for slot6 = 1, ModuleEnum.MaxHeroCountInGroup do
		slot9 = gohelper.cloneInPlace(slot0._goheroitem, "item" .. slot6)
		slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(slot9, slot0:_getHeroItemCls(), slot0)

		slot10:setIndex(slot6)
		table.insert(slot0.heroPosTrList, gohelper.findChild(slot0.heroContainer, "pos" .. slot6 .. "/container").transform)
		table.insert(slot0._heroItemList, slot10)
		gohelper.setActive(slot9, true)
		slot0:_setHeroItemPos(slot10, slot6)
		table.insert(slot0._heroItemPosList, slot10.go.transform)
		slot10:setParent(slot0.heroPosTrList[slot6])
		CommonDragHelper.instance:registerDragObj(slot10.go, slot0._onBeginDrag, nil, slot0._onEndDrag, slot0._checkCanDrag, slot0, slot6)
	end

	slot0._bgList = slot0:getUserDataTb_()
	slot0._orderList = slot0:getUserDataTb_()

	if HeroGroupModel.instance:getBattleRoleNum() then
		slot3 = math.min(slot4, HeroGroupModel.instance:positionOpenCount())
	end

	slot8 = slot3
	slot0._openCount = math.min(slot0._playerMax, slot8)

	for slot8 = 1, 4 do
		table.insert(slot0._bgList, gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/bg" .. slot8 .. "/bg"))

		slot10 = gohelper.findChildTextMesh(slot0.viewGO, "herogroupcontain/hero/bg" .. slot8 .. "/bg/#txt_order")
		slot10.text = slot8 <= slot3 and tostring(slot8) or ""

		table.insert(slot0._orderList, slot10)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCreateHeroItemDone)
	HeroGroupModel.instance:setHeroGroupItemPos(slot0._heroItemPosList)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, slot0._checkRestrictHero, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._checkRestrictHero, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._updateHeroList, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupSelectIndex, slot0._checkRestrictHero, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._checkRestrictHero, slot0)
end

function slot0.onOpen(slot0)
	slot0._isOpen = true

	slot0:_updateHeroList()
	slot0:_playOpenAnimation()
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, slot0._onHeroGroupExit, slot0)
end

function slot0._playOpenAnimation(slot0)
	for slot4, slot5 in ipairs(slot0.heroPosTrList) do
		if slot5 then
			slot6 = slot5.gameObject:GetComponent(typeof(UnityEngine.Animator))

			slot6:Play(UIAnimationName.Open)
			slot6:Update(0)

			slot6.speed = 1
		end
	end

	for slot4, slot5 in ipairs(slot0._heroItemList) do
		if slot5 then
			slot6 = slot5.anim

			slot6:Play(UIAnimationName.Open)
			slot6:Update(0)

			slot6.speed = 1
		end
	end

	for slot4, slot5 in ipairs(slot0._bgList) do
		if slot5 then
			slot6 = slot5:GetComponent(typeof(UnityEngine.Animator))

			slot6:Play(UIAnimationName.Open)
			slot6:Update(0)

			slot6.speed = 1
		end
	end

	slot0:_checkRestrictHero()
end

function slot0._getHeroItemCls(slot0)
	return HeroGroupHeroItem
end

function slot0._checkRestrictHero(slot0)
	for slot5 = 1, 4 do
		if HeroSingleGroupModel.instance:getById(slot5) and HeroGroupModel.instance:isRestrict(slot6.heroUid) then
			-- Nothing
		end
	end

	if tabletool.len({
		[slot6.heroUid] = true
	}) <= 0 then
		return
	end

	if not string.nilorempty(HeroGroupModel.instance:getCurrentBattleConfig() and slot2.restrictReason) then
		ToastController.instance:showToastWithString(slot3)
	end

	for slot7, slot8 in ipairs(slot0._heroItemList) do
		slot8:playRestrictAnimation(slot1)
	end

	slot0.needRemoveHeroUidDict = slot1

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(slot0._removeRestrictHero, slot0, 1.5)
end

function slot0._removeRestrictHero(slot0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not slot0.needRemoveHeroUidDict then
		return
	end

	for slot4, slot5 in pairs(slot0.needRemoveHeroUidDict) do
		HeroSingleGroupModel.instance:remove(slot4)
	end

	for slot4, slot5 in ipairs(slot0._heroItemList) do
		slot5:resetGrayFactor()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function slot0._onHeroGroupExit(slot0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear)

	if slot0._openTweenIdList then
		for slot4, slot5 in ipairs(slot0._openTweenIdList) do
			ZProj.TweenHelper.KillById(slot5)
		end
	end

	slot0._closeTweenIdList = {}

	for slot4 = 1, 4 do
		table.insert(slot0._closeTweenIdList, ZProj.TweenHelper.DOTweenFloat(0, 1, 0.03 * (4 - slot4), nil, slot0._closeTweenFinish, slot0, slot4, EaseType.Linear))
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupExitEffect)
	ViewMgr.instance:closeView(slot0.viewName, false, false)
end

function slot0._closeTweenFinish(slot0, slot1)
	if slot0.heroPosTrList[slot1] then
		slot3 = slot2.gameObject:GetComponent(typeof(UnityEngine.Animator))

		slot3:Play(UIAnimationName.Close)

		slot3.speed = 1
	end

	if slot0._heroItemList[slot1] then
		slot4 = slot3.anim

		slot4:Play(UIAnimationName.Close)

		slot4.speed = 1
	end

	if slot0._bgList[slot1] then
		slot5 = slot4:GetComponent(typeof(UnityEngine.Animator))

		slot5:Play(UIAnimationName.Close)

		slot5.speed = 1
	end
end

function slot0.canDrag(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	if slot0._heroItemList[slot1].isAid then
		return false
	end

	if slot4.isTrialLock then
		return false
	end

	if not slot2 and (slot4.mo:isEmpty() or slot4.mo.aid == -1 or HeroGroupModel.instance:positionOpenCount() < slot1) then
		return false
	end

	return true
end

function slot0._checkCanDrag(slot0, slot1)
	if not slot0:canDrag(slot1) then
		if slot0._heroItemList[slot1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return true
	end
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if slot0._tweening then
		return
	end

	if not slot0:canDrag(slot1) then
		return
	end

	if slot0._nowDragingIndex then
		return
	end

	if slot1 <= slot0._openCount then
		slot0._orderList[slot1].text = slot1
	end

	slot0._nowDragingIndex = slot1
	slot3 = slot0._heroItemList[slot1]

	for slot7, slot8 in ipairs(slot0._heroItemList) do
		slot8:onItemBeginDrag(slot1)
	end

	for slot7, slot8 in ipairs(slot0._heroItemList) do
		slot8:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(slot3.go)
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if not slot0:canDrag(slot1) then
		return
	end

	if slot0._nowDragingIndex ~= slot1 then
		return
	end

	slot0._nowDragingIndex = nil
	slot3 = slot0:_calcIndex(slot2.position)
	slot4 = slot0._heroItemList[slot1]

	for slot9, slot10 in ipairs(slot0._heroItemList) do
		slot10:onItemEndDrag(slot1, slot3)
	end

	CommonDragHelper.instance:setGlobalEnabled(false)

	if slot3 == slot1 or slot3 <= 0 then
		slot0._orderList[slot1].text = ""
	end

	if slot3 <= 0 then
		slot0:_setHeroItemPos(slot4, slot5, true, function (slot0, slot1)
			for slot5, slot6 in ipairs(slot0._heroItemList) do
				slot6:onItemCompleteDrag(uv0, uv1, slot1)
			end

			slot5 = true

			CommonDragHelper.instance:setGlobalEnabled(slot5)

			for slot5, slot6 in ipairs(slot0._heroItemList) do
				slot6:flowCurrentParent()
			end
		end, slot0)

		return
	end

	if not slot0:canDrag(slot3, true) then
		if slot0._heroItemList[slot3] and slot7.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)

		return
	end

	if slot3 <= 0 then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)

		return
	end

	slot8 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot7]

	if HeroGroupModel.instance:positionOpenCount() < slot3 then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)

		slot9, slot10 = HeroGroupModel.instance:getPositionLockDesc(slot3)

		GameFacade.showToast(slot9, slot10)

		return
	end

	if HeroGroupModel.instance:getBattleRoleNum() and slot9 < slot3 then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if slot8 and slot4.mo.aid and slot8.playerMax < slot3 then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	if slot0._heroItemList[slot3].mo.aid then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)

		return
	end

	if slot5 ~= slot3 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(slot10.go)
	gohelper.setAsLastSibling(slot4.go)
	slot10:flowOriginParent()

	slot0._tweenId = slot0:_setHeroItemPos(slot10, slot5, true)

	slot0:_setHeroItemPos(slot4, slot3, true, function ()
		if uv0._tweenId then
			ZProj.TweenHelper.KillById(uv0._tweenId)
		end

		for slot3, slot4 in ipairs(uv0._heroItemList) do
			uv0:_setHeroItemPos(slot4, slot3)
		end

		uv1(uv0, true)

		slot0 = HeroGroupModel.instance:getCurGroupMO()
		slot1 = uv2.mo.id - 1
		slot2 = uv3.mo.id - 1
		slot0.equips[slot1].equipUid = {
			slot0:getPosEquips(slot2).equipUid[1]
		}
		slot0.equips[slot2].equipUid = {
			slot0:getPosEquips(slot1).equipUid[1]
		}
		slot9 = uv5

		HeroSingleGroupModel.instance:swap(uv4, slot9)

		for slot9, slot10 in ipairs(slot0.heroList) do
			if HeroSingleGroupModel.instance:getHeroUids()[slot9] ~= slot10 then
				HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				HeroGroupModel.instance:saveCurGroupData()
				uv0:_updateHeroList()

				break
			end
		end
	end, slot0)
end

function slot0._setHeroItemPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = recthelper.rectToRelativeAnchorPos(slot0.heroPosTrList[slot2].position, slot0.heroContainer.transform)

	if slot1 then
		slot1:resetEquipPos()
	end

	if slot3 then
		return ZProj.TweenHelper.DOAnchorPos(slot1.go.transform, slot7.x, slot7.y, 0.2, slot4, slot5)
	else
		recthelper.setAnchor(slot1.go.transform, slot7.x, slot7.y)

		if slot4 then
			slot4(slot5)
		end
	end
end

function slot0._tweenToPos(slot0, slot1, slot2)
	slot3, slot4 = recthelper.getAnchor(slot1.go.transform)

	if math.abs(slot3 - slot2.x) > 10 or math.abs(slot4 - slot2.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(slot1.go.transform, slot2.x, slot2.y, 0.2)
	else
		recthelper.setAnchor(slot1.go.transform, slot2.x, slot2.y)
	end
end

function slot0._updateHeroList(slot0)
	slot2 = slot0.viewContainer:getHeroGroupFightView():isReplayMode()

	for slot6, slot7 in ipairs(slot0._heroItemList) do
		slot7:onUpdateMO(HeroSingleGroupModel.instance:getById(slot6))

		if not slot0._nowDragingIndex and slot6 <= slot0._openCount then
			slot0._orderList[slot6].text = slot8:isEmpty() and slot6 or ""
		end

		if not slot7.isLock and not HeroSingleGroupModel.instance:isTemp() and not slot2 and slot0._isOpen then
			if slot6 == 3 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnThirdPosOpen)
			elseif slot6 == 4 then
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFourthPosOpen)
			end
		end
	end
end

function slot0._calcIndex(slot0, slot1)
	for slot5 = 1, ModuleEnum.MaxHeroCountInGroup do
		if gohelper.isMouseOverGo(slot0.heroPosTrList[slot5].parent, slot1) then
			return slot5
		end
	end

	return 0
end

function slot0.onDestroyView(slot0)
	slot4 = true

	CommonDragHelper.instance:setGlobalEnabled(slot4)

	for slot4 = 1, ModuleEnum.MaxHeroCountInGroup do
		CommonDragHelper.instance:unregisterDragObj(slot0._heroItemList[slot4].go)
	end

	if slot0._openTweenIdList then
		for slot4, slot5 in ipairs(slot0._openTweenIdList) do
			ZProj.TweenHelper.KillById(slot5)
		end
	end

	if slot0._closeTweenIdList then
		for slot4, slot5 in ipairs(slot0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(slot5)
		end
	end
end

function slot0._onScreenSizeChange(slot0)
	for slot4 = 1, ModuleEnum.MaxHeroCountInGroup do
		slot0:_setHeroItemPos(slot0._heroItemList[slot4], slot4)
	end
end

return slot0
