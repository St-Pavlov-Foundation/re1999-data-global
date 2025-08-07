module("modules.logic.fight.view.FightNamePowerInfoView6", package.seeall)

local var_0_0 = class("FightNamePowerInfoView6", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.objList = {}

	for iter_1_0 = 0, 3 do
		local var_1_0 = gohelper.findChild(arg_1_0.viewGO, iter_1_0)

		arg_1_0.objList[iter_1_0] = var_1_0
	end

	recthelper.setAnchor(arg_1_0.viewGO.transform, -106, 6)

	arg_1_0.click = gohelper.findChildClick(arg_1_0.viewGO, "click")
	arg_1_0.tips = gohelper.findChild(arg_1_0.viewGO, "tips")
	arg_1_0.tipsText = gohelper.findChildText(arg_1_0.viewGO, "tips/desc")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.click, arg_2_0.onClick)
	arg_2_0:com_registFightEvent(FightEvent.PowerChange, arg_2_0.onPowerChange)
	arg_2_0:com_registFightEvent(FightEvent.TouchFightViewScreen, arg_2_0.onTouchFightViewScreen)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onTouchFightViewScreen(arg_4_0)
	gohelper.setActive(arg_4_0.tips, false)
end

function var_0_0.onClick(arg_5_0)
	gohelper.setActive(arg_5_0.tips, true)

	local var_5_0 = arg_5_0.powerInfo.num
	local var_5_1 = ""

	if var_5_0 == 0 or var_5_0 == 1 then
		var_5_1 = luaLang("p_v2a9_alert_help_1_txt_5")
	elseif var_5_0 == 2 then
		var_5_1 = luaLang("p_v2a9_alert_help_1_txt_6")
	elseif var_5_0 == 3 then
		var_5_1 = luaLang("p_v2a9_alert_help_1_txt_7")
	end

	arg_5_0.tipsText.text = var_5_1
end

function var_0_0.onConstructor(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.entityId = arg_6_1
	arg_6_0.powerInfo = arg_6_2
	arg_6_0.isFocusView = arg_6_3
end

function var_0_0.refreshData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.entityId = arg_7_1
	arg_7_0.powerInfo = arg_7_2

	if arg_7_0.viewGO then
		arg_7_0:refreshUI()
	end
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	local var_9_0 = arg_9_0.powerInfo.num

	for iter_9_0, iter_9_1 in pairs(arg_9_0.objList) do
		gohelper.setActive(iter_9_1, iter_9_0 == var_9_0)
	end

	if var_9_0 > 3 then
		gohelper.setActive(arg_9_0.objList[3], true)
	end

	if arg_9_0.isFocusView then
		recthelper.setAnchorX(arg_9_0.tips.transform, -414)
	end
end

function var_0_0.onPowerChange(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.entityId == arg_10_1 and arg_10_0.powerInfo.powerId == arg_10_2 then
		arg_10_0:refreshUI()
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
