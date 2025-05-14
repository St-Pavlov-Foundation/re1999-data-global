module("modules.logic.minors.view.DateOfBirthVerifyView", package.seeall)

local var_0_0 = class("DateOfBirthVerifyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagetop = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_top")
	arg_1_0._simagebottom = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bottom")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "middlebg/#txt_time")
	arg_1_0._txtage = gohelper.findChildText(arg_1_0.viewGO, "middlebg/#txt_age")
	arg_1_0._txtrestrict = gohelper.findChildText(arg_1_0.viewGO, "middlebg/#txt_restrict")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn1/#btn_cancel")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn2/#btn_confirm")
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

local var_0_1 = {
	Kid = 3,
	Age18 = 1,
	Age16_18 = 2
}

function var_0_0._btncancelOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickModalMask(arg_6_0)
	return
end

function var_0_0._btnconfirmOnClick(arg_7_0)
	local var_7_0 = arg_7_0.viewParam
	local var_7_1 = var_7_0.year
	local var_7_2 = var_7_0.month
	local var_7_3 = var_7_0.day

	MinorsController.instance:confirmDateOfBirthVerify(var_7_1, var_7_2, var_7_3)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_8_0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	local var_10_0 = arg_10_0.viewParam
	local var_10_1 = var_10_0.year
	local var_10_2 = var_10_0.month
	local var_10_3 = var_10_0.day
	local var_10_4 = arg_10_0:_checkMinorsState()

	if var_10_4 == var_0_1.Age18 then
		arg_10_0._txtage.text = luaLang("minors_18+")
		arg_10_0._txtrestrict.text = luaLang("minors_18+_limit")
	elseif var_10_4 == var_0_1.Age16_18 then
		arg_10_0._txtage.text = luaLang("minors_under_18")
		arg_10_0._txtrestrict.text = luaLang("minors_under_18_limit")
	else
		arg_10_0._txtage.text = luaLang("minors_under_16")
		arg_10_0._txtrestrict.text = luaLang("minors_under_16_limit")
	end

	arg_10_0._txttime.text = string.format(luaLang("minors_birth_format"), var_10_1, var_10_2, var_10_3)

	MinorsController.instance:registerCallback(MinorsEvent.PayLimitFlagUpdate, arg_10_0._onPayLimitFlagUpdate, arg_10_0)
end

function var_0_0._checkMinorsState(arg_11_0)
	local var_11_0 = arg_11_0.viewParam
	local var_11_1 = var_11_0.year
	local var_11_2 = var_11_0.month
	local var_11_3 = var_11_0.day
	local var_11_4 = ServerTime.nowDate()
	local var_11_5 = var_11_4.year - var_11_1
	local var_11_6 = var_11_4.month - var_11_2
	local var_11_7 = var_11_4.day - var_11_3

	if var_11_5 > 18 then
		return var_0_1.Age18
	end

	if var_11_5 == 18 then
		if var_11_6 > 0 then
			return var_0_1.Age18
		end

		if var_11_6 == 0 and var_11_7 >= 0 then
			return var_0_1.Age18
		end
	end

	if var_11_5 > 16 then
		return var_0_1.Age16_18
	end

	if var_11_5 == 16 then
		if var_11_6 > 0 then
			return var_0_1.Age16_18
		end

		if var_11_6 == 0 and var_11_7 >= 0 then
			return var_0_1.Age16_18
		end
	end

	return var_0_1.Kid
end

function var_0_0.onClose(arg_12_0)
	MinorsController.instance:unregisterCallback(MinorsEvent.PayLimitFlagUpdate, arg_12_0._onPayLimitFlagUpdate, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	arg_13_0._simagetop:UnLoadImage()
	arg_13_0._simagebottom:UnLoadImage()
end

function var_0_0._onPayLimitFlagUpdate(arg_14_0)
	GameFacade.showToast(ToastEnum.MinorDateofBirthSettingSuc)
	arg_14_0:closeThis()
end

return var_0_0
