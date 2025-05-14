module("modules.logic.explore.map.unit.ExploreLightReceiverUnit", package.seeall)

local var_0_0 = class("ExploreLightReceiverUnit", ExploreBaseLightUnit)

function var_0_0.getLightRecvDirs(arg_1_0)
	local var_1_0 = {
		[ExploreHelper.getDir(arg_1_0.mo.unitDir)] = true
	}

	if arg_1_0.mo.isPhoticDir then
		var_1_0[ExploreHelper.getDir(arg_1_0.mo.unitDir + 180)] = true
	end

	return var_1_0
end

function var_0_0.onLightEnter(arg_2_0, arg_2_1)
	local var_2_0 = ExploreController.instance:getMapLight()

	var_2_0:beginCheckStatusChange(arg_2_0.id, false)
	var_2_0:endCheckStatus()
end

function var_0_0.haveLight(arg_3_0)
	return ExploreController.instance:getMapLight():haveLight(arg_3_0)
end

function var_0_0.onLightChange(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.mo.isPhoticDir then
		return
	end

	if arg_4_2 then
		arg_4_0.lightComp:addLight(arg_4_1.dir)
	else
		arg_4_0.lightComp:removeLightByDir(arg_4_1.dir)
	end
end

function var_0_0.onLightExit(arg_5_0, arg_5_1)
	if arg_5_1 and not arg_5_0:getLightRecvDirs()[ExploreHelper.getDir(arg_5_1.dir - 180)] then
		return
	end

	local var_5_0 = ExploreController.instance:getMapLight()

	var_5_0:beginCheckStatusChange(arg_5_0.id, true)
	var_5_0:endCheckStatus()
end

return var_0_0
