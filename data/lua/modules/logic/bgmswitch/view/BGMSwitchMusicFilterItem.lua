module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterItem", package.seeall)

local var_0_0 = class("BGMSwitchMusicFilterItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._gounselected = gohelper.findChild(arg_1_1, "unselected")
	arg_1_0._txtunselected = gohelper.findChildText(arg_1_1, "unselected/info")
	arg_1_0._goselected = gohelper.findChild(arg_1_1, "selected")
	arg_1_0._txtselected = gohelper.findChildText(arg_1_1, "selected/info")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_1, "click")

	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0 = BGMSwitchModel.instance:getFilterTypeSelectState(arg_4_0._typeCo.id)

	BGMSwitchModel.instance:setFilterType(arg_4_0._typeCo.id, not var_4_0)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.FilterClassSelect)
	arg_4_0:_refreshItem()
end

function var_0_0.setItem(arg_5_0, arg_5_1)
	arg_5_0._typeCo = arg_5_1

	arg_5_0:_refreshItem()
end

function var_0_0._refreshItem(arg_6_0)
	local var_6_0 = BGMSwitchModel.instance:getFilterTypeSelectState(arg_6_0._typeCo.id)

	gohelper.setActive(arg_6_0._goselected, var_6_0)
	gohelper.setActive(arg_6_0._gounselected, not var_6_0)

	arg_6_0._txtselected.text = arg_6_0._typeCo.typename
	arg_6_0._txtunselected.text = arg_6_0._typeCo.typename
end

function var_0_0.destroy(arg_7_0)
	arg_7_0:removeEvents()
end

return var_0_0
