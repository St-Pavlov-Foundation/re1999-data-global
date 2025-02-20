module("modules.logic.scene.fight.comp.FightSceneBossEntityEvolutionMgrComp", package.seeall)

slot0 = class("FightSceneBossEntityEvolutionMgrComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._entityDic = {}
	slot0._entityVisible = {}
	slot0._skinId2Entity = {}
	slot0._skinIds = {}
	slot0._delayReleaseEntity = {}
	slot0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	FightController.instance:registerCallback(FightEvent.SetBossEvolution, slot0._onSetBossEvolution, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	FightController.instance:registerCallback(FightEvent.ReleaseAllEntrustedEntity, slot0._releaseAllEntity, slot0)
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
end

function slot0._onLevelLoaded(slot0)
	slot0._fightScene = GameSceneMgr.instance:getCurScene()
	slot0._sceneObj = slot0._fightScene.level:getSceneGo()
end

function slot0.isEvolutionSkin(slot0, slot1)
	return slot0._skinIds[slot1]
end

function slot0._onSetBossEvolution(slot0, slot1, slot2)
	if slot0._entityDic[slot1.id] then
		slot0:_releaseEntity(slot0._entityDic[slot3])
	end

	slot0._entityDic[slot3] = slot1
	slot0._entityVisible[slot3] = 0

	slot1.spine:play(slot1.spine._curAnimState, true)

	slot0._skinId2Entity[slot2] = slot0._skinId2Entity[slot2] or {}

	table.insert(slot0._skinId2Entity[slot2], slot1)

	slot0._skinIds[slot2] = true
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot1.unitSpawn and slot2:getMO() and slot0._skinId2Entity[slot3.skin] then
		slot7 = slot3.skin

		for slot7, slot8 in ipairs(slot0._skinId2Entity[slot7]) do
			if slot8.spine and slot9._skeletonAnim and slot9._skeletonAnim.state:GetCurrent(0) and slot1._skeletonAnim then
				slot1._skeletonAnim:Jump2Time(slot10.TrackTime)
			end

			slot12 = slot1:getSpineGO()

			transformhelper.setLocalPos(slot12.transform, -10000, 0, 0)
			table.insert(slot0._delayReleaseEntity, {
				entity = slot8,
				spineGO = slot12
			})
		end

		TaskDispatcher.runDelay(slot0._delayRelease, slot0, 0.01)

		slot0._skinId2Entity[slot3.skin] = nil
	end
end

function slot0._delayRelease(slot0)
	for slot4, slot5 in ipairs(slot0._delayReleaseEntity) do
		slot0:_releaseEntity(slot5.entity)
		transformhelper.setLocalPos(slot5.spineGO.transform, 0, 0, 0)
	end

	slot0._delayReleaseEntity = {}
end

function slot0._onSkillPlayStart(slot0)
	for slot4, slot5 in pairs(slot0._entityDic) do
		slot0._entityVisible[slot5.id] = (slot0._entityVisible[slot5.id] or 0) + 1

		slot5:setAlpha(0, 0.2)
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
			slot5:setAlpha(1, 0.2)
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
	if slot0._entityDic[slot1.id] then
		slot0._entityMgr:destroyUnit(slot1)

		slot0._entityDic[slot1.id] = nil
		slot0._entityVisible[slot1.id] = nil
	end
end

function slot0._releaseAllEntity(slot0)
	for slot4, slot5 in pairs(slot0._entityDic) do
		slot0:_releaseEntity(slot5)
	end

	slot0._skinId2Entity = {}
	slot0._skinIds = {}
	slot0._delayReleaseEntity = {}
end

function slot0._onRestartStageBefore(slot0)
	slot0:_releaseAllEntity()
end

function slot0.onSceneClose(slot0, slot1, slot2)
	TaskDispatcher.cancelTask(slot0._delayRelease, slot0)
	FightController.instance:unregisterCallback(FightEvent.SetBossEvolution, slot0._onSetBossEvolution, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
	FightController.instance:unregisterCallback(FightEvent.ReleaseAllEntrustedEntity, slot0._releaseAllEntity, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
	slot0:_releaseAllEntity()
end

return slot0
