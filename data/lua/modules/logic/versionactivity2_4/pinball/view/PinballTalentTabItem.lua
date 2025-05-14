module("modules.logic.versionactivity2_4.pinball.view.PinballTalentTabItem", package.seeall)

local var_0_0 = class("PinballTalentTabItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "selectbg")
	arg_1_0._gounselect = gohelper.findChild(arg_1_1, "unselectbg")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_1, "#txt_name")
	arg_1_0._click = gohelper.getClick(arg_1_1)
	arg_1_0._red = gohelper.findChild(arg_1_1, "go_reddot")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
	PinballController.instance:registerCallback(PinballEvent.TalentRedChange, arg_2_0._onTalentRedChange, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.TalentRedChange, arg_3_0._onTalentRedChange, arg_3_0)
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0._txtname.text = arg_4_1.co.name
	arg_4_0._data = arg_4_1

	arg_4_0:_onTalentRedChange()
end

function var_0_0._onTalentRedChange(arg_5_0)
	gohelper.setActive(arg_5_0._red, PinballModel.instance:getTalentRed(arg_5_0._data.co.id))
end

function var_0_0.setSelectData(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goselect, arg_6_1 == arg_6_0._data)
	gohelper.setActive(arg_6_0._gounselect, arg_6_1 ~= arg_6_0._data)
end

function var_0_0.setClickCall(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.callback = arg_7_1
	arg_7_0.callobj = arg_7_2
end

function var_0_0._onClick(arg_8_0)
	if arg_8_0.callback then
		arg_8_0.callback(arg_8_0.callobj, arg_8_0._data)
	end
end

return var_0_0
