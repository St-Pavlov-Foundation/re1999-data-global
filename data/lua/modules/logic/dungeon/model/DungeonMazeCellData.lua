module("modules.logic.dungeon.model.DungeonMazeCellData", package.seeall)

local var_0_0 = pureTable("DungeonMazeCellData")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.x = arg_1_1
	arg_1_0.y = arg_1_2
	arg_1_0.cellId = 0
	arg_1_0.value = 0
	arg_1_0.connectSet = {}
	arg_1_0.entryConnect = {}
	arg_1_0.entryCount = 0
	arg_1_0.diagueId = 0
	arg_1_0.obstacleDialog = ""
	arg_1_0.obstacleToggled = false
	arg_1_0.eventId = 0
	arg_1_0.eventToggled = false
	arg_1_0.pass = false
end

local var_0_1 = {}

function var_0_0.getConnectValue(arg_2_0)
	local var_2_0 = 0
	local var_2_1 = 0

	if arg_2_0.entryConnect then
		for iter_2_0, iter_2_1 in pairs(arg_2_0.entryConnect) do
			table.insert(var_0_1, iter_2_0)

			var_2_0 = var_2_0 + 1
		end

		table.sort(var_0_1)

		for iter_2_2, iter_2_3 in ipairs(var_0_1) do
			var_2_1 = var_2_1 * 10 + iter_2_3
		end

		for iter_2_4 = 1, var_2_0 do
			var_0_1[iter_2_4] = nil
		end
	end

	return var_2_1
end

function var_0_0.getDirectionTo(arg_3_0, arg_3_1)
	if arg_3_1.x == arg_3_0.x then
		if arg_3_1.y > arg_3_0.y then
			return DungeonMazeEnum.dir.right
		else
			return DungeonMazeEnum.dir.left
		end
	elseif arg_3_1.y == arg_3_0.y then
		if arg_3_1.x > arg_3_0.x then
			return DungeonMazeEnum.dir.down
		else
			return DungeonMazeEnum.dir.up
		end
	end

	return nil
end

function var_0_0.cleanEntrySet(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.entryConnect) do
		arg_4_0.entryConnect[iter_4_0] = nil
	end

	arg_4_0.entryCount = 0
end

return var_0_0
