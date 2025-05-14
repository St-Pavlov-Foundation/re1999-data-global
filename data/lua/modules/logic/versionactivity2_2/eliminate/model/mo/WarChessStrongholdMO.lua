module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessStrongholdMO", package.seeall)

local var_0_0 = class("WarChessStrongholdMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.mySidePiece = {}
	arg_1_0.enemySidePiece = {}

	arg_1_0:updateInfo(arg_1_1)
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.myScore = arg_2_1.myScore or 0
	arg_2_0.enemyScore = arg_2_1.enemyScore or 0
	arg_2_0.status = arg_2_1.status

	if arg_2_1.mySidePiece then
		arg_2_0.mySidePiece = GameUtil.rpcInfosToList(arg_2_1.mySidePiece, WarChessPieceMO)
	end

	if arg_2_1.enemySidePiece then
		arg_2_0.enemySidePiece = GameUtil.rpcInfosToList(arg_2_1.enemySidePiece, WarChessPieceMO)
	end
end

function var_0_0.updatePiece(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		local var_3_0 = WarChessPieceMO.New()

		var_3_0:init(arg_3_2)
		table.insert(arg_3_0.enemySidePiece, var_3_0)

		return #arg_3_0.enemySidePiece
	end

	if arg_3_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		local var_3_1 = WarChessPieceMO.New()

		var_3_1:init(arg_3_2)
		table.insert(arg_3_0.mySidePiece, var_3_1)

		return #arg_3_0.mySidePiece
	end
end

function var_0_0.addTempPiece(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = EliminateConfig.instance:getSoldierChessConfig(arg_4_2)
	local var_4_1 = WarChessPieceMO.New()

	var_4_1.id = arg_4_2
	var_4_1.teamType = arg_4_1
	var_4_1.battle = var_4_0.defaultPower
	var_4_1.uid = EliminateTeamChessEnum.tempPieceUid

	if arg_4_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		table.insert(arg_4_0.enemySidePiece, var_4_1)

		return var_4_1, #arg_4_0.enemySidePiece
	end

	if arg_4_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		table.insert(arg_4_0.mySidePiece, var_4_1)

		return var_4_1, #arg_4_0.mySidePiece
	end
end

function var_0_0.updateChessPower(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.mySidePiece then
		for iter_5_0 = 1, #arg_5_0.mySidePiece do
			local var_5_0 = arg_5_0.mySidePiece[iter_5_0]

			if var_5_0.uid == arg_5_1 then
				var_5_0:updatePower(arg_5_2)

				return true
			end
		end
	end

	if arg_5_0.enemySidePiece then
		for iter_5_1 = 1, #arg_5_0.enemySidePiece do
			local var_5_1 = arg_5_0.enemySidePiece[iter_5_1]

			if var_5_1.uid == arg_5_1 then
				var_5_1:updatePower(arg_5_2)

				return true
			end
		end
	end

	return false
end

function var_0_0.updateSkillGrowUp(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0.mySidePiece then
		for iter_6_0 = 1, #arg_6_0.mySidePiece do
			local var_6_0 = arg_6_0.mySidePiece[iter_6_0]

			if var_6_0.uid == arg_6_1 and var_6_0:updateSkillGrowUp(arg_6_2, arg_6_3) then
				return true
			end
		end
	end

	if arg_6_0.enemySidePiece then
		for iter_6_1 = 1, #arg_6_0.enemySidePiece do
			local var_6_1 = arg_6_0.enemySidePiece[iter_6_1]

			if var_6_1.uid == arg_6_1 and var_6_1:updateSkillGrowUp(arg_6_2, arg_6_3) then
				return true
			end
		end
	end

	return false
end

function var_0_0.updateDisplacementState(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.mySidePiece then
		for iter_7_0 = 1, #arg_7_0.mySidePiece do
			local var_7_0 = arg_7_0.mySidePiece[iter_7_0]

			if var_7_0.uid == arg_7_1 then
				var_7_0:updateDisplacementState(arg_7_2)

				return true
			end
		end
	end

	if arg_7_0.enemySidePiece then
		for iter_7_1 = 1, #arg_7_0.enemySidePiece do
			local var_7_1 = arg_7_0.enemySidePiece[iter_7_1]

			if var_7_1.uid == arg_7_1 then
				var_7_1:updateDisplacementState(arg_7_2)

				return true
			end
		end
	end

	return false
end

function var_0_0.updateScore(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		arg_8_0.myScore = math.max(arg_8_0.myScore + arg_8_2, 0)
	end

	if arg_8_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		arg_8_0.enemyScore = math.max(arg_8_0.enemyScore + arg_8_2, 0)
	end
end

function var_0_0.updateStatus(arg_9_0, arg_9_1)
	arg_9_0.status = arg_9_1
end

function var_0_0.getChess(arg_10_0, arg_10_1)
	for iter_10_0 = 1, #arg_10_0.mySidePiece do
		local var_10_0 = arg_10_0.mySidePiece[iter_10_0]

		if var_10_0.uid == arg_10_1 then
			return var_10_0
		end
	end

	for iter_10_1 = 1, #arg_10_0.enemySidePiece do
		local var_10_1 = arg_10_0.enemySidePiece[iter_10_1]

		if var_10_1.uid == arg_10_1 then
			return var_10_1
		end
	end

	return nil
end

function var_0_0.removeChess(arg_11_0, arg_11_1)
	for iter_11_0 = 1, #arg_11_0.mySidePiece do
		if arg_11_0.mySidePiece[iter_11_0].uid == arg_11_1 then
			table.remove(arg_11_0.mySidePiece, iter_11_0)

			return
		end
	end

	for iter_11_1 = 1, #arg_11_0.enemySidePiece do
		if arg_11_0.enemySidePiece[iter_11_1].uid == arg_11_1 then
			table.remove(arg_11_0.enemySidePiece, iter_11_1)

			return
		end
	end
end

function var_0_0.getPlayerSoliderCount(arg_12_0)
	return arg_12_0.mySidePiece and #arg_12_0.mySidePiece or 0
end

function var_0_0.getEnemySoliderCount(arg_13_0)
	return arg_13_0.enemySidePiece and #arg_13_0.enemySidePiece or 0
end

function var_0_0.isFull(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getStrongholdConfig()

	if arg_14_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		return var_14_0.friendCapacity == #arg_14_0.mySidePiece
	end

	if arg_14_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		return var_14_0.enemyCapacity == #arg_14_0.enemySidePiece
	end
end

function var_0_0.diffData(arg_15_0, arg_15_1)
	local var_15_0 = true

	if arg_15_0.id ~= arg_15_1.id then
		var_15_0 = false
	end

	if arg_15_0.myScore ~= arg_15_1.myScore then
		var_15_0 = false
	end

	if arg_15_0.enemyScore ~= arg_15_1.enemyScore then
		var_15_0 = false
	end

	if arg_15_0.status ~= arg_15_1.status then
		var_15_0 = false
	end

	if arg_15_0.mySidePiece and arg_15_1.mySidePiece then
		for iter_15_0 = 1, #arg_15_0.mySidePiece do
			if not arg_15_0.mySidePiece[iter_15_0]:diffData(arg_15_1.mySidePiece[iter_15_0]) then
				var_15_0 = false
			end
		end
	end

	if arg_15_0.enemySidePiece and arg_15_1.enemySidePiece then
		for iter_15_1 = 1, #arg_15_0.enemySidePiece do
			if not arg_15_0.enemySidePiece[iter_15_1]:diffData(arg_15_1.enemySidePiece[iter_15_1]) then
				var_15_0 = false
			end
		end
	end

	return var_15_0
end

function var_0_0.getStrongholdConfig(arg_16_0)
	if arg_16_0.config == nil then
		arg_16_0.config = EliminateConfig.instance:getStrongHoldConfig(arg_16_0.id)
	end

	return arg_16_0.config
end

function var_0_0.getMySideIndexByUid(arg_17_0, arg_17_1)
	if arg_17_0.mySidePiece then
		for iter_17_0 = 1, #arg_17_0.mySidePiece do
			if arg_17_0.mySidePiece[iter_17_0].uid == arg_17_1 then
				return iter_17_0
			end
		end
	end

	return -1
end

function var_0_0.getEnemySideIndexByUid(arg_18_0, arg_18_1)
	if arg_18_0.enemySidePiece then
		for iter_18_0 = 1, #arg_18_0.enemySidePiece do
			if arg_18_0.enemySidePiece[iter_18_0].uid == arg_18_1 then
				return iter_18_0
			end
		end
	end

	return -1
end

function var_0_0.getEnemySideByUid(arg_19_0, arg_19_1)
	if arg_19_0.enemySidePiece then
		for iter_19_0 = 1, #arg_19_0.enemySidePiece do
			local var_19_0 = arg_19_0.enemySidePiece[iter_19_0]

			if var_19_0.uid == arg_19_1 then
				return var_19_0
			end
		end
	end

	return nil
end

function var_0_0.getMySideByUid(arg_20_0, arg_20_1)
	if arg_20_0.mySidePiece then
		for iter_20_0 = 1, #arg_20_0.mySidePiece do
			local var_20_0 = arg_20_0.mySidePiece[iter_20_0]

			if var_20_0.uid == arg_20_1 then
				return var_20_0
			end
		end
	end

	return nil
end

return var_0_0
