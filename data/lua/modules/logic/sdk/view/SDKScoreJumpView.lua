module("modules.logic.sdk.view.SDKScoreJumpView", package.seeall)

slot0 = class("SDKScoreJumpView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn1/#btn_cancel")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn2/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnconfirmOnClick(slot0)
	slot0:closeThis()

	if GameChannelConfig.isGpGlobal() and UnityEngine.Application.version == "1.0.4" and BootNativeUtil.isAndroid() then
		GameUtil.openURL("https://play.google.com/store/apps/details?id=com.bluepoch.m.en.reverse1999")

		return
	elseif GameChannelConfig.isGpJapan() and slot1 == "1.0.5" and BootNativeUtil.isAndroid() then
		GameUtil.openURL("https://play.google.com/store/apps/details?id=com.bluepoch.m.jp.reverse1999.and")

		return
	elseif GameChannelConfig.isEfun() and BootNativeUtil.isAndroid() and slot1 == "1.0.2" and BootNativeUtil.isAndroid() then
		GameUtil.openURL("https://play.google.com/store/apps/details?id=com.mover.twcfwl1999")

		return
	end

	if GameChannelConfig.isGpJapan() then
		SDKMgr.instance:appReview()
	end

	if GameChannelConfig.isEfun() then
		SDKMgr.instance:appReview()
	end

	if GameChannelConfig.isGpGlobal() then
		SDKMgr.instance:appReview()
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebgimg_top = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_top")

	slot0._simagebgimg_top:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._simagebgimg_bot = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bottom")

	slot0._simagebgimg_bot:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	NavigateMgr.instance:addEscape(ViewName.SDKScoreJumpView, slot0.closeThis, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
end

return slot0
