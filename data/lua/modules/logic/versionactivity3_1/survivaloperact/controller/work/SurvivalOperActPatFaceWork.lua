module("modules.logic.versionactivity3_1.survivaloperact.controller.work.SurvivalOperActPatFaceWork", package.seeall)

local var_0_0 = class("SurvivalOperActPatFaceWork", Activity101SignPatFaceWork)

function var_0_0.checkCanPat(arg_1_0)
	local var_1_0 = arg_1_0:_actId()

	if not ActivityType101Model.instance:isOpen(var_1_0) then
		return false
	end

	local var_1_1 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SurvivalOperActPat)

	if PlayerPrefsHelper.getNumber(var_1_1, 0) ~= 0 then
		return false
	end

	if arg_1_0:isType101RewardCouldGetAnyOne() then
		PlayerPrefsHelper.setNumber(var_1_1, 1)

		return false
	end

	PlayerPrefsHelper.setNumber(var_1_1, 1)

	return true
end

return var_0_0
