module("modules.logic.activity.view.V1a8_Work_FullSignView", package.seeall)

local var_0_0 = class("V1a8_Work_FullSignView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._simageTitle_eff = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title_eff")
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
	arg_4_0._simageTitle:LoadImage(ResUrl.getV1a8SignSingleBgLang("v1a8_sign_work_panel_title2"))
	arg_4_0._simageTitle_eff:LoadImage(ResUrl.getV1a8SignSingleBgLang("v1a8_sign_work_panel_title2"))
	arg_4_0._simageFullBG:LoadImage(ResUrl.getV1a8SignSingleBg("v1a8_sign_work_full_bg"))
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._txtLimitTime.text = ""

	arg_5_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	arg_5_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_5_0._refreshTimeTick, arg_5_0, 1)
end

function var_0_0.onClose(arg_6_0)
	arg_6_0._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(arg_6_0._refreshTimeTick, arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	Activity101SignViewBase._internal_onDestroy(arg_7_0)
	arg_7_0._simageTitle:UnLoadImage()
	arg_7_0._simageTitle_eff:UnLoadImage()
	arg_7_0._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_7_0._refreshTimeTick, arg_7_0)
end

function var_0_0.onRefresh(arg_8_0)
	arg_8_0:_refreshList()
	arg_8_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_9_0)
	arg_9_0._txtLimitTime.text = arg_9_0:getRemainTimeStr()
end

return var_0_0
