module("modules.logic.versionactivity2_5.act182.rpc.Activity182Rpc", package.seeall)

local var_0_0 = class("Activity182Rpc", BaseRpc)

function var_0_0.sendGetAct182InfoRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity182Module_pb.GetAct182InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetAct182InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity182Model.instance:setActInfo(arg_2_2.act182Info)
end

function var_0_0.onReceiveAct182InfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	Activity182Model.instance:setActInfo(arg_3_2.act182Info)
end

function var_0_0.sendGetAct182RandomMasterRequest(arg_4_0, arg_4_1)
	local var_4_0 = Activity182Module_pb.GetAct182RandomMasterRequest()

	var_4_0.activityId = arg_4_1

	arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveGetAct182RandomMasterReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo():updateMasterIdBox(arg_5_2.activityId, arg_5_2.masterId)
	Activity182Controller.instance:dispatchEvent(Activity182Event.RandomMasterReply)
end

function var_0_0.sendAct182RefreshMasterRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = Activity182Module_pb.Act182RefreshMasterRequest()

	var_6_0.activityId = arg_6_1

	arg_6_0:sendMsg(var_6_0, arg_6_2, arg_6_3)
end

function var_0_0.onReceiveAct182RefreshMasterReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo():updateMasterIdBox(arg_7_2.activityId, arg_7_2.masterId, true)
end

function var_0_0.sendAct182SaveSnapshotRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = Activity182Module_pb.Act182SaveSnapshotRequest()

	var_8_0.activityId = arg_8_1

	arg_8_0:sendMsg(var_8_0, arg_8_2, arg_8_3)
end

function var_0_0.onReceiveAct182SaveSnapshotReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo(arg_9_2.activityId):updateSnapshot(arg_9_2.snapshot)
end

function var_0_0.sendAct182GetHasSnapshotFriendRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = Activity182Module_pb.Act182GetHasSnapshotFriendRequest()

	var_10_0.activityId = arg_10_1

	arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveAct182GetHasSnapshotFriendReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	local var_11_0 = Activity182Model.instance:getActMo(arg_11_2.activityId)

	var_11_0:updateFriendInfoList(arg_11_2.friendPlayerInfo)
	var_11_0:updateFriendSnapshot(arg_11_2.snapshot)
end

function var_0_0.sendAct182GetFriendSnapshotsRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = Activity182Module_pb.Act182GetFriendSnapshotsRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.friendUserId = arg_12_2

	arg_12_0:sendMsg(var_12_0, arg_12_3, arg_12_4)
end

function var_0_0.onReceiveAct182GetFriendSnapshotsReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo(arg_13_2.activityId):updateFriendSnapshot(arg_13_2.snapshots)
end

function var_0_0.sendAct182GetFriendFightRecordsRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = Activity182Module_pb.Act182GetFriendFightRecordsRequest()

	var_14_0.activityId = arg_14_1

	arg_14_0:sendMsg(var_14_0, arg_14_2, arg_14_3)
end

function var_0_0.onReceiveAct182GetFriendFightRecordsReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo(arg_15_2.activityId):updateFriendFightRecords(arg_15_2.fightRecords)
end

function var_0_0.sendAct182GetFriendFightMessageRequest(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	local var_16_0 = Activity182Module_pb.Act182GetFriendFightMessageRequest()

	var_16_0.activityId = arg_16_1
	var_16_0.friendUserId = arg_16_2
	var_16_0.uid = arg_16_3

	arg_16_0:sendMsg(var_16_0, arg_16_4, arg_16_5)
end

function var_0_0.onReceiveAct182GetFriendFightMessageReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= 0 then
		return
	end

	AutoChessModel.instance:enterSceneReply(AutoChessEnum.ModuleId.Friend, arg_17_2.scene)

	local var_17_0 = AutoChessModel.instance:getChessMo()

	if var_17_0 then
		var_17_0:cacheSvrFight()
		var_17_0:updateSvrTurn(arg_17_2.turn)
		AutoChessController.instance:enterSingleGame()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
