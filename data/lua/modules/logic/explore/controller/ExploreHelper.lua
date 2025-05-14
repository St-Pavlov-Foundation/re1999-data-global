module("modules.logic.explore.controller.ExploreHelper", package.seeall)

local var_0_0 = _M
local var_0_1 = LayerMask.GetMask("Scene")
local var_0_2 = LayerMask.GetMask("SceneOpaque", "Unit", "Scene")
local var_0_3 = LayerMask.GetMask(SceneLayer.UI3D, SceneLayer.UI3DAfterPostProcess)

function var_0_0.getXYByKey(arg_1_0)
	local var_1_0 = string.split(arg_1_0, "_")
	local var_1_1 = tonumber(var_1_0[1])
	local var_1_2 = tonumber(var_1_0[2])

	return var_1_1, var_1_2
end

function var_0_0.getNavigateMask()
	return var_0_1
end

function var_0_0.getSceneMask()
	return var_0_2
end

function var_0_0.getTriggerMask()
	return var_0_3
end

function var_0_0.getKey(arg_5_0)
	return var_0_0.getKeyXY(arg_5_0.x, arg_5_0.y)
end

function var_0_0.getKeyXY(arg_6_0, arg_6_1)
	return string.format("%s_%s", arg_6_0, arg_6_1)
end

function var_0_0.tileToPos(arg_7_0)
	return Vector3(arg_7_0.x * ExploreConstValue.TILE_SIZE + 0.5, 0, arg_7_0.y * ExploreConstValue.TILE_SIZE + 0.5)
end

function var_0_0.posToTile(arg_8_0)
	return Vector2(math.floor(arg_8_0.x / ExploreConstValue.TILE_SIZE), math.floor(arg_8_0.z / ExploreConstValue.TILE_SIZE))
end

function var_0_0.isPosEqual(arg_9_0, arg_9_1)
	return arg_9_0 == arg_9_1 or arg_9_0.x == arg_9_1.x and arg_9_0.y == arg_9_1.y
end

function var_0_0.getDistance(arg_10_0, arg_10_1)
	return math.abs(arg_10_0.x - arg_10_1.x) + math.abs(arg_10_0.y - arg_10_1.y)
end

function var_0_0.getDistanceRound(arg_11_0, arg_11_1)
	return math.max(math.abs(arg_11_0.x - arg_11_1.x), math.abs(arg_11_0.y - arg_11_1.y))
end

function var_0_0.getDir(arg_12_0)
	return (arg_12_0 + 360) % 360
end

local var_0_4 = {
	[0] = {
		x = 0,
		y = 1
	},
	[90] = {
		x = 1,
		y = 0
	},
	[180] = {
		x = 0,
		y = -1
	},
	[270] = {
		x = -1,
		y = 0
	}
}

function var_0_0.dirToXY(arg_13_0)
	arg_13_0 = var_0_0.getDir(arg_13_0)

	return var_0_4[arg_13_0]
end

function var_0_0.xyToDir(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in pairs(var_0_4) do
		if iter_14_1.x == arg_14_0 and iter_14_1.y == arg_14_1 then
			return iter_14_0
		end
	end

	return 0
end

function var_0_0.getCornerNum(arg_15_0, arg_15_1)
	if not arg_15_0 or #arg_15_0 <= 0 then
		return 0
	end

	local var_15_0 = 0
	local var_15_1 = arg_15_0[1]
	local var_15_2

	local function var_15_3(arg_16_0)
		local var_16_0 = 0

		if var_15_1.x == arg_16_0.x then
			var_16_0 = -1
		elseif var_15_1.y == arg_16_0.y then
			var_16_0 = 1
		end

		if not var_15_2 or var_15_2 ~= var_16_0 then
			var_15_0 = var_15_0 + 1
			var_15_2 = var_16_0
		end
	end

	for iter_15_0 = 2, #arg_15_0 do
		local var_15_4 = arg_15_0[iter_15_0]

		var_15_3(var_15_4)

		var_15_1 = var_15_4
	end

	var_15_3(arg_15_1)

	return var_15_0 - 1
end

function var_0_0.getBit(arg_17_0, arg_17_1)
	local var_17_0 = bit.lshift(1, arg_17_1 - 1)

	return bit.band(arg_17_0, var_17_0)
end

function var_0_0.setBit(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = bit.lshift(1, arg_18_1 - 1)

	if arg_18_2 then
		arg_18_0 = bit.bor(arg_18_0, var_18_0)
	else
		local var_18_1 = bit.bnot(var_18_0)

		arg_18_0 = bit.band(arg_18_0, var_18_1)
	end

	return arg_18_0
end

function var_0_0.triggerAudio(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_0 or arg_19_0 <= 0 then
		return
	end

	local var_19_0

	if arg_19_1 then
		var_19_0 = AudioMgr.instance:trigger(arg_19_0, arg_19_2)
	else
		var_19_0 = AudioMgr.instance:trigger(arg_19_0)
	end

	if arg_19_3 then
		GameSceneMgr.instance:getCurScene().audio:onTriggerAudio(arg_19_3, var_19_0)
	end
end

return var_0_0
