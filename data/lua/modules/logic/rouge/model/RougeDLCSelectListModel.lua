module("modules.logic.rouge.model.RougeDLCSelectListModel", package.seeall)

slot0 = class("RougeDLCSelectListModel", MixScrollModel)
slot1 = 1

function slot0.onInit(slot0)
	slot0:_initList()
end

function slot0._initList(slot0)
	slot2 = {}
	slot0._recordInfo = RougeOutsideModel.instance:getRougeGameRecord()

	for slot6, slot7 in ipairs(lua_rouge_season.configList) do
		if slot7.season == RougeOutsideModel.instance:season() then
			table.insert(slot2, slot7)
		end
	end

	slot0:setList(slot2)
	slot0:selectCell(uv0, true)
end

function slot0.updateVersions(slot0)
	slot0:onModelUpdate()
end

function slot0.getCurSelectVersions(slot0)
	return slot0._recordInfo and slot0._recordInfo:getVersionIds()
end

function slot0.isAddDLC(slot0, slot1)
	return slot0._recordInfo and slot0._recordInfo:isSelectDLC(slot1)
end

slot2 = 220
slot3 = 310

function slot0.getInfoList(slot0)
	slot1 = {}

	for slot6 = 1, slot0:getCount() do
		table.insert(slot1, SLFramework.UGUI.MixCellInfo.New(1, slot2 <= slot6 and uv0 or uv1, nil))
	end

	return slot1
end

function slot0.selectCell(slot0, slot1)
	if not slot0:getByIndex(slot1) then
		return
	end

	slot0._selectIndex = slot1

	RougeDLCController.instance:dispatchEvent(RougeEvent.OnSelectDLC, slot2.id)
end

function slot0.getCurSelectIndex(slot0)
	return slot0._selectIndex or 0
end

slot0.instance = slot0.New()

return slot0
