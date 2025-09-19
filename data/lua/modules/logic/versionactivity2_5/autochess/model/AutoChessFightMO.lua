module("modules.logic.versionactivity2_5.autochess.model.AutoChessFightMO", package.seeall)

local var_0_0 = pureTable("AutoChessFightMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.round = arg_1_1.round

	arg_1_0:initWarZones(arg_1_1.warZones)

	arg_1_0.unwarZone = var_0_0.buildWarZone(arg_1_1.unwarZones[1])
	arg_1_0.mySideMaster = var_0_0.copyMaster(arg_1_1.mySideMaster)
	arg_1_0.enemyMaster = var_0_0.copyMaster(arg_1_1.enemyMaster)
end

function var_0_0.initWarZones(arg_2_0, arg_2_1)
	arg_2_0.warZones = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(arg_2_0.warZones, var_0_0.buildWarZone(iter_2_1))
	end
end

function var_0_0.buildWarZone(arg_3_0)
	if not arg_3_0 then
		return
	end

	local var_3_0 = {
		id = arg_3_0.id,
		type = arg_3_0.type,
		positions = {}
	}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.positions) do
		local var_3_1 = {
			index = iter_3_1.index,
			teamType = iter_3_1.teamType,
			chess = iter_3_1.chess
		}

		table.insert(var_3_0.positions, var_3_1)
	end

	return var_3_0
end

function var_0_0.copyMaster(arg_4_0)
	return {
		id = arg_4_0.id,
		teamType = arg_4_0.teamType,
		hp = arg_4_0.hp,
		uid = arg_4_0.uid,
		skill = arg_4_0.skill,
		buffContainer = arg_4_0.buffContainer
	}
end

function var_0_0.updateMasterSkill(arg_5_0, arg_5_1)
	arg_5_0.mySideMaster.skill = arg_5_1

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function var_0_0.unlockMasterSkill(arg_6_0, arg_6_1)
	if arg_6_0.mySideMaster.uid == arg_6_1 then
		arg_6_0.mySideMaster.skill.unlock = true
	elseif arg_6_0.enemyMaster.uid == arg_6_1 then
		arg_6_0.enemyMaster.skill.unlock = true
	end

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function var_0_0.updateMaster(arg_7_0, arg_7_1)
	arg_7_0.mySideMaster = var_0_0.copyMaster(arg_7_1)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMasterSkill)
end

function var_0_0.hasUpgradeableChess(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.warZones) do
		for iter_8_2, iter_8_3 in ipairs(iter_8_1.positions) do
			if iter_8_3.index < AutoChessEnum.BoardSize.Column and iter_8_3.chess.id == arg_8_1 and iter_8_3.chess.maxExpLimit ~= 0 then
				return true
			end
		end
	end

	return false
end

return var_0_0
