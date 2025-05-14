module("modules.logic.permanent.controller.PermanentController", package.seeall)

local var_0_0 = class("PermanentController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.enterActivity(arg_3_0, arg_3_1)
	local var_3_0 = PlayerModel.instance:getMyUserId()
	local var_3_1 = ActivityConfig.instance:getActivityCo(arg_3_1)
	local var_3_2 = "PermanentStoryRecord" .. var_3_1.storyId .. var_3_0

	if PlayerPrefsHelper.getNumber(var_3_2, 0) == 0 then
		StoryController.instance:playStory(var_3_1.storyId, nil, arg_3_0.storyCallback, arg_3_0, {
			_actId = arg_3_1
		})
		PlayerPrefsHelper.setNumber(var_3_2, 1)
	else
		arg_3_0:storyCallback({
			_actId = arg_3_1
		})
	end
end

function var_0_0.storyCallback(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1._actId
	local var_4_1 = PermanentConfig.instance:getPermanentCO(var_4_0)

	if var_4_1 then
		ViewMgr.instance:openView(ViewName[var_4_1.enterview])
	end
end

function var_0_0.jump2Activity(arg_5_0, arg_5_1)
	local var_5_0 = PermanentConfig.instance:getPermanentCO(arg_5_1)

	if var_5_0 then
		DungeonController.instance:openDungeonView()
		ViewMgr.instance:openView(ViewName[var_5_0.enterview])
	end
end

function var_0_0.unlockPermanent(arg_6_0, arg_6_1)
	ActivityRpc.instance:sendUnlockPermanentRequest(arg_6_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
