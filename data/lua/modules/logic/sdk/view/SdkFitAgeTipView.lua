module("modules.logic.sdk.view.SdkFitAgeTipView", package.seeall)

slot0 = class("SdkFitAgeTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg/#simage_line")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_sure")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsure:RemoveClickListener()
end

function slot0._btnsureOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getSdkIcon("bg_beijing"))
	slot0._simageline:LoadImage(ResUrl.getSdkIcon("bg_hengxian"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(ViewName.SdkFitAgeTipView, slot0._btnsureOnClick, slot0)
end

function slot0.onClose(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageline:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
