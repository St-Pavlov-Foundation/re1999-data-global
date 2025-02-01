module("modules.logic.rouge.config.RougeConfig1", package.seeall)

slot0 = class("RougeConfig1", RougeConfig)

function slot0.season(slot0)
	return 1
end

function slot0.openUnlockId(slot0)
	return OpenEnum.UnlockFunc.Rouge1
end

function slot0.achievementJumpId(slot0)
	return tonumber(lua_rouge_const.configDict[RougeEnum.Const.AchievementJumpId].value)
end

function slot0.getRougeDifficultyViewStyleIndex(slot0, slot1)
	if not slot1 then
		return
	end

	return math.min(tonumber(slot0:getConstValueByID(12)) or 1, math.ceil(slot1 / (tonumber(slot0:getConstValueByID(11)) or 1)))
end

function slot0.calcStyleCOPassiveSkillDescsList(slot0, slot1)
	slot2 = {
		slot1.passiveSkillDescs
	}
	slot4 = slot1["passiveSkillDescs" .. tostring(2)]

	while slot4 do
		slot2[#slot2 + 1] = slot4
		slot4 = slot1["passiveSkillDescs" .. tostring(slot3 + 1)]
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
