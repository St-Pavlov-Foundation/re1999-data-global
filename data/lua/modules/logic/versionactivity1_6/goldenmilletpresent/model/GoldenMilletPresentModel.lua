module("modules.logic.versionactivity1_6.goldenmilletpresent.model.GoldenMilletPresentModel", package.seeall)

local var_0_0 = class("GoldenMilletPresentModel", BaseModel)

function var_0_0.getGoldenMilletPresentActId(arg_1_0)
	return ActivityEnum.Activity.V2a5_GoldenMilletPresent
end

function var_0_0.isGoldenMilletPresentOpen(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getGoldenMilletPresentActId()
	local var_2_1 = ActivityType101Model.instance:isOpen(var_2_0)

	if not var_2_1 and arg_2_1 then
		GameFacade.showToast(ToastEnum.BattlePass)
	end

	return var_2_1
end

function var_0_0.haveReceivedSkin(arg_3_0)
	local var_3_0 = arg_3_0:getGoldenMilletPresentActId()

	return not ActivityType101Model.instance:isType101RewardCouldGet(var_3_0, GoldenMilletEnum.REWARD_INDEX)
end

function var_0_0.isShowRedDot(arg_4_0)
	local var_4_0 = false

	if arg_4_0:isGoldenMilletPresentOpen() then
		local var_4_1 = arg_4_0:getGoldenMilletPresentActId()

		var_4_0 = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_4_1)
	end

	return var_4_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
