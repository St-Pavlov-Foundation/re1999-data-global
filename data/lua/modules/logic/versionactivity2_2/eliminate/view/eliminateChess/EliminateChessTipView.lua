module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessTipView", package.seeall)

local var_0_0 = class("EliminateChessTipView", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochessTip = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip")
	arg_1_0._imageChessQualityBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_chessTip/Info/#image_ChessQualityBG")
	arg_1_0._imageChess = gohelper.findChildImage(arg_1_0.viewGO, "#go_chessTip/Info/#image_Chess")
	arg_1_0._goResource = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/#go_Resource")
	arg_1_0._goResourceItem = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem")
	arg_1_0._imageResourceQuality = gohelper.findChildImage(arg_1_0.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	arg_1_0._txtResourceNum = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	arg_1_0._txtFireNum = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip/Info/image_Fire/#txt_FireNum")
	arg_1_0._goStar1 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/Stars/#go_Star1")
	arg_1_0._goStar2 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/Stars/#go_Star2")
	arg_1_0._goStar3 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/Stars/#go_Star3")
	arg_1_0._goStar4 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/Stars/#go_Star4")
	arg_1_0._goStar5 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/Stars/#go_Star5")
	arg_1_0._goStar6 = gohelper.findChild(arg_1_0.viewGO, "#go_chessTip/Info/Stars/#go_Star6")
	arg_1_0._txtChessName = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip/Info/#txt_ChessName")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#go_chessTip/Scroll View/Viewport/#txt_Descr")
	arg_1_0._gochessResourceTip = gohelper.findChild(arg_1_0.viewGO, "#go_chessResourceTip")
	arg_1_0._goTipsBG = gohelper.findChild(arg_1_0.viewGO, "#go_chessResourceTip/#go_TipsBG")
	arg_1_0._btnsell = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_chessResourceTip/#btn_sell")
	arg_1_0._txtopt = gohelper.findChildText(arg_1_0.viewGO, "#go_chessResourceTip/#txt_opt")
	arg_1_0._goResource2 = gohelper.findChild(arg_1_0.viewGO, "#go_chessResourceTip/#go_Resource_2")
	arg_1_0._goResourceItem2 = gohelper.findChild(arg_1_0.viewGO, "#go_chessResourceTip/#go_Resource_2/#go_ResourceItem_2")
	arg_1_0._txtConfirm = gohelper.findChildText(arg_1_0.viewGO, "#go_chessResourceTip/#txt_Confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsell:AddClickListener(arg_2_0._btnsellOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsell:RemoveClickListener()
end

local var_0_1 = ZProj.UIEffectsCollection

function var_0_0._btnsellOnClick(arg_4_0)
	if not EliminateLevelModel.instance:sellChessIsUnLock() then
		GameFacade.showToast(ToastEnum.EliminateChessSellLocked)

		return
	end

	if not arg_4_0:canSell() then
		return
	end

	if arg_4_0._uid == nil and arg_4_0._strongholdId == nil then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_bank_open)
	WarChessRpc.instance:sendWarChessPieceSellRequest(arg_4_0._uid, arg_4_0._strongholdId, arg_4_0._onSellChess, arg_4_0)
end

function var_0_0._onSellChess(arg_5_0)
	if arg_5_0._sellCb and arg_5_0._sellCbTarget then
		arg_5_0._sellCb(arg_5_0._sellCbTarget)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.sellUIEffect = var_0_1.Get(arg_6_0._btnsell.gameObject)
	arg_6_0._gochessTipAni = arg_6_0._gochessTip:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._gochessResourceTipAni = arg_6_0._gochessResourceTip:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.hideView(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._lastState = nil
	arg_10_0._hideCb = arg_10_1
	arg_10_0._hideCbTarget = arg_10_2

	if arg_10_0._gochessTipAni and arg_10_0._gochessResourceTipAni then
		arg_10_0._gochessTipAni:Play("close")
		arg_10_0._gochessResourceTipAni:Play("close")
		TaskDispatcher.runDelay(arg_10_0.hideViewGo, arg_10_0, 0.33)
	else
		arg_10_0:hideViewGo()
	end
end

function var_0_0.hideViewGo(arg_11_0)
	arg_11_0:setViewActive(false)

	if arg_11_0._hideCb then
		arg_11_0._hideCb(arg_11_0._hideCbTarget)
	end
end

function var_0_0.setViewActive(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._showType == EliminateTeamChessEnum.ChessTipType.showDragTip or arg_12_0._showType == EliminateTeamChessEnum.ChessTipType.showSell
	local var_12_1 = arg_12_0._showType == EliminateTeamChessEnum.ChessTipType.showDesc or arg_12_0._showType == EliminateTeamChessEnum.ChessTipType.showSell

	gohelper.setActive(arg_12_0._gochessResourceTip, var_12_0 and arg_12_1)
	gohelper.setActive(arg_12_0._gochessTip, var_12_1 and arg_12_1)
end

function var_0_0.setSoliderIdAndShowType(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._soliderId = arg_13_1
	arg_13_0._showType = arg_13_2
	arg_13_0._config = EliminateConfig.instance:getSoldierChessConfig(arg_13_0._soliderId)
	arg_13_0._cost, arg_13_0._costNumber = EliminateConfig.instance:getSoldierChessConfigConst(arg_13_0._soliderId)

	if arg_13_0._config then
		UISpriteSetMgr.instance:setV2a2ChessSprite(arg_13_0._imageChess, arg_13_0._config.resPic, false)
		UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_13_0._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. arg_13_0._config.level, false)
	end

	arg_13_0:refreshInfo()
	arg_13_0:refreshResource()
	arg_13_0:refreshSellResource()
	arg_13_0:refreshViewState()
end

function var_0_0.canSell(arg_14_0)
	if not EliminateLevelModel.instance:sellChessIsUnLock() then
		return false
	end

	local var_14_0 = arg_14_0._config.sell

	if var_14_0 and var_14_0 == 1 then
		return false
	end

	return true
end

function var_0_0.setSellCb(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._sellCb = arg_15_1
	arg_15_0._sellCbTarget = arg_15_2
end

function var_0_0.setChessUidAndStrongHoldId(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._uid = arg_16_1
	arg_16_0._strongholdId = arg_16_2
end

function var_0_0.refreshViewState(arg_17_0)
	local var_17_0 = arg_17_0._showType == EliminateTeamChessEnum.ChessTipType.showDragTip
	local var_17_1 = arg_17_0._showType == EliminateTeamChessEnum.ChessTipType.showSell
	local var_17_2

	var_17_2 = arg_17_0._showType == EliminateTeamChessEnum.ChessTipType.showDesc

	local var_17_3 = arg_17_0._showType == EliminateTeamChessEnum.ChessTipType.showDragTip or arg_17_0._showType == EliminateTeamChessEnum.ChessTipType.showSell
	local var_17_4 = arg_17_0._showType == EliminateTeamChessEnum.ChessTipType.showDesc or arg_17_0._showType == EliminateTeamChessEnum.ChessTipType.showSell

	gohelper.setActive(arg_17_0._btnsell.gameObject, var_17_1)
	gohelper.setActive(arg_17_0._goConfirm, var_17_0)
	gohelper.setActive(arg_17_0._goTipsBG, var_17_0)

	if var_17_1 and arg_17_0.sellUIEffect then
		arg_17_0.sellUIEffect:SetGray(not arg_17_0:canSell())
	end

	arg_17_0._txtopt.text = var_17_1 and "＋" or "－"

	gohelper.setActive(arg_17_0._txtConfirm.gameObject, var_17_0)
	gohelper.setActive(arg_17_0._goResource2, var_17_3)
	gohelper.setActive(arg_17_0._gochessResourceTip, var_17_3)
	gohelper.setActive(arg_17_0._gochessTip, var_17_4)

	if arg_17_0._showType == EliminateTeamChessEnum.ChessTipType.showSell then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.SoliderChessSellViewOpen)
	end
end

function var_0_0.updateViewPositionByEntity(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_1 == nil or arg_18_0._config == nil then
		return
	end

	local var_18_0 = arg_18_2 and arg_18_2.soliderTipOffsetX or EliminateTeamChessEnum.soliderTipOffsetX
	local var_18_1 = arg_18_2 and arg_18_2.soliderTipOffsetY or EliminateTeamChessEnum.soliderTipOffsetY
	local var_18_2, var_18_3, var_18_4 = arg_18_1:getPosXYZ()

	if isTypeOf(arg_18_1, TeamChessEmptyUnit) then
		var_18_2, var_18_3, var_18_4 = arg_18_1:getTopPosXYZ()
	end

	if arg_18_0._showType == EliminateTeamChessEnum.ChessTipType.showSell then
		transformhelper.setPos(arg_18_0._gochessResourceTip.transform, var_18_2 + var_18_0, var_18_3 + var_18_1, var_18_4)
		transformhelper.setPos(arg_18_0._gochessTip.transform, var_18_2 + EliminateTeamChessEnum.soliderSellTipOffsetX, var_18_3 + EliminateTeamChessEnum.soliderSellTipOffsetY, var_18_4)
	end

	if arg_18_0._showType == EliminateTeamChessEnum.ChessTipType.showDragTip then
		var_18_0 = EliminateTeamChessEnum.soliderItemDragTipOffsetX
		var_18_1 = EliminateTeamChessEnum.soliderItemDragTipOffsetY

		transformhelper.setPos(arg_18_0._gochessResourceTip.transform, var_18_2 + var_18_0, var_18_3 + var_18_1, var_18_4)
		arg_18_0:refreshAddState(arg_18_3)
	end

	if arg_18_0._showType == EliminateTeamChessEnum.ChessTipType.showDesc then
		transformhelper.setPos(arg_18_0._gochessTip.transform, var_18_2 + var_18_0, var_18_3 + var_18_1, var_18_4)
	end
end

function var_0_0.refreshAddState(arg_19_0, arg_19_1)
	if arg_19_1 == nil then
		arg_19_1 = true
	end

	if arg_19_0._lastState == nil or arg_19_0._lastState ~= arg_19_1 then
		arg_19_0._txtopt.text = arg_19_1 and "－" or ""

		gohelper.setActive(arg_19_0._goResource2, arg_19_1)

		arg_19_0._txtConfirm.text = arg_19_1 and luaLang("EliminateChessTipView_1") or luaLang("EliminateChessTipView_2")
		arg_19_0._lastState = arg_19_1
	end
end

function var_0_0.refreshInfo(arg_20_0)
	arg_20_0._txtFireNum.text = arg_20_0._config.defaultPower
	arg_20_0._txtChessName.text = arg_20_0._config.name

	local var_20_0 = EliminateConfig.instance:getSoldierChessDesc(arg_20_0._soliderId)

	arg_20_0._txtDescr.text = EliminateLevelModel.instance.formatString(var_20_0)
end

function var_0_0.refreshResource(arg_21_0)
	if not arg_21_0._cost then
		return
	end

	if arg_21_0._resourceItem == nil then
		arg_21_0._resourceItem = arg_21_0:getUserDataTb_()
	end

	for iter_21_0 = 1, #arg_21_0._resourceItem do
		local var_21_0 = arg_21_0._resourceItem[iter_21_0]

		gohelper.setActive(var_21_0.item, false)
	end

	for iter_21_1, iter_21_2 in ipairs(arg_21_0._cost) do
		local var_21_1 = iter_21_2[1]
		local var_21_2 = iter_21_2[2]
		local var_21_3 = arg_21_0._resourceItem[iter_21_1]

		if var_21_3 == nil then
			local var_21_4 = gohelper.clone(arg_21_0._goResourceItem, arg_21_0._goResource, var_21_1)
			local var_21_5 = gohelper.findChildImage(var_21_4, "#image_ResourceQuality")
			local var_21_6 = gohelper.findChildText(var_21_4, "#image_ResourceQuality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(var_21_5, EliminateTeamChessEnum.ResourceTypeToImagePath[var_21_1], false)

			var_21_6.text = var_21_2
			var_21_3 = {
				item = var_21_4,
				resourceImage = var_21_5,
				resourceNumberText = var_21_6
			}

			table.insert(arg_21_0._resourceItem, var_21_3)
		else
			var_21_3.resourceNumberText.text = var_21_2

			UISpriteSetMgr.instance:setV2a2EliminateSprite(var_21_3.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[var_21_1], false)
		end

		local var_21_7 = arg_21_0._resourceItem[iter_21_1]

		gohelper.setActive(var_21_7.item, true)
	end
end

function var_0_0.refreshSellResource(arg_22_0)
	if not arg_22_0._cost then
		return
	end

	local var_22_0 = arg_22_0._cost

	if arg_22_0._showType == EliminateTeamChessEnum.ChessTipType.showSell then
		var_22_0 = EliminateTeamChessModel.instance:getSellResourceData(arg_22_0._cost)
	end

	if arg_22_0._resourceItem2 == nil then
		arg_22_0._resourceItem2 = arg_22_0:getUserDataTb_()
	end

	for iter_22_0 = 1, #arg_22_0._resourceItem2 do
		local var_22_1 = arg_22_0._resourceItem2[iter_22_0]

		gohelper.setActive(var_22_1.item, false)
	end

	for iter_22_1, iter_22_2 in ipairs(var_22_0) do
		local var_22_2 = iter_22_2[1]
		local var_22_3 = tonumber(iter_22_2[2])
		local var_22_4 = arg_22_0._resourceItem2[iter_22_1]

		if var_22_4 == nil then
			local var_22_5 = gohelper.clone(arg_22_0._goResourceItem2, arg_22_0._goResource2, var_22_2)
			local var_22_6 = gohelper.findChildImage(var_22_5, "#image_ResourceQuality")
			local var_22_7 = gohelper.findChildText(var_22_5, "#image_ResourceQuality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(var_22_6, EliminateTeamChessEnum.ResourceTypeToImagePath[var_22_2], false)

			var_22_7.text = var_22_3
			var_22_4 = {
				item = var_22_5,
				resourceImage = var_22_6,
				resourceNumberText = var_22_7
			}

			table.insert(arg_22_0._resourceItem2, var_22_4)
		else
			var_22_4.resourceNumberText.text = var_22_3

			UISpriteSetMgr.instance:setV2a2EliminateSprite(var_22_4.resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[var_22_2], false)
		end

		local var_22_8 = arg_22_0._resourceItem2[iter_22_1]

		gohelper.setActive(var_22_8.item, true)
	end
end

function var_0_0.onDestroyView(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.hideViewGo, arg_23_0)

	arg_23_0._sellCb = nil
	arg_23_0._sellCbTarget = nil
end

return var_0_0
