module("modules.logic.season.rpc.Activity104Rpc", package.seeall)

local var_0_0 = class("Activity104Rpc", BaseRpc)

function var_0_0.sendGet104InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity104Module_pb.Get104InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet104InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity104Model.instance:setActivity104Info(arg_2_2)
	Activity104EquipController.instance:checkHeroGroupCardExist(arg_2_2.activityId)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104Info)
end

function var_0_0.sendBeforeStartAct104BattleRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = Activity104Module_pb.BeforeStartAct104BattleRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.episodeId = arg_3_3
	var_3_0.layer = arg_3_2

	return arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveBeforeStartAct104BattleReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.StartAct104BattleReply, arg_4_2)
end

function var_0_0.sendStartAct104BattleRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	local var_5_0 = Activity104Module_pb.StartAct104BattleRequest()

	arg_5_0:setStartDungeonReq(var_5_0.startDungeonRequest, arg_5_1)

	var_5_0.activityId = arg_5_2
	var_5_0.episodeId = arg_5_4
	var_5_0.layer = arg_5_3 or 0

	return arg_5_0:sendMsg(var_5_0, arg_5_5, arg_5_6)
end

function var_0_0.setStartDungeonReq(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2.endAdventure then
		DungeonModel.instance:SetSendChapterEpisodeId(arg_6_2.chapterId, arg_6_2.episodeId)
	end

	arg_6_1.chapterId = arg_6_2.chapterId
	arg_6_1.episodeId = arg_6_2.episodeId

	if arg_6_2.isRestart then
		arg_6_1.isRestart = arg_6_2.isRestart
	end

	local var_6_0 = arg_6_2.fightParam

	if var_6_0 then
		if HeroGroupBalanceHelper.getIsBalanceMode() then
			arg_6_1.isBalance = true
		end

		var_6_0:setReqFightGroup(arg_6_1)

		local var_6_1 = var_6_0:getCurEpisodeConfig()

		if var_6_1 and not Activity104Model.instance:isSeasonEpisodeType(var_6_1.type) then
			for iter_6_0 = #arg_6_1.fightGroup.activity104Equips, 1, -1 do
				table.remove(arg_6_1.fightGroup.activity104Equips, iter_6_0)
			end
		end
	end

	arg_6_1.multiplication = arg_6_2.multiplication or 1

	if arg_6_2.useRecord == true then
		arg_6_1.useRecord = arg_6_2.useRecord
	end

	VersionActivityDungeonBaseController.instance:resetIsFirstPassEpisode(arg_6_2.episodeId)
end

function var_0_0.onReceiveStartAct104BattleReply(arg_7_0, arg_7_1, arg_7_2)
	DungeonRpc.instance:onReceiveStartDungeonReply(arg_7_1, arg_7_2.startDungeonReply)
end

function var_0_0.onReceiveAct104BattleFinishPush(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	Activity104Model.instance:updateActivity104Info(arg_8_2)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104BattleFinish)
end

function var_0_0.onReceiveActivity104ItemChangePush(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 ~= 0 then
		return
	end

	Activity104Model.instance:updateItemChange(arg_9_2)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104ItemChange)
end

function var_0_0.sendRefreshRetailRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = Activity104Module_pb.RefreshRetailRequest()

	var_10_0.activityId = arg_10_1

	return arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveRefreshRetailReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 ~= 0 then
		return
	end

	Activity104Model.instance:replaceAct104Retails(arg_11_2)
	Activity104Controller.instance:dispatchEvent(Activity104Event.RefreshRetail)
end

function var_0_0.sendOptionalActivity104EquipRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = Activity104Module_pb.OptionalActivity104EquipRequest()

	var_12_0.activityId = arg_12_1
	var_12_0.optionalEquipUid = arg_12_2
	var_12_0.equipId = arg_12_3

	return arg_12_0:sendMsg(var_12_0, arg_12_4, arg_12_5)
end

function var_0_0.onReceiveOptionalActivity104EquipReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.OptionalEquip)
end

function var_0_0.sendChangeFightGroupRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = Activity104Module_pb.ChangeFightGroupRequest()

	var_14_0.activityId = arg_14_1
	var_14_0.heroGroupSnapshotSubId = arg_14_2

	return arg_14_0:sendMsg(var_14_0, arg_14_3, arg_14_4)
end

function var_0_0.onReceiveChangeFightGroupReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	Activity104Model.instance:setSeasonCurSnapshotSubId(arg_15_2.activityId, arg_15_2.heroGroupSnapshotSubId)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SwitchSnapshotSubId)
end

function var_0_0.sendComposeActivity104EquipRequest(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = Activity104Module_pb.ComposeActivity104EquipRequest()

	var_16_0.activityId = arg_16_1

	for iter_16_0, iter_16_1 in ipairs(arg_16_2) do
		var_16_0.equipIdUids:append(iter_16_1)
	end

	return arg_16_0:sendMsg(var_16_0)
end

function var_0_0.onReceiveComposeActivity104EquipReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 ~= 0 then
		return
	end

	Activity104EquipController.instance:checkHeroGroupCardExist(arg_17_2.activityId)
	Activity104EquipComposeController.instance:dispatchEvent(Activity104Event.OnComposeSuccess, arg_17_2.activityId)
end

function var_0_0.sendGetUnlockActivity104EquipIdsRequest(arg_18_0, arg_18_1)
	local var_18_0 = Activity104Module_pb.GetUnlockActivity104EquipIdsRequest()

	var_18_0.activityId = arg_18_1

	arg_18_0:sendMsg(var_18_0)
end

function var_0_0.onReceiveGetUnlockActivity104EquipIdsReply(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end

	Activity104Model.instance:onReceiveGetUnlockActivity104EquipIdsReply(arg_19_2)
end

function var_0_0.sendMarkActivity104StoryRequest(arg_20_0, arg_20_1)
	local var_20_0 = Activity104Module_pb.MarkActivity104StoryRequest()

	var_20_0.activityId = arg_20_1

	Activity104Model.instance:markActivityStory(arg_20_1)

	return arg_20_0:sendMsg(var_20_0)
end

function var_0_0.onReceiveMarkActivity104StoryReply(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		return
	end

	Activity104Model.instance:markActivityStory(arg_21_2.activityId)
end

function var_0_0.sendMarkEpisodeAfterStoryRequest(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = Activity104Module_pb.MarkEpisodeAfterStoryRequest()

	var_22_0.activityId = arg_22_1
	var_22_0.layer = arg_22_2

	return arg_22_0:sendMsg(var_22_0)
end

function var_0_0.onReceiveMarkEpisodeAfterStoryReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 ~= 0 then
		return
	end

	Activity104Model.instance:markEpisodeAfterStory(arg_23_2.activityId, arg_23_2.layer)
end

function var_0_0.sendMarkPopSummaryRequest(arg_24_0, arg_24_1)
	local var_24_0 = Activity104Module_pb.MarkPopSummaryRequest()

	var_24_0.activityId = arg_24_1

	return arg_24_0:sendMsg(var_24_0)
end

function var_0_0.onReceiveMarkPopSummaryReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 ~= 0 then
		return
	end

	Activity104Model.instance:MarkPopSummary(arg_25_2.activityId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
