module("modules.logic.explore.map.unit.comp.ExploreUnitLightComp", package.seeall)

local var_0_0 = class("ExploreUnitLightComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unit = arg_1_1
	arg_1_0.lights = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.addLight(arg_3_0, arg_3_1)
	if arg_3_1 % 45 ~= 0 then
		return
	end

	local var_3_0 = ExploreController.instance:getMapLight():addLight(arg_3_0.unit, arg_3_1)
	local var_3_1 = #arg_3_0.lights + 1

	arg_3_0.lights[var_3_1] = {
		mo = var_3_0,
		lightItem = ExploreMapLightPool.instance:getInst(var_3_0, arg_3_0.go)
	}
end

function var_0_0.haveLight(arg_4_0)
	return #arg_4_0.lights > 0
end

function var_0_0.onLightDataChange(arg_5_0, arg_5_1)
	for iter_5_0 = 1, #arg_5_0.lights do
		if arg_5_0.lights[iter_5_0].mo == arg_5_1 then
			return arg_5_0.lights[iter_5_0].lightItem:updateLightMO(arg_5_1)
		end
	end
end

function var_0_0.addLights(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:addLight(arg_6_1)
	arg_6_0:addLight(arg_6_2)
end

function var_0_0.removeLightByDir(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.lights) do
		if iter_7_1.mo.dir == arg_7_1 then
			ExploreMapLightPool.instance:inPool(iter_7_1.lightItem)
			table.remove(arg_7_0.lights, iter_7_0)

			break
		end
	end
end

function var_0_0.removeAllLight(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.lights) do
		ExploreMapLightPool.instance:inPool(iter_8_1.lightItem)
	end

	arg_8_0.lights = {}
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0:removeAllLight()

	arg_9_0.go = nil
	arg_9_0.unit = nil
end

return var_0_0
