module("modules.logic.versionactivity1_4.act134.config.Activity134Config", package.seeall)

slot0 = class("Activity134Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity134_task",
		"activity134_bonus",
		"activity134_story"
	}
end

function slot0.ctor(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity134_task" then
		slot0:_initTaskConfig()
	elseif slot1 == "activity134_bonus" then
		slot0:_initBonusConfig()
	elseif slot1 == "activity134_story" then
		slot0:_initStoryConfig()
	end
end

function slot0._initTaskConfig(slot0)
	slot0._taskConfig = {}

	for slot4, slot5 in ipairs(lua_activity134_task.configList) do
		table.insert(slot0._taskConfig, slot5)
	end
end

function slot0.getTaskConfig(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._taskConfig) do
		if slot6.id == slot1 then
			return slot6
		end
	end
end

function slot0._initBonusConfig(slot0)
	slot0._bonusConfig = {}
	slot1 = 1

	for slot5, slot6 in ipairs(lua_activity134_bonus.configList) do
		slot0._bonusConfig[slot1] = slot6
		slot1 = slot1 + 1
	end
end

function slot0.getBonusAllConfig(slot0)
	return slot0._bonusConfig
end

function slot0.getBonusConfig(slot0, slot1)
	if slot0._bonusConfig[slot1] and slot2.id == slot1 then
		return slot2
	end

	for slot6, slot7 in ipairs(slot0._bonusConfig) do
		if slot7.id == slot1 then
			return slot7
		end
	end

	return slot2
end

function slot0._initStoryConfig(slot0)
	slot0._storyConfig = {}

	for slot4, slot5 in ipairs(lua_activity134_story.configList) do
		slot0._storyConfig[slot5.id] = slot5
	end
end

function slot0.getStoryConfig(slot0, slot1)
	if not slot0._storyConfig[slot1] then
		logError("[1.4运营活动下半场尘封记录数据错误] 找不到对应的故事配置:id = " .. slot1)

		return
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
