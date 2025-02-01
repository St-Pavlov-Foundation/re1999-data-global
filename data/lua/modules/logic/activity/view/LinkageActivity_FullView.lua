module("modules.logic.activity.view.LinkageActivity_FullView", package.seeall)

slot0 = class("LinkageActivity_FullView", LinkageActivity_FullViewBase)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG")
	slot0._simageLogo = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Logo")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Root/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
end

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0._editableInitView(slot0)
	slot0._txtLimitTime.text = ""
	slot0._pageGo1 = gohelper.findChild(slot0.viewGO, "Root/Page1")
	slot0._pageGo2 = gohelper.findChild(slot0.viewGO, "Root/Page2")
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0.onStart(slot0)
	slot0:addPage(1, slot0._pageGo1, LinkageActivity_FullView_Page1)
	slot0:addPage(2, slot0._pageGo2, LinkageActivity_FullView_Page2)

	if ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot0:actId()) then
		slot0:selectedPage(2)
	else
		slot0:selectedPage(1)
	end
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
