module("modules.logic.activity.view.V1a4_Role_FullSignView", package.seeall)

local var_0_0 = class("V1a4_Role_FullSignView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
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

function var_0_0.onOpen(arg_4_0)
	arg_4_0._txtLimitTime.text = ""

	arg_4_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.MainActivityCenterView)
	arg_4_0:internal_onOpen()
	TaskDispatcher.runRepeat(arg_4_0._refreshTimeTick, arg_4_0, 1)
end

function var_0_0._updateScrollViewPos(arg_5_0)
	if arg_5_0._isFirstUpdateScrollPos then
		return
	end

	arg_5_0._isFirstUpdateScrollPos = true

	arg_5_0:updateRewardCouldGetHorizontalScrollPixel(function(arg_6_0)
		if arg_6_0 <= 4 then
			return arg_6_0 - 4
		else
			local var_6_0 = arg_5_0:getTempDataList()

			return var_6_0 and #var_6_0 or arg_6_0
		end
	end)
end

function var_0_0.onClose(arg_7_0)
	arg_7_0._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(arg_7_0._refreshTimeTick, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simageTitle:UnLoadImage()
	arg_8_0._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
end

function var_0_0.onRefresh(arg_9_0)
	arg_9_0:_refreshList()
	arg_9_0:_updateScrollViewPos()
	arg_9_0:_refreshTimeTick()
end

function var_0_0._refreshTimeTick(arg_10_0)
	arg_10_0._txtLimitTime.text = arg_10_0:getRemainTimeStr()
end

function var_0_0._setPinStartIndex(arg_11_0, arg_11_1)
	local var_11_0, var_11_1 = arg_11_0:getRewardCouldGetIndex()
	local var_11_2 = var_11_1 <= 4 and 1 or 3

	arg_11_0.viewContainer:getScrollModel():setStartPinIndex(var_11_2)
end

return var_0_0
