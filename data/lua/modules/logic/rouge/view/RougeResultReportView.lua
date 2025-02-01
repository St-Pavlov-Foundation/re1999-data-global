module("modules.logic.rouge.view.RougeResultReportView", package.seeall)

slot0 = class("RougeResultReportView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._scrollrecordlist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_recordlist")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btndetailsOnClick(slot0)
end

function slot0._editableInitView(slot0)
	RougeResultReportListModel.instance.startFrameCount = UnityEngine.Time.frameCount

	RougeResultReportListModel.instance:init()
	gohelper.setActive(slot0._goempty, #RougeResultReportListModel.instance:getList() == 0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio9)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	RougeResultReportListModel.instance:clear()
end

return slot0
