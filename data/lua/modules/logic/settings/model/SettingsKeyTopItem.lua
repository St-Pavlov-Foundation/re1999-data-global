module("modules.logic.settings.model.SettingsKeyTopItem", package.seeall)

local var_0_0 = class("SettingsKeyTopItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goUnchoose = gohelper.findChild(arg_1_0._go, "#go_unchoose")
	arg_1_0._goChoose = gohelper.findChild(arg_1_0._go, "#go_choose")
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_0._go, "btn")
	arg_1_0._txtunchoose = gohelper.findChildText(arg_1_0._go, "#go_unchoose/#txt_unchoose")
	arg_1_0._txtchoose = gohelper.findChildText(arg_1_0._go, "#go_choose/#txt_choose")
end

function var_0_0.onSelect(arg_2_0, arg_2_1)
	arg_2_0._goUnchoose:SetActive(not arg_2_1)
	arg_2_0._goChoose:SetActive(arg_2_1)
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1)
	arg_3_0._mo = arg_3_1
	arg_3_0._txtunchoose.text = arg_3_1.name
	arg_3_0._txtchoose.text = arg_3_1.name
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0._btn:AddClickListener(arg_4_0.OnClick, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._btn:RemoveClickListener()
end

function var_0_0.onDestroy(arg_6_0)
	return
end

function var_0_0.OnClick(arg_7_0)
	arg_7_0._view:selectCell(arg_7_0._index, true)
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyMapChange, arg_7_0._index)
end

return var_0_0
