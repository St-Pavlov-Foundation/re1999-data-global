module("modules.logic.social.view.ReportTypeItem", package.seeall)

slot0 = class("ReportTypeItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_click")
	slot0.gonormalicon = gohelper.findChild(slot0.viewGO, "go_normalicon")
	slot0.goselecticon = gohelper.findChild(slot0.viewGO, "go_selecticon")
	slot0.txtinform = gohelper.findChildText(slot0.viewGO, "txt_inform")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	ReportTypeListModel.instance:setSelectReportItem(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.refreshSelect(slot0)
	slot1 = ReportTypeListModel.instance:isSelect(slot0)

	gohelper.setActive(slot0.gonormalicon, not slot1)
	gohelper.setActive(slot0.goselecticon, slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.reportMo = slot1
	slot0.txtinform.text = slot0.reportMo.desc

	slot0:refreshSelect()
end

function slot0.getMo(slot0)
	return slot0.reportMo
end

return slot0
