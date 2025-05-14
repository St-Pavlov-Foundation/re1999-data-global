module("modules.logic.explore.model.mo.ExploreLightMO", package.seeall)

local var_0_0 = pureTable("ExploreLightMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.curEmitUnit = nil
	arg_1_0.dir = nil
	arg_1_0.endEmitUnit = nil
	arg_1_0.crossNodes = {}
	arg_1_0.lightLen = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.curEmitUnit = arg_2_1
	arg_2_0.dir = ExploreHelper.getDir(arg_2_2)

	arg_2_0:updateData()
end

local var_0_1 = {
	[0] = {
		x = 0,
		y = 1
	},
	[45] = {
		x = 1,
		y = 1
	},
	[90] = {
		x = 1,
		y = 0
	},
	[135] = {
		x = 1,
		y = -1
	},
	[180] = {
		x = 0,
		y = -1
	},
	[225] = {
		x = -1,
		y = -1
	},
	[270] = {
		x = -1,
		y = 0
	},
	[315] = {
		x = -1,
		y = 1
	}
}
local var_0_2 = {
	x = 0,
	y = 0
}
local var_0_3 = math.sqrt(2)

function var_0_0.updateData(arg_3_0)
	arg_3_0.crossNodes = {}

	local var_3_0 = ExploreController.instance:getMap()
	local var_3_1 = ExploreController.instance:getMapLight()
	local var_3_2 = arg_3_0.curEmitUnit.nodePos

	var_0_2.x, var_0_2.y = var_3_2.x, var_3_2.y

	local var_3_3
	local var_3_4 = 0
	local var_3_5 = var_0_1[arg_3_0.dir]

	repeat
		local var_3_6 = ExploreHelper.getKey(var_0_2)

		if not var_3_0:haveNodeXY(var_3_6) then
			break
		end

		arg_3_0.crossNodes[var_3_6] = true
		var_0_2.x = var_0_2.x + var_3_5.x
		var_0_2.y = var_0_2.y + var_3_5.y
		var_3_4 = var_3_4 + 1

		local var_3_7 = var_3_0:getUnitByPos(var_0_2)
		local var_3_8 = false

		for iter_3_0, iter_3_1 in pairs(var_3_7) do
			if not iter_3_1:isPassLight() then
				var_3_8 = true
				var_3_3 = iter_3_1

				break
			end
		end
	until var_3_8

	if not var_3_3 then
		var_3_4 = var_3_4 - 0.5
	end

	if (arg_3_0.dir + 360) % 90 == 45 then
		var_3_4 = var_3_4 * var_0_3
	end

	if var_3_3 and isTypeOf(var_3_3, ExploreBaseMoveUnit) and var_3_3:isMoving() then
		var_3_4 = Vector3.Distance(arg_3_0.curEmitUnit:getPos(), var_3_3:getPos())
	end

	arg_3_0.lightLen = var_3_4

	if var_3_3 ~= arg_3_0.endEmitUnit then
		local var_3_9 = arg_3_0.endEmitUnit

		arg_3_0.endEmitUnit = var_3_3

		if var_3_9 then
			var_3_1:removeUnitLight(var_3_9, arg_3_0)
		end

		if var_3_3 then
			local var_3_10 = var_3_3:getLightRecvDirs()

			if not var_3_10 or var_3_10[ExploreHelper.getDir(arg_3_0.dir - 180)] then
				if not var_3_1:haveLight(var_3_3, arg_3_0) then
					var_3_3:onLightEnter(arg_3_0)
				end

				var_3_3:onLightChange(arg_3_0, true)
			end
		end
	end

	arg_3_0.curEmitUnit:onLightDataChange(arg_3_0)
end

function var_0_0.isInLight(arg_4_0, arg_4_1)
	local var_4_0 = ExploreHelper.getKey(arg_4_1)

	return arg_4_0:getCrossNode()[var_4_0] or false
end

function var_0_0.getCrossNode(arg_5_0)
	return arg_5_0.crossNodes
end

return var_0_0
