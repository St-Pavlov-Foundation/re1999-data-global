module("modules.logic.fight.system.work.FightWorkFocusMonster", package.seeall)

slot0 = class("FightWorkFocusMonster", BaseWork)
slot0.EaseTime = 0
slot0.Speed = 15
slot0.TweenId = 0

function slot0.onStart(slot0)
	slot1, slot2 = uv0.getFocusEntityId()

	if slot1 then
		ViewMgr.instance:openView(ViewName.FightTechniqueGuideView, {
			entity = FightDataHelper.entityMgr:getById(slot1),
			config = slot2
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	else
		slot0:onDone(true)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.FightTechniqueGuideView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, uv0.EaseTime)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0.getPlayerPrefKey()
	return string.format("%s&%s&%s&%s", PlayerPrefsKey.FightFocusMonster, PlayerModel.instance:getPlayinfo().userId, tostring(FightModel.instance:getFightParam().episodeId), tostring(FightModel.instance:getCurWaveId()))
end

function slot0.getFocusEntityId()
	slot0 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)

	if not FightModel.instance:getFightParam().episodeId then
		return
	end

	if DungeonModel.instance:hasPassLevel(slot2) then
		return
	end

	if not lua_monster_guide_focus.configDict[slot1.episodeId] then
		return
	end

	table.sort(slot0, function (slot0, slot1)
		slot3 = slot1:getMO()

		if slot0:getMO() and slot3 and slot2.position ~= slot3.position then
			return slot2.position < slot3.position
		end

		return tonumber(slot2.id) < tonumber(slot3.id)
	end)

	for slot6, slot7 in ipairs(slot0) do
		if FightConfig.instance:getMonsterGuideFocusConfig(slot1.episodeId, uv0.invokeType.Enter, FightModel.instance:getCurWaveId(), slot7:getMO() and slot8.modelId) and not PlayerPrefsHelper.hasKey(FightWorkSkillOrBuffFocusMonster.getPlayerPrefKey(slot10)) then
			return slot8.id, slot10
		end
	end
end

slot0.invokeType = {
	Skill = 1,
	Enter = 0,
	Buff = 2
}

function slot0.getCameraPositionByEntity(slot0, slot1)
	slot3, slot4, slot5 = transformhelper.getPos(slot1:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle).transform)

	return slot1:isMySide() and slot3 - 2.7 or slot3 + 2.7, slot4 - 2, slot5 + 5.4
end

function slot0.focusCamera(slot0)
	slot1 = false

	if FightHelper.getEntity(slot0) and slot2:getMO() and FightConfig.instance:getSkinCO(slot3.skin) and slot4.canHide == 1 then
		slot1 = true
	end

	for slot7, slot8 in ipairs(FightHelper.getAllEntitys()) do
		slot8:setVisibleByPos(slot1 or slot0 == slot8.id)

		if slot8.buff then
			if slot0 ~= slot8.id then
				slot8.buff:hideBuffEffects()
			else
				slot8.buff:showBuffEffects()
			end
		end

		if slot8.nameUI then
			slot8.nameUI:setActive(slot0 == slot8.id)
		end
	end

	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(false)

	if FightHelper.getEntity(slot0) then
		slot6, slot7, slot8 = uv0:getCameraPositionByEntity(slot5)

		if #FightConfig.instance:getSkinCO(slot5:getMO().skin).focusOffset == 3 then
			slot6 = slot6 + slot10[1]
			slot7 = slot7 + slot10[2]
			slot8 = slot8 + slot10[3]
		end

		uv0.setVirtualCameDamping(1, 1, 1)

		uv0.EaseTime = Vector3.Distance(Vector3.New(slot6, slot7, slot8), Vector3.zero) / uv0.Speed

		uv0.killTween()

		uv0.TweenId = ZProj.TweenHelper.DOMove(CameraMgr.instance:getVirtualCameraTrs(), slot6, slot7, slot8, uv0.EaseTime)
	end
end

function slot0.cancelFocusCamera()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or GameSceneMgr.instance:isClosing() then
		return
	end

	for slot4, slot5 in ipairs(FightHelper.getAllEntitys()) do
		slot5:setVisibleByPos(true)

		if slot5.buff then
			slot5.buff:showBuffEffects()
		end

		if slot5.nameUI then
			slot5.nameUI:setActive(true)
		end
	end

	slot1, slot2, slot3 = uv0.getCurrentSceneCameraOffset()

	uv0.setVirtualCameDamping(0.5, 0.5, 0.5)
	uv0.killTween()

	uv0.TweenId = ZProj.TweenHelper.DOMove(CameraMgr.instance:getVirtualCameraTrs(), slot1, slot2, slot3, uv0.EaseTime, uv0.cancelFocusCameraFinished)

	TaskDispatcher.runDelay(uv0.showCardPart, uv0, uv0.EaseTime)

	uv0.EaseTime = 0
end

function slot0.changeCameraPosition(slot0, slot1, slot2, slot3, slot4)
	if not isDebugBuild then
		return
	end

	if not ViewMgr.instance:getContainer(ViewName.FightSkillSelectView) then
		return
	end

	if not slot5._views[1]:getCurrentFocusEntityId() then
		return
	end

	if not FightHelper.getEntity(slot6) then
		return
	end

	slot8, slot9, slot10 = uv0:getCameraPositionByEntity(slot7)

	uv0.killTween()

	uv0.TweenId = ZProj.TweenHelper.DOMove(CameraMgr.instance:getVirtualCameraTrs(), slot8 + slot0, slot9 + slot1, slot10 + slot2, 0.1, slot3, slot4)
end

function slot0.showCardPart()
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, false)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, false)
end

function slot0.getCurrentSceneCameraOffset()
	if lua_scene_level.configDict[GameSceneMgr.instance:getCurLevelId()] and not string.nilorempty(slot1.cameraOffset) then
		slot2 = Vector3(unpack(cjson.decode(slot1.cameraOffset)))

		return slot2.x, slot2.y, slot2.z
	else
		return 0, 0, 0
	end
end

function slot0.setVirtualCameDamping(slot0, slot1, slot2)
	ZProj.GameHelper.SetVirtualCameraTrackedDollyDamping(GameSceneMgr.instance:getScene(SceneType.Fight).camera:getCurActiveVirtualCame(), slot0, slot1, slot2)
end

function slot0.cancelFocusCameraFinished()
	uv0.setVirtualCameDamping(1, 1, 1)
	GameSceneMgr.instance:getScene(SceneType.Fight).level:setFrontVisible(true)
end

function slot0.killTween()
	if uv0.TweenId ~= 0 then
		ZProj.TweenHelper.KillById(uv0.TweenId)
	end
end

return slot0
