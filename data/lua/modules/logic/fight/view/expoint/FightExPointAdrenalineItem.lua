module("modules.logic.fight.view.expoint.FightExPointAdrenalineItem", package.seeall)

local var_0_0 = class("FightExPointAdrenalineItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.goItem = arg_1_1
	arg_1_0.animator = arg_1_0.goItem:GetComponent(gohelper.Type_Animator)
end

function var_0_0.refresh(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.index = arg_2_1

	if arg_2_2 then
		arg_2_0.animator:Play("open", 0, 1)
	else
		arg_2_0.animator:Play("close", 0, 1)
	end
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.goItem, arg_3_1)
end

function var_0_0.playAnim(arg_4_0, arg_4_1)
	arg_4_0.animator:Play(arg_4_1, 0, 0)
end

function var_0_0.dispose(arg_5_0)
	arg_5_0:__onDispose()
end

return var_0_0
