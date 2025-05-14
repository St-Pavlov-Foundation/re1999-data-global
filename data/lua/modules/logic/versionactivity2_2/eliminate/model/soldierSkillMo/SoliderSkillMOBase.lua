module("modules.logic.versionactivity2_2.eliminate.model.soldierSkillMo.SoliderSkillMOBase", package.seeall)

local var_0_0 = class("SoliderSkillMOBase")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._soldierId = arg_1_1
	arg_1_0._uid = arg_1_2
	arg_1_0._strongholdId = arg_1_3
	arg_1_0._selectSoliderIds = {}

	arg_1_0:initSkill()
end

function var_0_0.initSkill(arg_2_0)
	local var_2_0, var_2_1, var_2_2 = EliminateTeamChessModel.instance:getSoliderIdEffectParam(arg_2_0._soldierId)

	if var_2_0 ~= nil then
		arg_2_0._needSelectSoliderCount = var_2_1
		arg_2_0._needSelectSoliderType = var_2_0
		arg_2_0._needSelectSoliderCount = EliminateTeamChessModel.instance:haveSoliderByTeamTypeAndStrongholdId(arg_2_0._needSelectSoliderType, var_2_2 and arg_2_0._strongholdId or nil) and arg_2_0._needSelectSoliderCount or 0
	else
		arg_2_0._needSelectSoliderCount = 0
	end
end

function var_0_0.setSelectSoliderId(arg_3_0, arg_3_1)
	if arg_3_0:canRelease() then
		return true
	end

	local var_3_0 = tonumber(arg_3_1)

	if var_3_0 == EliminateTeamChessEnum.tempPieceUid then
		return false
	end

	local var_3_1 = EliminateTeamChessEnum.TeamChessTeamType.player
	local var_3_2 = EliminateTeamChessEnum.TeamChessTeamType.enemy

	if var_3_0 > 0 and arg_3_0._needSelectSoliderType == var_3_1 or var_3_0 < 0 and arg_3_0._needSelectSoliderType == var_3_2 then
		table.insert(arg_3_0._selectSoliderIds, arg_3_1)

		return true
	end

	return false
end

function var_0_0.getNeedSelectSoliderType(arg_4_0)
	return arg_4_0._needSelectSoliderType
end

function var_0_0.canRelease(arg_5_0)
	if arg_5_0._needSelectSoliderCount then
		return #arg_5_0._selectSoliderIds >= arg_5_0._needSelectSoliderCount
	end

	return true
end

function var_0_0._getReleaseExParam(arg_6_0)
	if arg_6_0._selectSoliderIds and #arg_6_0._selectSoliderIds > 0 then
		return arg_6_0._selectSoliderIds[1]
	end

	return ""
end

function var_0_0.needClearTemp(arg_7_0)
	return arg_7_0._needSelectSoliderCount > 0
end

function var_0_0.releaseSkill(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0:canRelease() then
		local var_8_0 = arg_8_0:_getReleaseExParam()

		EliminateTeamChessController.instance:sendWarChessPiecePlaceRequest(arg_8_0._soldierId, arg_8_0._uid, arg_8_0._strongholdId, var_8_0, arg_8_1, arg_8_2)
	end

	return arg_8_0:canRelease()
end

return var_0_0
