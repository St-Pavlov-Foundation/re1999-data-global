module("modules.logic.seasonver.act123.controller.Season123PickHeroEntryController", package.seeall)

slot0 = class("Season123PickHeroEntryController", BaseController)

function slot0.onOpenView(slot0, slot1, slot2, slot3, slot4)
	Season123PickHeroEntryModel.instance:init(slot1, slot2)
end

function slot0.onCloseView(slot0)
	Season123PickHeroEntryModel.instance:release()
end

function slot0.openPickHeroView(slot0, slot1)
	slot2 = nil

	if slot1 and Season123PickHeroEntryModel.instance:getByIndex(slot1) and slot3.heroMO then
		slot2 = slot3.heroMO.uid
	end

	ViewMgr.instance:openView(Season123Controller.instance:getPickHeroViewName(), {
		actId = Season123PickHeroEntryModel.instance.activityId,
		stage = Season123PickHeroEntryModel.instance.stage,
		finishCall = slot0.handlePickOver,
		finishCallObj = slot0,
		entryMOList = Season123PickHeroEntryModel.instance:getList(),
		selectHeroUid = slot2
	})
end

function slot0.openPickSupportView(slot0, slot1)
	slot3 = nil

	if Season123PickHeroEntryModel.instance:getSupportPosMO() and slot2.isSupport then
		slot3 = slot2.heroUid
	end

	if slot1 and Season123PickAssistController.instance:checkCanRefresh() then
		slot0.tmpIsRecordRefreshTime = true

		DungeonRpc.instance:sendRefreshAssistRequest(DungeonEnum.AssistType.Season123, slot0._openPickSupportViewAfterRpc, slot0)
	else
		slot0:_openPickSupportViewAfterRpc()
	end
end

function slot0._openPickSupportViewAfterRpc(slot0, slot1, slot2, slot3)
	if slot0.tmpIsRecordRefreshTime then
		Season123PickAssistController.instance:recordAssistRefreshTime()
	end

	slot0.tmpIsRecordRefreshTime = nil

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1)
	ViewMgr.instance:openView(Season123Controller.instance:getPickAssistViewName(), {
		actId = Season123PickHeroEntryModel.instance.activityId,
		finishCall = slot0.handlePickSupport,
		finishCallObj = slot0,
		selectedHeroUid = Season123PickHeroEntryModel.instance:getSupporterHeroUid()
	})
end

function slot0.cancelSupport(slot0)
	if Season123PickHeroEntryModel.instance:getSupportPosMO() and slot1.isSupport then
		slot1:setEmpty()
	end

	slot0:notifyView()
	Season123PickHeroEntryModel.instance:clearLastSupportHero()
end

function slot0.selectMainEquips(slot0, slot1)
	ViewMgr.instance:openView(Season123Controller.instance:getEquipHeroViewName(), {
		actId = Season123PickHeroEntryModel.instance.activityId,
		stage = Season123PickHeroEntryModel.instance.stage,
		slot = slot1,
		callback = slot0.handleSelectMainCard,
		callbackObj = slot0,
		equipUidList = Season123PickHeroEntryModel.instance:getMainCardList()
	})
end

function slot0.handlePickOver(slot0, slot1)
	Season123PickHeroEntryModel.instance:savePickHeroDatas(slot1)
	slot0:notifyView()
end

function slot0.handlePickSupport(slot0, slot1)
	Season123PickHeroEntryModel.instance:setPickAssistData(slot1)
	slot0:notifyView()
end

function slot0.handleSelectMainCard(slot0, slot1)
	Season123PickHeroEntryModel.instance:setMainEquips(slot1)
	slot0:notifyView()
end

function slot0.sendEnterStage(slot0)
	slot2 = Season123PickHeroEntryModel.instance:getLimitCount()

	if Season123PickHeroEntryModel.instance:getSelectCount() < 1 then
		logNormal(string.format("hero count not fit : %s/%s", slot1, slot2))
		GameFacade.showToast(ToastEnum.Season123PickHeroCountErr)

		return
	end

	if slot1 < slot2 then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123MemberNotEnough, MsgBoxEnum.BoxType.Yes_No, slot0.confirmSendEnterStage, nil, , slot0)

		return
	end

	Activity123Rpc.instance:sendAct123EnterStageRequest(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, Season123PickHeroEntryModel.instance:getHeroUidList(), Season123PickHeroEntryModel.instance:getMainCardList())
	Season123PickHeroEntryModel.instance:flushSelectionToLocal()
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123PickHeroEntryModel.instance.stage)
end

function slot0.confirmSendEnterStage(slot0)
	Activity123Rpc.instance:sendAct123EnterStageRequest(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, Season123PickHeroEntryModel.instance:getHeroUidList(), Season123PickHeroEntryModel.instance:getMainCardList())
	Season123PickHeroEntryModel.instance:flushSelectionToLocal()
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123PickHeroEntryModel.instance.stage)
end

function slot0.notifyView(slot0)
	Season123Controller.instance:dispatchEvent(Season123Event.PickEntryRefresh)
end

slot0.instance = slot0.New()

return slot0
