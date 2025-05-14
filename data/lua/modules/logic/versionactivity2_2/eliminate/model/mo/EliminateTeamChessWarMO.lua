module("modules.logic.versionactivity2_2.eliminate.model.mo.EliminateTeamChessWarMO", package.seeall)

local var_0_0 = class("EliminateTeamChessWarMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.myCharacter = WarChessCharacterMO.New()
	arg_1_0.enemyCharacter = WarChessCharacterMO.New()
	arg_1_0.strongholds = {}
	arg_1_0.winCondition = arg_1_1.winCondition
	arg_1_0.extraWinCondition = arg_1_1.extraWinCondition

	arg_1_0.myCharacter:init(arg_1_1.myCharacter)
	arg_1_0.enemyCharacter:init(arg_1_1.enemyCharacter)
	arg_1_0:updateInfo(arg_1_1)
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0.round = arg_2_1.round

	arg_2_0.myCharacter:updateInfo(arg_2_1.myCharacter)
	arg_2_0.enemyCharacter:updateInfo(arg_2_1.enemyCharacter)

	if arg_2_1.stronghold then
		tabletool.clear(arg_2_0.strongholds)

		arg_2_0.strongholds = GameUtil.rpcInfosToList(arg_2_1.stronghold, WarChessStrongholdMO)

		table.sort(arg_2_0.strongholds, function(arg_3_0, arg_3_1)
			return arg_3_0.id < arg_3_1.id
		end)
	end

	arg_2_0.winCondition = arg_2_1.winCondition
	arg_2_0.extraWinCondition = arg_2_1.extraWinCondition

	arg_2_0:updateStar()
end

function var_0_0.updateCondition(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.winCondition ~= arg_4_1 or arg_4_0.extraWinCondition ~= arg_4_2

	arg_4_0.winCondition = arg_4_1
	arg_4_0.extraWinCondition = arg_4_2

	arg_4_0:updateStar()

	return var_4_0
end

function var_0_0.updateStar(arg_5_0)
	local var_5_0 = 0

	if arg_5_0:winConditionIsFinish() then
		var_5_0 = var_5_0 + 1
	end

	if arg_5_0:extraWinConditionIsFinish() then
		var_5_0 = var_5_0 + 1
	end

	EliminateLevelModel.instance:setStar(var_5_0)
end

function var_0_0.updateForecastBehavior(arg_6_0, arg_6_1)
	arg_6_0.enemyCharacter:updateForecastBehavior(arg_6_1)
end

function var_0_0.getSlotIds(arg_7_0)
	return arg_7_0.myCharacter.slotIds
end

function var_0_0.getStrongholds(arg_8_0)
	return arg_8_0.strongholds
end

function var_0_0.getStronghold(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.strongholds) do
		if iter_9_1.id == arg_9_1 then
			return iter_9_1
		end
	end

	return nil
end

function var_0_0.updateChessPower(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.strongholds then
		for iter_10_0 = 1, #arg_10_0.strongholds do
			if arg_10_0.strongholds[iter_10_0]:updateChessPower(arg_10_1, arg_10_2) then
				return
			end
		end
	end
end

function var_0_0.updateSkillGrowUp(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0.strongholds then
		for iter_11_0 = 1, #arg_11_0.strongholds do
			if arg_11_0.strongholds[iter_11_0]:updateSkillGrowUp(arg_11_1, arg_11_2, arg_11_3) then
				return
			end
		end
	end
end

function var_0_0.updateDisplacementState(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.strongholds then
		for iter_12_0 = 1, #arg_12_0.strongholds do
			if arg_12_0.strongholds[iter_12_0]:updateDisplacementState(arg_12_1, arg_12_2) then
				return
			end
		end
	end
end

function var_0_0.updateStrongholdsScore(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if arg_13_0.strongholds then
		for iter_13_0 = 1, #arg_13_0.strongholds do
			local var_13_0 = arg_13_0.strongholds[iter_13_0]

			if var_13_0.id == arg_13_1 then
				var_13_0:updateScore(arg_13_2, arg_13_3)

				return
			end
		end
	end
end

function var_0_0.updateMainCharacterHp(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		arg_14_0.myCharacter:updateHp(arg_14_2)
	end

	if arg_14_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		arg_14_0.enemyCharacter:updateHp(arg_14_2)
	end
end

function var_0_0.updateMainCharacterPower(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == EliminateTeamChessEnum.TeamChessTeamType.player then
		arg_15_0.myCharacter:updatePower(arg_15_2)
	end

	if arg_15_1 == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		arg_15_0.enemyCharacter:updatePower(arg_15_2)
	end
end

function var_0_0.updateResourceData(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0.myCharacter then
		arg_16_0.myCharacter:updateDiamondInfo(arg_16_1, arg_16_2)
	end
end

function var_0_0.removeStrongholdChess(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.strongholds then
		for iter_17_0 = 1, #arg_17_0.strongholds do
			local var_17_0 = arg_17_0.strongholds[iter_17_0]

			if var_17_0.id == arg_17_1 then
				var_17_0:removeChess(arg_17_2)

				return
			end
		end
	end
end

function var_0_0.getChess(arg_18_0, arg_18_1)
	if arg_18_0.strongholds then
		for iter_18_0 = 1, #arg_18_0.strongholds do
			local var_18_0 = arg_18_0.strongholds[iter_18_0]:getChess(arg_18_1)

			if var_18_0 then
				return var_18_0
			end
		end
	end

	return nil
end

function var_0_0.strongHoldSettle(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0.strongholds then
		for iter_19_0 = 1, #arg_19_0.strongholds do
			local var_19_0 = arg_19_0.strongholds[iter_19_0]

			if var_19_0.id == arg_19_1 then
				var_19_0:updateStatus(arg_19_2)

				return
			end
		end
	end
end

function var_0_0.diamondsIsEnough(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.myCharacter then
		return false
	end

	return arg_20_0.myCharacter:diamondsIsEnough(arg_20_1, arg_20_2)
end

function var_0_0.winConditionIsFinish(arg_21_0)
	return arg_21_0.winCondition == 1
end

function var_0_0.extraWinConditionIsFinish(arg_22_0)
	return arg_22_0.extraWinCondition == 1
end

function var_0_0.diffTeamChess(arg_23_0, arg_23_1)
	local var_23_0 = true

	if arg_23_0.id ~= arg_23_1.id then
		var_23_0 = false
	end

	if not arg_23_0.myCharacter:diffData(arg_23_1.myCharacter) then
		var_23_0 = false
	end

	if not arg_23_0.enemyCharacter:diffData(arg_23_1.enemyCharacter) then
		var_23_0 = false
	end

	if #arg_23_0.strongholds ~= #arg_23_1.strongholds then
		var_23_0 = false
	end

	if arg_23_0.round ~= arg_23_1.round then
		var_23_0 = false
	end

	for iter_23_0 = 1, #arg_23_0.strongholds do
		local var_23_1 = arg_23_0.strongholds[iter_23_0]
		local var_23_2 = arg_23_1:getStronghold(var_23_1.id)

		if not var_23_1:diffData(var_23_2) then
			var_23_0 = false
		end
	end

	return var_23_0
end

return var_0_0
