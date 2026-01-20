-- chunkname: @modules/logic/minors/view/DateOfBirthSelectionView.lua

module("modules.logic.minors.view.DateOfBirthSelectionView", package.seeall)

local DateOfBirthSelectionView = class("DateOfBirthSelectionView", BaseView)

function DateOfBirthSelectionView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bottom")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn1/#btn_cancel")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn2/#btn_confirm")
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "#scroll_list")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DateOfBirthSelectionView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DateOfBirthSelectionView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function DateOfBirthSelectionView:_btncancelOnClick()
	self:closeThis()
end

function DateOfBirthSelectionView:_btncloseOnClick()
	self:closeThis()
end

function DateOfBirthSelectionView:onClickModalMask()
	self:closeThis()
end

function DateOfBirthSelectionView:_btnconfirmOnClick()
	local y, m, d = self:getYMD()

	ViewMgr.instance:openView(ViewName.DateOfBirthVerifyView, {
		year = y,
		month = m,
		day = d
	})
end

function DateOfBirthSelectionView:_editableInitView()
	self._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function DateOfBirthSelectionView:onUpdateParam()
	return
end

function DateOfBirthSelectionView:onOpen()
	self:_resetData()
	self:_refreshDropDownList()
	MinorsController.instance:registerCallback(MinorsEvent.PayLimitFlagUpdate, self._onPayLimitFlagUpdate, self)
end

function DateOfBirthSelectionView:onClose()
	MinorsController.instance:unregisterCallback(MinorsEvent.PayLimitFlagUpdate, self._onPayLimitFlagUpdate, self)
end

function DateOfBirthSelectionView:onDestroyView()
	self._simagetop:UnLoadImage()
	self._simagebottom:UnLoadImage()
end

function DateOfBirthSelectionView:_refreshDropDownList()
	local E = MinorsConfig.DateCmpType
	local dataList = {
		{
			type = E.Year,
			_parent = self
		},
		{
			type = E.Month,
			_parent = self
		},
		{
			type = E.Day,
			_parent = self
		}
	}

	DateOfBirthSelectionViewListModel.instance:setList(dataList)
end

function DateOfBirthSelectionView:_resetData()
	self._viewData = {
		selectedMonth = 1,
		selectedYear = 2000,
		selectedDay = 1
	}
end

function DateOfBirthSelectionView:onClickDropDownOption(type, dropDownIndexIndex)
	local E = MinorsConfig.DateCmpType

	if type == E.Year then
		self:_setYear(dropDownIndexIndex)
	elseif type == E.Month then
		self:_setMonth(dropDownIndexIndex)
	elseif type == E.Day then
		self:_setDay(dropDownIndexIndex)
	else
		assert(false)
	end
end

function DateOfBirthSelectionView:getDropDownOption(type)
	local E = MinorsConfig.DateCmpType

	if type == E.Year then
		return self:_getYearOptions()
	elseif type == E.Month then
		return self:_getMonthOptions()
	elseif type == E.Day then
		return self:_getDayOptions()
	else
		assert(false)
	end
end

function DateOfBirthSelectionView:getDropDownSelectedIndex(type)
	local E = MinorsConfig.DateCmpType

	if type == E.Year then
		return self:_getYearDropDownIndex()
	elseif type == E.Month then
		return self:_getMonthDropDownIndex()
	elseif type == E.Day then
		return self:_getDayDropDownIndex()
	else
		assert(false)
	end
end

function DateOfBirthSelectionView:_clamp(v, min, max)
	return math.max(min, math.min(v, max))
end

function DateOfBirthSelectionView:_getMaxDayOfMonth()
	local y, m, _ = self:getYMD()
	local isRun = y % 400 == 0 or y % 4 == 0 and y % 100 ~= 0
	local res = 31

	if m == 4 or m == 6 or m == 9 or m == 11 then
		res = 30
	end

	if m == 2 then
		res = isRun and 29 or 28
	end

	return res
end

function DateOfBirthSelectionView:_setYear(dropDownIndexIndex)
	local data = self._viewData

	data.selectedYear = dropDownIndexIndex + MinorsConfig.instance:getDateOfBirthSelectionViewStartYear()

	if data.selectedMonth == 2 then
		self:_tryUpdateSelectedDay()
		self:_refreshDropDownList()
	end
end

function DateOfBirthSelectionView:_setMonth(dropDownIndexIndex)
	local data = self._viewData
	local lastMaxdays = self:_getMaxDayOfMonth()

	data.selectedMonth = dropDownIndexIndex + 1

	local isDayOptionsRefresh = self:_tryUpdateSelectedDay()

	if isDayOptionsRefresh or self:_getMaxDayOfMonth() ~= lastMaxdays then
		self:_refreshDropDownList()
	end
end

function DateOfBirthSelectionView:_setDay(dropDownIndexIndex)
	local data = self._viewData

	data.selectedDay = dropDownIndexIndex + 1
end

function DateOfBirthSelectionView:_tryUpdateSelectedDay()
	local _, _, d = self:getYMD()
	local ed = self:_getMaxDayOfMonth()

	if d ~= self:_clamp(d, 1, ed) then
		self:_setDay(0)

		return true
	end

	return false
end

function DateOfBirthSelectionView:_getYearOptions()
	local res = {}
	local st = MinorsConfig.instance:getDateOfBirthSelectionViewStartYear()
	local ed = os.date("*t", os.time()).year

	for i = st, ed do
		res[#res + 1] = tostring(i) .. luaLang("DateOfBirthSelectionView_year")
	end

	return res
end

function DateOfBirthSelectionView:_getMonthOptions()
	local res = {}

	for i = 1, 12 do
		res[#res + 1] = tostring(i) .. luaLang("DateOfBirthSelectionView_month")
	end

	return res
end

function DateOfBirthSelectionView:_getDayOptions()
	local res = {}
	local ed = self:_getMaxDayOfMonth()

	for i = 1, ed do
		res[#res + 1] = tostring(i) .. luaLang("DateOfBirthSelectionView_day")
	end

	return res
end

function DateOfBirthSelectionView:_getYearDropDownIndex()
	local data = self._viewData

	return data.selectedYear - MinorsConfig.instance:getDateOfBirthSelectionViewStartYear()
end

function DateOfBirthSelectionView:_getMonthDropDownIndex()
	local data = self._viewData

	return data.selectedMonth - 1
end

function DateOfBirthSelectionView:_getDayDropDownIndex()
	local data = self._viewData

	return data.selectedDay - 1
end

function DateOfBirthSelectionView:getYMD()
	local data = self._viewData
	local y = data.selectedYear
	local m = data.selectedMonth
	local d = data.selectedDay

	return y, m, d
end

function DateOfBirthSelectionView:_onPayLimitFlagUpdate()
	self:closeThis()
end

return DateOfBirthSelectionView
