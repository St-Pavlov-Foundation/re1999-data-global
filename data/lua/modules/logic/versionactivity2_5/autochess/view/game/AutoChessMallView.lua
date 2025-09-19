module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallView", package.seeall)

local var_0_0 = class("AutoChessMallView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goViewSelf = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf")
	arg_1_0._goFrame = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_Frame")
	arg_1_0._goMallItem = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_MallItem")
	arg_1_0._txtCoin = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/Coin/#txt_Coin")
	arg_1_0._goRound = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_Round")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#go_Round/#txt_Round")
	arg_1_0._btnStartFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/#btn_StartFight")
	arg_1_0._goStartLight = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#btn_StartFight/#go_StartLight")
	arg_1_0._btnCheckEnemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/#btn_CheckEnemy")
	arg_1_0._goCheckCost = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#btn_CheckEnemy/#go_CheckCost")
	arg_1_0._txtCheckCost = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#btn_CheckEnemy/#go_CheckCost/#txt_CheckCost")
	arg_1_0._btnLederSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill")
	arg_1_0._simageSkill = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#simage_Skill")
	arg_1_0._txtSkillCost = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#txt_SkillCost")
	arg_1_0._imageSkillCost = gohelper.findChildImage(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#txt_SkillCost/#image_SkillCost")
	arg_1_0._goSkillLock = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#go_SkillLock")
	arg_1_0._goSkillLight = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#go_SkillLight")
	arg_1_0._btnCancelUse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/#btn_CancelUse")
	arg_1_0._btnPlayerBuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/#btn_PlayerBuff")
	arg_1_0._txtEnergyP = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#btn_PlayerBuff/#txt_EnergyP")
	arg_1_0._txtFireP = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#btn_PlayerBuff/#txt_FireP")
	arg_1_0._goChargeRoot = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot")
	arg_1_0._imageLevel = gohelper.findChildImage(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#image_Level")
	arg_1_0._txtMallLvl = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#image_Level/#txt_MallLvl")
	arg_1_0._goChargeFrame = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeFrame")
	arg_1_0._goFreeFrame = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeFrame/#go_FreeFrame")
	arg_1_0._btnFresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#btn_Fresh")
	arg_1_0._txtFreshCost = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#btn_Fresh/#txt_FreshCost")
	arg_1_0._goLockBtns = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_LockBtns")
	arg_1_0._btnLock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_LockBtns/#btn_Lock")
	arg_1_0._btnUnlock = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_LockBtns/#btn_Unlock")
	arg_1_0._goChargeContent = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/Bottom/#go_ChargeRoot/#go_ChargeContent")
	arg_1_0._goSelectChessTip = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_SelectChessTip")
	arg_1_0._goCheckSell = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_CheckSell")
	arg_1_0._txtSellPrice = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#go_CheckSell/cost/#txt_SellPrice")
	arg_1_0._goChessAvatar = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_ChessAvatar")
	arg_1_0._goViewEnemy = gohelper.findChild(arg_1_0.viewGO, "#go_ViewEnemy")
	arg_1_0._btnBack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewEnemy/#btn_Back")
	arg_1_0._goEnemyBuff = gohelper.findChild(arg_1_0.viewGO, "#go_ViewEnemy/#go_EnemyBuff")
	arg_1_0._txtEnergyE = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewEnemy/#go_EnemyBuff/#txt_EnergyE")
	arg_1_0._txtFireE = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewEnemy/#go_EnemyBuff/#txt_FireE")
	arg_1_0._goPickView = gohelper.findChild(arg_1_0.viewGO, "#go_PickView")
	arg_1_0._btnBackPick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_PickView/#btn_BackPick")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStartFight:AddClickListener(arg_2_0._btnStartFightOnClick, arg_2_0)
	arg_2_0._btnCheckEnemy:AddClickListener(arg_2_0._btnCheckEnemyOnClick, arg_2_0)
	arg_2_0._btnLederSkill:AddClickListener(arg_2_0._btnLederSkillOnClick, arg_2_0)
	arg_2_0._btnCancelUse:AddClickListener(arg_2_0._btnCancelUseOnClick, arg_2_0)
	arg_2_0._btnPlayerBuff:AddClickListener(arg_2_0._btnPlayerBuffOnClick, arg_2_0)
	arg_2_0._btnFresh:AddClickListener(arg_2_0._btnFreshOnClick, arg_2_0)
	arg_2_0._btnLock:AddClickListener(arg_2_0._btnLockOnClick, arg_2_0)
	arg_2_0._btnUnlock:AddClickListener(arg_2_0._btnUnlockOnClick, arg_2_0)
	arg_2_0._btnBack:AddClickListener(arg_2_0._btnBackOnClick, arg_2_0)
	arg_2_0._btnBackPick:AddClickListener(arg_2_0._btnBackPickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStartFight:RemoveClickListener()
	arg_3_0._btnCheckEnemy:RemoveClickListener()
	arg_3_0._btnLederSkill:RemoveClickListener()
	arg_3_0._btnCancelUse:RemoveClickListener()
	arg_3_0._btnPlayerBuff:RemoveClickListener()
	arg_3_0._btnFresh:RemoveClickListener()
	arg_3_0._btnLock:RemoveClickListener()
	arg_3_0._btnUnlock:RemoveClickListener()
	arg_3_0._btnBack:RemoveClickListener()
	arg_3_0._btnBackPick:RemoveClickListener()
end

function var_0_0._btnPlayerBuffOnClick(arg_4_0)
	if AutoChessGameModel.instance.usingLeaderSkill then
		AutoChessGameModel.instance:setUsingLeaderSkill(false)

		return
	end

	if arg_4_0._txtEnergyP.gameObject.activeInHierarchy or arg_4_0._txtFireP.gameObject.activeInHierarchy then
		local var_4_0 = ViewMgr.instance:getUIRoot()
		local var_4_1 = arg_4_0._btnPlayerBuff.gameObject.transform.position
		local var_4_2 = recthelper.rectToRelativeAnchorPos(var_4_1, var_4_0.transform)

		ViewMgr.instance:openView(ViewName.AutoChessLeaderBuffView, {
			position = var_4_2
		})
	end
end

function var_0_0._btnCancelUseOnClick(arg_5_0)
	AutoChessGameModel.instance:setUsingLeaderSkill(false)
end

function var_0_0._btnBackPickOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._btnLederSkill, true)
	gohelper.setActive(arg_6_0._btnPlayerBuff, true)
	gohelper.setActive(arg_6_0._btnCheckEnemy, true)
	gohelper.setActive(arg_6_0._btnStartFight, true)
	gohelper.setActive(arg_6_0._goRound, true)
	gohelper.setActive(arg_6_0._btnFresh, true)
	gohelper.setActive(arg_6_0._goLockBtns, true)
	gohelper.setActive(arg_6_0._goPickView, false)
	ViewMgr.instance:openView(ViewName.AutoChessForcePickView, arg_6_0.freeMall)
end

function var_0_0._btnCheckEnemyOnClick(arg_7_0)
	if arg_7_0.chessMo.preview then
		arg_7_0:previewCallback(0, 0)
	elseif arg_7_0.previewCostEnough then
		AutoChessRpc.instance:sendAutoChessPreviewFightRequest(arg_7_0.moduleId, arg_7_0.previewCallback, arg_7_0)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function var_0_0._btnLederSkillOnClick(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:checkCanUseLeaderSkill()

	if var_8_0 then
		if arg_8_0.masterSkillCo.needTarget then
			if AutoChessGameModel.instance.usingLeaderSkill then
				arg_8_0:_btnCancelUseOnClick()
			else
				local var_8_2 = string.split(arg_8_0.masterSkillCo.targetType, "#")

				AutoChessGameModel.instance:setUsingLeaderSkill(true, var_8_2)
			end

			return
		end

		arg_8_0.animBtnSkill:Play("click", 0, 0)

		local var_8_3 = arg_8_0.chessMo.svrFight.mySideMaster

		AutoChessRpc.instance:sendAutoChessUseMasterSkillRequest(arg_8_0.moduleId, var_8_3.skill.id)
	else
		GameFacade.showToast(var_8_1)
	end
end

function var_0_0._btnBackOnClick(arg_9_0)
	arg_9_0.checkingEnemy = false

	arg_9_0.animSwitch:Play("story", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
	TaskDispatcher.runDelay(arg_9_0.delaySwitch, arg_9_0, 0.35)
end

function var_0_0.previewCallback(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == 0 then
		arg_10_0.checkingEnemy = true

		arg_10_0.animSwitch:Play("hard", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
		TaskDispatcher.runDelay(arg_10_0.delaySwitch, arg_10_0, 0.35)
	end
end

function var_0_0.delaySwitch(arg_11_0)
	if arg_11_0.checkingEnemy then
		gohelper.setActive(arg_11_0._goCheckCost, false)
		gohelper.setActive(arg_11_0._goViewSelf, false)
		gohelper.setActive(arg_11_0._goViewEnemy, true)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.CheckEnemyTeam, true)
	else
		gohelper.setActive(arg_11_0._goViewSelf, true)
		gohelper.setActive(arg_11_0._goViewEnemy, false)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.CheckEnemyTeam, false)
	end
end

function var_0_0._btnFreshOnClick(arg_12_0)
	if tonumber(arg_12_0.chessMo.svrMall.coin) >= arg_12_0.freshCost then
		AutoChessHelper.lockScreen("AutoChessMallViewFreshStore", true)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_mln_details_open)
		gohelper.addChildPosStay(arg_12_0._goChargeRoot, arg_12_0.freeItem.go)
		arg_12_0.animBtnFresh:Play("click", 0, 0)
		arg_12_0.animBottom:Play("flushed", 0, 0)
		TaskDispatcher.runDelay(arg_12_0.delayRefreshStore, arg_12_0, 0.16)
		TaskDispatcher.runDelay(arg_12_0.delaySetFreeItem, arg_12_0, 0.4)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function var_0_0.delayRefreshStore(arg_13_0)
	AutoChessRpc.instance:sendAutoChessRefreshMallRequest(arg_13_0.moduleId)
end

function var_0_0.delaySetFreeItem(arg_14_0)
	gohelper.addChildPosStay(arg_14_0._goChargeContent, arg_14_0.freeItem.go)
	AutoChessHelper.lockScreen("AutoChessMallViewFreshStore", false)
end

function var_0_0._btnLockOnClick(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_lock)
	AutoChessRpc.instance:sendAutoChessFreezeItemRequest(arg_15_0.moduleId, arg_15_0.chargeMall.mallId, 0, AutoChessEnum.FreeZeType.Freeze, arg_15_0.freezeReply, arg_15_0)
end

function var_0_0._btnUnlockOnClick(arg_16_0)
	AutoChessRpc.instance:sendAutoChessFreezeItemRequest(arg_16_0.moduleId, arg_16_0.chargeMall.mallId, 0, AutoChessEnum.FreeZeType.UnFreeze, arg_16_0.freezeReply, arg_16_0)
end

function var_0_0._btnStartFightOnClick(arg_17_0)
	if #AutoChessHelper.getMallRegionByType(arg_17_0.chessMo.svrMall.regions, AutoChessEnum.MallType.Free).items ~= 0 then
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessFreeChessClean, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, arg_17_0._fightYesCallback, nil, nil, arg_17_0)
	else
		arg_17_0:_fightYesCallback()
	end
end

function var_0_0._fightYesCallback(arg_18_0)
	AutoChessRpc.instance:sendAutoChessEnterFightRequest(arg_18_0.moduleId)
end

function var_0_0._overrideClose(arg_19_0)
	if arg_19_0._btnBack.gameObject.activeInHierarchy then
		arg_19_0:_btnBackOnClick()

		return
	end

	AutoChessController.instance:exitGame()
end

function var_0_0._editableInitView(arg_20_0)
	arg_20_0.animFreeFrame = gohelper.findChild(arg_20_0.viewGO, "#go_ViewSelf/Bottom/Left/FreeFrame"):GetComponent(gohelper.Type_Animator)
	arg_20_0.goBottom = gohelper.findChild(arg_20_0.viewGO, "#go_ViewSelf/Bottom")
	arg_20_0.animBottom = arg_20_0.goBottom:GetComponent(gohelper.Type_Animator)
	arg_20_0.animBtnFresh = arg_20_0._btnFresh.gameObject:GetComponent(gohelper.Type_Animator)
	arg_20_0.animSwitch = arg_20_0._goexcessive:GetComponent(gohelper.Type_Animator)
	arg_20_0.animCoin = arg_20_0._txtCoin.gameObject:GetComponent(gohelper.Type_Animator)
	arg_20_0.animBtnSkill = arg_20_0._btnLederSkill.gameObject:GetComponent(gohelper.Type_Animator)

	arg_20_0:initMallItemList()

	arg_20_0.moduleId = AutoChessModel.instance.moduleId
	arg_20_0.chessMo = AutoChessModel.instance:getChessMo()
end

function var_0_0.onOpen(arg_21_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_shopping_enter)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.StartFight, arg_21_0.closeThis, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateMallData, arg_21_0.refreshUI, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntity, arg_21_0.onDragChess, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntityEnd, arg_21_0.onDragChessEnd, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.MallCoinChange, arg_21_0.onCoinChange, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.ForcePickViewBoard, arg_21_0.onViewBoard, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.ForcePickReply, arg_21_0.onForcePickReply, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateMallRegion, arg_21_0.onMallRegionChange, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateMasterSkill, arg_21_0.refreshLeaderSkillRelative, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateLeaderBuff, arg_21_0.refreshLeaderBuff, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItem, arg_21_0.onDragMallItem, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItemEnd, arg_21_0.onDragMallItemEnd, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.BuyChessReply, arg_21_0.onBuyReply, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.BuildReply, arg_21_0.onBuildReply, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.StartBuyStepFinih, arg_21_0.onStartBuyFinish, arg_21_0)
	arg_21_0:addEventCb(AutoChessController.instance, AutoChessEvent.UsingLeaderSkill, arg_21_0.onUsingLeaderSkill, arg_21_0)
	arg_21_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_21_0.onCloseView, arg_21_0)
	AutoChessGameModel.instance:setChessAvatar(arg_21_0._goChessAvatar)
	arg_21_0:refreshUI()

	if arg_21_0.viewParam then
		if arg_21_0.viewParam.firstEnter then
			if arg_21_0.moduleId == AutoChessEnum.ModuleId.PVP2 then
				ViewMgr.instance:openView(ViewName.AutoChessCrazyModeTipView)
			else
				AutoChessController.instance:dispatchEvent(AutoChessEvent.ZTrigger28302)
			end
		end

		arg_21_0.startBuyEnd = true
	end

	arg_21_0:checkPopUp()
end

function var_0_0.onClose(arg_22_0)
	AutoChessGameModel.instance.avatar = nil
end

function var_0_0.onDestroyView(arg_23_0)
	if arg_23_0._tweenId then
		ZProj.TweenHelper.KillById(arg_23_0._tweenId)

		arg_23_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_23_0.delaySetFreeItem, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.checkForcePick, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.recordItemPos, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0.delaySwitch, arg_23_0)
end

function var_0_0.initMallItemList(arg_24_0)
	arg_24_0.chargeFrameList = arg_24_0:getUserDataTb_()
	arg_24_0.chargeItemList = {}

	for iter_24_0 = 1, 7 do
		if iter_24_0 == 1 then
			local var_24_0 = gohelper.clone(arg_24_0._goMallItem, arg_24_0._goChargeContent, "freeItem" .. iter_24_0)

			arg_24_0.freeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_0, AutoChessMallItem, arg_24_0)
		end

		local var_24_1 = gohelper.clone(arg_24_0._goFrame, arg_24_0._goChargeFrame, "chargeFrame" .. iter_24_0)

		arg_24_0.chargeFrameList[iter_24_0] = var_24_1.transform

		local var_24_2 = gohelper.clone(arg_24_0._goMallItem, arg_24_0._goChargeContent, "chargeItem" .. iter_24_0)
		local var_24_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_2, AutoChessMallItem, arg_24_0)

		arg_24_0.chargeItemList[iter_24_0] = var_24_3
	end

	gohelper.setActive(arg_24_0._goFrame, false)
	gohelper.setActive(arg_24_0._goMallItem, false)
	TaskDispatcher.runDelay(arg_24_0.recordItemPos, arg_24_0, 0.01)
end

function var_0_0.recordItemPos(arg_25_0)
	for iter_25_0 = 1, 7 do
		if iter_25_0 == 1 then
			local var_25_0, var_25_1 = recthelper.getAnchor(arg_25_0._goFreeFrame.transform)

			arg_25_0.freeItem:setPos(var_25_0, var_25_1)
		end

		local var_25_2, var_25_3 = recthelper.getAnchor(arg_25_0.chargeFrameList[iter_25_0])

		arg_25_0.chargeItemList[iter_25_0]:setPos(var_25_2, var_25_3)
	end
end

function var_0_0.refreshUI(arg_26_0)
	local var_26_0 = arg_26_0.chessMo.svrMall

	arg_26_0:refreshMallItem(var_26_0)

	local var_26_1 = AutoChessHelper.getMallRegionByType(var_26_0.regions, AutoChessEnum.MallType.Normal)
	local var_26_2 = lua_auto_chess_mall.configDict[var_26_1.mallId]
	local var_26_3 = var_26_2 and var_26_2.showLevel or 0

	UISpriteSetMgr.instance:setAutoChessSprite(arg_26_0._imageLevel, "v2a5_autochess_quality3_" .. var_26_3)

	arg_26_0._txtMallLvl.text = "Lv." .. var_26_3

	gohelper.setActive(arg_26_0._goCheckCost, not arg_26_0.chessMo.preview)

	local var_26_4 = AutoChessEnum.ConstKey.ChessSellPrice

	arg_26_0._txtSellPrice.text = lua_auto_chess_const.configDict[var_26_4].value

	arg_26_0:refreshLeaderSkillRelative()
	arg_26_0:refreshLeaderBuff()
	arg_26_0:refreshCoinRelative()
	arg_26_0:refreshRoundRelative()
	arg_26_0:refreshMallLock()
end

function var_0_0.refreshRoundRelative(arg_27_0)
	local var_27_0 = arg_27_0.chessMo.sceneRound

	if arg_27_0.chessMo.svrMall.freeRefreshCount > 0 then
		arg_27_0.freshCost = 0
	else
		arg_27_0.freshCost = tonumber(lua_auto_chess_mall_refresh.configDict[var_27_0].cost)
	end

	arg_27_0._txtFreshCost.text = arg_27_0.freshCost

	local var_27_1 = AutoChessModel.instance.episodeId
	local var_27_2 = AutoChessConfig.instance:getEpisodeCO(var_27_1)

	arg_27_0._txtRound.text = string.format("%d/%d", var_27_0, var_27_2.maxRound)
end

function var_0_0.refreshMallLock(arg_28_0)
	local var_28_0 = arg_28_0.chargeMall.items[1] and arg_28_0.chargeMall.items[1].freeze and true or false

	gohelper.setActive(arg_28_0._btnLock, not var_28_0)
	gohelper.setActive(arg_28_0._btnUnlock, var_28_0)
end

function var_0_0.refreshLeaderSkillRelative(arg_29_0)
	arg_29_0.master = arg_29_0.chessMo.svrFight.mySideMaster
	arg_29_0.masterCo = lua_auto_chess_master.configDict[arg_29_0.master.id]
	arg_29_0.masterSkillCo = lua_auto_chess_master_skill.configDict[arg_29_0.master.skill.id]

	arg_29_0._simageSkill:LoadImage(ResUrl.getAutoChessIcon(arg_29_0.masterCo.skillIcon, "skillicon"))

	if not string.nilorempty(arg_29_0.masterSkillCo.cost) then
		local var_29_0 = string.split(arg_29_0.masterSkillCo.cost, "#")
		local var_29_1 = "v2a5_autochess_cost" .. var_29_0[1]

		UISpriteSetMgr.instance:setAutoChessSprite(arg_29_0._imageSkillCost, var_29_1)

		arg_29_0._txtSkillCost.text = tonumber(var_29_0[2]) ~= 0 and var_29_0[2] or luaLang("autochess_mallview_nocost")
	else
		arg_29_0._txtSkillCost.text = luaLang("autochess_mallview_nocost")
	end

	gohelper.setActive(arg_29_0._goSkillLock, not arg_29_0.chessMo.svrFight.mySideMaster.skill.unlock)
	arg_29_0:refreshLeaderSkillStatus()
end

function var_0_0.refreshLeaderSkillStatus(arg_30_0)
	local var_30_0, var_30_1 = arg_30_0:checkCanUseLeaderSkill()

	gohelper.setActive(arg_30_0._goSkillLight, var_30_0)
	ZProj.UGUIHelper.SetGrayscale(arg_30_0._simageSkill.gameObject, var_30_1 == ToastEnum.AutoChessMasterSkill2)
end

function var_0_0.refreshLeaderBuff(arg_31_0)
	local var_31_0 = arg_31_0.chessMo.svrFight
	local var_31_1 = AutoChessHelper.getBuffCnt(var_31_0.mySideMaster.buffContainer.buffs, AutoChessEnum.EnergyBuffIds)

	arg_31_0._txtEnergyP.text = var_31_1

	gohelper.setActive(arg_31_0._txtEnergyP, var_31_1 ~= 0)

	local var_31_2 = AutoChessHelper.getBuffCnt(var_31_0.enemyMaster.buffContainer.buffs, AutoChessEnum.EnergyBuffIds)

	arg_31_0._txtEnergyE.text = var_31_2

	gohelper.setActive(arg_31_0._txtEnergyE, var_31_2 ~= 0)

	local var_31_3 = AutoChessHelper.getBuffCnt(var_31_0.mySideMaster.buffContainer.buffs, AutoChessEnum.FireBuffIds)

	arg_31_0._txtFireP.text = var_31_3

	gohelper.setActive(arg_31_0._txtFireP, var_31_3 ~= 0)

	local var_31_4 = AutoChessHelper.getBuffCnt(var_31_0.enemyMaster.buffContainer.buffs, AutoChessEnum.FireBuffIds)

	arg_31_0._txtFireE.text = var_31_4

	gohelper.setActive(arg_31_0._txtFireE, var_31_4 ~= 0)
end

function var_0_0.refreshCoinRelative(arg_32_0)
	local var_32_0 = arg_32_0.chessMo.svrMall

	arg_32_0._txtCoin.text = var_32_0.coin

	local var_32_1 = arg_32_0.chessMo.previewCoin

	arg_32_0.previewCostEnough = arg_32_0.chessMo:checkCostEnough(AutoChessStrEnum.CostType.Coin, var_32_1)

	local var_32_2 = arg_32_0.previewCostEnough and var_32_1 or string.format("<color=#BD2C2C>%s</color>", var_32_1)

	arg_32_0._txtCheckCost.text = var_32_2

	gohelper.setActive(arg_32_0._goStartLight, var_32_0.coin == 0)
end

function var_0_0.refreshMallItem(arg_33_0, arg_33_1)
	for iter_33_0, iter_33_1 in ipairs(arg_33_1.regions) do
		local var_33_0 = lua_auto_chess_mall.configDict[iter_33_1.mallId]

		if var_33_0.type == AutoChessEnum.MallType.Normal then
			arg_33_0.chargeMall = iter_33_1

			table.sort(iter_33_1.items, function(arg_34_0, arg_34_1)
				local var_34_0 = lua_auto_chess_mall_item.configDict[arg_34_0.id]
				local var_34_1 = lua_auto_chess_mall_item.configDict[arg_34_1.id]

				return var_34_0.order < var_34_1.order
			end)

			for iter_33_2 = 1, 7 do
				arg_33_0.chargeItemList[iter_33_2]:setData(iter_33_1.mallId, iter_33_1.items[iter_33_2])
				gohelper.setActive(arg_33_0.chargeFrameList[iter_33_2].gameObject, iter_33_2 <= var_33_0.capacity)
			end
		else
			arg_33_0.freeMall = iter_33_1

			arg_33_0.freeItem:setData(iter_33_1.mallId, iter_33_1.items[1], true)
		end
	end
end

function var_0_0.onStartBuyFinish(arg_35_0)
	arg_35_0.startBuyEnd = true

	arg_35_0:checkPopUp()
end

function var_0_0.onUsingLeaderSkill(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1 and "select" or "idle"

	arg_36_0.animBtnSkill:Play(var_36_0, 0, 0)
	gohelper.setActive(arg_36_0._btnCancelUse, arg_36_1)
	gohelper.setActive(arg_36_0._goSelectChessTip, arg_36_1)
	gohelper.setActive(arg_36_0.goBottom, not arg_36_1)
	gohelper.setActive(arg_36_0._btnCheckEnemy, not arg_36_1)
	gohelper.setActive(arg_36_0._btnStartFight, not arg_36_1)
	gohelper.setActive(arg_36_0._goRound, not arg_36_1)
end

function var_0_0.checkPopUp(arg_37_0)
	if not arg_37_0.startBuyEnd then
		return
	end

	if arg_37_0.chessMo.mallUpgrade then
		ViewMgr.instance:openView(ViewName.AutoChessMallLevelUpView)

		arg_37_0.chessMo.mallUpgrade = false
	else
		arg_37_0:checkForcePick()
	end
end

function var_0_0.checkForcePick(arg_38_0)
	if #arg_38_0.freeMall.selectItems > 0 then
		ViewMgr.instance:openView(ViewName.AutoChessForcePickView, arg_38_0.freeMall)
	end
end

function var_0_0.onDragChess(arg_39_0)
	gohelper.setActive(arg_39_0._goCheckSell, true)
	gohelper.setActive(arg_39_0._goChargeRoot, false)
end

function var_0_0.onDragChessEnd(arg_40_0)
	gohelper.setActive(arg_40_0._goCheckSell, false)
	gohelper.setActive(arg_40_0._goChargeRoot, true)
end

function var_0_0.onCloseView(arg_41_0, arg_41_1)
	if arg_41_1 == ViewName.AutoChessMallLevelUpView then
		arg_41_0:checkForcePick()
	end
end

function var_0_0.onCoinChange(arg_42_0)
	arg_42_0:refreshCoinRelative()
	arg_42_0:refreshLeaderSkillStatus()
end

function var_0_0.onViewBoard(arg_43_0)
	gohelper.setActive(arg_43_0._btnLederSkill, false)
	gohelper.setActive(arg_43_0._btnPlayerBuff, false)
	gohelper.setActive(arg_43_0._btnCheckEnemy, false)
	gohelper.setActive(arg_43_0._btnStartFight, false)
	gohelper.setActive(arg_43_0._goRound, false)
	gohelper.setActive(arg_43_0._btnFresh, false)
	gohelper.setActive(arg_43_0._goLockBtns, false)
	gohelper.setActive(arg_43_0._goPickView, true)
end

function var_0_0.onForcePickReply(arg_44_0, arg_44_1)
	if not arg_44_1 then
		arg_44_0.animFreeFrame:Play("open", 0, 0)
		arg_44_0:refreshMallItem(arg_44_0.chessMo.svrMall)
		arg_44_0:checkForcePick()
	end
end

function var_0_0.onMallRegionChange(arg_45_0)
	arg_45_0:refreshUI()
	arg_45_0:checkForcePick()
end

function var_0_0.onDragMallItem(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_2 ~= 0 then
		arg_46_0._txtCoin.text = string.format("%d(-%d)", arg_46_0.chessMo.svrMall.coin, arg_46_2)

		arg_46_0.animCoin:Play("loop", 0, 0)
	end
end

function var_0_0.onDragMallItemEnd(arg_47_0)
	arg_47_0._txtCoin.text = arg_47_0.chessMo.svrMall.coin

	arg_47_0.animCoin:Play("idle", 0, 0)
end

function var_0_0.onBuyReply(arg_48_0)
	arg_48_0:refreshUI()

	if #arg_48_0.freeMall.selectItems > 0 then
		TaskDispatcher.runDelay(arg_48_0.checkForcePick, arg_48_0, 1.5)
	else
		arg_48_0:checkForcePick()
	end
end

function var_0_0.onBuildReply(arg_49_0)
	arg_49_0:refreshUI()

	if #arg_49_0.freeMall.selectItems > 0 then
		TaskDispatcher.runDelay(arg_49_0.checkForcePick, arg_49_0, 1.5)
	else
		arg_49_0:checkForcePick()
	end
end

function var_0_0.freezeReply(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	if arg_50_2 ~= 0 then
		return
	end

	local var_50_0 = arg_50_3.type == AutoChessEnum.FreeZeType.Freeze

	gohelper.setActive(arg_50_0._btnLock, not var_50_0)
	gohelper.setActive(arg_50_0._btnUnlock, var_50_0)

	for iter_50_0, iter_50_1 in ipairs(arg_50_0.chargeItemList) do
		iter_50_1:setLock(var_50_0)
	end
end

function var_0_0.checkCanUseLeaderSkill(arg_51_0)
	if arg_51_0.masterSkillCo.type == AutoChessStrEnum.SkillType.Passive then
		return false, ToastEnum.AutoChessMasterSkill1
	else
		if not arg_51_0.master.skill.unlock then
			return false, ToastEnum.AutoChessMasterSkill4
		end

		if not arg_51_0.master.skill.canUse then
			return false, ToastEnum.AutoChessMasterSkill2
		end

		local var_51_0 = arg_51_0.masterCo.roundTriggerCountLimit

		if var_51_0 ~= 0 then
			local var_51_1 = arg_51_0.chessMo.svrFight.mySideMaster.skill.roundUseCounts
			local var_51_2 = 0

			for iter_51_0, iter_51_1 in ipairs(var_51_1) do
				if iter_51_1.round == arg_51_0.chessMo.sceneRound then
					var_51_2 = iter_51_1.count

					break
				end
			end

			if var_51_0 <= var_51_2 then
				return false, ToastEnum.AutoChessMasterSkill2
			end
		end

		local var_51_3 = arg_51_0.masterCo.totalTriggerCountLimit

		if var_51_3 ~= 0 then
			local var_51_4 = arg_51_0.chessMo.svrFight.mySideMaster.skill.roundUseCounts
			local var_51_5 = 0

			for iter_51_2, iter_51_3 in ipairs(var_51_4) do
				var_51_5 = var_51_5 + iter_51_3.count
			end

			if var_51_3 <= var_51_5 then
				return false, ToastEnum.AutoChessMasterSkill3
			end
		end

		local var_51_6 = string.split(arg_51_0.masterSkillCo.cost, "#")

		return arg_51_0.chessMo:checkCostEnough(var_51_6[1], tonumber(var_51_6[2]))
	end

	return true
end

return var_0_0
