module("modules.logic.versionactivity2_5.autochess.model.AutoChessFightMO", package.seeall)

local var_0_0 = pureTable("AutoChessFightMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.round = arg_1_1.round

	arg_1_0:initWarZones(arg_1_1.warZones)

	arg_1_0.mySideMaster = var_0_0.copyMaster(arg_1_1.mySideMaster)
	arg_1_0.enemyMaster = var_0_0.copyMaster(arg_1_1.enemyMaster)
end

function var_0_0.initWarZones(arg_2_0, arg_2_1)
	arg_2_0.warZones = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = {
			id = iter_2_1.id,
			type = iter_2_1.type,
			positions = {}
		}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.positions) do
			local var_2_1 = {
				index = iter_2_3.index,
				teamType = iter_2_3.teamType,
				chess = iter_2_3.chess
			}

			table.insert(var_2_0.positions, var_2_1)
		end

		table.insert(arg_2_0.warZones, var_2_0)
	end
end

function var_0_0.copyMaster(arg_3_0)
	return {
		id = arg_3_0.id,
		teamType = arg_3_0.teamType,
		hp = arg_3_0.hp,
		uid = arg_3_0.uid,
		skill = arg_3_0.skill,
		buffContainer = arg_3_0.buffContainer
	}
end

function var_0_0.updateMasterSkill(arg_4_0, arg_4_1)
	arg_4_0.mySideMaster.skill = arg_4_1

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function var_0_0.unlockMasterSkill(arg_5_0, arg_5_1)
	if arg_5_0.mySideMaster.uid == arg_5_1 then
		arg_5_0.mySideMaster.skill.unlock = true
	elseif arg_5_0.enemyMaster.uid == arg_5_1 then
		arg_5_0.enemyMaster.skill.unlock = true
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function var_0_0.updateMaster(arg_6_0, arg_6_1)
	arg_6_0.mySideMaster = var_0_0.copyMaster(arg_6_1)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function var_0_0.hasUpgradeableChess(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.warZones) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1.positions) do
			if iter_7_3.index < AutoChessEnum.BoardSize.Column and iter_7_3.chess.id == arg_7_1 and iter_7_3.chess.maxExpLimit ~= 0 then
				return true
			end
		end
	end

	return false
end

return var_0_0
