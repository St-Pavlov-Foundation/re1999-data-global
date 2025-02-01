module("modules.logic.meilanni.model.EpisodeEventMO", package.seeall)

slot0 = pureTable("EpisodeEventMO")

function slot0.init(slot0, slot1)
	slot0.eventId = slot1.eventId
	slot0.isFinish = slot1.isFinish
	slot0.option = slot1.option
	slot0.index = slot1.index

	slot0:_initHistorySelect(slot1)
	slot0:_initHistorylist(slot1)

	slot0.config = MeilanniConfig.instance:getElementConfig(slot0.eventId)

	if not slot0.config then
		logError(string.format("EpisodeEventMO no config id:%s", slot0.eventId))

		return
	end

	slot0.interactParam = GameUtil.splitString2(slot0.config.interactParam, true, "|", "#")
end

function slot0._initHistorySelect(slot0, slot1)
	slot0.historySelect = {}

	for slot5, slot6 in ipairs(slot1.historySelect) do
		slot0.historySelect[slot6] = slot6
	end
end

function slot0.optionIsSelected(slot0, slot1)
	return slot0.historySelect[slot1]
end

function slot0._initHistorylist(slot0, slot1)
	slot0.historylist = {}

	for slot5, slot6 in ipairs(slot1.historylist) do
		slot7 = EventHistoryMO.New()

		slot7:init(slot6)

		slot0.historylist[slot7.index] = slot7
	end
end

function slot0.getSkipDialog(slot0)
	for slot4, slot5 in ipairs(slot0.interactParam) do
		if slot5[1] == MeilanniEnum.ElementType.Dialog and lua_activity108_dialog.configDict[slot5[2]] and slot7[-1] then
			return slot8
		end
	end
end

function slot0.getType(slot0)
	return slot0.interactParam[slot0.index + 1] and slot1[1]
end

function slot0.getNextType(slot0)
	return slot0.interactParam[slot0.index + 2] and slot1[1]
end

function slot0.getParam(slot0)
	return slot0.interactParam[slot0.index + 1] and slot1[2]
end

function slot0.getPrevParam(slot0)
	return slot0.interactParam[slot0.index] and slot1[2]
end

function slot0.getBattleId(slot0)
	return tonumber(slot0:getParam())
end

function slot0.getConfigBattleId(slot0)
	for slot4, slot5 in ipairs(slot0.interactParam) do
		if slot5[1] == MeilanniEnum.ElementType.Battle then
			return tonumber(slot5[2])
		end
	end
end

return slot0
