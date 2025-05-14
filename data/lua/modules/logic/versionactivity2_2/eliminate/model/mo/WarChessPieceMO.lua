module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessPieceMO", package.seeall)

local var_0_0 = class("WarChessPieceMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.id = arg_1_1.id
	arg_1_0.battle = arg_1_1.battle
	arg_1_0.teamType = arg_1_1.teamType
	arg_1_0.displacementState = arg_1_1.displacementState

	if arg_1_1.skill then
		arg_1_0.skill = GameUtil.rpcInfosToList(arg_1_1.skill, WarChessPieceSkillMO)
	end
end

function var_0_0.updatePower(arg_2_0, arg_2_1)
	arg_2_0.battle = math.max(arg_2_0.battle + arg_2_1, 0)
end

function var_0_0.updateDisplacementState(arg_3_0, arg_3_1)
	arg_3_0.displacementState = arg_3_1
end

function var_0_0.canActiveMove(arg_4_0)
	if arg_4_0.displacementState then
		local var_4_0 = EliminateLevelModel.instance:getRoundNumber()
		local var_4_1 = arg_4_0.displacementState.totalUseCountLimit
		local var_4_2 = arg_4_0.displacementState.totalUseCount
		local var_4_3 = arg_4_0.displacementState.effectRound
		local var_4_4 = 0

		if arg_4_0.displacementState.roundUseCount then
			for iter_4_0, iter_4_1 in ipairs(arg_4_0.displacementState.roundUseCount) do
				if iter_4_1.round == var_4_0 then
					var_4_4 = iter_4_1.count
				end
			end
		end

		local var_4_5 = arg_4_0.displacementState.perRoundUseCountLimit

		if var_4_3 <= var_4_0 and var_4_4 < var_4_5 and var_4_2 < var_4_1 then
			return true
		end
	end

	return false
end

function var_0_0.getDisplacementState(arg_5_0)
	return arg_5_0.displacementState
end

function var_0_0.updateSkillGrowUp(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0.skill == nil then
		return false
	end

	for iter_6_0 = 1, #arg_6_0.skill do
		local var_6_0 = arg_6_0.skill[iter_6_0]

		if var_6_0.id == arg_6_1 then
			var_6_0:updateSkillGrowUp(arg_6_2)

			return true
		end
	end

	return false
end

function var_0_0.getSkill(arg_7_0, arg_7_1)
	if arg_7_0.skill == nil then
		return nil
	end

	for iter_7_0 = 1, #arg_7_0.skill do
		local var_7_0 = arg_7_0.skill[iter_7_0]

		if var_7_0.id == arg_7_1 then
			return var_7_0
		end
	end

	return nil
end

function var_0_0.getActiveSkill(arg_8_0)
	if arg_8_0.skill ~= nil and #arg_8_0.skill > 0 then
		return arg_8_0.skill[1]
	end
end

function var_0_0.diffData(arg_9_0, arg_9_1)
	local var_9_0 = true

	if arg_9_0.battle ~= arg_9_1.battle then
		var_9_0 = false
	end

	if arg_9_0.teamType ~= arg_9_1.teamType then
		var_9_0 = false
	end

	if arg_9_0.uid ~= arg_9_1.uid then
		var_9_0 = false
	end

	if arg_9_0.id ~= arg_9_1.id then
		var_9_0 = false
	end

	return var_9_0
end

return var_0_0
