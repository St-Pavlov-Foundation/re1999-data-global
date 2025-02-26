module("modules.logic.seasonver.act123.view2_3.Season123_2_3HeroGroupListView", package.seeall)

slot0 = class("Season123_2_3HeroGroupListView", BaseView)

function slot0.onInitView(slot0)
	slot0._goheroarea = gohelper.findChild(slot0.viewGO, "herogroupcontain/area")
	slot0._gohero = gohelper.findChild(slot0.viewGO, "herogroupcontain/hero")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/heroitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._heroItemList = {}
	slot0._heroItemDrag = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goheroitem, false)
	gohelper.setActive(slot0._goaidheroitem, false)

	slot0.heroPosTrList = slot0:getUserDataTb_()
	slot0._heroItemPosList = slot0:getUserDataTb_()

	for slot4 = 1, 4 do
		slot7 = gohelper.cloneInPlace(slot0._goheroitem, "item" .. slot4)

		table.insert(slot0.heroPosTrList, gohelper.findChild(slot0._goheroarea, "pos" .. slot4 .. "/container").transform)
		table.insert(slot0._heroItemList, MonoHelper.addNoUpdateLuaComOnceToGo(slot7, Season123_2_3HeroGroupHeroItem, slot0))
		gohelper.setActive(slot7, true)
	end

	for slot4 = 1, ModuleEnum.MaxHeroCountInGroup do
		slot5 = slot0._heroItemList[slot4]

		slot0:_setHeroItemPos(slot5, slot4)
		table.insert(slot0._heroItemPosList, slot5.go.transform)
		slot5:setParent(slot0.heroPosTrList[slot4])
		table.insert(slot0._heroItemDrag, SLFramework.UGUI.UIDragListener.Get(slot5.go))
	end

	slot0._bgList = slot0:getUserDataTb_()
	slot0._orderList = slot0:getUserDataTb_()

	if HeroGroupModel.instance:getBattleRoleNum() then
		slot1 = math.min(slot2, HeroGroupModel.instance:positionOpenCount())
	end

	if HeroGroupModel.instance.battleId and lua_battle.configDict[slot3] then
		slot1 = math.min(slot4.playerMax, slot1)
	end

	slot0._openCount = slot1

	for slot8 = 1, 4 do
		table.insert(slot0._bgList, gohelper.findChild(slot0.viewGO, "herogroupcontain/hero/bg" .. slot8 .. "/bg"))

		slot10 = gohelper.findChildTextMesh(slot0.viewGO, "herogroupcontain/hero/bg" .. slot8 .. "/bg/#txt_order")
		slot10.text = slot8 <= slot1 and tostring(slot8) or ""

		table.insert(slot0._orderList, slot10)
	end

	HeroGroupModel.instance:setHeroGroupItemPos(slot0._heroItemPosList)
end

function slot0.addEvents(slot0)
	for slot4, slot5 in ipairs(slot0._heroItemDrag) do
		slot5:AddDragBeginListener(slot0._onBeginDrag, slot0, slot4)
		slot5:AddDragListener(slot0._onDrag, slot0, slot4)
		slot5:AddDragEndListener(slot0._onEndDrag, slot0, slot4)
	end

	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnHeroGroupExit, slot0._onHeroGroupExit, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._updateHeroList, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.HeroGroupIndexChanged, slot0._onSnapshotSaveSucc, slot0)
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
end

function slot0.removeEvents(slot0)
	for slot4, slot5 in ipairs(slot0._heroItemDrag) do
		slot5:RemoveDragBeginListener()
		slot5:RemoveDragListener()
		slot5:RemoveDragEndListener()
	end

	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.SelectHeroGroup, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._updateHeroList, slot0)
	slot0:removeEventCb(Season123Controller.instance, Season123Event.HeroGroupIndexChanged, slot0._onSnapshotSaveSucc, slot0)
	slot0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0._onScreenSizeChange, slot0)
end

function slot0.onOpen(slot0)
	slot0._isOpen = true

	slot0:_updateHeroList()
	slot0:_playOpenAnimation()
end

function slot0._playOpenAnimation(slot0)
	for slot4, slot5 in ipairs(slot0.heroPosTrList) do
		if slot5 then
			slot6 = slot5.gameObject:GetComponent(typeof(UnityEngine.Animator))

			slot6:Play("open")
			slot6:Update(0)

			slot6.speed = 1
		end
	end

	for slot4, slot5 in ipairs(slot0._heroItemList) do
		if slot5 then
			slot6 = slot5.anim

			slot6:Play("open")
			slot6:Update(0)

			slot6.speed = 1
		end
	end

	for slot4, slot5 in ipairs(slot0._bgList) do
		if slot5 then
			slot6 = slot5:GetComponent(typeof(UnityEngine.Animator))

			slot6:Play("open")
			slot6:Update(0)

			slot6.speed = 1
		end
	end

	slot0:_checkRestrictHero()
end

function slot0._checkRestrictHero(slot0)
	slot1 = {}
	slot2 = false
	slot3 = nil

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		slot2, slot3 = Season123HeroGroupController.checkUnloadHero(Season123HeroGroupModel.instance.activityId, Season123HeroGroupModel.instance.stage, Season123HeroGroupModel.instance.layer)
	end

	for slot7 = 1, 4 do
		if HeroSingleGroupModel.instance:getById(slot7) and HeroGroupModel.instance:isRestrict(slot8.heroUid) then
			slot1[slot8.heroUid] = true
		end
	end

	if tabletool.len(slot1) <= 0 and slot3 and tabletool.len(slot3) <= 0 then
		Season123HeroGroupController.instance:checkSeason123HeroGroup()

		return
	end

	if not string.nilorempty(HeroGroupModel.instance:getCurrentBattleConfig() and slot5.restrictReason) and slot4 > 0 then
		ToastController.instance:showToastWithString(slot6)
	end

	for slot10, slot11 in ipairs(slot0._heroItemList) do
		slot11:playRestrictAnimation(slot1, slot3)
	end

	slot0.needRemoveHeroUidDict = slot1

	UIBlockMgr.instance:startBlock("removeRestrictHero")
	TaskDispatcher.runDelay(slot0._removeRestrictHero, slot0, 1.5)
end

function slot0._removeRestrictHero(slot0)
	UIBlockMgr.instance:endBlock("removeRestrictHero")

	if not slot0.needRemoveHeroUidDict then
		Season123HeroGroupController.instance:checkSeason123HeroGroup()

		return
	end

	for slot4, slot5 in pairs(slot0.needRemoveHeroUidDict) do
		HeroSingleGroupModel.instance:remove(slot4)
	end

	HeroGroupModel.instance:replaceSingleGroup()
	Season123HeroGroupController.instance:checkSeason123HeroGroup()
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
	ViewMgr.instance:closeView(Season123Controller.instance:getHeroGroupFightViewName(), false, false)
end

function slot0._closeTweenFinish(slot0, slot1)
	if slot0.heroPosTrList[slot1] then
		slot3 = slot2.gameObject:GetComponent(typeof(UnityEngine.Animator))

		slot3:Play("close")

		slot3.speed = 1
	end

	if slot0._heroItemList[slot1] then
		slot4 = slot3.anim

		slot4:Play("close")

		slot4.speed = 1
	end

	if slot0._bgList[slot1] then
		slot5 = slot4:GetComponent(typeof(UnityEngine.Animator))

		slot5:Play("close")

		slot5.speed = 1
	end
end

function slot0.canDrag(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return false
	end

	if slot0._heroItemList[slot1].isTrialLock then
		return false
	end

	if not slot2 and (slot4.mo:isEmpty() or slot4.mo.aid == -1 or HeroGroupModel.instance:positionOpenCount() < slot1) then
		return false
	end

	return true
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not slot0:canDrag(slot1) then
		return
	end

	if slot0._tweening then
		return
	end

	slot4 = slot0._heroItemList[slot1]

	if slot1 <= slot0._openCount then
		slot0._orderList[slot1].text = slot1
	end

	if slot4.mo:isEmpty() or slot4.mo.aid == -1 or HeroGroupModel.instance:positionOpenCount() < slot1 then
		return
	end

	for slot8, slot9 in ipairs(slot0._heroItemList) do
		slot9:onItemBeginDrag(slot3)
	end

	for slot8, slot9 in ipairs(slot0._heroItemList) do
		slot9:flowOriginParent()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_raise)
	gohelper.setAsLastSibling(slot4.go)
	slot0:_tweenToPos(slot4, recthelper.screenPosToAnchorPos(slot2.position, slot0._goheroarea.transform))
end

function slot0._onDrag(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not slot0:canDrag(slot1) then
		if slot0._heroItemList[slot1].isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		return
	end

	if slot0._heroItemList[slot1].mo:isEmpty() or slot4.mo.aid == -1 or HeroGroupModel.instance:positionOpenCount() < slot1 then
		return
	end

	slot0:_tweenToPos(slot4, recthelper.screenPosToAnchorPos(slot2.position, slot0._goheroarea.transform))
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if not slot0:canDrag(slot1) then
		return
	end

	if slot0._heroItemList[slot1].mo:isEmpty() or slot4.mo.aid == -1 or HeroGroupModel.instance:positionOpenCount() < slot3 then
		return
	end

	if slot0:_calcIndex(slot2.position) == slot1 or slot5 <= 0 then
		slot0._orderList[slot1].text = ""
	end

	for slot9, slot10 in ipairs(slot0._heroItemList) do
		slot10:onItemEndDrag(slot3, slot5)
	end

	slot0:_setDragEnabled(false)

	if slot5 <= 0 then
		slot0:_setHeroItemPos(slot4, slot3, true, function (slot0, slot1)
			for slot5, slot6 in ipairs(slot0._heroItemList) do
				slot6:onItemCompleteDrag(uv0, uv1, slot1)
			end

			slot0:_setDragEnabled(true)

			for slot5, slot6 in ipairs(slot0._heroItemList) do
				slot6:flowCurrentParent()
			end
		end, slot0)

		return
	end

	if not slot0:canDrag(slot5, true) then
		if slot0._heroItemList[slot5] and slot7.isTrialLock then
			GameFacade.showToast(ToastEnum.TrialCantChangePos)
		end

		slot0:_setHeroItemPos(slot4, slot3, true, slot6, slot0)

		return
	end

	slot8 = HeroGroupModel.instance.battleId and lua_battle.configDict[slot7]

	if HeroGroupModel.instance:positionOpenCount() < slot5 then
		slot0:_setHeroItemPos(slot4, slot3, true, slot6, slot0)

		slot9, slot10 = HeroGroupModel.instance:getPositionLockDesc(slot5)

		GameFacade.showToast(slot9, slot10)

		return
	end

	if HeroGroupModel.instance:getBattleRoleNum() and slot9 < slot5 then
		slot0:_setHeroItemPos(slot4, slot3, true, slot6, slot0)
		GameFacade.showToast(ToastEnum.HeroGroupRoleNum)

		return
	end

	if slot8 and slot4.mo.aid and slot8.playerMax < slot5 then
		slot0:_setHeroItemPos(slot4, slot3, true, slot6, slot0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	if slot0._heroItemList[slot5].mo.aid and slot10.mo.aid ~= -1 and slot8 and slot8.playerMax < slot3 then
		slot0:_setHeroItemPos(slot4, slot3, true, slot6, slot0)
		GameFacade.showToast(ToastEnum.HeroGroupPlayerMax)

		return
	end

	slot11, slot12 = slot4:canMoveCardToPos(slot5 - 1)
	slot13, slot14 = slot10:canMoveCardToPos(slot3 - 1)

	if not slot11 or not slot13 then
		slot0:_setHeroItemPos(slot4, slot3, true, slot6, slot0)

		if not slot11 then
			GameFacade.showToast(Season123_2_3EquipItem.Toast_Pos_Wrong, slot12)
		end

		if not slot13 then
			GameFacade.showToast(Season123_2_3EquipItem.Toast_Pos_Wrong, slot14)
		end

		return
	end

	if slot3 ~= slot5 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_release)
	end

	gohelper.setAsLastSibling(slot10.go)
	gohelper.setAsLastSibling(slot4.go)
	slot10:flowOriginParent()

	slot0._tweenId = slot0:_setHeroItemPos(slot10, slot3, true)

	slot0:_setHeroItemPos(slot4, slot5, true, function ()
		if uv0._tweenId then
			ZProj.TweenHelper.KillById(uv0._tweenId)
		end

		for slot3, slot4 in ipairs(uv0._heroItemList) do
			uv0:_setHeroItemPos(slot4, slot3)
		end

		uv1(uv0, true)
		Season123HeroGroupUtils.swapHeroItem(uv2.mo.id, uv3.mo.id)

		if Season123HeroGroupModel.instance:isEpisodeSeason123() or Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
			uv0:_updateHeroList()
			Season123HeroGroupController.instance:saveCurrentHeroGroup()
		else
			for slot5, slot6 in ipairs(HeroGroupModel.instance:getCurGroupMO().heroList) do
				if HeroSingleGroupModel.instance:getHeroUids()[slot5] ~= slot6 then
					HeroSingleGroupModel.instance:setSingleGroup(slot0, true)
					HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
					HeroGroupModel.instance:saveCurGroupData()
					uv0:_updateHeroList()

					break
				end
			end
		end
	end)
end

function slot0._setHeroItemPos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = recthelper.rectToRelativeAnchorPos(slot0.heroPosTrList[slot2].position, slot0._goheroarea.transform)

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

function slot0._setDragEnabled(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._heroItemDrag) do
		slot6.enabled = slot1
	end
end

function slot0._updateHeroList(slot0)
	for slot4, slot5 in ipairs(slot0._heroItemList) do
		slot6 = nil

		if Season123HeroGroupModel.instance:isEpisodeSeason123() or Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
			slot7 = HeroGroupModel.instance:getCurGroupMO()
			slot6 = HeroSingleGroupMO.New()
			slot6.id = slot4
			slot6.heroUid = slot7.heroList[slot4]

			if slot7.isReplay then
				slot5:onUpdateMO(slot6, slot0.viewParam, slot7.replay_hero_data[slot6.heroUid])
			else
				slot5:onUpdateMO(slot6, slot0.viewParam)
			end
		else
			slot5:onUpdateMO(HeroSingleGroupModel.instance:getById(slot4), slot0.viewParam)
		end

		if slot4 <= slot0._openCount then
			slot0._orderList[slot4].text = slot6:isEmpty() and slot4 or ""
		end
	end
end

function slot0._onSnapshotSaveSucc(slot0)
	slot0:_updateHeroList()
	gohelper.setActive(slot0._goheroarea, false)
	gohelper.setActive(slot0._goheroarea, true)
	gohelper.setActive(slot0._gohero, false)
	gohelper.setActive(slot0._gohero, true)
end

function slot0._calcIndex(slot0, slot1)
	for slot5 = 1, 4 do
		slot6 = slot0.heroPosTrList[slot5].parent

		if math.abs(recthelper.screenPosToAnchorPos(slot1, slot6).x) * 2 < recthelper.getWidth(slot6) and math.abs(slot7.y) * 2 < recthelper.getHeight(slot6) then
			return slot5
		end
	end

	return 0
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)

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

function slot0.getHeroItemList(slot0)
	return slot0._heroItemList
end

return slot0
