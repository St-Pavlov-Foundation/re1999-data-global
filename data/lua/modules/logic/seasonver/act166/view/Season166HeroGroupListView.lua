module("modules.logic.seasonver.act166.view.Season166HeroGroupListView", package.seeall)

slot0 = class("Season166HeroGroupListView", BaseView)

function slot0.onInitView(slot0)
	slot0.heroContainer = gohelper.findChild(slot0.viewGO, "herogroupcontain/area")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/heroitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot2 = lua_battle.configDict[Season166HeroGroupModel.instance.battleId]
	slot3 = Season166Model.instance:getBattleContext()
	slot0.episodeType = Season166HeroGroupModel.instance.episodeType
	slot0._playerMax = slot2.playerMax
	slot0._roleNum = slot2.roleNum
	slot0._heroItemList = {}
	slot7 = false

	gohelper.setActive(slot0._goheroitem, slot7)

	slot0.heroPosTrList = slot0:getUserDataTb_()
	slot0._heroItemPosList = slot0:getUserDataTb_()

	for slot7 = 1, slot0._roleNum do
		MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._goheroitem, "item" .. slot7), slot0:_getHeroItemCls(), slot0):setIndex(slot7)
		slot11:setIsTeachItem(slot3 and slot3.teachId and slot3.teachId > 0)
		table.insert(slot0.heroPosTrList, gohelper.findChild(slot0.heroContainer, "pos" .. slot7 .. "/container").transform)
		table.insert(slot0._heroItemList, slot11)
		gohelper.setActive(slot10, true)
		slot0:_setHeroItemPos(slot11, slot7)
		table.insert(slot0._heroItemPosList, slot11.go.transform)
		slot11:setParent(slot0.heroPosTrList[slot7])
		CommonDragHelper.instance:registerDragObj(slot11.go, slot0._onBeginDrag, nil, slot0._onEndDrag, slot0._checkCanDrag, slot0, slot7)
	end

	slot0._bgList = slot0:getUserDataTb_()
	slot0._orderList = slot0:getUserDataTb_()

	if Season166HeroGroupModel.instance:getBattleRoleNum() then
		slot4 = math.min(slot5, Season166HeroGroupModel.instance:positionOpenCount())
	end

	slot0._openCount = slot4

	for slot9 = 1, slot0._roleNum do
		table.insert(slot0._bgList, gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/bg" .. slot9 .. "/bg"))

		slot11 = gohelper.findChildTextMesh(slot0.viewGO, "herogroupcontain/hero/bg" .. slot9 .. "/bg/txt_order")
		slot11.text = slot9 <= slot4 and tostring(slot9) or ""

		table.insert(slot0._orderList, slot11)
	end

	Season166HeroGroupController.instance:dispatchEvent(Season166Event.OnCreateHeroItemDone)
	Season166HeroGroupModel.instance:setHeroGroupItemPos(slot0._heroItemPosList)
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OpenPickAssistView, slot0.openPickAssistView, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.CleanAssistData, slot0.cleanAssistData, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._updateHeroList, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.OpenPickAssistView, slot0.openPickAssistView, slot0)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.CleanAssistData, slot0.cleanAssistData, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._updateHeroList, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	slot0:_updateHeroList()
	slot0:_playOpenAnimation()
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, slot0._onHeroGroupExit, slot0)
end

function slot0._getHeroItemCls(slot0)
	return Season166HeroGroupHeroItem
end

function slot0._updateHeroList(slot0)
	for slot4, slot5 in ipairs(slot0._heroItemList) do
		if Season166HeroGroupModel.instance:isSeason166Episode() then
			slot6 = Season166HeroGroupModel.instance:getCurGroupMO()

			if Season166HeroSingleGroupModel.instance.assistMO and slot8.pickAssistHeroMO.heroUid == Season166HeroSingleGroupModel.instance:getById(slot4).heroUid then
				slot7 = slot8
			end

			slot7.id = slot4
			slot7.heroUid = slot6.heroList[slot4]

			slot5:onUpdateMO(slot7)

			if not slot0._nowDragingIndex and slot4 <= slot0._openCount then
				slot0._orderList[slot4].text = slot7:isEmpty() and slot4 or ""
			end
		end
	end
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
end

function slot0.openPickAssistView(slot0)
	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.Activity166, slot0.actId, nil, slot0.pickOverCallBack, slot0, true)
end

function slot0.cleanAssistData(slot0)
	slot0._assistMO = nil
end

function slot0.pickOverCallBack(slot0, slot1)
	if not slot1 then
		slot0._assistMO = nil

		return
	end

	if not (slot0._assistMO and slot0._assistMO.id or slot0:_getAssistIndex(slot1.heroMO.heroId)) then
		return
	end

	slot0._assistMO = slot0._assistMO or Season166AssistHeroSingleGroupMO.New()

	slot0._assistMO:init(slot2, slot1)
	Season166HeroSingleGroupModel.instance:setAssistHeroGroupMO(slot0._assistMO)
	Season166HeroSingleGroupModel.instance:addTo(slot1.heroMO.uid, slot2)
	Season166HeroGroupModel.instance:replaceSingleGroup()
	Season166HeroGroupModel.instance:saveCurGroupData()
	Season166Controller.instance:dispatchEvent(Season166Event.OnSelectPickAssist, slot0._assistMO)
end

function slot0._getAssistIndex(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._heroItemList) do
		if Season166HeroSingleGroupModel.instance:getById(slot5):getHeroMO() and slot8.heroId == slot1 and slot1 then
			Season166HeroSingleGroupModel.instance:removeFrom(slot5)

			return slot5
		end
	end

	for slot5, slot6 in ipairs(slot0._heroItemList) do
		if not Season166HeroSingleGroupModel.instance:getById(slot5):getHeroMO() then
			return slot5
		end
	end
end

function slot0._checkCanDrag(slot0, slot1)
	if not slot0:canDrag(slot1) then
		if slot0._heroItemList[slot1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return true
	end
end

function slot0.canDrag(slot0, slot1, slot2)
	if slot0._heroItemList[slot1].isAid then
		return false
	end

	if slot4.isTrialLock then
		return false
	end

	if not slot2 and (slot4.mo:isEmpty() or slot4.mo.aid == -1 or Season166HeroGroupModel.instance:positionOpenCount() < slot1) then
		return false
	end

	return true
end

function slot0._onBeginDrag(slot0, slot1, slot2)
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

	slot8 = Season166HeroGroupModel.instance.battleId and lua_battle.configDict[slot7]

	if Season166HeroGroupModel.instance:positionOpenCount() < slot3 then
		slot0:_setHeroItemPos(slot4, slot5, true, slot6, slot0)
		logError("drag to Error OpenCount Pos")

		return
	end

	if Season166HeroGroupModel.instance:getBattleRoleNum() and slot9 < slot3 then
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

		slot0 = Season166HeroGroupModel.instance:getCurGroupMO()
		slot1 = uv2.mo.id - 1
		slot2 = uv3.mo.id - 1
		slot0.equips[slot1].equipUid = {
			slot0:getPosEquips(slot2).equipUid[1]
		}
		slot0.equips[slot2].equipUid = {
			slot0:getPosEquips(slot1).equipUid[1]
		}
		slot9 = uv5

		Season166HeroSingleGroupModel.instance:swap(uv4, slot9)

		for slot9, slot10 in ipairs(slot0.heroList) do
			if Season166HeroSingleGroupModel.instance:getHeroUids()[slot9] ~= slot10 then
				Season166HeroGroupModel.instance:replaceSingleGroup()
				HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
				Season166HeroGroupModel.instance:saveCurGroupData()
				uv0:_updateHeroList()

				break
			end
		end
	end, slot0)
end

function slot0._calcIndex(slot0, slot1)
	for slot5 = 1, slot0._roleNum do
		if gohelper.isMouseOverGo(slot0.heroPosTrList[slot5].parent, slot1) then
			return slot5
		end
	end

	return 0
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

function slot0._onHeroGroupExit(slot0)
	slot4 = AudioEnum.HeroGroupUI.Play_UI_Formation_Cardsdisappear

	AudioMgr.instance:trigger(slot4)

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

function slot0.onDestroyView(slot0)
	slot4 = true

	CommonDragHelper.instance:setGlobalEnabled(slot4)

	for slot4 = 1, slot0._roleNum do
		CommonDragHelper.instance:unregisterDragObj(slot0._heroItemList[slot4].go)
	end

	if slot0._closeTweenIdList then
		for slot4, slot5 in ipairs(slot0._closeTweenIdList) do
			ZProj.TweenHelper.KillById(slot5)
		end
	end
end

function slot0._onScreenSizeChange(slot0)
	for slot4 = 1, slot0._roleNum do
		slot0:_setHeroItemPos(slot0._heroItemList[slot4], slot4)
	end
end

return slot0
