module("modules.logic.room.model.mainview.bubble.RoomNavigateBaseBubble", package.seeall)

slot0 = pureTable("RoomNavigateBaseBubble")

function slot0.init(slot0, slot1)
	slot0.showType = slot1
	slot0.bubbleDatas = {}
	slot0.bubbleDataSet = {}
end

function slot0.addBubbleData(slot0, slot1)
	if slot0.bubbleDataSet[slot1] then
		return
	end

	table.insert(slot0.bubbleDatas, slot1)

	slot0.bubbleDataSet[slot1] = true
end

function slot0.removeBubbleData(slot0, slot1)
	if not slot0.bubbleDataSet[slot1] then
		return
	end

	tabletool.removeValue(slot0.bubbleDatas, slot1)

	slot0.bubbleDataSet[slot1] = nil
end

function slot0.clear(slot0)
	for slot4, slot5 in pairs(slot0.bubbleDatas) do
		slot0.bubbleDatas[slot4] = nil
	end

	for slot4, slot5 in pairs(slot0.bubbleDataSet) do
		slot0.bubbleDataSet[slot4] = nil
	end
end

function slot0.getShowType(slot0)
	return slot0.showType
end

function slot0.getBubbleCount(slot0)
	return #slot0.bubbleDatas
end

function slot0.getFirstBubble(slot0)
	return slot0.bubbleDatas[1]
end

function slot0.sort(slot0, slot1)
	if slot1 then
		table.sort(slot0.bubbleDatas, slot1)
	end
end

return slot0
