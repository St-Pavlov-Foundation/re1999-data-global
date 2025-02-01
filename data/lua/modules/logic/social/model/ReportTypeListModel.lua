module("modules.logic.social.model.ReportTypeListModel", package.seeall)

slot0 = class("ReportTypeListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0.reportTypeList = {}
end

function slot0.reInit(slot0)
	slot0.reportTypeList = {}
end

function slot0.sortFunc(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.initType(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot0.reportTypeList, {
			id = slot7.id,
			desc = slot7.desc
		})
	end

	table.sort(slot1, slot0.sortFunc)
end

function slot0.initDone(slot0)
	return slot0.reportTypeList and #slot0.reportTypeList > 0
end

function slot0.refreshData(slot0)
	slot0:setList(slot0.reportTypeList)
end

function slot0.setSelectReportItem(slot0, slot1)
	slot2 = slot0.selectReportItem

	if slot0:isSelect(slot1) then
		slot0.selectReportItem = nil
	else
		slot0.selectReportItem = slot1
	end

	if slot2 then
		slot2:refreshSelect()
	end

	slot1:refreshSelect()
end

function slot0.isSelect(slot0, slot1)
	return slot0.selectReportItem and slot0.selectReportItem:getMo().id == slot1:getMo().id
end

function slot0.getSelectReportId(slot0)
	return slot0.selectReportItem and slot0.selectReportItem:getMo().id
end

function slot0.clearSelectReportItem(slot0)
	slot0.selectReportItem = nil
end

slot0.instance = slot0.New()

return slot0
