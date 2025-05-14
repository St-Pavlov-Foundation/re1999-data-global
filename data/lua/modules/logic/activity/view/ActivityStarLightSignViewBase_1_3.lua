module("modules.logic.activity.view.ActivityStarLightSignViewBase_1_3", package.seeall)

local var_0_0 = class("ActivityStarLightSignViewBase_1_3", Activity101SignViewBase)

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
	assert(false, "please override thid function")
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._txtLimitTime.text = ""

	arg_3_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	arg_3_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_3_0._refreshTimeTick, arg_3_0, 1)
end

function var_0_0.onDestroyView(arg_4_0)
	arg_4_0._simageTitle:UnLoadImage()
	arg_4_0._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_4_0._refreshTimeTick, arg_4_0)
end

function var_0_0._updateScrollViewPos(arg_5_0)
	if arg_5_0._isFirst then
		return
	end

	arg_5_0._isFirst = true

	arg_5_0:updateRewardCouldGetHorizontalScrollPixel()
end

function var_0_0.onClose(arg_6_0)
	arg_6_0._isFirst = nil

	TaskDispatcher.cancelTask(arg_6_0._refreshTimeTick, arg_6_0)
end

function var_0_0.onRefresh(arg_7_0)
	arg_7_0:_refreshList()
	arg_7_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_8_0)
	arg_8_0._txtLimitTime.text = arg_8_0:getRemainTimeStr()
end

return var_0_0
