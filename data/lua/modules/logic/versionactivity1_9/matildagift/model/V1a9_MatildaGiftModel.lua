module("modules.logic.versionactivity1_9.matildagift.model.V1a9_MatildaGiftModel", package.seeall)

local var_0_0 = class("V1a9_MatildaGiftModel", BaseModel)

function var_0_0.getMatildagiftActId(arg_1_0)
	return ActivityEnum.Activity.V2a8_Matildagift
end

function var_0_0.isMatildaGiftOpen(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getMatildagiftActId()
	local var_2_1 = ActivityType101Model.instance:isOpen(var_2_0)

	if not var_2_1 and arg_2_1 then
		GameFacade.showToast(ToastEnum.BattlePass)
	end

	return var_2_1
end

function var_0_0.isShowRedDot(arg_3_0)
	local var_3_0 = false

	if arg_3_0:isMatildaGiftOpen() then
		local var_3_1 = arg_3_0:getMatildagiftActId()

		var_3_0 = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_3_1)
	end

	return var_3_0
end

function var_0_0.couldGet(arg_4_0)
	local var_4_0 = arg_4_0:getMatildagiftActId()

	return (ActivityType101Model.instance:isType101RewardCouldGet(var_4_0, 1))
end

function var_0_0.onGetBonus(arg_5_0)
	if arg_5_0:couldGet() then
		local var_5_0 = arg_5_0:getMatildagiftActId()

		Activity101Rpc.instance:sendGet101BonusRequest(var_5_0, 1)
	else
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
