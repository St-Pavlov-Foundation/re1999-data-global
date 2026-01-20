-- chunkname: @modules/logic/minors/view/DateOfBirthVerifyView.lua

module("modules.logic.minors.view.DateOfBirthVerifyView", package.seeall)

local DateOfBirthVerifyView = class("DateOfBirthVerifyView", BaseView)

function DateOfBirthVerifyView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bottom")
	self._txttime = gohelper.findChildText(self.viewGO, "middlebg/#txt_time")
	self._txtage = gohelper.findChildText(self.viewGO, "middlebg/#txt_age")
	self._txtrestrict = gohelper.findChildText(self.viewGO, "middlebg/#txt_restrict")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn1/#btn_cancel")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "btns/btn2/#btn_confirm")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DateOfBirthVerifyView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function DateOfBirthVerifyView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

local MinorAgeState = {
	Kid = 3,
	Age18 = 1,
	Age16_18 = 2
}

function DateOfBirthVerifyView:_btncancelOnClick()
	self:closeThis()
end

function DateOfBirthVerifyView:_btncloseOnClick()
	self:closeThis()
end

function DateOfBirthVerifyView:onClickModalMask()
	return
end

function DateOfBirthVerifyView:_btnconfirmOnClick()
	local viewParam = self.viewParam
	local year, month, day = viewParam.year, viewParam.month, viewParam.day

	MinorsController.instance:confirmDateOfBirthVerify(year, month, day)
end

function DateOfBirthVerifyView:_editableInitView()
	self._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function DateOfBirthVerifyView:onUpdateParam()
	return
end

function DateOfBirthVerifyView:onOpen()
	local viewParam = self.viewParam
	local year, month, day = viewParam.year, viewParam.month, viewParam.day
	local state = self:_checkMinorsState()

	if state == MinorAgeState.Age18 then
		self._txtage.text = luaLang("minors_18+")
		self._txtrestrict.text = luaLang("minors_18+_limit")
	elseif state == MinorAgeState.Age16_18 then
		self._txtage.text = luaLang("minors_under_18")
		self._txtrestrict.text = luaLang("minors_under_18_limit")
	else
		self._txtage.text = luaLang("minors_under_16")
		self._txtrestrict.text = luaLang("minors_under_16_limit")
	end

	self._txttime.text = string.format(luaLang("minors_birth_format"), year, month, day)

	MinorsController.instance:registerCallback(MinorsEvent.PayLimitFlagUpdate, self._onPayLimitFlagUpdate, self)
end

function DateOfBirthVerifyView:_checkMinorsState()
	local viewParam = self.viewParam
	local year, month, day = viewParam.year, viewParam.month, viewParam.day
	local nowDt = ServerTime.nowDate()
	local deltaYear = nowDt.year - year
	local deltaMonth = nowDt.month - month
	local deltaDay = nowDt.day - day

	if deltaYear > 18 then
		return MinorAgeState.Age18
	end

	if deltaYear == 18 then
		if deltaMonth > 0 then
			return MinorAgeState.Age18
		end

		if deltaMonth == 0 and deltaDay >= 0 then
			return MinorAgeState.Age18
		end
	end

	if deltaYear > 16 then
		return MinorAgeState.Age16_18
	end

	if deltaYear == 16 then
		if deltaMonth > 0 then
			return MinorAgeState.Age16_18
		end

		if deltaMonth == 0 and deltaDay >= 0 then
			return MinorAgeState.Age16_18
		end
	end

	return MinorAgeState.Kid
end

function DateOfBirthVerifyView:onClose()
	MinorsController.instance:unregisterCallback(MinorsEvent.PayLimitFlagUpdate, self._onPayLimitFlagUpdate, self)
end

function DateOfBirthVerifyView:onDestroyView()
	self._simagetop:UnLoadImage()
	self._simagebottom:UnLoadImage()
end

function DateOfBirthVerifyView:_onPayLimitFlagUpdate()
	GameFacade.showToast(ToastEnum.MinorDateofBirthSettingSuc)
	self:closeThis()
end

return DateOfBirthVerifyView
