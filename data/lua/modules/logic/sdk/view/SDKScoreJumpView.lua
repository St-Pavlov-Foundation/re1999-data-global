module("modules.logic.sdk.view.SDKScoreJumpView", package.seeall)

local var_0_0 = class("SDKScoreJumpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn1/#btn_cancel")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn2/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btncancelOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnconfirmOnClick(arg_5_0)
	arg_5_0:closeThis()

	local var_5_0 = UnityEngine.Application.version

	if GameChannelConfig.isGpGlobal() and var_5_0 == "1.0.4" and BootNativeUtil.isAndroid() then
		GameUtil.openURL("https://play.google.com/store/apps/details?id=com.bluepoch.m.en.reverse1999")

		return
	elseif GameChannelConfig.isGpJapan() and var_5_0 == "1.0.5" and BootNativeUtil.isAndroid() then
		GameUtil.openURL("https://play.google.com/store/apps/details?id=com.bluepoch.m.jp.reverse1999.and")

		return
	elseif GameChannelConfig.isEfun() and BootNativeUtil.isAndroid() and var_5_0 == "1.0.2" and BootNativeUtil.isAndroid() then
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

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebgimg_top = gohelper.findChildSingleImage(arg_6_0.viewGO, "bg/#simage_top")

	arg_6_0._simagebgimg_top:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_6_0._simagebgimg_bot = gohelper.findChildSingleImage(arg_6_0.viewGO, "bg/#simage_bottom")

	arg_6_0._simagebgimg_bot:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	NavigateMgr.instance:addEscape(ViewName.SDKScoreJumpView, arg_8_0.closeThis, arg_8_0)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
