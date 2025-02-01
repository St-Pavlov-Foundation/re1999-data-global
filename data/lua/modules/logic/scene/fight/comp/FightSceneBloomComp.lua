module("modules.logic.scene.fight.comp.FightSceneBloomComp", package.seeall)

slot0 = class("FightSceneBloomComp", BaseSceneComp)
slot0.Bloom_invisible = "invisible"
slot0.Bloom_mirror = "mirror"
slot0.Bloom_useShadow = "useShadow"
slot0.Bloom_mirrorNoise = "mirrorNoise"
slot1 = {
	[slot0.Bloom_invisible] = "useInvisible",
	[slot0.Bloom_mirror] = "useMirror",
	[slot0.Bloom_useShadow] = "useShadow"
}
slot2 = {
	[slot0.Bloom_invisible] = "characterInvisibleActive"
}

function slot0.onInit(slot0)
	slot0:addConstEvents()
end

function slot0.addConstEvents(slot0)
	slot0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._entityDict = {}
	slot0._scenePassDict = {}
	slot0._entityPassDict = {}

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
end

function slot0.onSceneClose(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	if slot0._localBloomColor then
		PostProcessingMgr.instance:setLocalBloomColor(slot0._localBloomColor)

		slot0._localBloomColor = nil
	end

	slot0._entityDict = {}
	slot0._scenePassDict = {}
	slot0._entityPassDict = {}

	slot0:_checkCameraPPVolume()
	TaskDispatcher.cancelTask(slot0._delayAddEntityBloom, slot0)
end

function slot0._onLevelLoaded(slot0, slot1)
	if lua_scene_level.configDict[slot1] and slot2.useBloom == 1 then
		if slot0._localBloomColor == nil then
			slot0._localBloomColor = PostProcessingMgr.instance:getLocalBloomColor()
		end

		PostProcessingMgr.instance:setLocalBloomColor(Color.New(slot2.bloomR, slot2.bloomG, slot2.bloomB, slot2.bloomA))
		PostProcessingMgr.instance:setFlickerSceneFactor(slot2.flickerSceneFactor)
		PostProcessingMgr.instance:setLocalBloomActive(true)

		slot0._scenePassDict = {}

		if not string.nilorempty(slot2.bloomEffect) then
			for slot7, slot8 in ipairs(string.split(slot2.bloomEffect, "#")) do
				slot0._scenePassDict[slot8] = true
			end
		end
	end

	for slot6, slot7 in pairs(slot0._entityDict) do
		slot0:_checkEntityPPEffectMask(slot6)
	end

	slot0:_checkCameraPPVolume()
end

function slot0.addEntity(slot0, slot1)
	slot0._delayAddEntitys = slot0._delayAddEntitys or {}

	table.insert(slot0._delayAddEntitys, slot1)
	TaskDispatcher.cancelTask(slot0._delayAddEntityBloom, slot0)
	TaskDispatcher.runDelay(slot0._delayAddEntityBloom, slot0, 2)
end

function slot0._delayAddEntityBloom(slot0)
	for slot4, slot5 in ipairs(slot0._delayAddEntitys) do
		slot0._entityDict[slot5] = true

		slot0:_checkEntityPPEffectMask(slot5)
		slot0:_checkCameraPPVolume()
	end

	slot0._delayAddEntitys = nil
end

function slot0.removeEntity(slot0, slot1)
	slot0._entityDict[slot1] = nil

	slot0:_checkEntityPPEffectMask(slot1)
	slot0:_checkCameraPPVolume()
end

function slot0.setSingleEntityPass(slot0, slot1, slot2, slot3, slot4)
	if not slot0._entityPassDict[slot1] then
		slot0._entityPassDict[slot1] = {}
	end

	if not slot5[slot3] then
		slot5[slot3] = {}
	end

	slot6[slot4] = slot2 and true or nil

	slot0:_checkEntityPPEffectMask(slot3)
	slot0:_checkCameraPPVolume(slot1)
end

function slot0._checkEntityPPEffectMask(slot0, slot1)
	if not (slot1.spine and slot1.spine:getPPEffectMask()) then
		return
	end

	if not slot1.spineRenderer then
		return
	end

	if gohelper.isNil(slot1.spineRenderer:getReplaceMat()) then
		logError("FightSceneBloomComp.SetPassEnable mat=nil")

		return
	end

	for slot7, slot8 in pairs(uv0) do
		if not (slot0._entityDict[slot1] and slot0._scenePassDict[slot7] or false) and slot0._entityPassDict[slot7] and slot10[slot1] then
			for slot15, slot16 in pairs(slot11) do
				slot9 = true

				break
			end
		end

		slot2:SetPassEnable(slot3, slot8, slot9)
	end
end

function slot0._checkCameraPPVolume(slot0, slot1)
	if slot1 then
		if uv0[slot1] then
			slot0:_checkOneCameraPPVolume(slot1)
		end
	else
		for slot5, slot6 in pairs(uv0) do
			slot0:_checkOneCameraPPVolume(slot5)
		end
	end
end

function slot0._checkOneCameraPPVolume(slot0, slot1)
	if not slot0._scenePassDict[slot1] and slot0._entityPassDict[slot1] then
		for slot7, slot8 in pairs(slot3) do
			for slot12, slot13 in pairs(slot8) do
				slot2 = true

				break
			end

			if slot2 then
				break
			end
		end
	end

	PostProcessingMgr.instance:setUnitPPValue(uv0[slot1], slot2)
end

function slot0._onSkillPlayStart(slot0, slot1, slot2)
	if slot1:getMO() and slot3:isUniqueSkill(slot2) then
		for slot8, slot9 in ipairs(FightHelper.getSideEntitys(slot3.side)) do
			GameSceneMgr.instance:getCurScene().bloom:setSingleEntityPass(uv0.Bloom_invisible, false, slot9, "buff_bloom")
		end
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2)
	if slot1:getMO() and slot3:isUniqueSkill(slot2) then
		for slot8, slot9 in ipairs(FightHelper.getSideEntitys(slot3.side)) do
			if slot9.buff then
				slot9.buff:_udpateBuffVariant()
			end
		end
	end
end

return slot0
