module("modules.logic.battlepass.rpc.BpRpc", package.seeall)

local var_0_0 = class("BpRpc", BaseRpc)

function var_0_0.sendGetBpInfoRequest(arg_1_0, arg_1_1)
	local var_1_0 = BpModule_pb.GetBpInfoRequest()

	var_1_0.getTask = arg_1_1

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetBpInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		BpModel.instance:onGetInfo(arg_2_2)

		if arg_2_2.endTime > 0 then
			BpBonusModel.instance:onGetInfo(arg_2_2.scoreBonusInfo)
			BpBonusModel.instance:initGetSelectBonus(arg_2_2.hasGetSelfSelectBonus)
			BpTaskModel.instance:onGetInfo(arg_2_2.taskInfo)
			BpController.instance:onCheckBpEndTime()
			BpController.instance:dispatchEvent(BpEvent.OnGetInfo)
			BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
		else
			ViewMgr.instance:closeView(ViewName.BpView)
		end
	end
end

function var_0_0.onReceiveBpOpenPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		arg_3_0:sendGetBpInfoRequest(true)
	end
end

function var_0_0.sendGetBpBonusRequest(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local var_4_0 = BpModule_pb.GetBpBonusRequest()

	var_4_0.id = BpModel.instance.id
	var_4_0.level = arg_4_1

	if arg_4_2 then
		var_4_0.payBonus = arg_4_2
	end

	if arg_4_3 then
		var_4_0.isSp = true
	end

	BpModel.instance.lockAlertBonus = true

	arg_4_0:sendMsg(var_4_0, arg_4_4, arg_4_5)
end

function var_0_0.onReceiveGetBpBonusReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		local var_5_0 = BpModel.instance:checkShowPayBonusTip(arg_5_2.scoreBonusInfo)

		BpBonusModel.instance:updateInfo(arg_5_2.scoreBonusInfo)
		BpController.instance:dispatchEvent(BpEvent.OnGetBonus)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if BpModel.instance.cacheBonus then
			if var_5_0 then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView2, BpModel.instance.cacheBonus)
			else
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView, BpModel.instance.cacheBonus)
			end

			BpModel.instance.cacheBonus = nil
		end
	end

	BpModel.instance.lockAlertBonus = false
end

function var_0_0.onReceiveBpScoreUpdatePush(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		if BpModel.instance:isEnd() then
			return
		end

		local var_6_0 = BpModel.instance.score
		local var_6_1 = BpModel.instance:checkLevelUp(arg_6_2.score)

		BpModel.instance:updateScore(arg_6_2.score, arg_6_2.weeklyScore)
		BpController.instance:dispatchEvent(BpEvent.OnUpdateScore)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if var_6_1 and not BpModel.instance.lockLevelUpShow then
			BpModel.instance.preStatus = {
				score = var_6_0,
				payStatus = BpModel.instance.payStatus
			}

			BpController.instance:onBpLevelUp()
		end
	end
end

function var_0_0.onReceiveBpPayPush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		if BpModel.instance:isEnd() then
			return
		end

		local var_7_0 = BpModel.instance.payStatus

		BpModel.instance:updatePayStatus(arg_7_2.payStatus)
		BpController.instance:dispatchEvent(BpEvent.OnUpdatePayStatus)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if not BpController.instance:needShowLevelUp() then
			if not BpModel.instance.preStatus then
				BpModel.instance.preStatus = {
					score = BpModel.instance.score
				}
			end

			BpModel.instance.preStatus.payStatus = var_7_0
		end

		BpModel.instance:buildChargeFlow()
	end
end

function var_0_0.sendBpBuyLevelRequset(arg_8_0, arg_8_1)
	local var_8_0 = BpModule_pb.BpBuyLevelRequset()

	var_8_0.id = BpModel.instance.id
	var_8_0.num = arg_8_1

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveBpBuyLevelReply(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 0 then
		local var_9_0 = BpModel.instance.score
		local var_9_1 = BpModel.instance:checkLevelUp(arg_9_2.score)

		BpModel.instance:onBuyLevel(arg_9_2.score)
		BpController.instance:dispatchEvent(BpEvent.OnBuyLevel)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if var_9_1 then
			BpModel.instance.preStatus = {
				score = var_9_0,
				payStatus = BpModel.instance.payStatus
			}

			BpController.instance:onBpLevelUp()
		end
	end
end

function var_0_0.sendBpMarkFirstShowRequest(arg_10_0, arg_10_1)
	local var_10_0 = BpModule_pb.BpMarkFirstShowRequest()

	var_10_0.id = BpModel.instance.id

	if arg_10_1 then
		var_10_0.isSp = true
	end

	arg_10_0:sendMsg(var_10_0)
end

function var_0_0.onReceiveBpMarkFirstShowReply(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		if arg_11_2.isSp then
			BpModel.instance.firstShowSp = false
		else
			BpModel.instance.firstShow = false
		end
	end
end

function var_0_0.sendGetSelfSelectBonusRequest(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = BpModule_pb.GetSelfSelectBonusRequest()

	var_12_0.id = BpModel.instance.id
	var_12_0.level = arg_12_1
	var_12_0.index = arg_12_2

	arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveGetSelfSelectBonusReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		BpBonusModel.instance:markSelectBonus(arg_13_2.level, arg_13_2.index)
		BpController.instance:dispatchEvent(BpEvent.onSelectBonusGet, arg_13_2.level)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
