module("modules.logic.dialogue.view.items.DialogueItem", package.seeall)

local var_0_0 = class("DialogueItem", UserDataDispose)

function var_0_0.CreateItem(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = DialogueEnum.DialogueItemCls[arg_1_0.type]

	if not var_1_0 then
		logError("un support type dialogue type : " .. tostring(arg_1_0.type))

		return nil
	end

	local var_1_1 = var_1_0.New()

	var_1_1:init(arg_1_0, arg_1_1, arg_1_2)

	return var_1_1
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:__onInit()

	arg_2_0.stepCo = arg_2_1
	arg_2_0.go = arg_2_2
	arg_2_0.transform = arg_2_0.go.transform

	recthelper.setAnchorY(arg_2_0.transform, -arg_2_3)
	gohelper.setActive(arg_2_2, true)
	arg_2_0:initView()
	arg_2_0:refresh()
	arg_2_0:calculateHeight()
end

function var_0_0.initView(arg_3_0)
	return
end

function var_0_0.refresh(arg_4_0)
	return
end

function var_0_0.calculateHeight(arg_5_0)
	return
end

function var_0_0.getHeight(arg_6_0)
	return arg_6_0.height
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.destroy(arg_8_0)
	arg_8_0:onDestroy()
	arg_8_0:__onDispose()
end

return var_0_0
