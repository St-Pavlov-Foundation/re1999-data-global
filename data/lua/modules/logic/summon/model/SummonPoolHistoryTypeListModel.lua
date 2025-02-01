module("modules.logic.summon.model.SummonPoolHistoryTypeListModel", package.seeall)

slot0 = class("SummonPoolHistoryTypeListModel", ListScrollModel)

function slot0.initPoolType(slot0)
	slot1 = {}

	for slot7, slot8 in ipairs(SummonPoolHistoryModel.instance:getHistoryValidPools()) do
		if slot0:getById(slot8.id) == nil then
			slot3 = 0 + 1

			SummonPoolHistoryTypeMO.New():init(slot8.id, slot8)
		end

		table.insert(slot1, slot9)
	end

	if slot3 > 0 or slot0:getCount() ~= #slot1 then
		slot0:setList(slot1)
		slot0:onModelUpdate()
	end

	if not slot0:getById(slot0._poolTypeId) then
		slot0._poolTypeId = slot0:getFirstId()

		slot0:_refreshSelect()
	end
end

function slot0.getFirstId(slot0)
	return slot0:getByIndex(1) and slot1.id
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:setSelect(slot0:getById(slot0._poolTypeId))
	end
end

function slot0.setSelectId(slot0, slot1)
	slot0._poolTypeId = slot1

	slot0:_refreshSelect()
end

function slot0.getSelectId(slot0)
	return slot0._poolTypeId
end

slot0.instance = slot0.New()

return slot0
