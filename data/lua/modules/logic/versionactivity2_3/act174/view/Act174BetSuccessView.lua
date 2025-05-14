module("modules.logic.versionactivity2_3.act174.view.Act174BetSuccessView", package.seeall)

local var_0_0 = class("Act174BetSuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._txtRule = gohelper.findChildText(arg_1_0.viewGO, "#txt_Rule")
	arg_1_0._imageHpPercent = gohelper.findChildImage(arg_1_0.viewGO, "hp/bg/fill")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)
	arg_5_0.hpEffList = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, arg_5_0.maxHp do
		local var_5_0 = gohelper.findChild(arg_5_0.viewGO, "hp/bg/#hp0" .. iter_5_0)

		arg_5_0.hpEffList[#arg_5_0.hpEffList + 1] = var_5_0
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = Activity174Model.instance:getActInfo():getGameInfo()

	arg_7_0._imageHpPercent.fillAmount = var_7_0.hp / arg_7_0.maxHp

	for iter_7_0 = 1, arg_7_0.maxHp do
		gohelper.setActive(arg_7_0.hpEffList[iter_7_0], iter_7_0 == var_7_0.hp)
	end

	TaskDispatcher.runDelay(arg_7_0.closeThis, arg_7_0, 3)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.closeThis, arg_9_0)
end

return var_0_0
