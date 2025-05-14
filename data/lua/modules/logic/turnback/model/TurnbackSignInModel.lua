module("modules.logic.turnback.model.TurnbackSignInModel", package.seeall)

local var_0_0 = class("TurnbackSignInModel", ListScrollModel)

function var_0_0.OnInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.signInInfoMoList = {}
end

function var_0_0.setSignInInfoList(arg_3_0, arg_3_1)
	arg_3_0.signInInfoMoList = {}

	local var_3_0 = TurnbackModel.instance:getCurTurnbackId()

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_1 = TurnbackSignInInfoMo.New()

		var_3_1:init(arg_3_1[iter_3_0], var_3_0)
		table.insert(arg_3_0.signInInfoMoList, var_3_1)
	end

	table.sort(arg_3_0.signInInfoMoList, function(arg_4_0, arg_4_1)
		return arg_4_0.id < arg_4_1.id
	end)
	arg_3_0:setSignInList()
end

function var_0_0.getSignInInfoMoList(arg_5_0)
	return arg_5_0.signInInfoMoList
end

function var_0_0.getSignInStateById(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.signInInfoMoList[arg_6_1]

	if var_6_0 then
		return var_6_0.state
	end
end

function var_0_0.setSignInList(arg_7_0)
	if GameUtil.getTabLen(arg_7_0.signInInfoMoList) > 0 then
		arg_7_0:setList(arg_7_0.signInInfoMoList)
	end
end

function var_0_0.updateSignInInfoState(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.signInInfoMoList) do
		if iter_8_1.id == arg_8_1 then
			iter_8_1:updateState(arg_8_2)

			break
		end
	end

	arg_8_0:setList(arg_8_0.signInInfoMoList)
end

function var_0_0.getTheFirstCanGetIndex(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.signInInfoMoList) do
		if iter_9_1.state == TurnbackEnum.SignInState.CanGet then
			return iter_9_0
		end
	end

	return 0
end

function var_0_0.setOpenTimeStamp(arg_10_0)
	arg_10_0.startTimeStamp = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.getOpenTimeStamp(arg_11_0)
	return arg_11_0.startTimeStamp
end

var_0_0.instance = var_0_0.New()

return var_0_0
