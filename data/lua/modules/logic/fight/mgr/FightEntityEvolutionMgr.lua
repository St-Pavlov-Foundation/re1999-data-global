module("modules.logic.fight.mgr.FightEntityEvolutionMgr", package.seeall)

slot0 = class("FightEntityEvolutionMgr", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0._entityDic = {}
	slot0._entityVisible = {}
	slot0._skinId2Entity = {}
	slot0._skinIds = {}
	slot0._delayReleaseEntity = {}
	slot0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	slot0:com_registMsg(FightMsgId.SetBossEvolution, slot0._onSetBossEvolution)
	slot0:com_registMsg(FightMsgId.PlayTimelineSkill, slot0._onPlayTimelineSkill)
	slot0:com_registMsg(FightMsgId.PlayTimelineSkillFinish, slot0._onPlayTimelineSkillFinish)
	slot0:com_registMsg(FightMsgId.CameraFocusChanged, slot0._onCameraFocusChanged)
	slot0:com_registMsg(FightMsgId.ReleaseAllEntrustedEntity, slot0._onReleaseAllEntrustedEntity)
	slot0:com_registMsg(FightMsgId.SpineLoadFinish, slot0._onSpineLoadFinish)
	slot0:com_registMsg(FightMsgId.IsEvolutionSkin, slot0._onIsEvolutionSkin)
	slot0:com_registFightEvent(FightEvent.BeforeDestroyEntity, slot0._onBeforeDestroyEntity)
end

function slot0._onBeforeDestroyEntity(slot0, slot1)
	if slot0._entityDic[slot1.id] == slot1 then
		slot0:_releaseEntity(slot1)

		for slot5, slot6 in ipairs(slot0._delayReleaseEntity) do
			if slot6.entity == slot1 then
				slot0._entityVisible[slot1.id] = 0

				table.remove(slot0._delayReleaseEntity, slot5)
			end
		end
	end
end

function slot0._onIsEvolutionSkin(slot0, slot1)
	FightMsgMgr.replyMsg(FightMsgId.IsEvolutionSkin, slot0._skinIds[slot1])
end

function slot0._onSetBossEvolution(slot0, slot1, slot2)
	if slot0._entityDic[slot1.id] and slot1 ~= slot0._entityDic[slot3] then
		slot0:_releaseEntity(slot0._entityDic[slot3])
	end

	slot0._entityDic[slot3] = slot1
	slot0._entityVisible[slot3] = 0

	slot1.spine:play(slot1.spine._curAnimState, true)

	slot0._skinId2Entity[slot2] = slot0._skinId2Entity[slot2] or {}

	table.insert(slot0._skinId2Entity[slot2], slot1)

	slot0._skinIds[slot2] = true
end

function slot0._onSpineLoadFinish(slot0, slot1)
	if slot1.unitSpawn and slot2:getMO() and slot0._skinId2Entity[slot3.skin] then
		for slot7, slot8 in ipairs(slot0._skinId2Entity[slot3.skin]) do
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

		slot0:com_registTimer(slot0._delayRelease, 0.01)

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

function slot0._onPlayTimelineSkill(slot0)
	for slot4, slot5 in pairs(slot0._entityDic) do
		if not slot5.IS_REMOVED then
			slot0._entityVisible[slot5.id] = (slot0._entityVisible[slot5.id] or 0) + 1

			slot5:setAlpha(0, 0.2)
		end
	end
end

function slot0._onPlayTimelineSkillFinish(slot0)
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
		slot0:_onPlayTimelineSkill()
	else
		slot0:_onPlayTimelineSkillFinish()
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

function slot0._onReleaseAllEntrustedEntity(slot0)
	slot0:_releaseAllEntity()
end

function slot0.onDestructor(slot0)
	slot0:_releaseAllEntity()
end

return slot0
