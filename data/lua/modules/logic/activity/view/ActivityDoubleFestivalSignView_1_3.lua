module("modules.logic.activity.view.ActivityDoubleFestivalSignView_1_3", package.seeall)

local var_0_0 = class("ActivityDoubleFestivalSignView_1_3", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_LimitTime")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._simageTitle:LoadImage(ResUrl.getActivityLangIcon("v1a3_sign_fulltitle"))
	arg_2_0._simageFullBG:LoadImage(ResUrl.getActivityBg("v1a3_sign_fullbg"))
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._txtLimitTime.text = ""

	arg_3_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	arg_3_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_3_0._refreshTimeTick, arg_3_0, 1)
end

function var_0_0.onClose(arg_4_0)
	arg_4_0._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(arg_4_0._refreshTimeTick, arg_4_0)
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simageTitle:UnLoadImage()
	arg_5_0._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_5_0._refreshTimeTick, arg_5_0)
end

function var_0_0.onRefresh(arg_6_0)
	arg_6_0:_refreshList()
	arg_6_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_7_0)
	arg_7_0._txtLimitTime.text = arg_7_0:getRemainTimeStr()
end

function var_0_0.updateRewardCouldGetHorizontalScrollPixel(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:getRewardCouldGetIndex()
	local var_8_2 = arg_8_0.viewContainer:getCsListScroll()
	local var_8_3 = arg_8_0.viewContainer:getListScrollParam()
	local var_8_4 = var_8_3.cellWidth
	local var_8_5 = var_8_3.cellSpaceH

	if var_8_1 <= 4 then
		var_8_1 = var_8_1 - 4
	else
		var_8_1 = 10
	end

	local var_8_6 = (var_8_4 + var_8_5) * math.max(0, var_8_1)

	var_8_2.HorizontalScrollPixel = math.max(0, var_8_6)

	var_8_2:UpdateCells(false)
end

return var_0_0
