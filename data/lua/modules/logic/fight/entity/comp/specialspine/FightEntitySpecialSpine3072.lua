module("modules.logic.fight.entity.comp.specialspine.FightEntitySpecialSpine3072", package.seeall)

local var_0_0 = class("FightEntitySpecialSpine3072", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._entity = arg_1_1
	arg_1_0._maskEffect = FightEntitySpecialSpine3072_Mask.New(arg_1_1)
end

function var_0_0.playAnim(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._maskEffect:playAnim(arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.setFreeze(arg_3_0, arg_3_1)
	arg_3_0._maskEffect:setFreeze(arg_3_1)
end

function var_0_0.setTimeScale(arg_4_0, arg_4_1)
	arg_4_0._maskEffect:setTimeScale(arg_4_1)
end

function var_0_0.setLayer(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._maskEffect:setLayer(arg_5_1, arg_5_2)
end

function var_0_0.setRenderOrder(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._maskEffect:setRenderOrder(arg_6_1, arg_6_2)
end

function var_0_0.changeLookDir(arg_7_0, arg_7_1)
	arg_7_0._maskEffect:changeLookDir(arg_7_1)
end

function var_0_0._changeLookDir(arg_8_0)
	arg_8_0._maskEffect:_changeLookDir()
end

function var_0_0.setActive(arg_9_0, arg_9_1)
	arg_9_0._maskEffect:setActive(arg_9_1)
end

function var_0_0.setAnimation(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._maskEffect:setAnimation(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.releaseSelf(arg_11_0)
	if arg_11_0._maskEffect then
		arg_11_0._maskEffect:releaseSelf()

		arg_11_0._maskEffect = nil
	end

	arg_11_0._entity = nil

	arg_11_0:__onDispose()
end

return var_0_0
