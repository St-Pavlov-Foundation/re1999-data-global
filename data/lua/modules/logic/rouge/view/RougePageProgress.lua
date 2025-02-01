module("modules.logic.rouge.view.RougePageProgress", package.seeall)

slot0 = class("RougePageProgress", LuaCompBase)

function slot0.ctor(slot0)
	slot0._highLightRange = {
		false,
		false
	}
	slot0._totalPage = 0
end

function slot0.init(slot0, slot1)
	slot0._itemList = slot0:getUserDataTb_()
	slot0._goLayout = gohelper.findChild(slot1, "Root/#go_Layout")

	for slot7 = 0, slot0._goLayout.transform.childCount - 1 do
		slot9 = RougePageProgressItem.New(slot0)

		slot9:init(slot2:GetChild(slot7))
		slot9:setHighLight(false)

		if slot7 == slot3 - 1 then
			slot9:setLineActiveByState(nil)
		else
			slot9:setLineActiveByState(RougePageProgressItem.LineStateEnum.Done)
		end

		table.insert(slot0._itemList, slot9)
	end

	slot0._totalPage = slot3
end

function slot0.setHighLightRange(slot0, slot1, slot2)
	slot4 = slot0._highLightRange[2]

	if slot0._highLightRange[1] == (slot2 or 1) and slot4 == slot1 then
		return
	end

	for slot10 = slot4 and math.max(slot4, slot2) or slot2, slot3 and math.min(slot3, slot1) or slot1 do
		slot0._itemList[slot10]:setHighLight(true)
	end

	if slot3 then
		for slot10 = slot3, slot5 - 1 do
			slot0._itemList[slot10]:setHighLight(false)
		end
	end

	if slot4 then
		for slot10 = slot6 + 1, slot4 do
			slot0._itemList[slot10]:setHighLight(false)
		end
	end

	slot0._highLightRange[1] = slot2
	slot0._highLightRange[2] = slot1
end

function slot0.onDestroyView(slot0)
end

function slot0.initData(slot0, slot1, slot2)
	slot3 = slot1 or 0

	assert(slot3 <= slot0:capacity(), "[RougePageProgress] initData: totalPage=" .. tostring(slot3) .. " maxPage=" .. tostring(slot0:capacity()))

	for slot7, slot8 in ipairs(slot0._itemList) do
		slot9 = slot7 <= slot3

		if slot2 then
			slot10 = RougePageProgressItem.LineStateEnum.Done

			if slot7 == slot2 then
				slot10 = RougePageProgressItem.LineStateEnum.Edit
			end

			if slot2 < slot7 then
				slot10 = RougePageProgressItem.LineStateEnum.Locked
			end

			if slot7 == slot1 then
				slot10 = (slot2 ~= slot1 or RougePageProgressItem.LineStateEnum.Done) and (slot2 + 1 ~= slot1 or RougePageProgressItem.LineStateEnum.Edit) and RougePageProgressItem.LineStateEnum.Locked
			end

			if slot9 then
				slot8:setLineActiveByState(slot10)
			end
		end

		slot8:setActive(slot9)
	end

	slot0._totalPage = slot3
end

function slot0.capacity(slot0)
	return slot0._itemList and #slot0._itemList or 0
end

function slot0.count(slot0)
	return slot0._totalPage
end

function slot0.highLightRange(slot0)
	return slot0._highLightRange[1], slot0._highLightRange[2]
end

function slot0._getCurStartProgress(slot0)
	slot1 = slot0:_getStartProgressCount()

	if ViewMgr.instance:isOpen(ViewName.RougeInitTeamView) then
		return slot1
	end

	slot1 = slot1 - 1

	if ViewMgr.instance:isOpen(ViewName.RougeFactionView) then
		return slot1
	end

	slot1 = slot1 - 1

	if RougeModel.instance:isCanSelectRewards() then
		if ViewMgr.instance:isOpen(ViewName.RougeCollectionGiftView) then
			return slot1
		end

		slot1 = slot1 - 1
	end

	if ViewMgr.instance:isOpen(ViewName.RougeDifficultyView) then
		return slot1
	end

	return slot1 - 1
end

function slot0._getStartProgressCount(slot0)
	if RougeModel.instance:isCanSelectRewards() then
		slot1 = 3 + 1
	end

	return slot1
end

function slot0.setData(slot0)
	slot0:initData(slot0:_getStartProgressCount(), slot0:_getCurStartProgress())
	slot0:setHighLightRange(slot0:_getCurStartProgress())
end

return slot0
