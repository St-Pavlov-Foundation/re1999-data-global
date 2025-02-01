module("modules.logic.scene.cachot.comp.CachotBGMComp", package.seeall)

slot0 = class("CachotBGMComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._levelComp = slot0._scene.level

	slot0._levelComp:registerCallback(CommonSceneLevelComp.OnLevelLoaded, slot0.onLevelLoaded, slot0)
end

function slot0.onLevelLoaded(slot0)
	slot1 = 0

	if V1a6_CachotModel.instance:getRogueInfo() then
		slot1 = slot2.layer
	end

	if V1a6_CachotEventConfig.instance:getBgmIdByLayer(slot1) then
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, slot3)
	end
end

function slot0.onSceneClose(slot0)
	slot0._levelComp:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, slot0.onLevelLoaded, slot0)
end

return slot0
