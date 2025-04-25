module("modules.logic.battlepass.rpc.BpRpc", package.seeall)

slot0 = class("BpRpc", BaseRpc)

function slot0.sendGetBpInfoRequest(slot0, slot1)
	slot2 = BpModule_pb.GetBpInfoRequest()
	slot2.getTask = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveGetBpInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		BpModel.instance:onGetInfo(slot2)

		if slot2.endTime > 0 then
			BpBonusModel.instance:onGetInfo(slot2.scoreBonusInfo)
			BpBonusModel.instance:initGetSelectBonus(slot2.hasGetSelfSelectBonus)
			BpTaskModel.instance:onGetInfo(slot2.taskInfo)
			BpController.instance:onCheckBpEndTime()
			BpController.instance:dispatchEvent(BpEvent.OnGetInfo)
			BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)
		else
			ViewMgr.instance:closeView(ViewName.BpView)
		end
	end
end

function slot0.onReceiveBpOpenPush(slot0, slot1, slot2)
	if slot1 == 0 then
		slot0:sendGetBpInfoRequest(true)
	end
end

function slot0.sendGetBpBonusRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = BpModule_pb.GetBpBonusRequest()
	slot6.id = BpModel.instance.id
	slot6.level = slot1

	if slot2 then
		slot6.payBonus = slot2
	end

	if slot3 then
		slot6.isSp = true
	end

	BpModel.instance.lockAlertBonus = true

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveGetBpBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		BpBonusModel.instance:updateInfo(slot2.scoreBonusInfo)
		BpController.instance:dispatchEvent(BpEvent.OnGetBonus)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if BpModel.instance.cacheBonus then
			if BpModel.instance:checkShowPayBonusTip(slot2.scoreBonusInfo) then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView2, BpModel.instance.cacheBonus)
			else
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView, BpModel.instance.cacheBonus)
			end

			BpModel.instance.cacheBonus = nil
		end
	end

	BpModel.instance.lockAlertBonus = false
end

function slot0.onReceiveBpScoreUpdatePush(slot0, slot1, slot2)
	if slot1 == 0 then
		if BpModel.instance:isEnd() then
			return
		end

		BpModel.instance:updateScore(slot2.score, slot2.weeklyScore)
		BpController.instance:dispatchEvent(BpEvent.OnUpdateScore)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if BpModel.instance:checkLevelUp(slot2.score) and not BpModel.instance.lockLevelUpShow then
			BpModel.instance.preStatus = {
				score = BpModel.instance.score,
				payStatus = BpModel.instance.payStatus
			}

			BpController.instance:onBpLevelUp()
		end
	end
end

function slot0.onReceiveBpPayPush(slot0, slot1, slot2)
	if slot1 == 0 then
		if BpModel.instance:isEnd() then
			return
		end

		slot3 = BpModel.instance.payStatus

		BpModel.instance:updatePayStatus(slot2.payStatus)
		BpController.instance:dispatchEvent(BpEvent.OnUpdatePayStatus)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if not BpController.instance:needShowLevelUp() then
			if not BpModel.instance.preStatus then
				BpModel.instance.preStatus = {
					score = BpModel.instance.score
				}
			end

			BpModel.instance.preStatus.payStatus = slot3
		end

		BpModel.instance:buildChargeFlow()
	end
end

function slot0.sendBpBuyLevelRequset(slot0, slot1)
	slot2 = BpModule_pb.BpBuyLevelRequset()
	slot2.id = BpModel.instance.id
	slot2.num = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveBpBuyLevelReply(slot0, slot1, slot2)
	if slot1 == 0 then
		BpModel.instance:onBuyLevel(slot2.score)
		BpController.instance:dispatchEvent(BpEvent.OnBuyLevel)
		BpController.instance:dispatchEvent(BpEvent.OnRedDotUpdate)

		if BpModel.instance:checkLevelUp(slot2.score) then
			BpModel.instance.preStatus = {
				score = BpModel.instance.score,
				payStatus = BpModel.instance.payStatus
			}

			BpController.instance:onBpLevelUp()
		end
	end
end

function slot0.sendBpMarkFirstShowRequest(slot0, slot1)
	BpModule_pb.BpMarkFirstShowRequest().id = BpModel.instance.id

	if slot1 then
		slot2.isSp = true
	end

	slot0:sendMsg(slot2)
end

function slot0.onReceiveBpMarkFirstShowReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2.isSp then
			BpModel.instance.firstShowSp = false
		else
			BpModel.instance.firstShow = false
		end
	end
end

function slot0.sendGetSelfSelectBonusRequest(slot0, slot1, slot2)
	slot3 = BpModule_pb.GetSelfSelectBonusRequest()
	slot3.id = BpModel.instance.id
	slot3.level = slot1
	slot3.index = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGetSelfSelectBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		BpBonusModel.instance:markSelectBonus(slot2.level, slot2.index)
		BpController.instance:dispatchEvent(BpEvent.onSelectBonusGet, slot2.level)
	end
end

slot0.instance = slot0.New()

return slot0
