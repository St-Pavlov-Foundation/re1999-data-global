module("modules.logic.fight.buffbehaviours.FightBuffBehaviourBase", package.seeall)

local var_0_0 = class("FightBuffBehaviourBase", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0.viewGo = arg_1_1
	arg_1_0.viewContainer = arg_1_2
	arg_1_0.co = arg_1_3
end

function var_0_0.onAddBuff(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return
end

function var_0_0.onUpdateBuff(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	return
end

function var_0_0.onRemoveBuff(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	return
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0:__onDispose()
end

return var_0_0
