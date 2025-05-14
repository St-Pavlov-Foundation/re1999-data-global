module("modules.logic.activity.view.V2a0_SummerSign_FullView", package.seeall)

local var_0_0 = class("V2a0_SummerSign_FullView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simageFullBG:LoadImage(ResUrl.getV2a0SignSingleBg("v2a0_summersign_fullbg"))

	arg_4_0._txtLimitTime.text = ""

	arg_4_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:internal_onOpen()
	arg_5_0:_clearTimeTick()
	TaskDispatcher.runRepeat(arg_5_0._refreshTimeTick, arg_5_0, 1)
end

function var_0_0.onClose(arg_6_0)
	arg_6_0:_clearTimeTick()
end

function var_0_0.onDestroyView(arg_7_0)
	Activity101SignViewBase._internal_onDestroy(arg_7_0)
	arg_7_0:_clearTimeTick()
	arg_7_0._simageFullBG:UnLoadImage()
end

function var_0_0._clearTimeTick(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
end

function var_0_0.onRefresh(arg_9_0)
	arg_9_0:_refreshList()
	arg_9_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_10_0)
	arg_10_0._txtLimitTime.text = arg_10_0:getRemainTimeStr()
end

return var_0_0
