module("modules.logic.season.view1_4.Season1_4SpecialMarketShowLevelItem", package.seeall)

local var_0_0 = class("Season1_4SpecialMarketShowLevelItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goline = gohelper.findChild(arg_1_1, "#go_line")
	arg_1_0._goselectedpass = gohelper.findChild(arg_1_1, "#go_selectedpass")
	arg_1_0._txtselectpassindex = gohelper.findChildText(arg_1_1, "#go_selectedpass/#txt_selectpassindex")
	arg_1_0._goselectedunpass = gohelper.findChild(arg_1_1, "#go_selectedunpass")
	arg_1_0._txtselectunpassindex = gohelper.findChildText(arg_1_1, "#go_selectedunpass/#txt_selectunpassindex")
	arg_1_0._gopass = gohelper.findChild(arg_1_1, "#go_pass")
	arg_1_0._txtpassindex = gohelper.findChildText(arg_1_1, "#go_pass/#txt_passindex")
	arg_1_0._gounpass = gohelper.findChild(arg_1_1, "#go_unpass")
	arg_1_0._txtunpassindex = gohelper.findChildText(arg_1_1, "#go_unpass/#txt_unpassindex")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_click")

	arg_1_0._btnClick:AddClickListener(arg_1_0._btnOnClick, arg_1_0)
end

function var_0_0._btnOnClick(arg_2_0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SwitchSpecialEpisode, arg_2_0.index)
end

function var_0_0.reset(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.index = arg_3_1
	arg_3_0.targetIndex = arg_3_2
	arg_3_0.maxSpecialLayer = arg_3_3

	arg_3_0:_refreshItem()
end

function var_0_0._refreshItem(arg_4_0)
	gohelper.setActive(arg_4_0.go, true)

	local var_4_0 = Activity104Model.instance:isSpecialLayerPassed(arg_4_0.index)

	gohelper.setActive(arg_4_0._gopass, var_4_0 and arg_4_0.targetIndex ~= arg_4_0.index)
	gohelper.setActive(arg_4_0._gounpass, not var_4_0 and arg_4_0.targetIndex ~= arg_4_0.index)
	gohelper.setActive(arg_4_0._goselectedpass, var_4_0 and arg_4_0.targetIndex == arg_4_0.index)
	gohelper.setActive(arg_4_0._goselectedunpass, not var_4_0 and arg_4_0.targetIndex == arg_4_0.index)
	gohelper.setActive(arg_4_0._goline, arg_4_0.index < arg_4_0.maxSpecialLayer)

	arg_4_0._txtselectpassindex.text = string.format("%02d", arg_4_0.index)
	arg_4_0._txtselectunpassindex.text = string.format("%02d", arg_4_0.index)
	arg_4_0._txtpassindex.text = string.format("%02d", arg_4_0.index)
	arg_4_0._txtunpassindex.text = string.format("%02d", arg_4_0.index)
end

function var_0_0.destroy(arg_5_0)
	arg_5_0._btnClick:RemoveClickListener()
end

return var_0_0
