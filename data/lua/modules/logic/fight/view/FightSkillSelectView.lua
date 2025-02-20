module("modules.logic.fight.view.FightSkillSelectView", package.seeall)

slot0 = class("FightSkillSelectView", BaseView)
slot1 = SLFramework.UGUI.UIRightClickListener

function slot0._onRightClick(slot0, slot1, slot2)
	slot0:_onClickDown(slot1, slot2)

	if slot0._curClickEntityId then
		slot0:_onLongPress(slot1)
	end
end

slot2 = SLFramework.UGUI.UILongPressListener

function slot0.onInitView(slot0)
	slot0._clickBlock = gohelper.findChildClick(slot0.viewGO, "clickBlock")
	slot0._clickBlockTransform = slot0._clickBlock:GetComponent(gohelper.Type_RectTransform)
	slot0._longPress = uv0.Get(slot0._clickBlock.gameObject)
	slot0._guideClickObj = gohelper.findChild(slot0.viewGO, "guideClick")

	gohelper.setActive(slot0._guideClickObj, false)

	slot0._guideClickObj.name = "guideClick"
	slot0._guideClickList = {}
	slot0._containerGO = slot0.viewGO
	slot0._containerTr = slot0._containerGO.transform
	slot0._imgSelectGO = gohelper.findChild(slot0.viewGO, "imgSkillSelect")
	slot0._imgSelectTr = slot0._imgSelectGO.transform
	slot0._imgSelectAnimator = slot0._containerGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._containerGO, false)

	slot0.showUI = true
	slot0.entityVisible = true

	slot0:_setSelectGOActive(false)

	slot0.started = nil

	slot0._clickBlock:AddClickListener(slot0._onClick, slot0)
	slot0._clickBlock:AddClickDownListener(slot0._onClickDown, slot0)
	slot0._clickBlock:AddClickUpListener(slot0._onClickUp, slot0)
	slot0._longPress:AddLongPressListener(slot0._onLongPress, slot0)

	slot0._pressTab = {
		0.5,
		99999
	}

	slot0._longPress:SetLongPressTime(slot0._pressTab)

	slot0._rightClick = uv1.Get(slot0._clickBlock.gameObject)

	slot0._rightClick:AddClickListener(slot0._onRightClick, slot0)
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
	slot0:addEventCb(FightController.instance, FightEvent.GuideCreateClickBySkinId, slot0._onGuideCreateClickBySkinId, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GuideReleaseClickBySkilId, slot0._onGuideReleaseClickBySkilId, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnChangeEntity, slot0.onChangeEntity, slot0)
end

function slot0.removeEvents(slot0)
	slot0._rightClick:RemoveClickListener()
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
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelect, slot0.OnKeySelect, slot0)

	slot4 = FightController.instance
	slot5 = FightEvent.OnChangeEntity

	slot0:removeEventCb(slot4, slot5, slot0.onChangeEntity, slot0)
	slot0._clickBlock:RemoveClickListener()
	slot0._clickBlock:RemoveClickDownListener()
	slot0._clickBlock:RemoveClickUpListener()
	slot0._longPress:RemoveLongPressListener()

	for slot4, slot5 in ipairs(slot0._guideClickList) do
		slot5.rightClick:RemoveClickListener()

		slot6 = slot5.click

		slot6:RemoveClickListener()
		slot6:RemoveClickDownListener()
		slot6:RemoveClickUpListener()
		slot5.longPress:RemoveLongPressListener()
	end
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:_resetDefaultFocus()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
end

function slot0.onChangeEntity(slot0, slot1)
	if not FightHelper.getEntity(FightCardModel.instance.curSelectEntityId) then
		slot0:_resetDefaultFocus()
		FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, FightCardModel.instance.curSelectEntityId)
	end
end

function slot0._updateGuideClick(slot0)
	for slot4, slot5 in ipairs(slot0._guideClickList) do
		slot6 = slot5.entity
		slot7 = slot6:getMO()
		slot8, slot9, slot10, slot11 = FightHelper.calcRect(slot6, slot0._clickBlockTransform)
		slot12, slot13 = nil

		if slot6:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle) then
			slot15, slot16, slot17 = transformhelper.getPos(slot14.transform)
			slot12, slot13 = recthelper.worldPosToAnchorPosXYZ(slot15, slot16, slot17, slot0._containerTr)
		else
			slot12 = (slot8 + slot10) / 2
			slot13 = (slot9 + slot11) / 2
		end

		recthelper.setAnchor(slot5.transform, slot12, slot13)

		slot18 = lua_monster_skin.configDict[slot7.skin] and slot17.clickBoxUnlimit == 1

		recthelper.setSize(slot5.transform, Mathf.Clamp(math.abs(slot8 - slot10), 150, slot18 and 800 or 200), Mathf.Clamp(math.abs(slot9 - slot11), 150, slot18 and 800 or 500))
	end
end

function slot0._onGuideCreateClickBySkinId(slot0, slot1, slot2)
	slot1 = tonumber(slot1)

	for slot7, slot8 in ipairs(FightHelper.getAllEntitys()) do
		if slot0:_checkEntityGuideClick(slot8:getMO(), slot1, tonumber(slot2)) then
			FightModel.instance:setClickEnemyState(true)

			slot0._curClickEntityId = slot8.id
			slot10 = slot0:getUserDataTb_()
			slot10.entity = slot8
			slot11 = gohelper.cloneInPlace(slot0._guideClickObj, "guideClick" .. slot1)

			gohelper.setActive(slot11, true)

			slot10.obj = slot11
			slot10.transform = slot11.transform
			slot12 = gohelper.getClick(slot11)

			slot12:AddClickListener(slot0._onClick, slot0)
			slot12:AddClickDownListener(slot0._onClickDown, slot0)
			slot12:AddClickUpListener(slot0._onClickUp, slot0)

			slot10.click = slot12
			slot13 = uv0.Get(slot11)

			slot13:AddLongPressListener(slot0._onLongPress, slot0)
			slot13:SetLongPressTime(slot0._pressTab)

			slot10.longPress = slot13
			slot14 = uv1.Get(slot11)

			slot14:AddClickListener(slot0._onRightClick, slot0)

			slot10.rightClick = slot14

			table.insert(slot0._guideClickList, slot10)
			TaskDispatcher.runRepeat(slot0._updateGuideClick, slot0, 0.01)

			break
		end
	end
end

function slot0._checkEntityGuideClick(slot0, slot1, slot2, slot3)
	if not slot1 then
		return false
	end

	if slot1.skin ~= tonumber(slot2) then
		return false
	end

	if slot3 and tonumber(slot3) ~= slot1.position then
		return false
	end

	return true
end

function slot0._onGuideReleaseClickBySkilId(slot0, slot1, slot2)
	for slot6 = #slot0._guideClickList, 1, -1 do
		if slot0:_checkEntityGuideClick(slot0._guideClickList[slot6].entity:getMO(), slot1, slot2) then
			slot8 = table.remove(slot0._guideClickList, slot6)

			slot8.rightClick:RemoveClickListener()

			slot9 = slot8.click

			slot9:RemoveClickListener()
			slot9:RemoveClickDownListener()
			slot9:RemoveClickUpListener()
			slot8.longPress:RemoveLongPressListener()
			gohelper.destroy(slot8.obj)
		end
	end

	if #slot0._guideClickList == 0 then
		TaskDispatcher.cancelTask(slot0._updateGuideClick, slot0)
		FightModel.instance:setClickEnemyState(false)

		slot0._curClickEntityId = nil
	end
end

function slot0._onClick(slot0, slot1, slot2)
	if not (slot1 or slot0._curClickEntityId) then
		return
	end

	if not FightHelper.getEntity(slot3) then
		return
	end

	if not slot4:isEnemySide() then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightFocus) and not GuideModel.instance:isGuideFinish(GuideController.FirstGuideId) then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard or slot7 == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if FightModel.instance:isAuto() then
		if slot3 == FightCardModel.instance.curSelectEntityId then
			FightCardModel.instance:setCurSelectEntityId(0)
		else
			slot0:_playSelectAnim()
			FightCardModel.instance:setCurSelectEntityId(slot3)
		end
	else
		if slot3 ~= FightCardModel.instance.curSelectEntityId then
			slot0:_playSelectAnim()
		end

		FightCardModel.instance:setCurSelectEntityId(slot3)
	end

	slot0:_updateSelectUI()
	FightController.instance:dispatchEvent(FightEvent.SelectSkillTarget, slot3)
end

function slot0._onClickDown(slot0, slot1, slot2)
	slot0._curClickEntityId = nil

	for slot7 = #FightHelper.getAllEntitys(), 1, -1 do
		if not slot0:checkCanSelect(slot3[slot7].id) then
			table.remove(slot3, slot7)
		end
	end

	if FightHelper.getClickEntity(slot3, slot0._clickBlockTransform, slot2) then
		FightModel.instance:setClickEnemyState(true)

		slot0._curClickEntityId = slot4
	end
end

function slot0.checkCanSelect(slot0, slot1)
	if FightDataHelper.entityMgr:isAssistBoss(slot1) then
		return false
	end

	if FightDataHelper.entityMgr:isSub(slot1) then
		return false
	end

	if not FightDataHelper.entityMgr:getById(slot1) then
		return false
	end

	if slot2:hasBuffFeature(FightEnum.BuffType_CantSelect) then
		return false
	end

	if slot2:hasBuffFeature(FightEnum.BuffType_CantSelectEx) then
		return false
	end

	if slot2:hasBuffFeature(FightEnum.BuffType_HideLife) then
		return false
	end

	return true
end

function slot0._onClickUp(slot0, slot1, slot2)
	if slot0._curClickEntityId then
		FightModel.instance:setClickEnemyState(false)
	end
end

function slot0._onLongPress(slot0, slot1)
	if not slot0._curClickEntityId then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if FightDataHelper.stageMgr:getCurOperateState() == FightStageMgr.OperateStateType.Discard or slot2 == FightStageMgr.OperateStateType.DiscardEffect then
		return
	end

	if FightModel.instance:getCurStage() ~= FightEnum.Stage.Card then
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

	if not FightHelper.getEntity(slot0._curClickEntityId) then
		return
	end

	if FightDataHelper.entityMgr:isSub(slot4.id) then
		return
	end

	slot0.currentFocusEntityMO = FightDataHelper.entityMgr:getById(slot0._curClickEntityId)

	if not slot0.currentFocusEntityMO then
		return
	end

	if slot0.currentFocusEntityMO:isAssistBoss() then
		return
	end

	slot0.viewContainer:openFightFocusView(slot0.currentFocusEntityMO.id)
end

function slot0.onExitStage(slot0, slot1)
	slot2 = FightDataHelper.stageMgr:getCurStage()

	if FightDataHelper.stageMgr:inReplay() then
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

function slot0.onEnemyActionStatusChange(slot0, slot1)
	slot0.showEnemyActioning = FightEnum.EnemyActionStatus.Select == slot1

	slot0:_setSelectGOActive(true)
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
	TaskDispatcher.cancelTask(slot0._updateGuideClick, slot0)
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
		slot3, slot4, slot5, slot6 = FightHelper.calcRect(slot1, slot0._clickBlockTransform)

		return (slot3 + slot5) / 2, (slot4 + slot6) / 2
	end
end

function slot0.getCurrentFocusEntityId(slot0)
	return slot0.currentFocusEntityMO.id
end

function slot0.onDestroyView(slot0)
end

return slot0
