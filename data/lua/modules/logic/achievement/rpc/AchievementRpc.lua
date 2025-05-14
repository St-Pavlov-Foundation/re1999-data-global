module("modules.logic.achievement.rpc.AchievementRpc", package.seeall)

local var_0_0 = class("AchievementRpc", BaseRpc)

function var_0_0.sendGetAchievementInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = AchievementModule_pb.GetAchievementInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetAchievementInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		AchievementModel.instance:initDatas(arg_2_2.infos)
		AchievementController.instance:onUpdateAchievements()
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

function var_0_0.onReceiveUpdateAchievementPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		AchievementModel.instance:updateDatas(arg_3_2.infos)
		AchievementToastModel.instance:updateNeedPushToast(arg_3_2.infos)
		AchievementController.instance:onUpdateAchievements()
		AchievementToastController.instance:onUpdateAchievements()
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

function var_0_0.sendShowAchievementRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = AchievementModule_pb.ShowAchievementRequest()

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		var_4_0.ids:append(iter_4_1)
	end

	var_4_0.groupId = arg_4_2

	return arg_4_0:sendMsg(var_4_0, arg_4_3, arg_4_4)
end

function var_0_0.onReceiveShowAchievementReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		GameFacade.showToast(ToastEnum.AchievementSaveSucc)
		AchievementController.instance:dispatchEvent(AchievementEvent.AchievementSaveSucc)
		AchievementStatController.instance:onSaveDisplayAchievementsSucc()
	end
end

function var_0_0.sendReadNewAchievementRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = AchievementModule_pb.ReadNewAchievementRequest()

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		var_6_0.ids:append(iter_6_1)
	end

	return arg_6_0:sendMsg(var_6_0, arg_6_2, arg_6_3)
end

function var_0_0.onReceiveReadNewAchievementReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 and AchievementModel.instance:cleanAchievementNew(arg_7_2.ids) then
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
