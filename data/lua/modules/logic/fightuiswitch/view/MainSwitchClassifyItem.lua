module("modules.logic.fightuiswitch.view.MainSwitchClassifyItem", package.seeall)

local var_0_0 = class("MainSwitchClassifyItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_click")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "image_line")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0.clickCb and arg_4_0.clickCbobject then
		arg_4_0.clickCb(arg_4_0.clickCbobject, arg_4_0._index)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._txts = arg_5_0:getUserDataTb_()

	local var_5_0 = gohelper.findChildText(arg_5_0.viewGO, "#go_normal/txt")
	local var_5_1 = gohelper.findChildText(arg_5_0.viewGO, "#go_select/txt")

	table.insert(arg_5_0._txts, var_5_0)
	table.insert(arg_5_0._txts, var_5_1)

	arg_5_0._goreddot = gohelper.findChild(arg_5_0.viewGO, "reddot")
end

function var_0_0.init(arg_6_0, arg_6_1)
	arg_6_0.viewGO = arg_6_1

	arg_6_0:onInitView()
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._mo = arg_7_1
	arg_7_0._index = arg_7_2
end

function var_0_0.addBtnListeners(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.clickCb = arg_8_1
	arg_8_0.clickCbobject = arg_8_2
end

function var_0_0.setTxt(arg_9_0, arg_9_1)
	if arg_9_0._txts then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._txts) do
			iter_9_1.text = arg_9_1
		end
	end
end

function var_0_0.showLine(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goline, arg_10_1)
end

function var_0_0.setActive(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0.viewGO, arg_11_1)
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._gonormal, not arg_12_1)
	gohelper.setActive(arg_12_0._goselect, arg_12_1)
end

function var_0_0.onSelectByIndex(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._index == arg_13_1

	arg_13_0:onSelect(var_13_0)
end

function var_0_0.showReddot(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._goreddot, arg_14_1)
end

return var_0_0
