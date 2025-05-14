module("modules.logic.activity.view.warmup.ActivityWarmUpTips", package.seeall)

local var_0_0 = class("ActivityWarmUpTips", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "#scroll_info/Viewport/Content/#txt_info")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg1:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi8"))
	arg_4_0._simageicon:LoadImage(ResUrl.getActivityWarmUpBg("bg_tu1"))
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagebg1:UnLoadImage()
	arg_5_0._simageicon:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.orderId
	local var_6_1 = arg_6_0.viewParam.actId

	arg_6_0.orderCo = Activity106Config.instance:getActivityWarmUpOrderCo(var_6_1, var_6_0)

	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.refreshUI(arg_9_0)
	if arg_9_0.orderCo then
		arg_9_0._txtinfo.text = arg_9_0.orderCo.desc
		arg_9_0._txttitle.text = arg_9_0.orderCo.name
	else
		arg_9_0._txtinfo.text = ""
		arg_9_0._txttitle.text = ""
	end
end

function var_0_0.onClickModalMask(arg_10_0)
	arg_10_0:closeThis()
end

return var_0_0
