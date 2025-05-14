module("modules.logic.versionactivity1_4.act131.view.Activity131LogCategoryItem", package.seeall)

local var_0_0 = class("Activity131LogCategoryItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._btnCategory = gohelper.findChildButtonWithAudio(arg_1_1, "btnclick")
	arg_1_0.goSelected = gohelper.findChild(arg_1_1, "beselected")
	arg_1_0.goUnSelected = gohelper.findChild(arg_1_1, "unselected")
	arg_1_0.txtTitleS = gohelper.findChildTextMesh(arg_1_1, "beselected/chapternamecn")
	arg_1_0.txtTitleUS = gohelper.findChildTextMesh(arg_1_1, "unselected/chapternamecn")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnCategory:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	arg_2_0:addEventCb(Activity131Controller.instance, Activity131Event.SelectCategory, arg_2_0.onSelectCategory, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnCategory:RemoveClickListener()
	arg_3_0:removeEventCb(Activity131Controller.instance, Activity131Event.SelectCategory, arg_3_0.onSelectCategory, arg_3_0)
end

function var_0_0.setInfo(arg_4_0, arg_4_1)
	arg_4_0.logType = arg_4_1

	local var_4_0 = string.split(arg_4_1, "_")
	local var_4_1 = Activity131Config.instance:getActivity131DialogCo(tonumber(var_4_0[1]), tonumber(var_4_0[2]))

	arg_4_0.txtTitleS.text = var_4_1.content
	arg_4_0.txtTitleUS.text = var_4_1.content

	gohelper.setActive(arg_4_0.goSelected, arg_4_0:_isSelected())
	gohelper.setActive(arg_4_0.goUnSelected, not arg_4_0:_isSelected())
end

function var_0_0.onDestroy(arg_5_0)
	return
end

function var_0_0._isSelected(arg_6_0)
	return arg_6_0.logType == Activity131Model.instance:getSelectLogType()
end

function var_0_0._onItemClick(arg_7_0)
	if arg_7_0:_isSelected() then
		return
	end

	Activity131Model.instance:setSelectLogType(arg_7_0.logType)
end

function var_0_0.onSelectCategory(arg_8_0)
	gohelper.setActive(arg_8_0.goSelected, arg_8_0:_isSelected())
	gohelper.setActive(arg_8_0.goUnSelected, not arg_8_0:_isSelected())
end

return var_0_0
