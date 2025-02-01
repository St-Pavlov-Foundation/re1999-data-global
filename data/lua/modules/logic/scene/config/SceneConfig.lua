module("modules.logic.scene.config.SceneConfig", package.seeall)

slot0 = class("SceneConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._scene2LevelCOs = nil
	slot0._iconCos = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"scene",
		"scene_level",
		"camera",
		"loading_text",
		"loading_icon",
		"scene_ctrl"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "loading_icon" then
		slot0._iconCos = slot2
	end
end

function slot0.getSceneLevelCOs(slot0, slot1)
	if not slot0._scene2LevelCOs then
		slot0._scene2LevelCOs = {}
	end

	if not lua_scene.configDict[slot1] then
		logError("scene config not exist: " .. tostring(slot1))

		return
	end

	if not slot0._scene2LevelCOs[slot1] then
		slot0._scene2LevelCOs[slot1] = {}

		for slot6, slot7 in ipairs(slot2.levels) do
			if lua_scene_level.configDict[slot7] then
				table.insert(slot0._scene2LevelCOs[slot1], slot8)
			else
				logError("scene level config not exist: " .. tostring(slot7))
			end
		end
	end

	return slot0._scene2LevelCOs[slot1]
end

function slot0.getLoadingIcons(slot0)
	return slot0._iconCos.configDict
end

slot0.instance = slot0.New()

return slot0
