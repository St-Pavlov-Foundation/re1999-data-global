module("modules.logic.character.view.CharacterSkinTagItem", package.seeall)

local var_0_0 = class("CharacterSkinTagItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._color2 = gohelper.findChild(arg_1_0.viewGO, "color2")
	arg_1_0._color3 = gohelper.findChild(arg_1_0.viewGO, "color3")
	arg_1_0._color4 = gohelper.findChild(arg_1_0.viewGO, "color4")
	arg_1_0._color5 = gohelper.findChild(arg_1_0.viewGO, "color5")
	arg_1_0._txt = gohelper.findChildText(arg_1_0.viewGO, "text")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._txt.text = arg_7_1.desc

	gohelper.setActive(arg_7_0._color2, arg_7_1.color == 2)
	gohelper.setActive(arg_7_0._color3, arg_7_1.color == 3)
	gohelper.setActive(arg_7_0._color4, arg_7_1.color == 4)
	gohelper.setActive(arg_7_0._color5, arg_7_1.color == 5)
end

return var_0_0
