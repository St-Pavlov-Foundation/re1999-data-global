module("modules.logic.seasonver.act123.view1_8.component.Season123_1_8MarketShowLevelItem", package.seeall)

local var_0_0 = class("Season123_1_8MarketShowLevelItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0.targetIndex = arg_1_3
	arg_1_0.maxIndex = arg_1_4
	arg_1_0._goselected = gohelper.findChild(arg_1_1, "#go_selected")
	arg_1_0._txtselectindex = gohelper.findChildText(arg_1_1, "#go_selected/#txt_selectindex")
	arg_1_0._gounselect = gohelper.findChild(arg_1_1, "#go_unselected")
	arg_1_0._txtunselectindex = gohelper.findChildText(arg_1_1, "#go_unselected/#txt_selectindex")

	gohelper.setActive(arg_1_0.go, true)
	gohelper.setActive(arg_1_0._goselected, false)
	gohelper.setActive(arg_1_0._gounselect, false)
end

function var_0_0.show(arg_2_0)
	gohelper.setActive(arg_2_0._goselected, arg_2_0.targetIndex == arg_2_0.index)
	gohelper.setActive(arg_2_0._gounselect, arg_2_0.targetIndex ~= arg_2_0.index)

	arg_2_0._txtselectindex.text = string.format("%02d", arg_2_0.index)
	arg_2_0._txtunselectindex.text = string.format("%02d", arg_2_0.index)
end

function var_0_0.destroy(arg_3_0)
	arg_3_0:__onDispose()
end

return var_0_0
