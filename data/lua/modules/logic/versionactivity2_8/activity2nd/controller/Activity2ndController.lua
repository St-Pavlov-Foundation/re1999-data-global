module("modules.logic.versionactivity2_8.activity2nd.controller.Activity2ndController", package.seeall)

local var_0_0 = class("Activity2ndController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.enterActivity2ndMainView(arg_4_0)
	if ActivityHelper.isOpen(ActivityEnum.Activity.V2a8_PVPopupReward) then
		Activity101Rpc.instance:sendGet101InfosRequest(ActivityEnum.Activity.V2a8_PVPopupReward)
	end

	Activity196Rpc.instance:sendGet196InfoRequest(Activity196Enum.ActId, arg_4_0._openMainView, arg_4_0)
end

function var_0_0._openMainView(arg_5_0)
	local var_5_0 = {
		actId = Activity196Enum.ActId
	}

	ViewMgr.instance:openView(ViewName.Activity2ndCollectionPageView, var_5_0)
end

function var_0_0.trySendText(arg_6_0, arg_6_1)
	local var_6_0 = Activity2ndConfig.instance:getStrList()
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if string.upper(iter_6_1.code) == arg_6_1 then
			var_6_1 = iter_6_1.id

			break
		end
	end

	if var_6_1 ~= 0 then
		if not Activity196Model.instance:checkRewardReceied(var_6_1) then
			Activity196Rpc.instance:sendAct196GainRequest(Activity196Enum.ActId, var_6_1)

			local var_6_2 = 0
		else
			arg_6_0:dispatchEvent(Activity2ndEvent.InputErrorOrHasReward, luaLang(Activity2ndEnum.ShowTipsType.HasGetReward))
		end
	else
		arg_6_0:dispatchEvent(Activity2ndEvent.InputErrorOrHasReward, luaLang(Activity2ndEnum.ShowTipsType.Error))
	end
end

function var_0_0.statButtonClick(arg_7_0, arg_7_1)
	StatController.instance:track(StatEnum.EventName.Activity2ndPageButtonClick, {
		[StatEnum.EventProperties.ButtonName] = Activity2ndEnum.StatButtonName[arg_7_1]
	})
end

function var_0_0.statTakePhotos(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_2 and StatEnum.Result.Success or StatEnum.Result.Fail

	StatController.instance:track(StatEnum.EventName.Activity2ndTakePhotoGame, {
		[StatEnum.EventProperties.EpisodeId] = tostring(arg_8_1),
		[StatEnum.EventProperties.Result] = var_8_0
	})
end

function var_0_0.reInit(arg_9_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
