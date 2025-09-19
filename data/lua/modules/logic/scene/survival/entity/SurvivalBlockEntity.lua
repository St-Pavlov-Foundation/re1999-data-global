module("modules.logic.scene.survival.entity.SurvivalBlockEntity", package.seeall)

local var_0_0 = class("SurvivalBlockEntity", LuaCompBase)
local var_0_1 = require("bit")

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

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._blockCo = arg_2_1
end

local var_0_2 = 9

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0._terrainMRs = arg_3_0:getUserDataTb_()

	local var_3_0 = arg_3_1:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)

	for iter_3_0 = 0, var_3_0.Length - 1 do
		local var_3_1 = var_3_0[iter_3_0]
		local var_3_2 = var_3_1.renderingLayerMask

		if var_0_1.band(var_3_2, 2^var_0_2) ~= 0 then
			table.insert(arg_3_0._terrainMRs, var_3_1)
		end
	end

	if not arg_3_0._terrainMRs[1] then
		return
	end

	local var_3_3 = SurvivalMapModel.instance:getSceneMo()
	local var_3_4 = var_3_3.exitPos

	arg_3_0._isInRain = SurvivalHelper.instance:getDistance(arg_3_0._blockCo.pos, var_3_4) > var_3_3.circle
	arg_3_0._isInFog = SurvivalMapModel.instance:isInFog(arg_3_0._blockCo.pos)

	for iter_3_1, iter_3_2 in pairs(arg_3_0._terrainMRs) do
		SurvivalMapHelper.instance:getSceneFogComp():setBlockStatu(iter_3_2, arg_3_0._isInFog, arg_3_0._isInRain)
	end
end

function var_0_0.addEventListeners(arg_4_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapExploredPointUpdate, arg_4_0._onFogUpdate, arg_4_0)
end

function var_0_0.removeEventListeners(arg_5_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapExploredPointUpdate, arg_5_0._onFogUpdate, arg_5_0)
end

function var_0_0.onStart(arg_6_0)
	arg_6_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function var_0_0._onCircleUpdate(arg_7_0)
	return
end

function var_0_0._onFogUpdate(arg_8_0)
	if not arg_8_0._terrainMRs[1] then
		return
	end

	local var_8_0 = SurvivalMapModel.instance:isInFog(arg_8_0._blockCo.pos)

	if var_8_0 ~= arg_8_0._isInFog then
		arg_8_0._isInFog = var_8_0

		for iter_8_0, iter_8_1 in pairs(arg_8_0._terrainMRs) do
			SurvivalMapHelper.instance:getSceneFogComp():setBlockStatu(iter_8_1, var_8_0)
		end
	end
end

function var_0_0.onDestroy(arg_9_0)
	return
end

return var_0_0
