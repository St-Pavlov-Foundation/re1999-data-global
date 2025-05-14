module("modules.logic.explore.map.unit.ExplorePrismUnit", package.seeall)

local var_0_0 = class("ExplorePrismUnit", ExploreBaseLightUnit)

function var_0_0.getLightRecvType(arg_1_0)
	return ExploreEnum.LightRecvType.Custom
end

function var_0_0.onLightEnter(arg_2_0, arg_2_1)
	if not arg_2_0.mo:isInteractEnabled() then
		return
	end

	local var_2_0 = ExploreController.instance:getMapLight()

	var_2_0:beginCheckStatusChange(arg_2_0.id, arg_2_0:haveLight())
	arg_2_0:addLights()
	var_2_0:endCheckStatus()
end

function var_0_0.onInteractChange(arg_3_0, arg_3_1)
	var_0_0.super.onInteractChange(arg_3_0, arg_3_1)

	if arg_3_0.animComp._curAnim ~= ExploreAnimEnum.AnimName.uToN then
		local var_3_0 = ExploreController.instance:getMapLight()

		var_3_0:beginCheckStatusChange(arg_3_0.id, arg_3_0:haveLight())
		arg_3_0:checkLight()
		var_3_0:endCheckStatus()
	else
		ExploreModel.instance:setStepPause(true)
	end
end

function var_0_0.onAnimEnd(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super.onAnimEnd(arg_4_0, arg_4_1, arg_4_2)

	if arg_4_1 == ExploreAnimEnum.AnimName.uToN then
		local var_4_0 = ExploreController.instance:getMapLight()

		var_4_0:beginCheckStatusChange(arg_4_0.id, arg_4_0:haveLight())
		arg_4_0:checkLight()
		var_4_0:endCheckStatus()
		ExploreModel.instance:setStepPause(false)
	end
end

function var_0_0.onLightExit(arg_5_0)
	local var_5_0 = ExploreController.instance:getMapLight()

	var_5_0:beginCheckStatusChange(arg_5_0.id, arg_5_0:haveLight())
	arg_5_0:removeLights()
	var_5_0:endCheckStatus()
end

function var_0_0.setEmitLight(arg_6_0, arg_6_1)
	var_0_0.super.setEmitLight(arg_6_0, arg_6_1)

	if arg_6_1 then
		local var_6_0 = ExploreController.instance:getMapLight()

		var_6_0:removeUnitEmitLight(arg_6_0)
		arg_6_0:removeLights()
		var_6_0:updateLightsByUnit(arg_6_0)
		arg_6_0:playAnim(arg_6_0:getIdleAnim())
	else
		arg_6_0:checkLight()
	end
end

function var_0_0.checkLight(arg_7_0)
	if not ExploreController.instance:getMap():isInitDone() then
		return
	end

	local var_7_0 = ExploreController.instance:getMapLight()

	if not arg_7_0.mo:isInteractEnabled() then
		var_7_0:removeUnitEmitLight(arg_7_0)
		arg_7_0:removeLights()
		var_7_0:updateLightsByUnit(arg_7_0)

		return
	end

	local var_7_1 = arg_7_0:haveLight()

	var_7_0:beginCheckStatusChange(arg_7_0.id, arg_7_0:haveLight())
	var_7_0:removeUnitEmitLight(arg_7_0)
	var_7_0:updateLightsByUnit(arg_7_0)
	arg_7_0:removeLights()

	if arg_7_0:isHaveIlluminant() and not arg_7_0._isNoEmitLight then
		arg_7_0:addLights()
	end

	var_7_0:endCheckStatus()
end

function var_0_0.haveLight(arg_8_0)
	return arg_8_0.lightComp:haveLight()
end

function var_0_0.onBallLightChange(arg_9_0)
	arg_9_0:checkLight()
end

function var_0_0.addLights(arg_10_0)
	arg_10_0.lightComp:addLight(arg_10_0.mo.unitDir)
end

function var_0_0.removeLights(arg_11_0)
	arg_11_0.lightComp:removeAllLight()
end

function var_0_0.isCustomShowOutLine(arg_12_0)
	local var_12_0 = not arg_12_0.mo:isInteractEnabled()

	return var_12_0, var_12_0 and "explore/common/sprite/prefabs/msts_icon_xiuli.prefab"
end

function var_0_0.isHaveIlluminant(arg_13_0)
	return ExploreController.instance:getMapLight():haveLight(arg_13_0)
end

function var_0_0.getFixItemId(arg_14_0)
	return arg_14_0.mo.fixItemId
end

return var_0_0
