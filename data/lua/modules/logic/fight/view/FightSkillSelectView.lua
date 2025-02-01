module("modules.logic.fight.view.FightSkillSelectView", package.seeall)

slot0 = class("FightSkillSelectView", BaseView)
slot1 = SLFramework.UGUI.UILongPressListener

function slot0.onInitView(slot0)
	slot0._containerGO = slot0.viewGO
	slot0._containerTr = slot0._containerGO.transform
	slot0._imgSelectGO = gohelper.findChild(slot0.viewGO, "imgSkillSelect")
	slot0._imgSelectTr = slot0._imgSelectGO.transform
	slot0._imgSelectAnimator = slot0._containerGO:GetComponent(typeof(UnityEngine.Animator))
	slot1 = gohelper.findChild(slot0.viewGO, "click")
	slot0._clickGOArr = slot0:getUserDataTb_()
	slot0._clickGoLongListenerArr = slot0:getUserDataTb_()
	slot0._clickGoClickArr = slot0:getUserDataTb_()
	slot0._clickGoTrArr = slot0:getUserDataTb_()

	table.insert(slot0._clickGOArr, slot1)
	table.insert(slot0._clickGoLongListenerArr, uv0.Get(slot1))
	table.insert(slot0._clickGoClickArr, gohelper.getClick(slot1))
	table.insert(slot0._clickGoTrArr, slot1.transform)
	gohelper.setActive(slot0._containerGO, false)

	slot0.showUI = true
	slot0.entityVisible = true

	slot0:_setSelectGOActive(false)

	slot0.started = nil
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0.onCameraFocusChanged, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnEnemyActionStatusChange, slot0.onEnemyActionStatusChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StartReplay, slot0._removeAllEvent, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, slot0._setIsShowUI, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRestartStageBefore, slot0._onRestartStage, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillTimeLineDone, slot0._onSkillTimeLineDone, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetEntityVisibleByTimeline, slot0._setEntityVisibleByTimeline, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EntityDeadFinish, slot0.onEntityDeadFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ExitStage, slot0.onExitStage, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnChangeEntity, slot0.onChangeEntity, slot0)
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
end

function slot0.onExitStage(slot0, slot1)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Replay then
		logError("reply stage ?")

		return
	end

	if slot2 == FightStageMgr.StageType.Normal then
		slot0:clearAllFlag()
		slot0:_updatePos()
	end
end

function slot0.onEntityDeadFinish(slot0)
	slot0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	slot0:_updatePos()
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0.onCameraFocusChanged, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnEnemyActionStatusChange, slot0.onEnemyActionStatusChange, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.StartReplay, slot0._removeAllEvent, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, slot0._setIsShowUI, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRestartStageBefore, slot0._onRestartStage, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillTimeLineDone, slot0._onSkillTimeLineDone, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.SetEntityVisibleByTimeline, slot0._setEntityVisibleByTimeline, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBeginWave, slot0._onBeginWave, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.EntityDeadFinish, slot0.onEntityDeadFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.ExitStage, slot0.onExitStage, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnChangeEntity, slot0.onChangeEntity, slot0)

	slot4 = PCInputEvent.NotifyBattleSelect
	slot5 = slot0.OnKeySelect

	slot0:removeEventCb(PCInputController.instance, slot4, slot5, slot0)

	for slot4, slot5 in ipairs(slot0._clickGOArr) do
		slot0:getClickGoLongListenerArrByIndex(slot4, slot5):RemoveLongPressListener()

		slot7 = slot0:getClickGoClickArrByIndex(slot4, slot5)

		slot7:RemoveClickListener()
		slot7:RemoveClickDownListener()
		slot7:RemoveClickUpListener()
		SLFramework.UGUI.UIRightClickListener.Get(slot5):RemoveClickListener()
	end
end

function slot0.onChangeEntity(slot0, slot1)
	if not FightHelper.getEntity(FightCardModel.instance.curSelectEntityId) then
		slot0:_resetDefaultFocus()
		FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	end
end

function slot0.onEnemyActionStatusChange(slot0, slot1)
	slot0.showEnemyActioning = FightEnum.EnemyActionStatus.Select == slot1

	slot0:_setSelectGOActive(true)
end

function slot0.getClickGoLongListenerArrByIndex(slot0, slot1, slot2)
	return slot0._clickGoLongListenerArr[slot1] or uv0.Get(slot2)
end

function slot0.getClickGoClickArrByIndex(slot0, slot1, slot2)
	return slot0._clickGoClickArr[slot1] or gohelper.getClick(slot2)
end

function slot0.getClickGoTransformByIndex(slot0, slot1, slot2)
	return slot0._clickGoTrArr[slot1] or slot2.transform
end

function slot0.onUpdateParam(slot0)
	gohelper.setAsFirstSibling(slot0.viewGO)
end

function slot0.onOpen(slot0)
	gohelper.setAsFirstSibling(slot0.viewGO)

	if FightReplayModel.instance:isReplay() then
		slot0:_removeAllEvent()
	end
end

function slot0.onClose(slot0)
	FightCardModel.instance:setCurSelectEntityId(0)
	TaskDispatcher.cancelTask(slot0._delayStartSequenceFinish, slot0)
	slot0:removeLateUpdate()
end

function slot0._onBeginWave(slot0)
	slot0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
end

function slot0._setEntityVisibleByTimeline(slot0, slot1, slot2, slot3, slot4)
	if slot1.id ~= FightCardModel.instance.curSelectEntityId then
		return
	end

	slot0.entityVisible = slot3

	slot0:_setSelectGOActive(true)
end

function slot0._onSkillPlayStart(slot0, slot1)
	if FightCardModel.instance.curSelectEntityId ~= slot1.id then
		return
	end

	slot0.playingCurSelectEntityTimeline = true

	slot0:_setSelectGOActive(false)
end

function slot0._onSkillTimeLineDone(slot0, slot1)
	if FightCardModel.instance.curSelectEntityId ~= (slot1 and slot1.fromId) then
		return
	end

	slot0.playingCurSelectEntityTimeline = false

	slot0:_setSelectGOActive(true)
end

function slot0._setIsShowUI(slot0, slot1)
	slot0.showUI = slot1

	if not slot0._canvasGroup then
		slot0._canvasGroup = gohelper.onceAddComponent(slot0._containerGO, typeof(UnityEngine.CanvasGroup))
	end

	gohelper.setActiveCanvasGroup(slot0._canvasGroup, slot1)
end

function slot0._removeAllEvent(slot0)
	slot0:removeEvents()
	slot0:removeLateUpdate()
end

function slot0.onCameraFocusChanged(slot0, slot1)
	if slot1 then
		slot0._on_camera_focus = true

		slot0:_setSelectGOActive(false)
	else
		slot0._on_camera_focus = false

		slot0:_setSelectGOActive(true)
	end
end

function slot0.clearAllFlag(slot0)
	slot0._on_camera_focus = nil
	slot0.playingCurSelectEntityTimeline = nil
	slot0.entityVisible = true
	slot0.showEnemyActioning = nil
end

function slot0._setSelectGOActive(slot0, slot1)
	if not slot1 then
		gohelper.setActive(slot0._imgSelectGO, false)

		return
	end

	if slot0.showEnemyActioning then
		gohelper.setActive(slot0._imgSelectGO, false)

		return
	end

	if slot0._on_camera_focus then
		gohelper.setActive(slot0._imgSelectGO, false)

		return
	end

	if slot0.playingCurSelectEntityTimeline then
		gohelper.setActive(slot0._imgSelectGO, false)

		return
	end

	if not slot0.entityVisible then
		gohelper.setActive(slot0._imgSelectGO, false)

		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		gohelper.setActive(slot0._imgSelectGO, false)

		return
	end

	if not GMFightShowState.monsterSelect then
		gohelper.setActive(slot0._imgSelectGO, false)

		return
	end

	gohelper.setActive(slot0._imgSelectGO, true)
end

function slot0._resetSelect(slot0)
	slot0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	slot0:_updateSelectUI()
end

function slot0._onStartSequenceFinish(slot0)
	FightCardModel.instance:setCurSelectEntityId(0)
	TaskDispatcher.runDelay(slot0._delayStartSequenceFinish, slot0, 0.01)
end

function slot0._delayStartSequenceFinish(slot0)
	slot0.started = true

	slot0:clearAllFlag()
	gohelper.setActive(slot0._containerGO, true)
	slot0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelect, slot0.OnKeySelect, slot0)
	slot0:_updatePos()
	slot0:initUpdateBeat()
end

function slot0.OnKeySelect(slot0, slot1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightCardModel.instance:getSelectEnemyPosLOrR(slot1) ~= nil then
		slot0:_onClick(slot3)
	end
end

function slot0.initUpdateBeat(slot0)
	if slot0.lateUpdateHandle or not slot0.showUI or slot0.playingCurSelectEntityTimeline then
		return
	end

	slot0.lateUpdateHandle = LateUpdateBeat:CreateListener(slot0._onFrameLateUpdate, slot0)

	LateUpdateBeat:AddListener(slot0.lateUpdateHandle)
end

function slot0._onFrameLateUpdate(slot0)
	if slot0._on_camera_focus then
		return
	end

	slot0:_updatePos()
end

function slot0.removeLateUpdate(slot0)
	if slot0.lateUpdateHandle then
		LateUpdateBeat:RemoveListener(slot0.lateUpdateHandle)

		slot0.lateUpdateHandle = nil
	end
end

function slot0._playSelectAnim(slot0)
	if slot0._imgSelectAnimator then
		slot0._imgSelectAnimator:Play("fightview_skillselect", 0, 0)
	else
		logError("无法播放目标锁定动画，Animator不存在")
	end
end

function slot0._onRestartStage(slot0)
	gohelper.setActive(slot0._containerGO, false)
	slot0:removeLateUpdate()

	slot0.started = nil
end

function slot0._updatePos(slot0)
	slot0:_updateClickPos()
	slot0:_updateSelectUI()
end

function slot0._resetDefaultFocus(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightAutoFocus) then
		FightCardModel.instance:resetCurSelectEntityIdDefault()
	end
end

function slot0._updateSelectUI(slot0)
	slot0:_setSelectGOActive(FightHelper.getEntity(FightCardModel.instance.curSelectEntityId) ~= nil)

	if slot1 then
		slot2, slot3 = slot0:_getEntityMiddlePos(slot1)

		recthelper.setAnchor(slot0._imgSelectTr, slot2, slot3)
	end
end

function slot0._updateClickPos(slot0)
	slot1 = FightEntityModel.instance:getEnemySideList()
	slot2 = FightEntityModel.instance:getSpModel(FightEnum.EntitySide.EnemySide):getList()
	slot3 = FightEntityModel.instance:getMySideList()
	slot4 = FightEntityModel.instance:getSpModel(FightEnum.EntitySide.MySide):getList()

	if slot0._entityList then
		tabletool.clear(slot0._entityList)
	else
		slot0._entityList = {}
	end

	tabletool.addValues(slot0._entityList, slot3)
	tabletool.addValues(slot0._entityList, slot4)
	tabletool.addValues(slot0._entityList, slot1)
	tabletool.addValues(slot0._entityList, slot2)

	for slot8 = tabletool.len(slot0._entityList), 1, -1 do
		if not FightHelper.getEntity(slot0._entityList[slot8].id) then
			table.remove(slot0._entityList, slot8)
		elseif isTypeOf(slot9, FightEntitySub) then
			table.remove(slot0._entityList, slot8)
		end
	end

	if slot0._assembledMonster then
		tabletool.clear(slot0._assembledMonster)
	else
		slot0._assembledMonster = slot0:getUserDataTb_()
	end

	if slot0._entityId2ClickGO then
		tabletool.clear(slot0._entityId2ClickGO)
	else
		slot0._entityId2ClickGO = slot0:getUserDataTb_()
	end

	for slot8, slot9 in ipairs(slot0._entityList) do
		if not slot0._clickGOArr[slot8] then
			slot10 = gohelper.clone(slot0._clickGOArr[1], slot0._containerGO, "click" .. slot8)

			table.insert(slot0._clickGOArr, slot10)
			table.insert(slot0._clickGoLongListenerArr, uv0.Get(slot10))
			table.insert(slot0._clickGoClickArr, gohelper.getClick(slot10))
			table.insert(slot0._clickGoTrArr, slot10.transform)
		end

		slot0._entityId2ClickGO[slot9.id] = slot10

		gohelper.setActive(slot10, true)

		slot11 = FightHelper.getEntity(slot9.id)
		slot12 = slot0:getClickGoTransformByIndex(slot8, slot10)
		slot13, slot14, slot15, slot16 = slot0:_calcRect(slot11)
		slot17, slot18 = nil

		if slot11:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle) then
			slot20, slot21, slot22 = transformhelper.getPos(slot19.transform)
			slot17, slot18 = recthelper.worldPosToAnchorPosXYZ(slot20, slot21, slot22, slot0._containerTr)
		else
			slot17 = (slot13 + slot15) / 2
			slot18 = (slot14 + slot16) / 2
		end

		recthelper.setAnchor(slot12, slot17, slot18)

		slot23 = lua_monster_skin.configDict[slot9.skin] and slot22.clickBoxUnlimit == 1

		recthelper.setSize(slot12, Mathf.Clamp(math.abs(slot13 - slot15), 150, slot23 and 800 or 200), Mathf.Clamp(math.abs(slot14 - slot16), 150, slot23 and 800 or 500))

		slot32 = slot0:getClickGoClickArrByIndex(slot8, slot10)

		if not FightReplayModel.instance:isReplay() and slot9.side == FightEnum.EntitySide.EnemySide and not (slot9.entityType == 3) and not (slot9:hasBuffFeature(FightEnum.BuffType_CantSelect) or slot9:hasBuffFeature(FightEnum.BuffType_CantSelectEx)) then
			slot32:AddClickListener(slot0._onClick, slot0, slot9.id)
			slot32:AddClickDownListener(slot0._onClickDown, slot0)
			slot32:AddClickUpListener(slot0._onClickUp, slot0)
		else
			slot32:RemoveClickListener()
			slot32:RemoveClickDownListener()
			slot32:RemoveClickUpListener()
		end

		slot33 = slot0:getClickGoLongListenerArrByIndex(slot8, slot10)

		if not slot28 and not slot30 and not slot31 then
			slot33:AddLongPressListener(slot0._onLongPress, slot0, slot9.id)
			slot33:SetLongPressTime({
				0.5,
				99999
			})
			SLFramework.UGUI.UIRightClickListener.Get(slot10):AddClickListener(slot0._onLongPress, slot0, slot9.id)
		else
			slot33:RemoveLongPressListener()
			slot34:RemoveClickListener()
		end

		if isTypeOf(FightHelper.getEntity(slot9.id), FightEntityAssembledMonsterMain) or isTypeOf(slot35, FightEntityAssembledMonsterSub) then
			table.insert(slot0._assembledMonster, {
				entity = slot35,
				clickTr = slot12,
				clickGO = slot10
			})
		end
	end

	for slot8 = tabletool.len(slot0._entityList) + 1, #slot0._clickGOArr do
		gohelper.setActive(slot0._clickGOArr[slot8], false)
	end

	slot0:_sortSiblingByZPos(slot0._entityId2ClickGO)

	if tabletool.len(slot0._assembledMonster) > 0 then
		slot0:_dealAssembledMonsterClick(slot0._assembledMonster)
	end
end

function slot0._dealAssembledMonsterClick(slot0, slot1)
	table.sort(slot1, uv0.sortAssembledMonster)

	for slot5, slot6 in ipairs(slot1) do
		gohelper.setAsLastSibling(slot6.clickGO)

		slot8 = lua_fight_assembled_monster.configDict[slot6.entity:getMO().skin]
		slot9 = slot6.entity.go.transform.position
		slot9 = Vector3.New(slot9.x + slot8.virtualSpinePos[1], slot9.y + slot8.virtualSpinePos[2], slot9.z + slot8.virtualSpinePos[3])
		slot10 = recthelper.worldPosToAnchorPos(slot9, slot0._containerTr)

		recthelper.setAnchor(slot6.clickTr, slot10.x, slot10.y)

		slot11 = slot8.virtualSpineSize[1] * 0.5
		slot12 = slot8.virtualSpineSize[2] * 0.5
		slot15 = recthelper.worldPosToAnchorPos(Vector3.New(slot9.x - slot11, slot9.y - slot12, slot9.z), slot0._containerTr)
		slot16 = recthelper.worldPosToAnchorPos(Vector3.New(slot9.x + slot11, slot9.y + slot12, slot9.z), slot0._containerTr)

		recthelper.setSize(slot6.clickTr, slot16.x - slot15.x, slot16.y - slot15.y)
	end
end

function slot0.sortAssembledMonster(slot0, slot1)
	return lua_fight_assembled_monster.configDict[slot0.entity:getMO().skin].clickIndex < lua_fight_assembled_monster.configDict[slot1.entity:getMO().skin].clickIndex
end

function slot0._sortSiblingByZPos(slot0, slot1)
	if slot0._entityIds then
		tabletool.clear(slot0._entityIds)
	else
		slot0._entityIds = {}
	end

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0._entityIds, slot5)
	end

	table.sort(slot0._entityIds, function (slot0, slot1)
		slot4, slot5, slot6 = FightHelper.getEntityStandPos(FightEntityModel.instance:getById(slot0))
		slot7, slot8, slot9 = FightHelper.getEntityStandPos(FightEntityModel.instance:getById(slot1))

		if slot6 ~= slot9 then
			return slot6 < slot9
		else
			return tonumber(slot3.id) < tonumber(slot2.id)
		end
	end)

	for slot5, slot6 in ipairs(slot0._entityIds) do
		gohelper.setAsLastSibling(slot1[slot6])
	end
end

function slot0._getEntityMiddlePos(slot0, slot1)
	if FightHelper.isAssembledMonster(slot1) then
		slot3 = lua_fight_assembled_monster.configDict[slot1:getMO().skin]
		slot4, slot5, slot6 = transformhelper.getPos(slot1.go.transform)
		slot7, slot8 = recthelper.worldPosToAnchorPosXYZ(slot4 + slot3.selectPos[1], slot5 + slot3.selectPos[2], slot6, slot0._containerTr)

		return slot7, slot8
	end

	if slot1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle) and slot2.name == ModuleEnum.SpineHangPoint.mountmiddle then
		slot3, slot4, slot5 = transformhelper.getPos(slot2.transform)
		slot6, slot7 = recthelper.worldPosToAnchorPosXYZ(slot3, slot4, slot5, slot0._containerTr)

		return slot6, slot7
	else
		slot3, slot4, slot5, slot6 = slot0:_calcRect(slot1)

		return (slot3 + slot5) / 2, (slot4 + slot6) / 2
	end
end

function slot0._calcRect(slot0, slot1)
	if not slot1 then
		slot2 = Vector3.New(10000, 0)

		return slot2, slot2
	end

	slot3, slot4, slot5 = transformhelper.getPos(slot1:getHangPoint(ModuleEnum.SpineHangPoint.BodyStatic).transform)
	slot6, slot7 = FightHelper.getEntityBoxSizeOffsetV2(slot1)
	slot8 = slot1:isMySide() and 1 or -1
	slot9, slot10 = recthelper.worldPosToAnchorPosXYZ(slot3 - slot6.x * 0.5, slot4 - slot6.y * 0.5 * slot8, slot5, slot0._containerTr)
	slot11, slot12 = recthelper.worldPosToAnchorPosXYZ(slot3 + slot6.x * 0.5, slot4 + slot6.y * 0.5 * slot8, slot5, slot0._containerTr)

	return slot9, slot10, slot11, slot12
end

function slot0._onClick(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightFocus) and not GuideModel.instance:isGuideFinish(GuideController.FirstGuideId) then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard or slot4 == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if FightModel.instance:isAuto() then
		if slot1 == FightCardModel.instance.curSelectEntityId then
			FightCardModel.instance:setCurSelectEntityId(0)
		else
			slot0:_playSelectAnim()
			FightCardModel.instance:setCurSelectEntityId(slot1)
		end
	else
		if slot1 ~= FightCardModel.instance.curSelectEntityId then
			slot0:_playSelectAnim()
		end

		FightCardModel.instance:setCurSelectEntityId(slot1)
	end

	slot0:_updateSelectUI()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, slot1)
end

function slot0._onClickUp(slot0)
	FightModel.instance:setClickEnemyState(false)
end

function slot0._onClickDown(slot0)
	FightModel.instance:setClickEnemyState(true)
end

function slot0._onLongPress(slot0, slot1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
		return
	end

	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard or slot3 == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.FightForbidLongPressCard) then
		return
	end

	if FightViewHandCard.blockOperate then
		return
	end

	if GuideModel.instance:isDoingFirstGuide() then
		logNormal("新手第一个指引不能长按查看详情")

		return
	end

	if FightModel.instance:isAuto() then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		logNormal("出完牌了不能长按查看详情")

		return
	end

	slot0.currentFocusEntityMO = FightEntityModel.instance:getById(slot1)

	if slot0.currentFocusEntityMO then
		slot0.viewContainer:openFightFocusView(slot0.currentFocusEntityMO.id)
		FightController.instance:dispatchEvent(FightEvent.HideFightViewTips)
		FightController.instance:dispatchEvent(FightEvent.LongPressHandCardEnd)
	end
end

function slot0.getCurrentFocusEntityId(slot0)
	return slot0.currentFocusEntityMO.id
end

function slot0.onDestroyView(slot0)
	if slot0._clickGOArr then
		slot0._clickGOArr = nil
	end

	if slot0._clickGoLongListenerArr then
		slot0._clickGoLongListenerArr = nil
	end

	if slot0._clickGoClickArr then
		slot0._clickGoClickArr = nil
	end

	if slot0._entityIds then
		slot0._entityIds = nil
	end

	if slot0._entityList then
		slot0._entityList = nil
	end

	if slot0._assembledMonster then
		slot0._assembledMonster = nil
	end

	if slot0._entityId2ClickGO then
		slot0._entityId2ClickGO = nil
	end

	if slot0._clickGoTrArr then
		slot0._clickGoTrArr = nil
	end
end

return slot0
