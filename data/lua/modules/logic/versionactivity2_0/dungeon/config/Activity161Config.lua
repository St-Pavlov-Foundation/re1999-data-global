module("modules.logic.versionactivity2_0.dungeon.config.Activity161Config", package.seeall)

slot0 = class("Activity161Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._activity161GraffitiConfig = nil
	slot0._activity161RewardConfig = nil
	slot0._activity161DialogConfig = nil
	slot0._activity161ChessConfig = nil
	slot0.graffitiPicList = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity161_graffiti",
		"activity161_reward",
		"activity161_graffiti_event",
		"activity161_graffiti_dialog",
		"activity161_graffiti_chess"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity161_graffiti" then
		slot0._activity161GraffitiConfig = slot2
	elseif slot1 == "activity161_reward" then
		slot0._activity161RewardConfig = slot2
	elseif slot1 == "activity161_graffiti_dialog" then
		slot0._activity161DialogConfig = slot2
	elseif slot1 == "activity161_graffiti_chess" then
		slot0._activity161ChessConfig = slot2
	end
end

function slot0.getAllGraffitiCo(slot0, slot1)
	return slot0._activity161GraffitiConfig.configDict[slot1]
end

function slot0.getGraffitiCo(slot0, slot1, slot2)
	return slot0._activity161GraffitiConfig.configDict[slot1][slot2]
end

function slot0.getGraffitiCount(slot0, slot1)
	return GameUtil.getTabLen(slot0:getAllGraffitiCo(slot1))
end

function slot0.getAllRewardCos(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(slot0._activity161RewardConfig.configDict[slot1]) do
		table.insert(slot2, slot8)
	end

	table.sort(slot2, uv0.sortReward)

	return slot2
end

function slot0.sortReward(slot0, slot1)
	return slot0.rewardId < slot1.rewardId
end

function slot0.getRewardCo(slot0, slot1, slot2)
	return slot0._activity161RewardConfig.configDict[slot1][slot2]
end

function slot0.getFinalReward(slot0, slot1)
	slot2 = tabletool.copy(slot0:getAllRewardCos(slot1))
	slot4 = GameUtil.splitString2(slot2[#slot2].bonus, true)

	return slot4, table.remove(slot4, #slot4)
end

function slot0.getUnlockCondition(slot0, slot1)
	slot3, slot4, slot5 = nil

	if not string.nilorempty(DungeonConfig.instance:getChapterMapElement(slot1).condition) then
		slot3 = slot0:extractConditionValue(slot2.condition, "EpisodeFinish")
		slot4 = slot0:extractConditionValue(slot2.condition, "ChapterMapElement")
		slot5 = slot0:extractConditionValue(slot2.condition, "Act161CdFinish")
	end

	return slot3, slot4, slot5
end

function slot0.extractConditionValue(slot0, slot1, slot2)
	return string.match(slot1, slot2 .. "=(%d+)") or nil
end

function slot0.getAllDialogMapCoByGraoupId(slot0, slot1)
	return slot0._activity161DialogConfig.configDict[slot1]
end

function slot0.getDialogConfig(slot0, slot1, slot2)
	return slot0._activity161DialogConfig.configDict[slot1][slot2]
end

function slot0.getChessConfig(slot0, slot1)
	return slot0._activity161ChessConfig.configDict[slot1]
end

function slot0.getGraffitiRelevantElementMap(slot0, slot1)
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(slot0:getAllGraffitiCo(slot1)) do
		slot10 = {}

		if not string.nilorempty(slot9.subElementIds) then
			slot14 = "#"

			for slot14, slot15 in pairs(string.splitToNumber(slot9.subElementIds, slot14)) do
				slot3[slot15] = slot9
			end
		end

		if not string.nilorempty(slot9.mainElementId) then
			slot4[slot9.mainElementId] = slot9
		end
	end

	return slot3, slot4
end

function slot0.getGraffitiRelevantElement(slot0, slot1, slot2)
	slot4 = {}

	if not string.nilorempty(slot0:getGraffitiCo(slot1, slot2).subElementIds) then
		slot4 = string.splitToNumber(slot3.subElementIds, "#")
	end

	return slot4
end

function slot0.isPreMainElementFinish(slot0, slot1)
	if #(string.splitToNumber(slot1.preMainElementIds, "#") or {}) == 0 then
		return true
	end

	for slot6, slot7 in ipairs(slot2) do
		if not DungeonMapModel.instance:elementIsFinished(slot7) then
			return false
		end
	end

	return true
end

function slot0.initGraffitiPicMap(slot0, slot1)
	if #slot0.graffitiPicList == 0 then
		for slot6, slot7 in pairs(slot0:getAllGraffitiCo(slot1)) do
			table.insert(slot0.graffitiPicList, slot7)
		end

		table.sort(slot0.graffitiPicList, slot0.sortGraffitiPic)
	end
end

function slot0.sortGraffitiPic(slot0, slot1)
	return slot0.sort < slot1.sort
end

function slot0.checkIsGraffitiMainElement(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0:getAllGraffitiCo(slot1)) do
		if slot8.mainElementId == slot2 then
			return true, slot8
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
