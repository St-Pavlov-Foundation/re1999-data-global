module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceChoiceView", package.seeall)

local var_0_0 = class("RougeMapPieceChoiceView", RougeMapChoiceBaseView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0.goFullBg = gohelper.findChild(arg_1_0.viewGO, "all_bg/#simage_FullBG")
	arg_1_0.goEpisodeBg = gohelper.findChild(arg_1_0.viewGO, "all_bg/#simage_EpisodeBG")

	gohelper.setActive(arg_1_0.goFullBg, false)
	gohelper.setActive(arg_1_0.goEpisodeBg, false)

	arg_1_0._simageFrameBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "all_bg/#simage_FrameBG")

	arg_1_0._simageFrameBG:LoadImage("singlebg/rouge/rouge_illustration_framebg.png")

	local var_1_0 = arg_1_0.viewContainer:getSetting().otherRes[2]

	arg_1_0.goOptionItem = arg_1_0.viewContainer:getResInst(var_1_0, arg_1_0._gochoicecontainer)

	gohelper.setActive(arg_1_0.goOptionItem, false)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onExitPieceChoiceEvent, arg_1_0.closeThis, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onRefreshPieceChoiceEvent, arg_1_0.onRefreshPieceChoiceEvent, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onRefreshChoiceStore, arg_1_0.onRefreshChoiceStore, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChoiceViewStatusChange, arg_1_0.onChoiceViewStatusChange, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectPieceChoice, arg_1_0.onSelectPieceChoice, arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0.onClickBlockOnFinishState(arg_2_0)
	arg_2_0:triggerHandle()
end

function var_0_0.onRefreshChoiceStore(arg_3_0)
	arg_3_0:noAnimRefreshRight()
end

function var_0_0.onRefreshPieceChoiceEvent(arg_4_0)
	arg_4_0:playAnimRefreshRight()
end

function var_0_0.onSelectPieceChoice(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.preSelectChoiceId == arg_5_2 then
		RougeMapPieceTriggerHelper.triggerHandle(arg_5_1, arg_5_2)

		return
	end

	local var_5_0 = lua_rouge_piece_select.configDict[arg_5_2]
	local var_5_1 = var_5_0 and var_5_0.talkDesc

	arg_5_0._selectPieceMo = arg_5_1
	arg_5_0._choiceId = arg_5_2
	arg_5_0.preSelectChoiceId = arg_5_2

	if string.nilorempty(var_5_1) then
		arg_5_0:triggerHandle()
	else
		arg_5_0:startPlayDialogue(var_5_1, arg_5_0.onSelectDialogueDone, arg_5_0)
	end
end

function var_0_0.onSelectDialogueDone(arg_6_0)
	if RougeMapHelper.isRestPiece(arg_6_0._selectPieceMo.pieceCo.entrustType) then
		arg_6_0:triggerHandle()

		return
	end

	arg_6_0:changeState(RougeMapEnum.ChoiceViewState.Finish)
end

function var_0_0.triggerHandle(arg_7_0)
	RougeMapPieceTriggerHelper.triggerHandle(arg_7_0._selectPieceMo, arg_7_0._choiceId)

	arg_7_0._selectPieceMo = nil
	arg_7_0._choiceId = nil

	arg_7_0:changeState(RougeMapEnum.ChoiceViewState.WaitSelect)
end

function var_0_0.onChoiceViewStatusChange(arg_8_0, arg_8_1)
	arg_8_0.viewStatus = arg_8_1

	arg_8_0:playAnimRefreshRight()
end

function var_0_0.initData(arg_9_0)
	arg_9_0.pieceMo = arg_9_0.viewParam
	arg_9_0.talkId = arg_9_0.pieceMo.talkId
	arg_9_0.talkCo = lua_rouge_piece_talk.configDict[arg_9_0.talkId]
	arg_9_0.preSelectChoiceId = 0
end

function var_0_0.onOpen(arg_10_0)
	var_0_0.super.onOpen(arg_10_0)
	arg_10_0.viewContainer:setOverrideClose(arg_10_0.exitCurView, arg_10_0)

	arg_10_0.viewStatus = RougeMapEnum.PieceChoiceViewStatus.Choice

	arg_10_0:initData()
	arg_10_0:refreshUI()
	arg_10_0:refreshDesc()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0._txtName.text = arg_11_0.talkCo.title
	arg_11_0._txtNameEn.text = ""
end

function var_0_0.refreshDesc(arg_12_0)
	local var_12_0 = arg_12_0.talkCo.content

	arg_12_0:startPlayDialogue(var_12_0, arg_12_0.enterDialogueDone, arg_12_0)
end

function var_0_0.enterDialogueDone(arg_13_0)
	gohelper.setActive(arg_13_0.goRight, true)
	gohelper.setActive(arg_13_0.goLeft, true)
	arg_13_0:playChoiceShowAnim()
	arg_13_0:refreshChoice()
end

function var_0_0.playAnimRefreshRight(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.ChoiceViewChoiceOpen)
	arg_14_0.rightAnimator:Play("open", 0, 0)

	if arg_14_0.viewStatus == RougeMapEnum.PieceChoiceViewStatus.Choice then
		arg_14_0:refreshChoice()
	else
		arg_14_0:refreshStoreGoods()
	end
end

function var_0_0.noAnimRefreshRight(arg_15_0)
	if arg_15_0.viewStatus == RougeMapEnum.PieceChoiceViewStatus.Choice then
		arg_15_0:refreshChoice()
	else
		arg_15_0:refreshStoreGoods()
	end
end

function var_0_0.refreshChoice(arg_16_0)
	local var_16_0 = arg_16_0.talkCo.selectIds
	local var_16_1 = string.splitToNumber(var_16_0, "|")

	RougeMapHelper.filterUnActivePieceChoice(var_16_1)
	table.insert(var_16_1, 0)

	arg_16_0.posList = RougeMapEnum.ChoiceItemPos[#var_16_1]

	RougeMapHelper.loadItemWithCustomUpdateFunc(arg_16_0.goChoiceItem, RougeMapPieceChoiceItem, var_16_1, arg_16_0.choiceItemList, arg_16_0.updateItem, arg_16_0)

	if arg_16_0.optionItem then
		arg_16_0.optionItem:hide()
	end
end

function var_0_0.updateItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_1:update(arg_17_3, arg_17_0.posList[arg_17_2], arg_17_0.pieceMo)
end

function var_0_0.refreshStoreGoods(arg_18_0)
	local var_18_0 = arg_18_0.pieceMo.triggerStr and arg_18_0.pieceMo.triggerStr.repairShopCollections

	if not var_18_0 then
		logError("store goods is nil")

		return
	end

	arg_18_0.collectionList = arg_18_0.collectionList or {}
	arg_18_0.consumeCoList = arg_18_0.consumeCoList or {}

	tabletool.clear(arg_18_0.collectionList)
	tabletool.clear(arg_18_0.consumeCoList)

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		iter_18_0 = tonumber(iter_18_0)

		local var_18_1 = lua_rouge_repair_shop_price.configDict[iter_18_1]

		table.insert(arg_18_0.collectionList, iter_18_0)
		table.insert(arg_18_0.consumeCoList, var_18_1)
	end

	local var_18_2 = #arg_18_0.collectionList + 1

	arg_18_0.posList = RougeMapEnum.ChoiceItemPos[var_18_2]

	RougeMapHelper.loadItemWithCustomUpdateFunc(arg_18_0.goChoiceItem, RougeMapPieceChoiceItem, arg_18_0.collectionList, arg_18_0.choiceItemList, arg_18_0.updateStoreGoods, arg_18_0)

	if not arg_18_0.optionItem then
		arg_18_0.optionItem = RougeMapPieceOptionItem.New()

		arg_18_0.optionItem:init(arg_18_0.goOptionItem)
	end

	arg_18_0.optionItem:show()
	arg_18_0.optionItem:update(arg_18_0.posList[var_18_2], arg_18_0.pieceMo)
end

function var_0_0.updateStoreGoods(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_1:updateStoreGoods(arg_19_3, arg_19_0.consumeCoList[arg_19_2], arg_19_0.posList[arg_19_2], arg_19_0.pieceMo)
end

function var_0_0.exitCurView(arg_20_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onExitPieceChoiceEvent)
end

function var_0_0.onDestroyView(arg_21_0)
	if arg_21_0.optionItem then
		arg_21_0.optionItem:destroy()

		arg_21_0.optionItem = nil
	end

	arg_21_0._simageFrameBG:UnLoadImage()
	var_0_0.super.onDestroyView(arg_21_0)
end

return var_0_0
