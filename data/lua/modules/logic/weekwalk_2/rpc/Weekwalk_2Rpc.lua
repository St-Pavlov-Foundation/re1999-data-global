module("modules.logic.weekwalk_2.rpc.Weekwalk_2Rpc", package.seeall)

local var_0_0 = class("Weekwalk_2Rpc", BaseRpc)

function var_0_0.sendWeekwalkVer2GetInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = WeekwalkVer2Module_pb.WeekwalkVer2GetInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveWeekwalkVer2GetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.info

	WeekWalk_2Model.instance:initInfo(var_2_0)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnGetInfo)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
end

function var_0_0.sendWeekwalkVer2HeroRecommendRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = WeekwalkVer2Module_pb.WeekwalkVer2HeroRecommendRequest()

	var_3_0.elementId = arg_3_1
	var_3_0.layerId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveWeekwalkVer2HeroRecommendReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.racommends
end

function var_0_0.sendWeekwalkVer2ResetLayerRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = WeekwalkVer2Module_pb.WeekwalkVer2ResetLayerRequest()

	var_5_0.layerId = arg_5_1
	var_5_0.battleId = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveWeekwalkVer2ResetLayerReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	local var_6_0 = arg_6_2.layerInfo

	WeekWalk_2Model.instance:getInfo():setLayerInfo(var_6_0)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkResetLayer)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
end

function var_0_0.sendWeekwalkVer2ChangeHeroGroupSelectRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = WeekwalkVer2Module_pb.WeekwalkVer2ChangeHeroGroupSelectRequest()

	var_7_0.layerId = arg_7_1
	var_7_0.battleId = arg_7_2
	var_7_0.select = arg_7_3

	arg_7_0:sendMsg(var_7_0, arg_7_4, arg_7_5)
end

function var_0_0.onReceiveWeekwalkVer2ChangeHeroGroupSelectReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	local var_8_0 = arg_8_2.layerId
	local var_8_1 = arg_8_2.battleId
	local var_8_2 = arg_8_2.select
	local var_8_3 = WeekWalk_2Model.instance:getBattleInfo(var_8_0, var_8_1)

	if var_8_3 then
		var_8_3.heroGroupSelect = var_8_2
	end
end

function var_0_0.sendWeekwalkVer2ChooseSkillRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = WeekwalkVer2Module_pb.WeekwalkVer2ChooseSkillRequest()

	var_9_0.no = arg_9_1

	if arg_9_2 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_2) do
			table.insert(var_9_0.skillIds, iter_9_1)
		end
	end

	arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveWeekwalkVer2ChooseSkillReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	local var_10_0 = arg_10_2.no
	local var_10_1 = arg_10_2.skillIds
	local var_10_2 = WeekWalk_2Model.instance:getInfo()

	if var_10_2 then
		var_10_2:setHeroGroupSkill(var_10_0, var_10_1)
		WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSetupReply)
	end
end

function var_0_0.sendWeekwalkVer2GetSettleInfoRequest(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = WeekwalkVer2Module_pb.WeekwalkVer2GetSettleInfoRequest()

	arg_11_0:sendMsg(var_11_0, arg_11_1, arg_11_2)
end

function var_0_0.onReceiveWeekwalkVer2GetSettleInfoReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.settleInfo

	WeekWalk_2Model.instance:initSettleInfo(var_12_0)
	WeekWalk_2Controller.instance:openWeekWalk_2HeartResultView()
end

function var_0_0.sendWeekwalkVer2MarkPreSettleRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = WeekwalkVer2Module_pb.WeekwalkVer2MarkPreSettleRequest()

	arg_13_0:sendMsg(var_13_0, arg_13_1, arg_13_2)
end

function var_0_0.onReceiveWeekwalkVer2MarkPreSettleReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end
end

function var_0_0.sendWeekwalkVer2MarkPopRuleRequest(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = WeekwalkVer2Module_pb.WeekwalkVer2MarkPopRuleRequest()

	arg_15_0:sendMsg(var_15_0, arg_15_1, arg_15_2)
end

function var_0_0.onReceiveWeekwalkVer2MarkPopRuleReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end
end

function var_0_0.sendWeekwalkVer2MarkShowFinishedRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = WeekwalkVer2Module_pb.WeekwalkVer2MarkShowFinishedRequest()

	var_17_0.layerId = arg_17_1

	arg_17_0:sendMsg(var_17_0, arg_17_2, arg_17_3)
end

function var_0_0.onReceiveWeekwalkVer2MarkShowFinishedReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end

	local var_18_0 = arg_18_2.layerId
end

function var_0_0.onReceiveWeekwalkVer2InfoUpdatePush(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end

	local var_19_0 = arg_19_2.info

	WeekWalk_2Model.instance:updateInfo(var_19_0)
	WeekWalk_2Model.instance:clearSettleInfo()
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoUpdate)
	WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnWeekwalkInfoChange)
end

function var_0_0.onReceiveWeekwalkVer2SettleInfoUpdatePush(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		return
	end

	local var_20_0 = arg_20_2.settleInfo

	WeekWalk_2Model.instance:initSettleInfo(var_20_0)
end

function var_0_0.onReceiveWeekwalkVer2FightSettlePush(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		return
	end

	local var_21_0 = arg_21_2.layerId
	local var_21_1 = arg_21_2.battleId
	local var_21_2 = arg_21_2.result
	local var_21_3 = arg_21_2.cupInfos

	WeekWalk_2Model.instance:initFightSettleInfo(var_21_2, var_21_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
