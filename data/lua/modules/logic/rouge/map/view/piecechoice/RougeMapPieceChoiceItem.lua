module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceChoiceItem", package.seeall)

local var_0_0 = class("RougeMapPieceChoiceItem", RougeMapChoiceBaseItem)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._btnlockdetail2 = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_locked/#btn_lockdetail2")
	arg_1_0._simagelockcollection = gohelper.findChildSingleImage(arg_1_0.go, "#go_locked/#btn_lockdetail2/#simage_collection")
	arg_1_0._btnnormaldetail2 = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_normal/#btn_normaldetail2")
	arg_1_0._simagenormalcollection = gohelper.findChildSingleImage(arg_1_0.go, "#go_normal/#btn_normaldetail2/#simage_collection")
	arg_1_0._btnselectdetail2 = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_select/#btn_selectdetail2")
	arg_1_0._simageselectcollection = gohelper.findChildSingleImage(arg_1_0.go, "#go_select/#btn_selectdetail2/#simage_collection")

	arg_1_0._btnlockdetail2:AddClickListener(arg_1_0.onClickCollection, arg_1_0)
	arg_1_0._btnnormaldetail2:AddClickListener(arg_1_0.onClickCollection, arg_1_0)
	arg_1_0._btnselectdetail2:AddClickListener(arg_1_0.onClickCollection, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChoiceItemStatusChange, arg_1_0.onStatusChange, arg_1_0)
end

function var_0_0.onClickCollection(arg_2_0)
	if not arg_2_0:hadCollection() then
		return
	end

	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	arg_2_0.collectionIdList = arg_2_0.collectionIdList or {
		arg_2_0.collectionId
	}

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClickPieceStoreDetail, arg_2_0.collectionIdList)
end

function var_0_0.onClickSelf(arg_3_0)
	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	if arg_3_0:canShowLockUI() then
		return
	end

	if arg_3_0.viewEnum == RougeMapEnum.PieceChoiceViewStatus.Store then
		arg_3_0:handleStoreChoice()

		return
	end

	arg_3_0:handleNormalChoice()
end

function var_0_0.handleNormalChoice(arg_4_0)
	if arg_4_0.status == RougeMapEnum.ChoiceStatus.Select then
		if arg_4_0.choiceId == 0 then
			RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
		else
			arg_4_0.animator:Play("select", 0, 0)
			TaskDispatcher.cancelTask(arg_4_0.onNormalChoiceSelectAnimDone, arg_4_0)
			TaskDispatcher.runDelay(arg_4_0.onNormalChoiceSelectAnimDone, arg_4_0, RougeMapEnum.ChoiceSelectAnimDuration)
			UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
		end
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, arg_4_0.dataId)
	end
end

function var_0_0.onNormalChoiceSelectAnimDone(arg_5_0)
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)

	local var_5_0 = lua_rouge_piece_select.configDict[arg_5_0.choiceId].triggerType

	if var_5_0 == RougeMapEnum.PieceTriggerType.Shop and arg_5_0.pieceMo.triggerStr and arg_5_0.pieceMo.triggerStr.repairShopCollections then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, arg_5_0.pieceMo, arg_5_0.choiceId)

		return
	elseif var_5_0 == RougeMapEnum.PieceTriggerType.EndFight and arg_5_0.pieceMo.selectId and arg_5_0.pieceMo.selectId ~= 0 then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, arg_5_0.pieceMo, arg_5_0.choiceId)

		return
	end

	arg_5_0:clearCallback()

	arg_5_0.callbackId = RougeRpc.instance:sendRougePieceTalkSelectRequest(arg_5_0.choiceId, arg_5_0.onReceiveMsg, arg_5_0)
end

function var_0_0.onReceiveMsg(arg_6_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectPieceChoice, arg_6_0.pieceMo, arg_6_0.choiceId)
end

function var_0_0.handleStoreChoice(arg_7_0)
	if arg_7_0.status == RougeMapEnum.ChoiceStatus.Select then
		arg_7_0.animator:Play("select", 0, 0)
		TaskDispatcher.cancelTask(arg_7_0.onStoreSelectAnimDone, arg_7_0)
		TaskDispatcher.runDelay(arg_7_0.onStoreSelectAnimDone, arg_7_0, RougeMapEnum.ChoiceSelectAnimDuration)
		UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, arg_7_0.dataId)
	end
end

function var_0_0.onStoreSelectAnimDone(arg_8_0)
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	arg_8_0:clearCallback()

	arg_8_0.callbackId = RougeRpc.instance:sendRougeRepairShopBuyRequest(arg_8_0.collectionId, arg_8_0.onReceiveBuyMsg, arg_8_0)
end

function var_0_0.onReceiveBuyMsg(arg_9_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshChoiceStore)
end

function var_0_0.onStatusChange(arg_10_0, arg_10_1)
	if arg_10_0.status == RougeMapEnum.ChoiceStatus.Lock or arg_10_0.status == RougeMapEnum.ChoiceStatus.Bought then
		return
	end

	local var_10_0

	if arg_10_1 then
		if arg_10_1 == arg_10_0.dataId then
			var_10_0 = RougeMapEnum.ChoiceStatus.Select
		else
			var_10_0 = RougeMapEnum.ChoiceStatus.UnSelect
		end
	else
		var_10_0 = RougeMapEnum.ChoiceStatus.Normal
	end

	if var_10_0 == arg_10_0.status then
		return
	end

	arg_10_0.status = var_10_0

	arg_10_0:refreshUI()
end

function var_0_0.update(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	var_0_0.super.update(arg_11_0, arg_11_2)

	arg_11_0.viewEnum = RougeMapEnum.PieceChoiceViewStatus.Choice
	arg_11_0.choiceId = arg_11_1
	arg_11_0.dataId = arg_11_1
	arg_11_0.pieceMo = arg_11_3
	arg_11_0.collectionIdList = nil

	if arg_11_0.choiceId == 0 then
		local var_11_0 = arg_11_0.pieceMo.talkId

		arg_11_0.desc = lua_rouge_piece_talk.configDict[var_11_0].exitDesc
		arg_11_0.title = ""
		arg_11_0.collectionId = nil
	else
		arg_11_0.choiceCo = lua_rouge_piece_select.configDict[arg_11_1]
		arg_11_0.desc = arg_11_0.choiceCo.content
		arg_11_0.title = arg_11_0.choiceCo.title
		arg_11_0.collectionId = arg_11_0.choiceCo.display
	end

	arg_11_0.status = RougeMapPieceTriggerHelper.getChoiceStatus(arg_11_3, arg_11_1)
	arg_11_0.tip = RougeMapPieceTriggerHelper.getTip(arg_11_0.pieceMo, arg_11_0.choiceId, arg_11_0.status)

	arg_11_0:refreshUI()
	arg_11_0:playUnlockAnim()
end

function var_0_0.updateStoreGoods(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	var_0_0.super.update(arg_12_0, arg_12_3)

	arg_12_0.collectionIdList = nil
	arg_12_0.viewEnum = RougeMapEnum.PieceChoiceViewStatus.Store
	arg_12_0.collectionId = arg_12_1
	arg_12_0.dataId = arg_12_1
	arg_12_0.consumeCo = arg_12_2
	arg_12_0.pieceMo = arg_12_4
	arg_12_0.consumeUnlockType = arg_12_2.unlockType
	arg_12_0.consumeUnlockParam = arg_12_2.unlockParam
	arg_12_0.boughtCollectionList = arg_12_4.triggerStr.curBoughtRepairShopCollections

	arg_12_0:initGoodsStatus()

	arg_12_0.title = ""
	arg_12_0.desc = arg_12_0.consumeCo.desc
	arg_12_0.tip = arg_12_0:getGoodsTip()

	arg_12_0:refreshUI()
end

function var_0_0.initGoodsStatus(arg_13_0)
	if tabletool.indexOf(arg_13_0.boughtCollectionList, arg_13_0.collectionId) then
		arg_13_0.status = RougeMapEnum.ChoiceStatus.Bought

		return
	end

	arg_13_0.status = RougeMapUnlockHelper.checkIsUnlock(arg_13_0.consumeUnlockType, arg_13_0.consumeUnlockParam) and RougeMapEnum.ChoiceStatus.Normal or RougeMapEnum.ChoiceStatus.Lock
end

function var_0_0.getGoodsTip(arg_14_0)
	if arg_14_0.status == RougeMapEnum.ChoiceStatus.Bought then
		return ""
	end

	if arg_14_0.status == RougeMapEnum.ChoiceStatus.Lock then
		return RougeMapUnlockHelper.getLockTips(arg_14_0.consumeUnlockType, arg_14_0.consumeUnlockParam)
	end

	return ""
end

function var_0_0.canShowLockUI(arg_15_0)
	return arg_15_0.status == RougeMapEnum.ChoiceStatus.Lock or arg_15_0.status == RougeMapEnum.ChoiceStatus.Bought
end

function var_0_0.refreshLockUI(arg_16_0)
	var_0_0.super.refreshLockUI(arg_16_0)
	arg_16_0:refreshCollection(arg_16_0._golockdetail2, arg_16_0._simagelockcollection)
end

function var_0_0.refreshNormalUI(arg_17_0)
	var_0_0.super.refreshNormalUI(arg_17_0)
	arg_17_0:refreshCollection(arg_17_0._gonormaldetail2, arg_17_0._simagenormalcollection)
end

function var_0_0.refreshSelectUI(arg_18_0)
	var_0_0.super.refreshSelectUI(arg_18_0)
	arg_18_0:refreshCollection(arg_18_0._goselectdetail2, arg_18_0._simageselectcollection)
end

function var_0_0.refreshCollection(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:hadCollection()

	gohelper.setActive(arg_19_1, var_19_0)

	if var_19_0 then
		arg_19_2:LoadImage(RougeCollectionHelper.getCollectionIconUrl(arg_19_0.collectionId))
	end
end

function var_0_0.hadCollection(arg_20_0)
	return arg_20_0.collectionId and arg_20_0.collectionId ~= 0
end

function var_0_0.playUnlockAnim(arg_21_0)
	if not arg_21_0.choiceCo then
		return
	end

	local var_21_0 = arg_21_0.choiceCo.activeType

	if var_21_0 == 0 then
		return
	end

	if RougeMapController.instance:checkPieceChoicePlayedUnlockAnim(arg_21_0.choiceId) then
		return
	end

	if RougeMapUnlockHelper.checkIsUnlock(var_21_0, arg_21_0.choiceCo.activeParam) then
		arg_21_0.animator:Play("unlock", 0, 0)
		RougeMapController.instance:playedPieceChoiceEvent(arg_21_0.choiceId)
	end
end

function var_0_0.destroy(arg_22_0)
	arg_22_0._btnlockdetail2:RemoveClickListener()
	arg_22_0._btnnormaldetail2:RemoveClickListener()
	arg_22_0._btnselectdetail2:RemoveClickListener()
	arg_22_0._simagenormalcollection:UnLoadImage()
	arg_22_0._simageselectcollection:UnLoadImage()
	var_0_0.super.destroy(arg_22_0)
end

return var_0_0
