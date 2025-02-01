module("modules.logic.versionactivity1_4.act130.model.Activity130ElementMo", package.seeall)

slot0 = pureTable("Activity130ElementMo")

function slot0.ctor(slot0)
	slot0.elementId = 0
	slot0.isFinish = false
	slot0.index = 0
	slot0.historylist = {}
	slot0.visible = false
	slot0.config = {}
	slot0.typeList = {}
	slot0.paramList = {}
end

function slot0.init(slot0, slot1)
	slot0.elementId = slot1.elementId
	slot0.isFinish = slot1.isFinish
	slot0.index = slot1.index
	slot0.historylist = {}

	for slot5, slot6 in ipairs(slot1.historylist) do
		table.insert(slot0.historylist, slot6)
	end

	slot0.visible = slot1.visible
	slot0.config = Activity130Config.instance:getActivity130ElementCo(VersionActivity1_4Enum.ActivityId.Role37, slot0.elementId)

	if not slot0.config then
		logError(string.format("Activity130ElementMo no config id:%s", slot0.elementId))

		return
	end

	slot0.typeList = string.splitToNumber(slot0.config.type, "#")
	slot0.paramList = string.split(slot0.config.param, "#")
end

function slot0.isAvailable(slot0)
	return not slot0.isFinish and slot0.visible
end

function slot0.updateHistoryList(slot0, slot1)
	slot0.historylist = slot1
end

function slot0.getType(slot0)
	return slot0.typeList[slot0.index + 1]
end

function slot0.getNextType(slot0)
	return slot0.typeList[slot0.index + 2]
end

function slot0.getParam(slot0)
	return slot0.paramList[slot0.index + 1]
end

function slot0.getPrevParam(slot0)
	return slot0.paramList[slot0.index]
end

return slot0
