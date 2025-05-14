module("modules.logic.explore.map.light.ExploreMapLight", package.seeall)

local var_0_0 = class("ExploreMapLight")

function var_0_0.initLight(arg_1_0)
	arg_1_0._checkCount = 0
	arg_1_0._unitStatus = {}
	arg_1_0._initDone = false
	arg_1_0._lights = {}

	local var_1_0 = ExploreController.instance:getMap()

	arg_1_0:beginCheckStatusChange()

	for iter_1_0, iter_1_1 in pairs(var_1_0._unitDic) do
		if iter_1_1:getLightRecvType() == ExploreEnum.LightRecvType.Custom then
			iter_1_1:checkLight()
		end
	end

	arg_1_0:endCheckStatus()

	arg_1_0._initDone = true
end

function var_0_0.isInitDone(arg_2_0)
	return arg_2_0._initDone
end

function var_0_0.addLight(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = ExploreLightMO.New()

	table.insert(arg_3_0._lights, var_3_0)
	var_3_0:init(arg_3_1, arg_3_2)

	return var_3_0
end

function var_0_0.removeLight(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.endEmitUnit

	tabletool.removeValue(arg_4_0._lights, arg_4_1)

	if var_4_0 then
		arg_4_0:removeUnitLight(var_4_0, arg_4_1)
	end
end

function var_0_0.haveLight(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:getLightRecvDirs()
	local var_5_1 = ExploreEnum.PrismTypes[arg_5_1:getUnitType()]

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._lights) do
		if iter_5_1 ~= arg_5_2 and iter_5_1.endEmitUnit == arg_5_1 and (not var_5_0 or var_5_0[ExploreHelper.getDir(iter_5_1.dir - 180)]) then
			return true
		end
	end

	if var_5_1 then
		local var_5_2 = ExploreController.instance:getMap()
		local var_5_3 = var_5_2:getUnitByType(ExploreEnum.ItemType.LightBall)

		if var_5_3 and ExploreHelper.getDistance(var_5_3.nodePos, arg_5_1.nodePos) <= 1 then
			return true
		end

		local var_5_4 = var_5_2:getUnitsByType(ExploreEnum.ItemType.Illuminant)

		for iter_5_2, iter_5_3 in pairs(var_5_4) do
			if ExploreHelper.isPosEqual(iter_5_3.nodePos, arg_5_1.nodePos) then
				return true
			end
		end
	end

	return false
end

function var_0_0.haveLightDepth(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_1:isEnter() then
		return false
	end

	local var_6_0 = ExploreController.instance:getMap()
	local var_6_1 = var_6_0:getUnitByType(ExploreEnum.ItemType.LightBall)
	local var_6_2 = var_6_0:getUnitsByType(ExploreEnum.ItemType.Illuminant)

	if arg_6_0:haveIlluminant(arg_6_1, var_6_1, var_6_2) then
		return true
	end

	local var_6_3 = {
		[arg_6_1.id] = true
	}
	local var_6_4 = {}

	while next(var_6_3) do
		local var_6_5 = var_6_3

		var_6_3 = {}

		for iter_6_0 in pairs(var_6_5) do
			var_6_4[iter_6_0] = true

			local var_6_6 = var_6_0:getUnit(iter_6_0)
			local var_6_7 = var_6_6:getLightRecvDirs()

			for iter_6_1, iter_6_2 in ipairs(arg_6_0._lights) do
				if arg_6_2 ~= iter_6_2 and iter_6_2.endEmitUnit == var_6_6 and (not var_6_7 or var_6_7[ExploreHelper.getDir(iter_6_2.dir - 180)]) and not var_6_4[iter_6_2.curEmitUnit.id] then
					var_6_3[iter_6_2.curEmitUnit.id] = true
				end
			end
		end
	end

	for iter_6_3 in pairs(var_6_4) do
		local var_6_8 = var_6_0:getUnit(iter_6_3)

		if arg_6_0:haveIlluminant(var_6_8, var_6_1, var_6_2) then
			return true
		end
	end

	return false
end

function var_0_0.haveIlluminant(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_1 then
		return false
	end

	if arg_7_1:getIsNoEmitLight() then
		return false
	end

	if not ExploreEnum.PrismTypes[arg_7_1:getUnitType()] then
		return false
	end

	if arg_7_2 and ExploreHelper.getDistance(arg_7_2.nodePos, arg_7_1.nodePos) <= 1 then
		return true
	end

	for iter_7_0, iter_7_1 in pairs(arg_7_3) do
		if ExploreHelper.isPosEqual(iter_7_1.nodePos, arg_7_1.nodePos) then
			return true
		end
	end
end

function var_0_0.removeUnitEmitLight(arg_8_0, arg_8_1)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._lights) do
		if iter_8_1.curEmitUnit == arg_8_1 then
			var_8_0 = var_8_0 or {}

			table.insert(var_8_0, iter_8_1)
		end
	end

	if var_8_0 then
		for iter_8_2, iter_8_3 in pairs(var_8_0) do
			arg_8_0:removeLight(iter_8_3)
		end
	end
end

function var_0_0.removeUnitLight(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:onLightChange(arg_9_2, false)

	if not arg_9_0:haveLightDepth(arg_9_1, arg_9_2) then
		arg_9_1:onLightExit(arg_9_2)

		local var_9_0

		for iter_9_0, iter_9_1 in ipairs(arg_9_0._lights) do
			if iter_9_1.curEmitUnit == arg_9_1 then
				var_9_0 = var_9_0 or {}

				table.insert(var_9_0, iter_9_1)
			end
		end

		if var_9_0 then
			for iter_9_2, iter_9_3 in pairs(var_9_0) do
				arg_9_0:removeLight(iter_9_3)
			end
		end
	end
end

function var_0_0.updateLightsByUnit(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._lights) do
		if iter_10_1:isInLight(arg_10_1.nodePos) or iter_10_1.endEmitUnit == arg_10_1 then
			iter_10_1:updateData()
		end
	end
end

function var_0_0.getAllLightMos(arg_11_0)
	return arg_11_0._lights
end

function var_0_0.beginCheckStatusChange(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._checkCount = arg_12_0._checkCount + 1

	if not arg_12_1 then
		return
	end

	if not arg_12_0._unitStatus[arg_12_1] then
		arg_12_0._unitStatus[arg_12_1] = arg_12_2
	end
end

function var_0_0.endCheckStatus(arg_13_0)
	arg_13_0._checkCount = arg_13_0._checkCount - 1

	if arg_13_0._checkCount == 0 then
		local var_13_0 = ExploreController.instance:getMap()

		for iter_13_0, iter_13_1 in pairs(arg_13_0._unitStatus) do
			local var_13_1 = var_13_0:getUnit(iter_13_0)

			if var_13_1 and var_13_1.setActiveAnim then
				local var_13_2 = var_13_1:haveLight()

				if var_13_2 ~= iter_13_1 then
					var_13_1:setActiveAnim(var_13_2)
				end
			end
		end

		arg_13_0._unitStatus = {}
	end
end

function var_0_0.unloadMap(arg_14_0)
	arg_14_0:destroy()
end

function var_0_0.destroy(arg_15_0)
	arg_15_0._lights = {}
end

return var_0_0
