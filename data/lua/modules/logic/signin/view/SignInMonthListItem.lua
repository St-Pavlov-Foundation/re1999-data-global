module("modules.logic.signin.view.SignInMonthListItem", package.seeall)

local var_0_0 = class("SignInMonthListItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._obj = gohelper.findChild(arg_1_1, "obj")
	arg_1_0._normal = gohelper.findChild(arg_1_1, "obj/normal")
	arg_1_0._select = gohelper.findChild(arg_1_1, "obj/select")
	arg_1_0._txtmonthnormal = gohelper.findChildText(arg_1_1, "obj/normal/txt_normalmonth")
	arg_1_0._txtmonthselect = gohelper.findChildText(arg_1_1, "obj/select/txt_selectmonth")
	arg_1_0._itemClick = gohelper.getClickWithAudio(arg_1_0._obj)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._itemClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	SignInController.instance:registerCallback(SignInEvent.GetHistorySignInSuccess, arg_2_0._onCheckSignInMonthUnlocked, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._itemClick:RemoveClickListener()
	SignInController.instance:unregisterCallback(SignInEvent.GetHistorySignInSuccess, arg_3_0._onCheckSignInMonthUnlocked, arg_3_0)
end

function var_0_0._onItemClick(arg_4_0)
	local var_4_0 = SignInModel.instance:getSignTargetDate()

	if arg_4_0._mo.year == var_4_0[1] and arg_4_0._mo.month == var_4_0[2] then
		return
	end

	SignInModel.instance:setNewShowDetail(false)

	local var_4_1 = SignInModel.instance:getCurDate()

	if arg_4_0._mo.year == var_4_1.year and arg_4_0._mo.month == var_4_1.month then
		SignInModel.instance:setTargetDate(arg_4_0._mo.year, arg_4_0._mo.month, var_4_1.day)
		arg_4_0:_refreshMonthItem()
	elseif 12 * (var_4_1.year - arg_4_0._mo.year - 1) + 13 - arg_4_0._mo.month + var_4_1.month > 13 then
		SignInModel.instance:setTargetDate(arg_4_0._mo.year, arg_4_0._mo.month, 1)
		arg_4_0:_refreshMonthItem()
	else
		SignInRpc.instance:sendSignInHistoryRequest(arg_4_0._mo.month)
	end
end

function var_0_0._onCheckSignInMonthUnlocked(arg_5_0, arg_5_1)
	local var_5_0 = SignInModel.instance:getCurDate()

	if arg_5_0._mo.month == var_5_0.month and arg_5_0._mo.year == var_5_0.year then
		return
	end

	if arg_5_0._mo.month == arg_5_1 then
		local var_5_1 = SignInModel.instance:getHistorySignInDays(arg_5_1)

		if var_5_1 and #var_5_1 > 0 then
			SignInModel.instance:setTargetDate(arg_5_0._mo.year, arg_5_0._mo.month, var_5_1[1])
			arg_5_0:_refreshMonthItem()
		else
			GameFacade.showToast(ToastEnum.SignInError)
		end
	end
end

function var_0_0._refreshMonthItem(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_sign_calendar_month_turn)
	SignInController.instance:dispatchEvent(SignInEvent.ClickSignInMonthItem)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	arg_7_0:_refreshItem()
end

function var_0_0._refreshItem(arg_8_0)
	arg_8_0._txtmonthnormal.text = arg_8_0._mo.month
	arg_8_0._txtmonthselect.text = arg_8_0._mo.month

	local var_8_0 = SignInModel.instance:getSignTargetDate()
	local var_8_1 = arg_8_0._mo.year == var_8_0[1] and arg_8_0._mo.month == var_8_0[2]

	gohelper.setActive(arg_8_0._select, var_8_1)
	gohelper.setActive(arg_8_0._normal, not var_8_1)
end

function var_0_0.onDestroy(arg_9_0)
	return
end

return var_0_0
