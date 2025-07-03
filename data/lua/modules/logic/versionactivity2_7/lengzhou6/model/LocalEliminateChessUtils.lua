module("modules.logic.versionactivity2_7.lengzhou6.model.LocalEliminateChessUtils", package.seeall)

local var_0_0 = class("LocalEliminateChessUtils")
local var_0_1 = {
	{
		x = 1,
		y = 0
	},
	{
		x = -1,
		y = 0
	},
	{
		x = 2,
		y = 0
	},
	{
		x = -2,
		y = 0
	}
}
local var_0_2 = {
	{
		x = 0,
		y = 1
	},
	{
		x = 0,
		y = -1
	},
	{
		x = 0,
		y = 2
	},
	{
		x = 0,
		y = -2
	}
}

local function var_0_3(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = EliminateEnum_2_7.AllChessID
	local var_1_1 = {}
	local var_1_2 = arg_1_2 > 1 and arg_1_0[arg_1_1][arg_1_2 - 1] or nil
	local var_1_3 = arg_1_2 > 2 and arg_1_0[arg_1_1][arg_1_2 - 2] or nil
	local var_1_4 = arg_1_1 > 1 and arg_1_0[arg_1_1 - 1][arg_1_2] or nil
	local var_1_5 = arg_1_1 > 2 and arg_1_0[arg_1_1 - 2][arg_1_2] or nil

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		local var_1_6 = true

		if var_1_2 and var_1_3 and iter_1_1 == var_1_2 and iter_1_1 == var_1_3 then
			var_1_6 = false
		end

		if var_1_4 and var_1_5 and iter_1_1 == var_1_4 and iter_1_1 == var_1_5 then
			var_1_6 = false
		end

		if var_1_6 then
			table.insert(var_1_1, iter_1_1)
		end
	end

	return var_1_1
end

local function var_0_4(arg_2_0, arg_2_1)
	print("生成的不可消除棋盘：")

	for iter_2_0 = 1, arg_2_1 do
		print(table.concat(arg_2_0[iter_2_0], " "))
	end
end

function var_0_0.generateUnsolvableBoard(arg_3_0, arg_3_1)
	math.randomseed(os.time())

	local var_3_0 = {}

	for iter_3_0 = 1, arg_3_0 do
		var_3_0[iter_3_0] = {}
	end

	for iter_3_1 = 1, arg_3_0 do
		for iter_3_2 = 1, arg_3_1 do
			local var_3_1 = var_0_3(var_3_0, iter_3_1, iter_3_2)

			if #var_3_1 == 0 then
				return nil
			end

			var_3_0[iter_3_1][iter_3_2] = var_3_1[math.random(#var_3_1)]
		end
	end

	var_0_4(var_3_0, arg_3_0)

	return var_3_0
end

function var_0_0.canEliminate(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0 = 1, arg_4_1 do
		for iter_4_1 = 1, arg_4_2 do
			local var_4_1 = arg_4_0[iter_4_0][iter_4_1]

			if not var_4_1:haveStatus(EliminateEnum.ChessState.Die) then
				local var_4_2 = var_0_0.instance.checkWithDirection(iter_4_0, iter_4_1, var_0_1, arg_4_1, arg_4_2, arg_4_0)
				local var_4_3 = var_0_0.instance.checkWithDirection(iter_4_0, iter_4_1, var_0_2, arg_4_1, arg_4_2, arg_4_0)

				if #var_4_2 == 2 then
					tabletool.clear(var_4_0)

					for iter_4_2 = 1, #var_4_2 do
						table.insert(var_4_0, var_4_2[iter_4_2])
					end

					local var_4_4, var_4_5 = var_0_0.instance._findTypeXY(arg_4_0, arg_4_1, arg_4_2, var_4_1.id, var_4_2)

					if var_4_4 ~= nil then
						table.insert(var_4_0, {
							x = var_4_4,
							y = var_4_5
						})

						return var_4_0
					end
				end

				if #var_4_3 == 2 then
					tabletool.clear(var_4_0)

					for iter_4_3 = 1, #var_4_3 do
						table.insert(var_4_0, var_4_3[iter_4_3])
					end

					local var_4_6, var_4_7 = var_0_0.instance._findTypeXY(arg_4_0, arg_4_1, arg_4_2, var_4_1.id, var_4_3)

					if var_4_6 ~= nil then
						table.insert(var_4_0, {
							x = var_4_6,
							y = var_4_7
						})

						return var_4_0
					end
				end
			end
		end
	end

	return var_4_0
end

function var_0_0.checkWithDirection(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = {}
	local var_5_1 = {
		[arg_5_0 + arg_5_1 * arg_5_4] = true
	}

	table.insert(var_5_0, {
		x = arg_5_0,
		y = arg_5_1
	})

	local var_5_2 = 1
	local var_5_3 = var_5_0[var_5_2]

	arg_5_0 = var_5_3.x
	arg_5_1 = var_5_3.y

	local var_5_4 = arg_5_5[arg_5_0][arg_5_1]
	local var_5_5 = var_5_2 + 1

	if not var_5_4 then
		-- block empty
	else
		for iter_5_0 = 1, #arg_5_2 do
			local var_5_6 = arg_5_2[iter_5_0].x
			local var_5_7 = arg_5_2[iter_5_0].y
			local var_5_8 = arg_5_0 + var_5_6
			local var_5_9 = arg_5_1 + var_5_7

			if var_5_8 < 1 or arg_5_3 < var_5_8 or var_5_9 < 1 or arg_5_4 < var_5_9 or var_5_1[var_5_8 + var_5_9 * arg_5_4] or arg_5_5[var_5_8] == nil or arg_5_5[var_5_8][var_5_9] == nil then
				-- block empty
			elseif var_5_4.id == arg_5_5[var_5_8][var_5_9].id and var_5_4.id ~= EliminateEnum.InvalidId and var_5_4.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
				var_5_1[var_5_8 + var_5_9 * arg_5_4] = true

				local var_5_10 = -1
				local var_5_11 = -1

				if math.abs(var_5_6) == 1 or math.abs(var_5_7) == 1 then
					var_5_10 = arg_5_0 + var_5_6 * 2
					var_5_11 = arg_5_1 + var_5_7 * 2
				end

				if math.abs(var_5_6) == 2 or math.abs(var_5_7) == 2 then
					var_5_10 = arg_5_0 + (var_5_6 ~= 0 and var_5_6 / 2 or var_5_6)
					var_5_11 = arg_5_1 + (var_5_7 ~= 0 and var_5_7 / 2 or var_5_7)
				end

				if var_5_10 >= 1 and var_5_11 >= 1 and var_5_10 <= arg_5_3 and var_5_11 <= arg_5_4 then
					local var_5_12 = arg_5_5[var_5_10][var_5_11]

					if var_5_12 ~= nil and not var_5_12:haveStatus(EliminateEnum.ChessState.Frost) and LocalEliminateChessModel.instance:getSpEffect(var_5_10, var_5_11) == nil and var_5_12.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone and var_5_12.id ~= EliminateEnum_2_7.InvalidId then
						table.insert(var_5_0, {
							x = var_5_8,
							y = var_5_9
						})
					end
				end
			end
		end
	end

	return var_5_0
end

function var_0_0._findTypeXY(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0 == nil then
		return nil, nil
	end

	for iter_6_0 = 1, arg_6_1 do
		for iter_6_1 = 1, arg_6_2 do
			local var_6_0 = arg_6_0[iter_6_0][iter_6_1]

			if var_6_0.id == arg_6_3 and not var_6_0:haveStatus(EliminateEnum.ChessState.Frost) and LocalEliminateChessModel.instance:getSpEffect(iter_6_0, iter_6_1) == nil and var_6_0.id ~= EliminateEnum_2_7.ChessTypeToIndex.stone then
				local var_6_1 = true

				if arg_6_4 ~= nil then
					for iter_6_2 = 1, #arg_6_4 do
						local var_6_2 = arg_6_4[iter_6_2]

						if var_6_2.x == iter_6_0 and var_6_2.y == iter_6_1 then
							var_6_1 = false

							break
						end
					end
				end

				if var_6_1 then
					return iter_6_0, iter_6_1
				end
			end
		end
	end

	return nil, nil
end

local var_0_5 = {
	8,
	7,
	6,
	8,
	7,
	6,
	8,
	7,
	6
}

function var_0_0.getFixDropId()
	if not LengZhou6Controller.instance:isNeedForceDrop() then
		return nil
	end

	return (table.remove(var_0_5, 1))
end

function var_0_0.getChessPos(arg_8_0, arg_8_1)
	local var_8_0 = (arg_8_0 - 1) * EliminateEnum_2_7.ChessWidth + EliminateEnum_2_7.ChessIntervalX * (arg_8_0 - 1)
	local var_8_1 = (arg_8_1 - 1) * EliminateEnum_2_7.ChessHeight + EliminateEnum_2_7.ChessIntervalY * (arg_8_1 - 1)

	return var_8_0, var_8_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
