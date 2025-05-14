module("modules.logic.playercard.view.comp.PlayerCardLayoutItemCardGroup", package.seeall)

local var_0_0 = class("PlayerCardLayoutItemCardGroup", PlayerCardLayoutItem)

var_0_0.TweenDuration = 0.16

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0.frameSingle = gohelper.findChild(arg_1_1, "frame_single")
	arg_1_0.goSelectSingle = gohelper.findChild(arg_1_1, "card/select_single")

	gohelper.setActive(arg_1_0.frame, false)
	gohelper.setActive(arg_1_0.goSelect, false)
	gohelper.setActive(arg_1_0.frameSingle, false)
	gohelper.setActive(arg_1_0.goSelectSingle, false)
end

function var_0_0.setEditMode(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.cardComp:isSingle()

	if var_2_0 then
		gohelper.setActive(arg_2_0.frame, false)
		gohelper.setActive(arg_2_0.goSelect, false)
		gohelper.setActive(arg_2_0.frameSingle, arg_2_1)
		gohelper.setActive(arg_2_0.goSelectSingle, arg_2_1)
	else
		gohelper.setActive(arg_2_0.frame, arg_2_1)
		gohelper.setActive(arg_2_0.goSelect, arg_2_1)
		gohelper.setActive(arg_2_0.frameSingle, false)
		gohelper.setActive(arg_2_0.goSelectSingle, false)
	end

	recthelper.setHeight(arg_2_0.go.transform, var_2_0 and 137 or 274)

	if arg_2_1 then
		arg_2_0.animCard:Play("wiggle")
	end
end

return var_0_0
