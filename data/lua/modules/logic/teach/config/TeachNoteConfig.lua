module("modules.logic.teach.config.TeachNoteConfig", package.seeall)

slot0 = class("TeachNoteConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.topicConfig = nil
	slot0.levelConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"instruction_topic",
		"instruction_level"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "instruction_topic" then
		slot0.topicConfig = slot2
	elseif slot1 == "instruction_level" then
		slot0.levelConfig = slot2
	end
end

function slot0.getInstructionTopicCos(slot0)
	return slot0.topicConfig.configDict
end

function slot0.getInstructionLevelCos(slot0)
	return slot0.levelConfig.configDict
end

function slot0.getInstructionTopicCO(slot0, slot1)
	return slot0.topicConfig.configDict[slot1]
end

function slot0.getInstructionLevelCO(slot0, slot1)
	return slot0.levelConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
