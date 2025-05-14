module("modules.logic.minors.view.DateOfBirthSelectionView", package.seeall)

local var_0_0 = class("DateOfBirthSelectionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bottom")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn1/#btn_cancel")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn2/#btn_confirm")
	arg_1_0._scrolllist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_list")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncancelOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickModalMask(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnconfirmOnClick(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = arg_7_0:getYMD()

	ViewMgr.instance:openView(ViewName.DateOfBirthVerifyView, {
		year = var_7_0,
		month = var_7_1,
		day = var_7_2
	})
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_8_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_resetData()
	arg_10_0:_refreshDropDownList()
	MinorsController.instance:registerCallback(MinorsEvent.PayLimitFlagUpdate, arg_10_0._onPayLimitFlagUpdate, arg_10_0)
end

function var_0_0.onClose(arg_11_0)
	MinorsController.instance:unregisterCallback(MinorsEvent.PayLimitFlagUpdate, arg_11_0._onPayLimitFlagUpdate, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagetop:UnLoadImage()
	arg_12_0._simagebottom:UnLoadImage()
end

function var_0_0._refreshDropDownList(arg_13_0)
	local var_13_0 = MinorsConfig.DateCmpType
	local var_13_1 = {
		{
			type = var_13_0.Year,
			_parent = arg_13_0
		},
		{
			type = var_13_0.Month,
			_parent = arg_13_0
		},
		{
			type = var_13_0.Day,
			_parent = arg_13_0
		}
	}

	DateOfBirthSelectionViewListModel.instance:setList(var_13_1)
end

function var_0_0._resetData(arg_14_0)
	arg_14_0._viewData = {
		selectedMonth = 1,
		selectedYear = 2000,
		selectedDay = 1
	}
end

function var_0_0.onClickDropDownOption(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = MinorsConfig.DateCmpType

	if arg_15_1 == var_15_0.Year then
		arg_15_0:_setYear(arg_15_2)
	elseif arg_15_1 == var_15_0.Month then
		arg_15_0:_setMonth(arg_15_2)
	elseif arg_15_1 == var_15_0.Day then
		arg_15_0:_setDay(arg_15_2)
	else
		assert(false)
	end
end

function var_0_0.getDropDownOption(arg_16_0, arg_16_1)
	local var_16_0 = MinorsConfig.DateCmpType

	if arg_16_1 == var_16_0.Year then
		return arg_16_0:_getYearOptions()
	elseif arg_16_1 == var_16_0.Month then
		return arg_16_0:_getMonthOptions()
	elseif arg_16_1 == var_16_0.Day then
		return arg_16_0:_getDayOptions()
	else
		assert(false)
	end
end

function var_0_0.getDropDownSelectedIndex(arg_17_0, arg_17_1)
	local var_17_0 = MinorsConfig.DateCmpType

	if arg_17_1 == var_17_0.Year then
		return arg_17_0:_getYearDropDownIndex()
	elseif arg_17_1 == var_17_0.Month then
		return arg_17_0:_getMonthDropDownIndex()
	elseif arg_17_1 == var_17_0.Day then
		return arg_17_0:_getDayDropDownIndex()
	else
		assert(false)
	end
end

function var_0_0._clamp(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	return math.max(arg_18_2, math.min(arg_18_1, arg_18_3))
end

function var_0_0._getMaxDayOfMonth(arg_19_0)
	local var_19_0, var_19_1, var_19_2 = arg_19_0:getYMD()
	local var_19_3 = var_19_0 % 400 == 0 or var_19_0 % 4 == 0 and var_19_0 % 100 ~= 0
	local var_19_4 = 31

	if var_19_1 == 4 or var_19_1 == 6 or var_19_1 == 9 or var_19_1 == 11 then
		var_19_4 = 30
	end

	if var_19_1 == 2 then
		var_19_4 = var_19_3 and 29 or 28
	end

	return var_19_4
end

function var_0_0._setYear(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._viewData

	var_20_0.selectedYear = arg_20_1 + MinorsConfig.instance:getDateOfBirthSelectionViewStartYear()

	if var_20_0.selectedMonth == 2 then
		arg_20_0:_tryUpdateSelectedDay()
		arg_20_0:_refreshDropDownList()
	end
end

function var_0_0._setMonth(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._viewData
	local var_21_1 = arg_21_0:_getMaxDayOfMonth()

	var_21_0.selectedMonth = arg_21_1 + 1

	if arg_21_0:_tryUpdateSelectedDay() or arg_21_0:_getMaxDayOfMonth() ~= var_21_1 then
		arg_21_0:_refreshDropDownList()
	end
end

function var_0_0._setDay(arg_22_0, arg_22_1)
	arg_22_0._viewData.selectedDay = arg_22_1 + 1
end

function var_0_0._tryUpdateSelectedDay(arg_23_0)
	local var_23_0, var_23_1, var_23_2 = arg_23_0:getYMD()
	local var_23_3 = arg_23_0:_getMaxDayOfMonth()

	if var_23_2 ~= arg_23_0:_clamp(var_23_2, 1, var_23_3) then
		arg_23_0:_setDay(0)

		return true
	end

	return false
end

function var_0_0._getYearOptions(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = MinorsConfig.instance:getDateOfBirthSelectionViewStartYear()
	local var_24_2 = os.date("*t", os.time()).year

	for iter_24_0 = var_24_1, var_24_2 do
		var_24_0[#var_24_0 + 1] = tostring(iter_24_0) .. luaLang("DateOfBirthSelectionView_year")
	end

	return var_24_0
end

function var_0_0._getMonthOptions(arg_25_0)
	local var_25_0 = {}

	for iter_25_0 = 1, 12 do
		var_25_0[#var_25_0 + 1] = tostring(iter_25_0) .. luaLang("DateOfBirthSelectionView_month")
	end

	return var_25_0
end

function var_0_0._getDayOptions(arg_26_0)
	local var_26_0 = {}
	local var_26_1 = arg_26_0:_getMaxDayOfMonth()

	for iter_26_0 = 1, var_26_1 do
		var_26_0[#var_26_0 + 1] = tostring(iter_26_0) .. luaLang("DateOfBirthSelectionView_day")
	end

	return var_26_0
end

function var_0_0._getYearDropDownIndex(arg_27_0)
	return arg_27_0._viewData.selectedYear - MinorsConfig.instance:getDateOfBirthSelectionViewStartYear()
end

function var_0_0._getMonthDropDownIndex(arg_28_0)
	return arg_28_0._viewData.selectedMonth - 1
end

function var_0_0._getDayDropDownIndex(arg_29_0)
	return arg_29_0._viewData.selectedDay - 1
end

function var_0_0.getYMD(arg_30_0)
	local var_30_0 = arg_30_0._viewData
	local var_30_1 = var_30_0.selectedYear
	local var_30_2 = var_30_0.selectedMonth
	local var_30_3 = var_30_0.selectedDay

	return var_30_1, var_30_2, var_30_3
end

function var_0_0._onPayLimitFlagUpdate(arg_31_0)
	arg_31_0:closeThis()
end

return var_0_0
