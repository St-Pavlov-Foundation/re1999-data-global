module("modules.logic.versionactivity2_5.challenge.view.Act183ReportView", package.seeall)

slot0 = class("Act183ReportView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._scrollreview = gohelper.findChildScrollRect(slot0.viewGO, "root/#scroll_review")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "root/#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._goempty, Act183ReportListModel.instance:getCount() <= 0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
