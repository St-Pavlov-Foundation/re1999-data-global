module("modules.logic.scene.fight.comp.FightSceneTempEntityMgrComp", package.seeall)

slot0 = class("FightSceneTempEntityMgrComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._entityDic = {}
	slot0._entityVisible = {}
	slot0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	FightController.instance:registerCallback(FightEvent.EntrustTempEntity, slot0._onEntrustTempEntity, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	FightController.instance:registerCallback(FightEvent.ReleaseAllEntrustedEntity, slot0._releaseAllEntity, slot0)
end

function slot0._onLevelLoaded(slot0)
	slot0._fightScene = GameSceneMgr.instance:getCurScene()
	slot0._sceneObj = slot0._fightScene.level:getSceneGo()
end

function slot0._onEntrustTempEntity(slot0, slot1)
	if slot0._entityDic[slot1.id] then
		slot0:_releaseEntity(slot0._entityDic[slot2])
	end

	slot0._entityDic[slot2] = slot1
	slot0._entityVisible[slot2] = 0

	slot1.spine:play(slot1.spine._curAnimState, true)
end

function slot0._onSkillPlayStart(slot0)
	for slot4, slot5 in pairs(slot0._entityDic) do
		slot0._entityVisible[slot5.id] = (slot0._entityVisible[slot5.id] or 0) + 1

		slot5:setVisibleByPos(false)
	end
end

function slot0._onSkillPlayFinish(slot0)
	for slot4, slot5 in pairs(slot0._entityDic) do
		if slot0._entityVisible[slot5.id] then
			slot0._entityVisible[slot5.id] = slot0._entityVisible[slot5.id] - 1

			if slot0._entityVisible[slot5.id] < 0 then
				slot0._entityVisible[slot5.id] = 0
			end
		end

		if slot0._entityVisible[slot5.id] == 0 then
			slot5:setVisibleByPos(true)
			slot0._entityMgr:adjustSpineLookRotation(slot5)
		end
	end
end

function slot0._onCameraFocusChanged(slot0, slot1)
	if slot1 then
		slot0:_onSkillPlayStart()
	else
		slot0:_onSkillPlayFinish()
	end
end

function slot0._releaseEntity(slot0, slot1)
	slot0._entityMgr:removeUnit(slot1:getTag(), slot1.id)

	slot0._entityDic[slot1.id] = nil
	slot0._entityVisible[slot1.id] = nil
end

function slot0._releaseAllEntity(slot0)
	for slot4, slot5 in pairs(slot0._entityDic) do
		slot0:_releaseEntity(slot5)
	end
end

function slot0._onRestartStageBefore(slot0)
	slot0:_releaseAllEntity()
end

function slot0.onSceneClose(slot0, slot1, slot2)
	FightController.instance:unregisterCallback(FightEvent.EntrustTempEntity, slot0._onEntrustTempEntity, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	FightController.instance:unregisterCallback(FightEvent.ReleaseAllEntrustedEntity, slot0._releaseAllEntity, slot0)
	slot0:_releaseAllEntity()
end

return slot0
