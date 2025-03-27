module("modules.logic.turnback.config.TurnbackConfig", package.seeall)

slot0 = class("TurnbackConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._turnbackConfig = nil
	slot0._turnbackSigninConfig = nil
	slot0._turnbackTaskConfig = nil
	slot0._turnbackSubModuleConfig = nil
	slot0._turnbackTaskBonusConfig = nil
	slot0._turnbackRecommendConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"turnback",
		"turnback_sign_in",
		"turnback_task",
		"turnback_submodule",
		"turnback_task_bonus",
		"turnback_recommend",
		"turnback_drop"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "turnback" then
		slot0:initTurnbackConfig(slot2)
	elseif slot1 == "turnback_sign_in" then
		slot0._turnbackSigninConfig = slot2
	elseif slot1 == "turnback_task" then
		slot0._turnbackTaskConfig = slot2
	elseif slot1 == "turnback_submodule" then
		slot0._turnbackSubModuleConfig = slot2
	elseif slot1 == "turnback_task_bonus" then
		slot0._turnbackTaskBonusConfig = slot2
	elseif slot1 == "turnback_recommend" then
		slot0._turnbackRecommendConfig = slot2
	elseif slot1 == "turnback_drop" then
		slot0._turnbackDropConfig = slot2
	end
end

function slot0.initTurnbackConfig(slot0, slot1)
	slot0._turnbackConfig = slot1
	slot0.turnBackAdditionChapterId = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		for slot12, slot13 in ipairs(string.splitToNumber(slot6.additionChapterIds, "#")) do
			-- Nothing
		end

		slot0.turnBackAdditionChapterId[slot5] = {
			[slot13] = true
		}
	end
end

function slot0.isTurnBackAdditionToChapter(slot0, slot1, slot2)
	slot3 = false

	if slot1 and slot2 and slot0.turnBackAdditionChapterId and slot0.turnBackAdditionChapterId[slot1] then
		slot3 = slot0.turnBackAdditionChapterId[slot1][slot2]
	end

	return slot3
end

function slot0.getTurnbackCo(slot0, slot1)
	return slot0._turnbackConfig.configDict[slot1]
end

function slot0.getTurnbackSignInCo(slot0, slot1)
	return slot0._turnbackSigninConfig.configDict[slot1]
end

function slot0.getTurnbackSignInDayCo(slot0, slot1, slot2)
	return slot0._turnbackSigninConfig.configDict[slot1][slot2]
end

function slot0.getTurnbackTaskCo(slot0, slot1)
	return slot0._turnbackTaskConfig.configDict[slot1]
end

function slot0.getTurnbackSubModuleCo(slot0, slot1)
	return slot0._turnbackSubModuleConfig.configDict[slot1]
end

function slot0.getAllTurnbackTaskBonusCo(slot0, slot1)
	return slot0._turnbackTaskBonusConfig.configDict[slot1]
end

function slot0.getTurnbackTaskBonusCo(slot0, slot1, slot2)
	return slot0._turnbackTaskBonusConfig.configDict[slot1][slot2]
end

function slot0.getTurnbackLastBounsPoint(slot0, slot1)
	if slot0._turnbackTaskBonusConfig.configDict[slot1] then
		return slot2[#slot2].needPoint
	end

	return 0
end

function slot0.getAllTurnbackTaskBonusCoCount(slot0, slot1)
	return #slot0._turnbackTaskBonusConfig.configList[slot1]
end

function slot0.getAllTurnbackSubModules(slot0, slot1)
	return string.splitToNumber(slot0:getTurnbackCo(slot1).subModuleIds, "#")
end

function slot0.getTurnbackSubViewCo(slot0, slot1, slot2)
	slot4 = nil

	for slot8, slot9 in ipairs(slot0:getAllTurnbackSubModules(slot1)) do
		if slot9 == slot2 then
			slot4 = slot0:getTurnbackSubModuleCo(slot9)

			break
		end
	end

	return slot4
end

function slot0.getAdditionTotalCount(slot0, slot1)
	slot2 = 0

	if slot0:getTurnbackCo(slot1) then
		slot2 = string.splitToNumber(slot3.additionType, "#")[2] or 0
	end

	return slot2
end

function slot0.getAdditionRate(slot0, slot1)
	slot2 = 0

	if slot0:getTurnbackCo(slot1) then
		slot2 = slot3.additionRate
	end

	return slot2
end

function slot0.getAdditionDurationDays(slot0, slot1)
	slot2 = 0

	if slot0:getTurnbackCo(slot1) then
		slot2 = slot3.additionDurationDays
	end

	return slot2
end

function slot0.getOnlineDurationDays(slot0, slot1)
	slot2 = 0

	if slot0:getTurnbackCo(slot1) then
		slot2 = slot3.onlineDurationDays
	end

	return slot2
end

function slot0.getTaskItemBonusPoint(slot0, slot1, slot2)
	slot3, slot4 = slot0:getBonusPointCo(slot1)

	for slot10, slot11 in ipairs(string.split(slot0:getTurnbackTaskCo(slot2).bonus, "|")) do
		if tonumber(string.split(slot11, "#")[1]) == slot3 and tonumber(slot12[2]) == slot4 then
			return tonumber(slot12[3]) or 0
		end
	end
end

function slot0.getBonusPointCo(slot0, slot1)
	slot3 = string.split(slot0:getTurnbackCo(slot1).bonusPointMaterial, "#")

	return tonumber(slot3[1]), tonumber(slot3[2])
end

function slot0.getAllRecommendCo(slot0, slot1)
	return slot0._turnbackRecommendConfig.configDict[slot1]
end

function slot0.getAllRecommendList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0._turnbackRecommendConfig.configList) do
		if slot8.turnbackId == slot1 then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getRecommendCo(slot0, slot1, slot2)
	return slot0._turnbackRecommendConfig.configDict[slot1][slot2]
end

function slot0.getSearchTaskCoList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._turnbackTaskConfig.configList) do
		if slot6.listenerType == "TodayOnlineSeconds" then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getDropCoList(slot0)
	return slot0._turnbackDropConfig.configList
end

function slot0.getDropCoById(slot0, slot1)
	return slot0._turnbackDropConfig.configDict[slot1]
end

function slot0.getDropCoCount(slot0)
	return #slot0._turnbackDropConfig.configList
end

slot0.instance = slot0.New()

return slot0
