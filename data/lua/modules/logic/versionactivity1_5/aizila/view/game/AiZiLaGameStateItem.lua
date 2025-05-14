module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateItem", package.seeall)

local var_0_0 = class("AiZiLaGameStateItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goState = gohelper.findChild(arg_1_0.viewGO, "#go_State")
	arg_1_0._goeffdown = gohelper.findChild(arg_1_0.viewGO, "#go_State/#go_effdown")
	arg_1_0._goeffup = gohelper.findChild(arg_1_0.viewGO, "#go_State/#go_effup")
	arg_1_0._txteffDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_State/#txt_effDesc")

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
	arg_7_0._mo = arg_7_1
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0.setStateStr(arg_10_0, arg_10_1)
	arg_10_0._txteffDesc.text = arg_10_1
end

function var_0_0.setShowUp(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goeffdown, not arg_11_1)
	gohelper.setActive(arg_11_0._goeffup, arg_11_1)
end

return var_0_0
