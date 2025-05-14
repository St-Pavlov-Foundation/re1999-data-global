module("modules.logic.versionactivity1_3.act126.rpc.Activity126Rpc", package.seeall)

local var_0_0 = class("Activity126Rpc", BaseRpc)

function var_0_0.sendGet126InfosRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity126Module_pb.Get126InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGet126InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity126Model.instance:updateInfo(arg_2_2)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onGet126InfosReply)
end

function var_0_0.sendUpdateProgressRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity126Module_pb.UpdateProgressRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.progressStr = arg_3_2

	for iter_3_0, iter_3_1 in ipairs(arg_3_3) do
		table.insert(var_3_0.activeStarId, iter_3_1)
	end

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveUpdateProgressReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity126Model.instance:updateStarProgress(arg_4_2)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUpdateProgressReply)
end

function var_0_0.sendResetProgressRequest(arg_5_0, arg_5_1)
	local var_5_0 = Activity126Module_pb.ResetProgressRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveResetProgressReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	Activity126Controller.instance:dispatchEvent(Activity126Event.onBeforeResetProgressReply)
	Activity126Model.instance:updateStarProgress(arg_6_2)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUpdateProgressReply, {
		fromReset = true
	})
	Activity126Controller.instance:dispatchEvent(Activity126Event.onResetProgressReply)
end

function var_0_0.sendGetProgressRewardRequest(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = Activity126Module_pb.GetProgressRewardRequest()

	var_7_0.activityId = arg_7_1
	var_7_0.getRewardId = arg_7_2

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveGetProgressRewardReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	Activity126Model.instance:updateGetProgressBonus(arg_8_2)
end

function var_0_0.sendHoroscopeRequest(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Activity126Module_pb.HoroscopeRequest()

	var_9_0.activityId = arg_9_1
	var_9_0.id = arg_9_2

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveHoroscopeReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.horoscope

	Activity126Model.instance:updateHoroscope(var_10_0)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onHoroscopeReply)
end

function var_0_0.sendGetHoroscopeRequest(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = Activity126Module_pb.GetHoroscopeRequest()

	var_11_0.activityId = arg_11_1
	var_11_0.id = arg_11_2

	arg_11_0:sendMsg(var_11_0)
end

function var_0_0.onReceiveGetHoroscopeReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.getHoroscope

	Activity126Model.instance:updateGetHoroscope(var_12_0)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onGetHoroscopeReply)
end

function var_0_0.sendUnlockBuffRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = Activity126Module_pb.UnlockBuffRequest()

	var_13_0.activityId = arg_13_1
	var_13_0.unlockId = arg_13_2

	arg_13_0:sendMsg(var_13_0)
end

function var_0_0.onReceiveUnlockBuffReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	Stat1_3Controller.instance:trackUnlockBuff(arg_14_2)
	Activity126Model.instance:updateBuffInfo(arg_14_2)
	Activity126Controller.instance:dispatchEvent(Activity126Event.onUnlockBuffReply)
end

function var_0_0.onReceiveAct126InfoUpdatePush(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	Activity126Model.instance:updateInfo(arg_15_2)
end

function var_0_0.onReceiveExchangeStarPush(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	local var_16_0 = arg_16_2.activityId
	local var_16_1 = arg_16_2.dataList
	local var_16_2 = arg_16_2.getApproach
	local var_16_3 = MaterialRpc.receiveMaterial(arg_16_2)

	if #var_16_3 > 0 then
		if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
			VersionActivity1_3AstrologyModel.instance:setExchangeList(var_16_3)

			return
		end

		VersionActivity1_3AstrologyController.instance:openVersionActivity1_3AstrologyPropView(var_16_3)
	end
end

function var_0_0.sendEnterFightRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = Activity126Module_pb.EnterFightRequest()

	var_17_0.activityId = arg_17_1
	var_17_0.dreamlandCard = arg_17_2
	var_17_0.episodeId = arg_17_3

	arg_17_0:sendMsg(var_17_0)
end

function var_0_0.onReceiveEnterFightReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	local var_18_0 = arg_18_2.dreamlandCard
	local var_18_1 = arg_18_2.episodeId
end

var_0_0.instance = var_0_0.New()

return var_0_0
