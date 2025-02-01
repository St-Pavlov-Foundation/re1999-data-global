module("modules.logic.weekwalk.rpc.WeekwalkRpc", package.seeall)

slot0 = class("WeekwalkRpc", BaseRpc)

function slot0.sendGetWeekwalkInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(WeekwalkModule_pb.GetWeekwalkInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetWeekwalkInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalkModel.instance:initInfo(slot2.info, true)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnGetInfo)
end

function slot0.sendBeforeStartWeekwalkBattleRequest(slot0, slot1, slot2, slot3, slot4)
	slot0._isRestar = slot3
	WeekwalkModule_pb.BeforeStartWeekwalkBattleRequest().elementId = slot1
	slot5.layerId = slot2 or WeekWalkModel.instance:getCurMapId()

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveBeforeStartWeekwalkBattleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.elementId
	slot4 = slot2.layerId

	if slot0._isRestar then
		slot0._isRestar = nil

		return
	end

	WeekWalkController.instance:enterWeekwalkFight(slot3)
end

function slot0.sendWeekwalkGeneralRequest(slot0, slot1, slot2)
	WeekwalkModule_pb.WeekwalkGeneralRequest().elementId = slot1
	slot3.layerId = slot2 or WeekWalkModel.instance:getCurMapId()

	slot0:sendMsg(slot3)
end

function slot0.onReceiveWeekwalkGeneralReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if WeekWalkModel.instance:getMapInfo(slot2.layerId) and slot5:getElementInfo(slot2.elementId) then
		slot6.isFinish = true
	end
end

function slot0.onReceiveWeekwalkInfoUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalkModel.instance:updateInfo(slot2.info)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnWeekwalkInfoUpdate)
end

function slot0.sendWeekwalkDialogRequest(slot0, slot1, slot2, slot3)
	slot4 = WeekwalkModule_pb.WeekwalkDialogRequest()
	slot4.elementId = slot1
	slot4.option = slot2
	slot4.layerId = slot3 or WeekWalkModel.instance:getCurMapId()

	slot0:sendMsg(slot4)
end

function slot0.onReceiveWeekwalkDialogReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.elementId
	slot4 = slot2.option
	slot5 = slot2.layerId
end

function slot0.sendWeekwalkHeroRecommendRequest(slot0, slot1, slot2, slot3)
	slot4 = WeekwalkModule_pb.WeekwalkHeroRecommendRequest()
	slot4.elementId = slot1
	slot4.layerId = WeekWalkModel.instance:getCurMapId()

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveWeekwalkHeroRecommendReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.racommends
end

function slot0.sendWeekwalkDialogHistoryRequest(slot0, slot1, slot2, slot3)
	WeekwalkModule_pb.WeekwalkDialogHistoryRequest().elementId = slot1
	slot4.layerId = slot3 or WeekWalkModel.instance:getCurMapId()

	for slot8, slot9 in ipairs(slot2) do
		table.insert(slot4.historylist, slot9)
	end

	slot0:sendMsg(slot4)
end

function slot0.onReceiveWeekwalkDialogHistoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.elementId
	slot4 = slot2.historylist
	slot5 = slot2.layerId
end

function slot0.sendResetLayerRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = WeekwalkModule_pb.ResetLayerRequest()
	slot5.layerId = slot1
	slot5.battleId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveResetLayerReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalkModel.instance:initInfo(slot2.info, true)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnWeekwalkResetLayer)
	GameFacade.showToast(ToastEnum.WeekwalkResetLayer)
end

function slot0.sendMarkShowBuffRequest(slot0, slot1)
	slot2 = WeekwalkModule_pb.MarkShowBuffRequest()
	slot2.layerId = slot1 or WeekWalkModel.instance:getCurMapId()

	slot0:sendMsg(slot2)
end

function slot0.onReceiveMarkShowBuffReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalkModel.instance:getMapInfo(slot2.layerId).isShowBuff = false
end

function slot0.sendMarkShowFinishedRequest(slot0, slot1)
	slot2 = WeekwalkModule_pb.MarkShowFinishedRequest()
	slot2.layerId = slot1 or WeekWalkModel.instance:getCurMapId()

	slot0:sendMsg(slot2)
end

function slot0.onReceiveMarkShowFinishedReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalkModel.instance:getMapInfo(slot2.layerId).isShowFinished = false
end

function slot0.sendSelectNotCdHeroRequest(slot0, slot1)
	WeekwalkModule_pb.SelectNotCdHeroRequest().layerId = WeekWalkModel.instance:getCurMapId()

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2.heroId, slot7)
	end

	slot0:sendMsg(slot2)
end

function slot0.onReceiveSelectNotCdHeroReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	WeekWalkModel.instance:getMapInfo(slot2.layerId):clearHeroCd(slot2.heroId)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnSelectNotCdHeroReply)
end

function slot0.sendMarkPopDeepRuleRequest(slot0)
	slot0:sendMsg(WeekwalkModule_pb.MarkPopDeepRuleRequest())
end

function slot0.onReceiveMarkPopDeepRuleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendMarkPopShallowSettleRequest(slot0)
	slot0:sendMsg(WeekwalkModule_pb.MarkPopShallowSettleRequest())
end

function slot0.onReceiveMarkPopShallowSettleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendMarkPopDeepSettleRequest(slot0)
	slot0:sendMsg(WeekwalkModule_pb.MarkPopDeepSettleRequest())
end

function slot0.onReceiveMarkPopDeepSettleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendChangeWeekwalkHeroGroupSelectRequest(slot0, slot1, slot2, slot3)
	slot4 = WeekwalkModule_pb.ChangeWeekwalkHeroGroupSelectRequest()
	slot4.layerId = slot1
	slot4.battleId = slot2
	slot4.select = slot3

	slot0:sendMsg(slot4)
end

function slot0.onReceiveChangeWeekwalkHeroGroupSelectReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if WeekWalkModel.instance:getBattleInfo(slot2.layerId, slot2.battleId) then
		slot6.heroGroupSelect = slot2.select
	end
end

slot0.instance = slot0.New()

return slot0
