module("modules.logic.room.model.mainview.bubble.RoomNavigateBubbleCategoryMO", package.seeall)

slot0 = pureTable("RoomNavigateBubbleCategoryMO")

function slot0.init(slot0, slot1)
	slot0.showType = slot1
	slot0._buildingBubblesDict = {}
	slot0._buildingBubblesList = {}
end

slot1 = {}

function slot0.getOrCreateBubbleMO(slot0, slot1)
	if not slot0._buildingBubblesDict[slot1] then
		slot2 = (uv0[slot1] or RoomNavigateBaseBubble).New()

		slot2:init(slot1)

		slot0._buildingBubblesDict[slot1] = slot2
		slot0._buildingBubblesList[#slot0._buildingBubblesList + 1] = slot2
	end

	return slot2
end

function slot0.cleanBubble(slot0, slot1)
	if slot0._buildingBubblesDict[slot1] then
		slot2:clear()
	end
end

function slot0.getBubbles(slot0)
	return slot0._buildingBubblesList
end

function slot0.getBubbleByType(slot0, slot1)
	slot2 = nil

	if slot0._buildingBubblesDict and slot1 then
		slot2 = slot0._buildingBubblesDict[slot1]
	end

	return slot2
end

function slot0.getBubblesCount(slot0)
	for slot5, slot6 in pairs(slot0._buildingBubblesDict) do
		slot1 = 0 + slot6:getBubbleCount()
	end

	return slot1
end

function slot0.sort(slot0)
	for slot4, slot5 in pairs(slot0._buildingBubblesDict) do
		if RoomNavigateBubbleController.sortFunc[slot0.showType][slot5.showType] then
			slot5:sort(slot6)
		end
	end
end

return slot0
