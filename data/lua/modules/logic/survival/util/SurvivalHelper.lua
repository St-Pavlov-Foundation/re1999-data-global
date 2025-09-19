module("modules.logic.survival.util.SurvivalHelper", package.seeall)

local var_0_0 = class("SurvivalHelper")
local var_0_1 = math.sqrt(3)
local var_0_2 = Vector3()

function var_0_0.getDistance(arg_1_0, arg_1_1, arg_1_2)
	return (math.abs(arg_1_1.q - arg_1_2.q) + math.abs(arg_1_1.r - arg_1_2.r) + math.abs(arg_1_1.s - arg_1_2.s)) / 2
end

function var_0_0.getAllPointsByDis(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_2 or not arg_2_1 or arg_2_2 <= 0 then
		return {}
	end

	local var_2_0 = {}

	for iter_2_0 = -arg_2_2, arg_2_2 do
		for iter_2_1 = -arg_2_2, arg_2_2 do
			for iter_2_2 = -arg_2_2, arg_2_2 do
				if iter_2_0 + iter_2_1 + iter_2_2 == 0 then
					table.insert(var_2_0, SurvivalHexNode.New(iter_2_0 + arg_2_1.q, iter_2_1 + arg_2_1.r, iter_2_2 + arg_2_1.s))
				end
			end
		end
	end

	return var_2_0
end

function var_0_0.hexPointToWorldPoint(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_2 / 4 * var_0_1 + arg_3_1 * var_0_1 / 2, 0, -arg_3_2 * 3 / 4
end

function var_0_0.worldPointToHex(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = (arg_4_3 + arg_4_1 * var_0_1) * 2 / 3
	local var_4_1 = -arg_4_3 * 4 / 3
	local var_4_2 = -var_4_0 - var_4_1
	local var_4_3 = Mathf.Round(var_4_0)
	local var_4_4 = Mathf.Round(var_4_1)
	local var_4_5 = Mathf.Round(var_4_2)
	local var_4_6 = math.abs(var_4_0 - var_4_3)
	local var_4_7 = math.abs(var_4_1 - var_4_4)
	local var_4_8 = math.abs(var_4_2 - var_4_5)

	if var_4_7 < var_4_6 and var_4_8 < var_4_6 then
		var_4_3 = -var_4_4 - var_4_5
	elseif var_4_8 < var_4_7 then
		var_4_4 = -var_4_3 - var_4_5
	else
		var_4_5 = -var_4_3 - var_4_4
	end

	return var_4_3, var_4_4, var_4_5
end

function var_0_0.getScene3DPos(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or GamepadController.instance:getMousePosition()

	local var_5_0 = CameraMgr.instance:getMainCamera():ScreenPointToRay(arg_5_1)
	local var_5_1 = var_5_0.direction

	if var_5_1.y == 0 then
		return var_0_2
	end

	local var_5_2 = var_5_0.origin
	local var_5_3 = -var_5_2.y / var_5_1.y

	return var_5_2:Add(var_5_1:Mul(var_5_3))
end

function var_0_0.getDir(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_2.q - arg_6_1.q
	local var_6_1 = arg_6_2.r - arg_6_1.r
	local var_6_2 = math.max(math.abs(var_6_0), math.abs(var_6_1))
	local var_6_3 = math.floor(var_6_0 / var_6_2)
	local var_6_4 = math.floor(var_6_1 / var_6_2)

	for iter_6_0, iter_6_1 in pairs(SurvivalEnum.DirToPos) do
		if iter_6_1.q == var_6_3 and iter_6_1.r == var_6_4 then
			return iter_6_0
		end
	end
end

function var_0_0.screenPosToRay(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or GamepadController.instance:getMousePosition()

	return (CameraMgr.instance:getMainCamera():ScreenPointToRay(arg_7_1))
end

function var_0_0.isInSeasonAndVersion(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return false
	end

	local var_8_0 = SurvivalModel.instance:getOutSideInfo()

	if not var_8_0 then
		return false
	end

	local var_8_1 = arg_8_1.versions

	if not string.nilorempty(var_8_1) then
		local var_8_2 = GameUtil.splitString2(var_8_1, true)

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			table.sort(iter_8_1)

			if not arg_8_0:isSame(iter_8_1, var_8_0.versions) then
				return false
			end
		end
	end

	local var_8_3 = arg_8_1.seasons

	if not string.nilorempty(var_8_3) then
		local var_8_4 = string.splitToNumber(var_8_3, "#")

		if not tabletool.indexOf(var_8_4, var_8_0.season) then
			return false
		end
	end

	return true
end

function var_0_0.isSame(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_1 or not arg_9_2 then
		return false
	end

	if #arg_9_1 ~= #arg_9_2 then
		return false
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if arg_9_2[iter_9_0] ~= iter_9_1 then
			return false
		end
	end

	return true
end

function var_0_0.makeArrFull(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = arg_10_3 * arg_10_4
	local var_10_1 = #arg_10_1

	if var_10_1 < var_10_0 then
		for iter_10_0 = var_10_1 + 1, var_10_0 do
			table.insert(arg_10_1, arg_10_2)
		end
	else
		local var_10_2 = var_10_1 % arg_10_4

		if var_10_2 ~= 0 then
			for iter_10_1 = var_10_2 + 1, arg_10_4 do
				table.insert(arg_10_1, arg_10_2)
			end
		end
	end
end

function var_0_0.getOperResult(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1 == SurvivalEnum.ConditionOper.GE then
		return arg_11_3 <= arg_11_2
	elseif arg_11_1 == SurvivalEnum.ConditionOper.EQ then
		return arg_11_2 == arg_11_3
	elseif arg_11_1 == SurvivalEnum.ConditionOper.LE then
		return arg_11_2 <= arg_11_3
	end
end

function var_0_0.fitlterPath(arg_12_0, arg_12_1)
	if not arg_12_1 or #arg_12_1 < 3 then
		return arg_12_1
	end

	local var_12_0 = {
		arg_12_1[1]
	}
	local var_12_1 = arg_12_0:getDir(arg_12_1[1], arg_12_1[2])

	for iter_12_0 = 2, #arg_12_1 - 1 do
		local var_12_2 = arg_12_0:getDir(arg_12_1[iter_12_0], arg_12_1[iter_12_0 + 1])

		if var_12_2 ~= var_12_1 then
			table.insert(var_12_0, arg_12_1[iter_12_0])

			var_12_1 = var_12_2
		end
	end

	table.insert(var_12_0, arg_12_1[#arg_12_1])

	return var_12_0
end

function var_0_0.addNodeToDict(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1[arg_13_2.q] then
		arg_13_1[arg_13_2.q] = {}
	end

	arg_13_1[arg_13_2.q][arg_13_2.r] = arg_13_2
end

function var_0_0.removeNodeToDict(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1[arg_14_2.q] then
		return
	end

	arg_14_1[arg_14_2.q][arg_14_2.r] = nil
end

function var_0_0.isHaveNode(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1[arg_15_2.q] then
		return nil
	end

	return arg_15_1[arg_15_2.q][arg_15_2.r]
end

function var_0_0.getDirMustHave(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2.q - arg_16_1.q
	local var_16_1 = arg_16_2.r - arg_16_1.r
	local var_16_2 = math.max(math.abs(var_16_0), math.abs(var_16_1))
	local var_16_3 = math.floor(var_16_0 / var_16_2)
	local var_16_4 = math.floor(var_16_1 / var_16_2)

	for iter_16_0, iter_16_1 in pairs(SurvivalEnum.DirToPos) do
		if iter_16_1.q == var_16_3 and iter_16_1.r == var_16_4 then
			return iter_16_0
		end
	end

	return SurvivalEnum.Dir.Right
end

var_0_0.instance = var_0_0.New()

return var_0_0
