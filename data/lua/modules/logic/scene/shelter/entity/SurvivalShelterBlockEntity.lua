module("modules.logic.scene.shelter.entity.SurvivalShelterBlockEntity", package.seeall)

local var_0_0 = class("SurvivalShelterBlockEntity", LuaCompBase)

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = gohelper.create3d(arg_1_1, tostring(arg_1_0.pos))
	local var_1_1, var_1_2, var_1_3 = SurvivalHelper.instance:hexPointToWorldPoint(arg_1_0.pos.q, arg_1_0.pos.r)
	local var_1_4 = var_1_0.transform

	transformhelper.setLocalPos(var_1_4, var_1_1, var_1_2, var_1_3)
	transformhelper.setLocalRotation(var_1_4, 0, arg_1_0.dir * 60 + 30, 0)

	local var_1_5 = SurvivalMapHelper.instance:getBlockRes(arg_1_0.assetPath)

	if var_1_5 then
		local var_1_6 = gohelper.clone(var_1_5, var_1_0).transform

		transformhelper.setLocalPos(var_1_6, 0, 0, 0)
		transformhelper.setLocalRotation(var_1_6, 0, 0, 0)
		transformhelper.setLocalScale(var_1_6, 1, 1, 1)
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0, arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

return var_0_0
