module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessTipView", package.seeall)

slot0 = class("EliminateChessTipView", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gochessTip = gohelper.findChild(slot0.viewGO, "#go_chessTip")
	slot0._imageChessQualityBG = gohelper.findChildImage(slot0.viewGO, "#go_chessTip/Info/#image_ChessQualityBG")
	slot0._imageChess = gohelper.findChildImage(slot0.viewGO, "#go_chessTip/Info/#image_Chess")
	slot0._goResource = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/#go_Resource")
	slot0._goResourceItem = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem")
	slot0._imageResourceQuality = gohelper.findChildImage(slot0.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	slot0._txtResourceNum = gohelper.findChildText(slot0.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	slot0._txtFireNum = gohelper.findChildText(slot0.viewGO, "#go_chessTip/Info/image_Fire/#txt_FireNum")
	slot0._goStar1 = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/Stars/#go_Star1")
	slot0._goStar2 = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/Stars/#go_Star2")
	slot0._goStar3 = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/Stars/#go_Star3")
	slot0._goStar4 = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/Stars/#go_Star4")
	slot0._goStar5 = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/Stars/#go_Star5")
	slot0._goStar6 = gohelper.findChild(slot0.viewGO, "#go_chessTip/Info/Stars/#go_Star6")
	slot0._txtChessName = gohelper.findChildText(slot0.viewGO, "#go_chessTip/Info/#txt_ChessName")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "#go_chessTip/Scroll View/Viewport/#txt_Descr")
	slot0._gochessResourceTip = gohelper.findChild(slot0.viewGO, "#go_chessResourceTip")
	slot0._goTipsBG = gohelper.findChild(slot0.viewGO, "#go_chessResourceTip/#go_TipsBG")
	slot0._btnsell = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_chessResourceTip/#btn_sell")
	slot0._txtopt = gohelper.findChildText(slot0.viewGO, "#go_chessResourceTip/#txt_opt")
	slot0._goResource2 = gohelper.findChild(slot0.viewGO, "#go_chessResourceTip/#go_Resource_2")
	slot0._goResourceItem2 = gohelper.findChild(slot0.viewGO, "#go_chessResourceTip/#go_Resource_2/#go_ResourceItem_2")
	slot0._txtConfirm = gohelper.findChildText(slot0.viewGO, "#go_chessResourceTip/#txt_Confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsell:AddClickListener(slot0._btnsellOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsell:RemoveClickListener()
end

slot1 = ZProj.UIEffectsCollection

function slot0._btnsellOnClick(slot0)
	if not EliminateLevelModel.instance:sellChessIsUnLock() then
		GameFacade.showToast(ToastEnum.EliminateChessSellLocked)

		return
	end

	if not slot0:canSell() then
		return
	end

	if slot0._uid == nil and slot0._strongholdId == nil then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_bank_open)
	WarChessRpc.instance:sendWarChessPieceSellRequest(slot0._uid, slot0._strongholdId, slot0._onSellChess, slot0)
end

function slot0._onSellChess(slot0)
	if slot0._sellCb and slot0._sellCbTarget then
		slot0._sellCb(slot0._sellCbTarget)
	end
end

function slot0._editableInitView(slot0)
	slot0.sellUIEffect = uv0.Get(slot0._btnsell.gameObject)
	slot0._gochessTipAni = slot0._gochessTip:GetComponent(typeof(UnityEngine.Animator))
	slot0._gochessResourceTipAni = slot0._gochessResourceTip:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.hideView(slot0, slot1, slot2)
	slot0._lastState = nil
	slot0._hideCb = slot1
	slot0._hideCbTarget = slot2

	if slot0._gochessTipAni and slot0._gochessResourceTipAni then
		slot0._gochessTipAni:Play("close")
		slot0._gochessResourceTipAni:Play("close")
		TaskDispatcher.runDelay(slot0.hideViewGo, slot0, 0.33)
	else
		slot0:hideViewGo()
	end
end

function slot0.hideViewGo(slot0)
	slot0:setViewActive(false)

	if slot0._hideCb then
		slot0._hideCb(slot0._hideCbTarget)
	end
end

function slot0.setViewActive(slot0, slot1)
	gohelper.setActive(slot0._gochessResourceTip, (slot0._showType == EliminateTeamChessEnum.ChessTipType.showDragTip or slot0._showType == EliminateTeamChessEnum.ChessTipType.showSell) and slot1)
	gohelper.setActive(slot0._gochessTip, (slot0._showType == EliminateTeamChessEnum.ChessTipType.showDesc or slot0._showType == EliminateTeamChessEnum.ChessTipType.showSell) and slot1)
end

function slot0.setSoliderIdAndShowType(slot0, slot1, slot2)
	slot0._soliderId = slot1
	slot0._showType = slot2
	slot0._config = EliminateConfig.instance:getSoldierChessConfig(slot0._soliderId)
	slot0._cost, slot0._costNumber = EliminateConfig.instance:getSoldierChessConfigConst(slot0._soliderId)

	if slot0._config then
		UISpriteSetMgr.instance:setV2a2ChessSprite(slot0._imageChess, slot0._config.resPic, false)
		UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. slot0._config.level, false)
	end

	slot0:refreshInfo()
	slot0:refreshResource()
	slot0:refreshSellResource()
	slot0:refreshViewState()
end

function slot0.canSell(slot0)
	if not EliminateLevelModel.instance:sellChessIsUnLock() then
		return false
	end

	if slot0._config.sell and slot1 == 1 then
		return false
	end

	return true
end

function slot0.setSellCb(slot0, slot1, slot2)
	slot0._sellCb = slot1
	slot0._sellCbTarget = slot2
end

function slot0.setChessUidAndStrongHoldId(slot0, slot1, slot2)
	slot0._uid = slot1
	slot0._strongholdId = slot2
end

function slot0.refreshViewState(slot0)
	slot1 = slot0._showType == EliminateTeamChessEnum.ChessTipType.showDragTip
	slot2 = slot0._showType == EliminateTeamChessEnum.ChessTipType.showSell
	slot3 = slot0._showType == EliminateTeamChessEnum.ChessTipType.showDesc
	slot4 = slot0._showType == EliminateTeamChessEnum.ChessTipType.showDragTip or slot0._showType == EliminateTeamChessEnum.ChessTipType.showSell
	slot5 = slot0._showType == EliminateTeamChessEnum.ChessTipType.showDesc or slot0._showType == EliminateTeamChessEnum.ChessTipType.showSell

	gohelper.setActive(slot0._btnsell.gameObject, slot2)
	gohelper.setActive(slot0._goConfirm, slot1)
	gohelper.setActive(slot0._goTipsBG, slot1)

	if slot2 and slot0.sellUIEffect then
		slot0.sellUIEffect:SetGray(not slot0:canSell())
	end

	slot0._txtopt.text = slot2 and "＋" or "－"

	gohelper.setActive(slot0._txtConfirm.gameObject, slot1)
	gohelper.setActive(slot0._goResource2, slot4)
	gohelper.setActive(slot0._gochessResourceTip, slot4)
	gohelper.setActive(slot0._gochessTip, slot5)

	if slot0._showType == EliminateTeamChessEnum.ChessTipType.showSell then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.SoliderChessSellViewOpen)
	end
end

function slot0.updateViewPositionByEntity(slot0, slot1, slot2, slot3)
	if slot1 == nil or slot0._config == nil then
		return
	end

	slot4 = slot2 and slot2.soliderTipOffsetX or EliminateTeamChessEnum.soliderTipOffsetX
	slot5 = slot2 and slot2.soliderTipOffsetY or EliminateTeamChessEnum.soliderTipOffsetY
	slot6, slot7, slot8 = slot1:getPosXYZ()

	if isTypeOf(slot1, TeamChessEmptyUnit) then
		slot6, slot7, slot8 = slot1:getTopPosXYZ()
	end

	if slot0._showType == EliminateTeamChessEnum.ChessTipType.showSell then
		transformhelper.setPos(slot0._gochessResourceTip.transform, slot6 + slot4, slot7 + slot5, slot8)
		transformhelper.setPos(slot0._gochessTip.transform, slot6 + EliminateTeamChessEnum.soliderSellTipOffsetX, slot7 + EliminateTeamChessEnum.soliderSellTipOffsetY, slot8)
	end

	if slot0._showType == EliminateTeamChessEnum.ChessTipType.showDragTip then
		transformhelper.setPos(slot0._gochessResourceTip.transform, slot6 + EliminateTeamChessEnum.soliderItemDragTipOffsetX, slot7 + EliminateTeamChessEnum.soliderItemDragTipOffsetY, slot8)
		slot0:refreshAddState(slot3)
	end

	if slot0._showType == EliminateTeamChessEnum.ChessTipType.showDesc then
		transformhelper.setPos(slot0._gochessTip.transform, slot6 + slot4, slot7 + slot5, slot8)
	end
end

function slot0.refreshAddState(slot0, slot1)
	if slot1 == nil then
		slot1 = true
	end

	if slot0._lastState == nil or slot0._lastState ~= slot1 then
		slot0._txtopt.text = slot1 and "－" or ""

		gohelper.setActive(slot0._goResource2, slot1)

		slot0._txtConfirm.text = slot1 and luaLang("EliminateChessTipView_1") or luaLang("EliminateChessTipView_2")
		slot0._lastState = slot1
	end
end

function slot0.refreshInfo(slot0)
	slot0._txtFireNum.text = slot0._config.defaultPower
	slot0._txtChessName.text = slot0._config.name
	slot0._txtDescr.text = EliminateLevelModel.instance.formatString(EliminateConfig.instance:getSoldierChessDesc(slot0._soliderId))
end

function slot0.refreshResource(slot0)
	if not slot0._cost then
		return
	end

	if slot0._resourceItem == nil then
		slot0._resourceItem = slot0:getUserDataTb_()
	end

	for slot4 = 1, #slot0._resourceItem do
		gohelper.setActive(slot0._resourceItem[slot4].item, false)
	end

	for slot4, slot5 in ipairs(slot0._cost) do
		slot6 = slot5[1]

		if slot0._resourceItem[slot4] == nil then
			slot9 = gohelper.clone(slot0._goResourceItem, slot0._goResource, slot6)
			slot10 = gohelper.findChildImage(slot9, "#image_ResourceQuality")
			slot11 = gohelper.findChildText(slot9, "#image_ResourceQuality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot10, EliminateTeamChessEnum.ResourceTypeToImagePath[slot6], false)

			slot11.text = slot5[2]

			table.insert(slot0._resourceItem, {
				item = slot9,
				resourceImage = slot10,
				resourceNumberText = slot11
			})
		else
			slot8.resourceNumberText.text = slot7

			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot8.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[slot6], false)
		end

		gohelper.setActive(slot0._resourceItem[slot4].item, true)
	end
end

function slot0.refreshSellResource(slot0)
	if not slot0._cost then
		return
	end

	slot1 = slot0._cost

	if slot0._showType == EliminateTeamChessEnum.ChessTipType.showSell then
		slot1 = EliminateTeamChessModel.instance:getSellResourceData(slot0._cost)
	end

	if slot0._resourceItem2 == nil then
		slot0._resourceItem2 = slot0:getUserDataTb_()
	end

	for slot5 = 1, #slot0._resourceItem2 do
		gohelper.setActive(slot0._resourceItem2[slot5].item, false)
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot6[1]

		if slot0._resourceItem2[slot5] == nil then
			slot10 = gohelper.clone(slot0._goResourceItem2, slot0._goResource2, slot7)
			slot11 = gohelper.findChildImage(slot10, "#image_ResourceQuality")
			slot12 = gohelper.findChildText(slot10, "#image_ResourceQuality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot11, EliminateTeamChessEnum.ResourceTypeToImagePath[slot7], false)

			slot12.text = tonumber(slot6[2])

			table.insert(slot0._resourceItem2, {
				item = slot10,
				resourceImage = slot11,
				resourceNumberText = slot12
			})
		else
			slot9.resourceNumberText.text = slot8

			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot9.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[slot7], false)
		end

		gohelper.setActive(slot0._resourceItem2[slot5].item, true)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.hideViewGo, slot0)

	slot0._sellCb = nil
	slot0._sellCbTarget = nil
end

return slot0
