module("modules.logic.activity.view.LinkageActivity_PanelView", package.seeall)

slot0 = class("LinkageActivity_PanelView", LinkageActivity_PanelViewBase)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageLogo = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Logo")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	uv0.super.removeEvents(slot0)
end

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._txtLimitTime.text = ""
	slot0._pageGo1 = gohelper.findChild(slot0.viewGO, "Page1")
	slot0._pageGo2 = gohelper.findChild(slot0.viewGO, "Page2")
end

function slot0.onStart(slot0)
	slot0:addPage(1, slot0._pageGo1, LinkageActivity_PanelView_Page1)
	slot0:addPage(2, slot0._pageGo2, LinkageActivity_PanelView_Page2)
	slot0:selectedPage(2)
end

function slot0.onRefresh(slot0)
	uv0.super.onRefresh(slot0)
	slot0:_refreshTimeTick()
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

return slot0
