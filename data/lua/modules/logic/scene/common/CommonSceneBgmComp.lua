module("modules.logic.scene.common.CommonSceneBgmComp", package.seeall)

slot0 = class("CommonSceneBgmComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0._sceneLevelCO = lua_scene_level.configDict[slot2]

	if slot0._sceneLevelCO and slot0._sceneLevelCO.bgmId and slot0._sceneLevelCO.bgmId > 0 then
		AudioMgr.instance:trigger(slot0._sceneLevelCO.bgmId)
	end
end

function slot0.onSceneClose(slot0)
end

return slot0
