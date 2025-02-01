module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceChoiceView", package.seeall)

slot0 = class("RougeMapPieceChoiceView", RougeMapChoiceBaseView)

function slot0._editableInitView(slot0)
	slot0.goFullBg = gohelper.findChild(slot0.viewGO, "all_bg/#simage_FullBG")
	slot0.goEpisodeBg = gohelper.findChild(slot0.viewGO, "all_bg/#simage_EpisodeBG")

	gohelper.setActive(slot0.goFullBg, false)
	gohelper.setActive(slot0.goEpisodeBg, false)

	slot0._simageFrameBG = gohelper.findChildSingleImage(slot0.viewGO, "all_bg/#simage_FrameBG")

	slot0._simageFrameBG:LoadImage("singlebg/rouge/rouge_illustration_framebg.png")

	slot0.goOptionItem = slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0._gochoicecontainer)

	gohelper.setActive(slot0.goOptionItem, false)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, slot0.closeThis, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onRefreshPieceChoiceEvent, slot0.onRefreshPieceChoiceEvent, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onRefreshChoiceStore, slot0.onRefreshChoiceStore, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChoiceViewStatusChange, slot0.onChoiceViewStatusChange, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectPieceChoice, slot0.onSelectPieceChoice, slot0)
	uv0.super._editableInitView(slot0)
end

function slot0.onClickBlockOnFinishState(slot0)
	slot0:triggerHandle()
end

function slot0.onRefreshChoiceStore(slot0)
	slot0:noAnimRefreshRight()
end

function slot0.onRefreshPieceChoiceEvent(slot0)
	slot0:playAnimRefreshRight()
end

function slot0.onSelectPieceChoice(slot0, slot1, slot2)
	if slot0.preSelectChoiceId == slot2 then
		RougeMapPieceTriggerHelper.triggerHandle(slot1, slot2)

		return
	end

	slot0._selectPieceMo = slot1
	slot0._choiceId = slot2
	slot0.preSelectChoiceId = slot2

	if string.nilorempty(lua_rouge_piece_select.configDict[slot2] and slot3.talkDesc) then
		slot0:triggerHandle()
	else
		slot0:startPlayDialogue(slot4, slot0.onSelectDialogueDone, slot0)
	end
end

function slot0.onSelectDialogueDone(slot0)
	if RougeMapHelper.isRestPiece(slot0._selectPieceMo.pieceCo.entrustType) then
		slot0:triggerHandle()

		return
	end

	slot0:changeState(RougeMapEnum.ChoiceViewState.Finish)
end

function slot0.triggerHandle(slot0)
	RougeMapPieceTriggerHelper.triggerHandle(slot0._selectPieceMo, slot0._choiceId)

	slot0._selectPieceMo = nil
	slot0._choiceId = nil

	slot0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
end

function slot0.onChoiceViewStatusChange(slot0, slot1)
	slot0.viewStatus = slot1

	slot0:playAnimRefreshRight()
end

function slot0.initData(slot0)
	slot0.pieceMo = slot0.viewParam
	slot0.talkId = slot0.pieceMo.talkId
	slot0.talkCo = lua_rouge_piece_talk.configDict[slot0.talkId]
	slot0.preSelectChoiceId = 0
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0.viewContainer:setOverrideClose(slot0.exitCurView, slot0)

	slot0.viewStatus = RougeMapEnum.PieceChoiceViewStatus.Choice

	slot0:initData()
	slot0:refreshUI()
	slot0:refreshDesc()
end

function slot0.refreshUI(slot0)
	slot0._txtName.text = slot0.talkCo.title
	slot0._txtNameEn.text = ""
end

function slot0.refreshDesc(slot0)
	slot0:startPlayDialogue(slot0.talkCo.content, slot0.enterDialogueDone, slot0)
end

function slot0.enterDialogueDone(slot0)
	gohelper.setActive(slot0.goRight, true)
	gohelper.setActive(slot0.goLeft, true)
	slot0:playChoiceShowAnim()
	slot0:refreshChoice()
end

function slot0.playAnimRefreshRight(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	slot0.rightAnimator:Play("open", 0, 0)

	if slot0.viewStatus == RougeMapEnum.PieceChoiceViewStatus.Choice then
		slot0:refreshChoice()
	else
		slot0:refreshStoreGoods()
	end
end

function slot0.noAnimRefreshRight(slot0)
	if slot0.viewStatus == RougeMapEnum.PieceChoiceViewStatus.Choice then
		slot0:refreshChoice()
	else
		slot0:refreshStoreGoods()
	end
end

function slot0.refreshChoice(slot0)
	slot2 = string.splitToNumber(slot0.talkCo.selectIds, "|")

	RougeMapHelper.filterUnActivePieceChoice(slot2)
	table.insert(slot2, 0)

	slot0.posList = RougeMapEnum.ChoiceItemPos[#slot2]

	RougeMapHelper.loadItemWithCustomUpdateFunc(slot0.goChoiceItem, RougeMapPieceChoiceItem, slot2, slot0.choiceItemList, slot0.updateItem, slot0)

	if slot0.optionItem then
		slot0.optionItem:hide()
	end
end

function slot0.updateItem(slot0, slot1, slot2, slot3)
	slot1:update(slot3, slot0.posList[slot2], slot0.pieceMo)
end

function slot0.refreshStoreGoods(slot0)
	if not (slot0.pieceMo.triggerStr and slot0.pieceMo.triggerStr.repairShopCollections) then
		logError("store goods is nil")

		return
	end

	slot0.collectionList = slot0.collectionList or {}
	slot0.consumeCoList = slot0.consumeCoList or {}

	tabletool.clear(slot0.collectionList)
	tabletool.clear(slot0.consumeCoList)

	for slot5, slot6 in pairs(slot1) do
		table.insert(slot0.collectionList, tonumber(slot5))
		table.insert(slot0.consumeCoList, lua_rouge_repair_shop_price.configDict[slot6])
	end

	slot0.posList = RougeMapEnum.ChoiceItemPos[#slot0.collectionList + 1]

	RougeMapHelper.loadItemWithCustomUpdateFunc(slot0.goChoiceItem, RougeMapPieceChoiceItem, slot0.collectionList, slot0.choiceItemList, slot0.updateStoreGoods, slot0)

	if not slot0.optionItem then
		slot0.optionItem = RougeMapPieceOptionItem.New()

		slot0.optionItem:init(slot0.goOptionItem)
	end

	slot0.optionItem:show()
	slot0.optionItem:update(slot0.posList[slot2], slot0.pieceMo)
end

function slot0.updateStoreGoods(slot0, slot1, slot2, slot3)
	slot1:updateStoreGoods(slot3, slot0.consumeCoList[slot2], slot0.posList[slot2], slot0.pieceMo)
end

function slot0.exitCurView(slot0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function slot0.onDestroyView(slot0)
	if slot0.optionItem then
		slot0.optionItem:destroy()

		slot0.optionItem = nil
	end

	slot0._simageFrameBG:UnLoadImage()
	uv0.super.onDestroyView(slot0)
end

return slot0
