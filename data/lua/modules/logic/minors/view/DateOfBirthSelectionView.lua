module("modules.logic.minors.view.DateOfBirthSelectionView", package.seeall)

slot0 = class("DateOfBirthSelectionView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_top")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bottom")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn1/#btn_cancel")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn2/#btn_confirm")
	slot0._scrolllist = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_list")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._btnconfirmOnClick(slot0)
	slot1, slot2, slot3 = slot0:getYMD()

	ViewMgr.instance:openView(ViewName.DateOfBirthVerifyView, {
		year = slot1,
		month = slot2,
		day = slot3
	})
end

function slot0._editableInitView(slot0)
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_resetData()
	slot0:_refreshDropDownList()
	MinorsController.instance:registerCallback(MinorsEvent.PayLimitFlagUpdate, slot0._onPayLimitFlagUpdate, slot0)
end

function slot0.onClose(slot0)
	MinorsController.instance:unregisterCallback(MinorsEvent.PayLimitFlagUpdate, slot0._onPayLimitFlagUpdate, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagetop:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
end

function slot0._refreshDropDownList(slot0)
	slot1 = MinorsConfig.DateCmpType

	DateOfBirthSelectionViewListModel.instance:setList({
		{
			type = slot1.Year,
			_parent = slot0
		},
		{
			type = slot1.Month,
			_parent = slot0
		},
		{
			type = slot1.Day,
			_parent = slot0
		}
	})
end

function slot0._resetData(slot0)
	slot0._viewData = {
		selectedMonth = 1,
		selectedYear = 2000,
		selectedDay = 1
	}
end

function slot0.onClickDropDownOption(slot0, slot1, slot2)
	if slot1 == MinorsConfig.DateCmpType.Year then
		slot0:_setYear(slot2)
	elseif slot1 == slot3.Month then
		slot0:_setMonth(slot2)
	elseif slot1 == slot3.Day then
		slot0:_setDay(slot2)
	else
		assert(false)
	end
end

function slot0.getDropDownOption(slot0, slot1)
	if slot1 == MinorsConfig.DateCmpType.Year then
		return slot0:_getYearOptions()
	elseif slot1 == slot2.Month then
		return slot0:_getMonthOptions()
	elseif slot1 == slot2.Day then
		return slot0:_getDayOptions()
	else
		assert(false)
	end
end

function slot0.getDropDownSelectedIndex(slot0, slot1)
	if slot1 == MinorsConfig.DateCmpType.Year then
		return slot0:_getYearDropDownIndex()
	elseif slot1 == slot2.Month then
		return slot0:_getMonthDropDownIndex()
	elseif slot1 == slot2.Day then
		return slot0:_getDayDropDownIndex()
	else
		assert(false)
	end
end

function slot0._clamp(slot0, slot1, slot2, slot3)
	return math.max(slot2, math.min(slot1, slot3))
end

function slot0._getMaxDayOfMonth(slot0)
	slot1, slot2, slot3 = slot0:getYMD()
	slot4 = slot1 % 400 == 0 or slot1 % 4 == 0 and slot1 % 100 ~= 0
	slot5 = 31

	if slot2 == 4 or slot2 == 6 or slot2 == 9 or slot2 == 11 then
		slot5 = 30
	end

	if slot2 == 2 then
		slot5 = slot4 and 29 or 28
	end

	return slot5
end

function slot0._setYear(slot0, slot1)
	slot2 = slot0._viewData
	slot2.selectedYear = slot1 + MinorsConfig.instance:getDateOfBirthSelectionViewStartYear()

	if slot2.selectedMonth == 2 then
		slot0:_tryUpdateSelectedDay()
		slot0:_refreshDropDownList()
	end
end

function slot0._setMonth(slot0, slot1)
	slot0._viewData.selectedMonth = slot1 + 1

	if slot0:_tryUpdateSelectedDay() or slot0:_getMaxDayOfMonth() ~= slot0:_getMaxDayOfMonth() then
		slot0:_refreshDropDownList()
	end
end

function slot0._setDay(slot0, slot1)
	slot0._viewData.selectedDay = slot1 + 1
end

function slot0._tryUpdateSelectedDay(slot0)
	slot1, slot2, slot3 = slot0:getYMD()

	if slot3 ~= slot0:_clamp(slot3, 1, slot0:_getMaxDayOfMonth()) then
		slot0:_setDay(0)

		return true
	end

	return false
end

function slot0._getYearOptions(slot0)
	slot1 = {}

	for slot7 = MinorsConfig.instance:getDateOfBirthSelectionViewStartYear(), os.date("*t", os.time()).year do
		slot1[#slot1 + 1] = tostring(slot7) .. luaLang("DateOfBirthSelectionView_year")
	end

	return slot1
end

function slot0._getMonthOptions(slot0)
	slot1 = {}

	for slot5 = 1, 12 do
		slot1[#slot1 + 1] = tostring(slot5) .. luaLang("DateOfBirthSelectionView_month")
	end

	return slot1
end

function slot0._getDayOptions(slot0)
	slot1 = {}

	for slot6 = 1, slot0:_getMaxDayOfMonth() do
		slot1[#slot1 + 1] = tostring(slot6) .. luaLang("DateOfBirthSelectionView_day")
	end

	return slot1
end

function slot0._getYearDropDownIndex(slot0)
	return slot0._viewData.selectedYear - MinorsConfig.instance:getDateOfBirthSelectionViewStartYear()
end

function slot0._getMonthDropDownIndex(slot0)
	return slot0._viewData.selectedMonth - 1
end

function slot0._getDayDropDownIndex(slot0)
	return slot0._viewData.selectedDay - 1
end

function slot0.getYMD(slot0)
	slot1 = slot0._viewData

	return slot1.selectedYear, slot1.selectedMonth, slot1.selectedDay
end

function slot0._onPayLimitFlagUpdate(slot0)
	slot0:closeThis()
end

return slot0
