module("modules.logic.versionactivity2_5.autochess.model.AutoChessGameModel", package.seeall)

local var_0_0 = class("AutoChessGameModel", BaseModel)

function var_0_0.initTileNodes(arg_1_0, arg_1_1)
	arg_1_0.viewType = arg_1_1
	arg_1_0.tileNodes = {}

	local var_1_0 = AutoChessEnum.BoardSize.Row
	local var_1_1

	if arg_1_1 == AutoChessEnum.ViewType.All then
		var_1_1 = AutoChessEnum.BoardSize.Column * 2
	else
		var_1_1 = AutoChessEnum.BoardSize.Column
	end

	local var_1_2 = AutoChessEnum.TileOffsetX[arg_1_1]

	for iter_1_0 = 1, var_1_0 do
		local var_1_3 = AutoChessEnum.TileSize[arg_1_1][iter_1_0]
		local var_1_4 = AutoChessEnum.TileStartPos[arg_1_1][iter_1_0]

		arg_1_0.tileNodes[iter_1_0] = arg_1_0.tileNodes[iter_1_0] or {}

		for iter_1_1 = 1, var_1_1 do
			local var_1_5 = var_1_4.x + (iter_1_1 - 1) * (var_1_3.x + var_1_2)

			arg_1_0.tileNodes[iter_1_0][iter_1_1] = Vector2(var_1_5, var_1_4.y)
		end

		if arg_1_1 == AutoChessEnum.ViewType.Player then
			if not arg_1_0.tileNodes[4] then
				arg_1_0.tileNodes[4] = {}
			end

			local var_1_6 = var_1_4.x - (var_1_3.x + var_1_2)

			arg_1_0.tileNodes[4][iter_1_0] = Vector2(var_1_6, var_1_4.y)
		end
	end
end

function var_0_0.getNearestTileXY(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.tileNodes) do
		local var_2_0

		if iter_2_0 ~= 4 then
			var_2_0 = AutoChessEnum.TileSize[arg_2_0.viewType][iter_2_0]
		end

		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			var_2_0 = var_2_0 or AutoChessEnum.TileSize[arg_2_0.viewType][iter_2_2]

			local var_2_1 = math.abs(arg_2_1 - iter_2_3.x)
			local var_2_2 = math.abs(arg_2_2 - iter_2_3.y)

			if var_2_1 < var_2_0.x / 2 and var_2_2 < var_2_0.y / 2 then
				return iter_2_0, iter_2_2
			end
		end
	end
end

function var_0_0.getChessLocation(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0.tileNodes[arg_3_1]

	return var_3_0[arg_3_2] or var_3_0[arg_3_2 - 5]
end

function var_0_0.getNearestLeader(arg_4_0, arg_4_1)
	if arg_4_0.viewType == AutoChessEnum.ViewType.Player then
		local var_4_0 = arg_4_0:getLeaderLocation(AutoChessEnum.TeamType.Player)
		local var_4_1 = math.abs(arg_4_1.x - var_4_0.x)
		local var_4_2 = math.abs(arg_4_1.y - var_4_0.y)

		if var_4_1 < 55 and var_4_2 < 145 then
			return AutoChessModel.instance:getChessMo().svrFight.mySideMaster
		end
	elseif arg_4_0.viewType == AutoChessEnum.ViewType.Enemy then
		local var_4_3 = arg_4_0:getLeaderLocation(AutoChessEnum.TeamType.Enemy)
		local var_4_4 = math.abs(arg_4_1.x - var_4_3.x)
		local var_4_5 = math.abs(arg_4_1.y - var_4_3.y)

		if var_4_4 < 55 and var_4_5 < 145 then
			return AutoChessModel.instance:getChessMo().svrFight.enemyMaster
		end
	end
end

function var_0_0.getLeaderLocation(arg_5_0, arg_5_1)
	return AutoChessEnum.LeaderPos[arg_5_0.viewType][arg_5_1]
end

function var_0_0.setChessAvatar(arg_6_0, arg_6_1)
	arg_6_0.avatar = arg_6_1
end

function var_0_0.setUsingLeaderSkill(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.usingLeaderSkill = arg_7_1
	arg_7_0.targetTypes = arg_7_2

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UsingLeaderSkill, arg_7_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
