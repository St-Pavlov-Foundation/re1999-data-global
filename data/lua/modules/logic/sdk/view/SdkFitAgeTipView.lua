module("modules.logic.sdk.view.SdkFitAgeTipView", package.seeall)

local var_0_0 = class("SdkFitAgeTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg/#simage_line")
	arg_1_0._btnsure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_sure")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsure:AddClickListener(arg_2_0._btnsureOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsure:RemoveClickListener()
end

function var_0_0._btnsureOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getSdkIcon("bg_beijing"))
	arg_5_0._simageline:LoadImage(ResUrl.getSdkIcon("bg_hengxian"))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	NavigateMgr.instance:addEscape(ViewName.SdkFitAgeTipView, arg_7_0._btnsureOnClick, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0._simagebg:UnLoadImage()
	arg_8_0._simageline:UnLoadImage()
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
