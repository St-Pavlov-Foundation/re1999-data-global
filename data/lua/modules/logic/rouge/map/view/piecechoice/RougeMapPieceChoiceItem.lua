module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceChoiceItem", package.seeall)

slot0 = class("RougeMapPieceChoiceItem", RougeMapChoiceBaseItem)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._btnlockdetail2 = gohelper.findChildButtonWithAudio(slot0.go, "#go_locked/#btn_lockdetail2")
	slot0._simagelockcollection = gohelper.findChildSingleImage(slot0.go, "#go_locked/#btn_lockdetail2/#simage_collection")
	slot0._btnnormaldetail2 = gohelper.findChildButtonWithAudio(slot0.go, "#go_normal/#btn_normaldetail2")
	slot0._simagenormalcollection = gohelper.findChildSingleImage(slot0.go, "#go_normal/#btn_normaldetail2/#simage_collection")
	slot0._btnselectdetail2 = gohelper.findChildButtonWithAudio(slot0.go, "#go_select/#btn_selectdetail2")
	slot0._simageselectcollection = gohelper.findChildSingleImage(slot0.go, "#go_select/#btn_selectdetail2/#simage_collection")

	slot0._btnlockdetail2:AddClickListener(slot0.onClickCollection, slot0)
	slot0._btnnormaldetail2:AddClickListener(slot0.onClickCollection, slot0)
	slot0._btnselectdetail2:AddClickListener(slot0.onClickCollection, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChoiceItemStatusChange, slot0.onStatusChange, slot0)
end

function slot0.onClickCollection(slot0)
	if not slot0:hadCollection() then
		return
	end

	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	slot0.collectionIdList = slot0.collectionIdList or {
		slot0.collectionId
	}

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClickPieceStoreDetail, slot0.collectionIdList)
end

function slot0.onClickSelf(slot0)
	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	if slot0:canShowLockUI() then
		return
	end

	if slot0.viewEnum == RougeMapEnum.PieceChoiceViewStatus.Store then
		slot0:handleStoreChoice()

		return
	end

	slot0:handleNormalChoice()
end

function slot0.handleNormalChoice(slot0)
	if slot0.status == RougeMapEnum.ChoiceStatus.Select then
		if slot0.choiceId == 0 then
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
		else
			slot0.animator:Play("select", 0, 0)
			TaskDispatcher.cancelTask(slot0.onNormalChoiceSelectAnimDone, slot0)
			TaskDispatcher.runDelay(slot0.onNormalChoiceSelectAnimDone, slot0, RougeMapEnum.ChoiceSelectAnimDuration)
			UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
		end
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, slot0.dataId)
	end
end

function slot0.onNormalChoiceSelectAnimDone(slot0)
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)

	if lua_rouge_piece_select.configDict[slot0.choiceId].triggerType == RougeMapEnum.PieceTriggerType.Shop and slot0.pieceMo.triggerStr and slot0.pieceMo.triggerStr.repairShopCollections then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, slot0.pieceMo, slot0.choiceId)

		return
	elseif slot2 == RougeMapEnum.PieceTriggerType.EndFight and slot0.pieceMo.selectId and slot0.pieceMo.selectId ~= 0 then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, slot0.pieceMo, slot0.choiceId)

		return
	end

	slot0:clearCallback()

	slot0.callbackId = RougeRpc.instance:sendRougePieceTalkSelectRequest(slot0.choiceId, slot0.onReceiveMsg, slot0)
end

function slot0.onReceiveMsg(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, slot0.pieceMo, slot0.choiceId)
end

function slot0.handleStoreChoice(slot0)
	if slot0.status == RougeMapEnum.ChoiceStatus.Select then
		slot0.animator:Play("select", 0, 0)
		TaskDispatcher.cancelTask(slot0.onStoreSelectAnimDone, slot0)
		TaskDispatcher.runDelay(slot0.onStoreSelectAnimDone, slot0, RougeMapEnum.ChoiceSelectAnimDuration)
		UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, slot0.dataId)
	end
end

function slot0.onStoreSelectAnimDone(slot0)
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	slot0:clearCallback()

	slot0.callbackId = RougeRpc.instance:sendRougeRepairShopBuyRequest(slot0.collectionId, slot0.onReceiveBuyMsg, slot0)
end

function slot0.onReceiveBuyMsg(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshChoiceStore)
end

function slot0.onStatusChange(slot0, slot1)
	if slot0.status == RougeMapEnum.ChoiceStatus.Lock or slot0.status == RougeMapEnum.ChoiceStatus.Bought then
		return
	end

	slot2 = nil

	if ((not slot1 or (slot1 ~= slot0.dataId or RougeMapEnum.ChoiceStatus.Select) and RougeMapEnum.ChoiceStatus.UnSelect) and RougeMapEnum.ChoiceStatus.Normal) == slot0.status then
		return
	end

	slot0.status = slot2

	slot0:refreshUI()
end

function slot0.update(slot0, slot1, slot2, slot3)
	uv0.super.update(slot0, slot2)

	slot0.viewEnum = RougeMapEnum.PieceChoiceViewStatus.Choice
	slot0.choiceId = slot1
	slot0.dataId = slot1
	slot0.pieceMo = slot3
	slot0.collectionIdList = nil

	if slot0.choiceId == 0 then
		slot0.desc = lua_rouge_piece_talk.configDict[slot0.pieceMo.talkId].exitDesc
		slot0.title = ""
		slot0.collectionId = nil
	else
		slot0.choiceCo = lua_rouge_piece_select.configDict[slot1]
		slot0.desc = slot0.choiceCo.content
		slot0.title = slot0.choiceCo.title
		slot0.collectionId = slot0.choiceCo.display
	end

	slot0.status = RougeMapPieceTriggerHelper.getChoiceStatus(slot3, slot1)
	slot0.tip = RougeMapPieceTriggerHelper.getTip(slot0.pieceMo, slot0.choiceId, slot0.status)

	slot0:refreshUI()
	slot0:playUnlockAnim()
end

function slot0.updateStoreGoods(slot0, slot1, slot2, slot3, slot4)
	uv0.super.update(slot0, slot3)

	slot0.collectionIdList = nil
	slot0.viewEnum = RougeMapEnum.PieceChoiceViewStatus.Store
	slot0.collectionId = slot1
	slot0.dataId = slot1
	slot0.consumeCo = slot2
	slot0.pieceMo = slot4
	slot0.consumeUnlockType = slot2.unlockType
	slot0.consumeUnlockParam = slot2.unlockParam
	slot0.boughtCollectionList = slot4.triggerStr.curBoughtRepairShopCollections

	slot0:initGoodsStatus()

	slot0.title = ""
	slot0.desc = slot0.consumeCo.desc
	slot0.tip = slot0:getGoodsTip()

	slot0:refreshUI()
end

function slot0.initGoodsStatus(slot0)
	if tabletool.indexOf(slot0.boughtCollectionList, slot0.collectionId) then
		slot0.status = RougeMapEnum.ChoiceStatus.Bought

		return
	end

	slot0.status = RougeMapUnlockHelper.checkIsUnlock(slot0.consumeUnlockType, slot0.consumeUnlockParam) and RougeMapEnum.ChoiceStatus.Normal or RougeMapEnum.ChoiceStatus.Lock
end

function slot0.getGoodsTip(slot0)
	if slot0.status == RougeMapEnum.ChoiceStatus.Bought then
		return ""
	end

	if slot0.status == RougeMapEnum.ChoiceStatus.Lock then
		return RougeMapUnlockHelper.getLockTips(slot0.consumeUnlockType, slot0.consumeUnlockParam)
	end

	return ""
end

function slot0.canShowLockUI(slot0)
	return slot0.status == RougeMapEnum.ChoiceStatus.Lock or slot0.status == RougeMapEnum.ChoiceStatus.Bought
end

function slot0.refreshLockUI(slot0)
	uv0.super.refreshLockUI(slot0)
	slot0:refreshCollection(slot0._golockdetail2, slot0._simagelockcollection)
end

function slot0.refreshNormalUI(slot0)
	uv0.super.refreshNormalUI(slot0)
	slot0:refreshCollection(slot0._gonormaldetail2, slot0._simagenormalcollection)
end

function slot0.refreshSelectUI(slot0)
	uv0.super.refreshSelectUI(slot0)
	slot0:refreshCollection(slot0._goselectdetail2, slot0._simageselectcollection)
end

function slot0.refreshCollection(slot0, slot1, slot2)
	slot3 = slot0:hadCollection()

	gohelper.setActive(slot1, slot3)

	if slot3 then
		slot2:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0.collectionId))
	end
end

function slot0.hadCollection(slot0)
	return slot0.collectionId and slot0.collectionId ~= 0
end

function slot0.playUnlockAnim(slot0)
	if not slot0.choiceCo then
		return
	end

	if slot0.choiceCo.activeType == 0 then
		return
	end

	if RougeMapController.instance:checkPieceChoicePlayedUnlockAnim(slot0.choiceId) then
		return
	end

	if RougeMapUnlockHelper.checkIsUnlock(slot1, slot0.choiceCo.activeParam) then
		slot0.animator:Play("unlock", 0, 0)
		RougeMapController.instance:playedPieceChoiceEvent(slot0.choiceId)
	end
end

function slot0.destroy(slot0)
	slot0._btnlockdetail2:RemoveClickListener()
	slot0._btnnormaldetail2:RemoveClickListener()
	slot0._btnselectdetail2:RemoveClickListener()
	slot0._simagenormalcollection:UnLoadImage()
	slot0._simageselectcollection:UnLoadImage()
	uv0.super.destroy(slot0)
end

return slot0
