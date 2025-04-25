module("modules.logic.mainsceneswitch.config.MainSceneSwitchConfig", package.seeall)

slot0 = class("MainSceneSwitchConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"scene_switch",
		"scene_settings",
		"scene_effect_settings"
	}
end

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "scene_switch" then
		slot0:_initSceneSwitchConfig()
	end
end

function slot0._initSceneSwitchConfig(slot0)
	slot0._itemMap = {}
	slot0._itemLockList = {}
	slot0._itemSource = {}
	slot0._defaultSceneId = nil

	for slot4, slot5 in ipairs(lua_scene_switch.configList) do
		slot0._itemMap[slot5.itemId] = slot5

		if slot5.defaultUnlock == 1 then
			if slot0._defaultSceneId ~= nil then
				logError("MainSceneSwitchConfig:_initSceneSwitchConfig has more than one default scene")
			end

			slot0._defaultSceneId = slot5.id
		else
			table.insert(slot0._itemLockList, slot5.itemId)
		end
	end

	if not slot0._defaultSceneId then
		logError("MainSceneSwitchConfig:_initSceneSwitchConfig has no default scene")
	end
end

function slot0.getItemSource(slot0, slot1)
	if not slot0._itemSource[slot1] then
		slot0._itemSource[slot1] = slot0:_collectSource(slot1)
	end

	return slot2
end

function slot0._collectSource(slot0, slot1)
	slot4 = {}

	if not string.nilorempty(lua_item.configDict[slot1].sources) then
		for slot9, slot10 in ipairs(string.split(slot3, "|")) do
			slot11 = string.splitToNumber(slot10, "#")
			slot12 = {
				sourceId = slot11[1],
				probability = slot11[2]
			}
			slot12.episodeId = JumpConfig.instance:getJumpEpisodeId(slot12.sourceId)

			if slot12.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(slot12.episodeId) then
				table.insert(slot4, slot12)
			end
		end
	end

	return slot4
end

function slot0.getItemLockList(slot0)
	return slot0._itemLockList
end

function slot0.getConfigByItemId(slot0, slot1)
	return slot0._itemMap[slot1]
end

function slot0.getDefaultSceneId(slot0)
	return slot0._defaultSceneId
end

function slot0.getSceneEffect(slot0, slot1, slot2)
	if lua_scene_effect_settings.configDict[slot1] then
		for slot7, slot8 in ipairs(slot3) do
			if slot8.tag == slot2 then
				return slot8
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
