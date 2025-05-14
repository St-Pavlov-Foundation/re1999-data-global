module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessMallView", package.seeall)

local var_0_0 = class("AutoChessMallView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goViewSelf = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf")
	arg_1_0._goFrame = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_Frame")
	arg_1_0._goMallItem = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_MallItem")
	arg_1_0._txtCoin = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/Coin/#txt_Coin")
	arg_1_0._goStarProgress = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_StarProgress")
	arg_1_0._imageFreeP = gohelper.findChildImage(arg_1_0.viewGO, "#go_ViewSelf/#go_StarProgress/#image_FreeP")
	arg_1_0._txtFreeP = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#go_StarProgress/#txt_FreeP")
	arg_1_0._goRound = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_Round")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#go_Round/#txt_Round")
	arg_1_0._btnStartFight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/#btn_StartFight")
	arg_1_0._goStartLight = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#btn_StartFight/#go_StartLight")
	arg_1_0._btnCheckEnemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/#btn_CheckEnemy")
	arg_1_0._goCheckCost = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#btn_CheckEnemy/#go_CheckCost")
	arg_1_0._txtCheckCost = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#btn_CheckEnemy/#go_CheckCost/#txt_CheckCost")
	arg_1_0._btnLederSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill")
	arg_1_0._simageLeaderSkill = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#simage_LeaderSkill")
	arg_1_0._txtLeaderSkillCost = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#txt_LeaderSkillCost")
	arg_1_0._imageLeaderSkillCost = gohelper.findChildImage(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#txt_LeaderSkillCost/#image_LeaderSkillCost")
	arg_1_0._goSkillLock = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#go_SkillLock")
	arg_1_0._goLeaderSkillLight = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#btn_LederSkill/#go_LeaderSkillLight")
	arg_1_0._goLeaderEnergyP = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_LeaderEnergyP")
	arg_1_0._txtLeaderEnergyP = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#go_LeaderEnergyP/#txt_LeaderEnergyP")
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
	arg_1_0._goCheckSell = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_CheckSell")
	arg_1_0._txtSellPrice = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewSelf/#go_CheckSell/cost/#txt_SellPrice")
	arg_1_0._goChessAvatar = gohelper.findChild(arg_1_0.viewGO, "#go_ViewSelf/#go_ChessAvatar")
	arg_1_0._goViewEnemy = gohelper.findChild(arg_1_0.viewGO, "#go_ViewEnemy")
	arg_1_0._btnBack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ViewEnemy/#btn_Back")
	arg_1_0._goLeaderEnergyE = gohelper.findChild(arg_1_0.viewGO, "#go_ViewEnemy/#go_LeaderEnergyE")
	arg_1_0._txtLeaderEnergyE = gohelper.findChildText(arg_1_0.viewGO, "#go_ViewEnemy/#go_LeaderEnergyE/#txt_LeaderEnergyE")
	arg_1_0._goPickView = gohelper.findChild(arg_1_0.viewGO, "#go_PickView")
	arg_1_0._btnBackPick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_PickView/#btn_BackPick")
	arg_1_0._goexcessive = gohelper.findChild(arg_1_0.viewGO, "#go_excessive")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStartFight:AddClickListener(arg_2_0._btnStartFightOnClick, arg_2_0)
	arg_2_0._btnCheckEnemy:AddClickListener(arg_2_0._btnCheckEnemyOnClick, arg_2_0)
	arg_2_0._btnLederSkill:AddClickListener(arg_2_0._btnLederSkillOnClick, arg_2_0)
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
	arg_3_0._btnFresh:RemoveClickListener()
	arg_3_0._btnLock:RemoveClickListener()
	arg_3_0._btnUnlock:RemoveClickListener()
	arg_3_0._btnBack:RemoveClickListener()
	arg_3_0._btnBackPick:RemoveClickListener()
end

function var_0_0._btnBackPickOnClick(arg_4_0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	gohelper.setActive(arg_4_0._btnLederSkill, true)
	gohelper.setActive(arg_4_0._goLeaderEnergyP, true)
	gohelper.setActive(arg_4_0._goStarProgress, true)
	gohelper.setActive(arg_4_0._btnCheckEnemy, true)
	gohelper.setActive(arg_4_0._btnStartFight, true)
	gohelper.setActive(arg_4_0._goRound, true)
	gohelper.setActive(arg_4_0._btnFresh, true)
	gohelper.setActive(arg_4_0._goLockBtns, true)
	gohelper.setActive(arg_4_0._goPickView, false)
	ViewMgr.instance:openView(ViewName.AutoChessForcePickView, arg_4_0.freeMall)
end

function var_0_0._btnCheckEnemyOnClick(arg_5_0)
	if AutoChessController.instance:isClickDisable(GuideModel.GuideFlag.AutoChessEnablePreviewEnemy) then
		return
	end

	if arg_5_0.chessMo.preview then
		arg_5_0:previewCallback(0, 0)
	elseif arg_5_0.previewCostEnough then
		AutoChessRpc.instance:sendAutoChessPreviewFightRequest(arg_5_0.moduleId, arg_5_0.previewCallback, arg_5_0)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function var_0_0._btnLederSkillOnClick(arg_6_0)
	if AutoChessController.instance:isClickDisable(GuideModel.GuideFlag.AutoChessEnableUseSkill) then
		return
	end

	if arg_6_0:checkCanUseLeaderSkill(true) then
		arg_6_0.animBtnSkill:Play("click", 0, 0)

		local var_6_0 = arg_6_0.chessMo.svrFight.mySideMaster

		AutoChessRpc.instance:sendAutoChessUseMasterSkillRequest(arg_6_0.moduleId, var_6_0.skill.id)
	end
end

function var_0_0._btnBackOnClick(arg_7_0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	arg_7_0.checkingEnemy = false

	arg_7_0.animSwitch:Play("story", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
	TaskDispatcher.runDelay(arg_7_0.delaySwitch, arg_7_0, 0.35)
end

function var_0_0.previewCallback(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == 0 then
		arg_8_0.checkingEnemy = true

		arg_8_0.animSwitch:Play("hard", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_game_reopen)
		TaskDispatcher.runDelay(arg_8_0.delaySwitch, arg_8_0, 0.35)
	end
end

function var_0_0.delaySwitch(arg_9_0)
	if arg_9_0.checkingEnemy then
		gohelper.setActive(arg_9_0._goCheckCost, false)
		gohelper.setActive(arg_9_0._goViewSelf, false)
		gohelper.setActive(arg_9_0._goViewEnemy, true)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.CheckEnemyTeam, true)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZClickPreviewEnemy, true)
	else
		gohelper.setActive(arg_9_0._goViewSelf, true)
		gohelper.setActive(arg_9_0._goViewEnemy, false)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.CheckEnemyTeam, false)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZClickBackSelf, false)
	end
end

function var_0_0._btnFreshOnClick(arg_10_0)
	if tonumber(arg_10_0.chessMo.svrMall.coin) >= arg_10_0.freshCost then
		AutoChessHelper.lockScreen("AutoChessMallViewFreshStore", true)
		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_mln_details_open)
		gohelper.addChildPosStay(arg_10_0._goChargeRoot, arg_10_0.freeItem.go)
		arg_10_0.animBtnFresh:Play("click", 0, 0)
		arg_10_0.animBottom:Play("flushed", 0, 0)
		TaskDispatcher.runDelay(arg_10_0.delayRefreshStore, arg_10_0, 0.16)
		TaskDispatcher.runDelay(arg_10_0.delaySetFreeItem, arg_10_0, 0.4)
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function var_0_0.delayRefreshStore(arg_11_0)
	AutoChessRpc.instance:sendAutoChessRefreshMallRequest(arg_11_0.moduleId)
end

function var_0_0.delaySetFreeItem(arg_12_0)
	gohelper.addChildPosStay(arg_12_0._goChargeContent, arg_12_0.freeItem.go)
	AutoChessHelper.lockScreen("AutoChessMallViewFreshStore", false)
end

function var_0_0._btnLockOnClick(arg_13_0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_lock)
	AutoChessRpc.instance:sendAutoChessFreezeItemRequest(arg_13_0.moduleId, arg_13_0.chargeMall.mallId, 0, AutoChessEnum.FreeZeType.Freeze, arg_13_0.freezeReply, arg_13_0)
end

function var_0_0._btnUnlockOnClick(arg_14_0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	AutoChessRpc.instance:sendAutoChessFreezeItemRequest(arg_14_0.moduleId, arg_14_0.chargeMall.mallId, 0, AutoChessEnum.FreeZeType.UnFreeze, arg_14_0.freezeReply, arg_14_0)
end

function var_0_0._btnStartFightOnClick(arg_15_0)
	if AutoChessController.instance:isClickDisable() then
		return
	end

	if #AutoChessHelper.getMallRegionByType(arg_15_0.chessMo.svrMall.regions, AutoChessEnum.MallType.Free).items ~= 0 then
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.AutoChessFreeChessClean, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, arg_15_0._fightYesCallback, nil, nil, arg_15_0)
	else
		arg_15_0:_fightYesCallback()
	end
end

function var_0_0._fightYesCallback(arg_16_0)
	AutoChessRpc.instance:sendAutoChessEnterFightRequest(arg_16_0.moduleId)
end

function var_0_0._overrideClose(arg_17_0)
	if arg_17_0._btnBack.gameObject.activeInHierarchy then
		arg_17_0:_btnBackOnClick()

		return
	end

	AutoChessController.instance:exitGame()
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0.animFreeFrame = gohelper.findChild(arg_18_0.viewGO, "#go_ViewSelf/Bottom/Left/FreeFrame"):GetComponent(gohelper.Type_Animator)
	arg_18_0.animBottom = gohelper.findChild(arg_18_0.viewGO, "#go_ViewSelf/Bottom"):GetComponent(gohelper.Type_Animator)
	arg_18_0.animBtnFresh = arg_18_0._btnFresh.gameObject:GetComponent(gohelper.Type_Animator)
	arg_18_0.animSwitch = arg_18_0._goexcessive:GetComponent(gohelper.Type_Animator)
	arg_18_0.animCoin = arg_18_0._txtCoin.gameObject:GetComponent(gohelper.Type_Animator)
	arg_18_0.animStarProgress = arg_18_0._goStarProgress:GetComponent(gohelper.Type_Animator)
	arg_18_0.animBtnSkill = arg_18_0._btnLederSkill.gameObject:GetComponent(gohelper.Type_Animator)

	arg_18_0:initMallItemList()
end

function var_0_0.onOpen(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_shopping_enter)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.StartFight, arg_19_0.closeThis, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateMallData, arg_19_0.refreshUI, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntity, arg_19_0.onDragChess, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.DragChessEntityEnd, arg_19_0.onDragChessEnd, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.MallCoinChange, arg_19_0.refreshCoinRelative, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.ForcePickViewBoard, arg_19_0.onViewBoard, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.ForcePickReply, arg_19_0.onForcePickReply, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateMallRegion, arg_19_0.onMallRegionChange, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateMasterSkill, arg_19_0.refreshLeaderSkillRelative, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.UpdateLeaderEnergy, arg_19_0.refreshLeaderEnergy, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItem, arg_19_0.onDragMallItem, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.DrageMallItemEnd, arg_19_0.onDragMallItemEnd, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.BuyChessReply, arg_19_0.onBuyReply, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.BuildReply, arg_19_0.onBuildReply, arg_19_0)
	arg_19_0:addEventCb(AutoChessController.instance, AutoChessEvent.StartBuyStepFinih, arg_19_0.onStartBuyFinish, arg_19_0)
	arg_19_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_19_0.onCloseView, arg_19_0)
	AutoChessGameModel.instance:setChessAvatar(arg_19_0._goChessAvatar)

	arg_19_0.moduleId = AutoChessModel.instance:getCurModuleId()
	arg_19_0.chessMo = AutoChessModel.instance:getChessMo()

	if arg_19_0.viewParam and arg_19_0.viewParam.firstOpen then
		arg_19_0.startBuyEnd = true
	end

	arg_19_0:refreshUI()
	arg_19_0:checkStartProgressAnim()
	arg_19_0:setGuideButtonStatus()
end

function var_0_0.onClose(arg_20_0)
	AutoChessGameModel.instance.avatar = nil
end

function var_0_0.onDestroyView(arg_21_0)
	if arg_21_0._tweenId then
		ZProj.TweenHelper.KillById(arg_21_0._tweenId)

		arg_21_0._tweenId = nil
	end

	TaskDispatcher.cancelTask(arg_21_0.delaySetFreeItem, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.checkForcePick, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.starProgressFinish, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.recordItemPos, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.delaySwitch, arg_21_0)
end

function var_0_0.initMallItemList(arg_22_0)
	arg_22_0.chargeFrameList = arg_22_0:getUserDataTb_()
	arg_22_0.chargeItemList = {}

	for iter_22_0 = 1, 7 do
		if iter_22_0 == 1 then
			local var_22_0 = gohelper.clone(arg_22_0._goMallItem, arg_22_0._goChargeContent, "freeItem" .. iter_22_0)

			arg_22_0.freeItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_0, AutoChessMallItem, arg_22_0)
		end

		local var_22_1 = gohelper.clone(arg_22_0._goFrame, arg_22_0._goChargeFrame, "chargeFrame" .. iter_22_0)

		arg_22_0.chargeFrameList[iter_22_0] = var_22_1.transform

		local var_22_2 = gohelper.clone(arg_22_0._goMallItem, arg_22_0._goChargeContent, "chargeItem" .. iter_22_0)
		local var_22_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_2, AutoChessMallItem, arg_22_0)

		arg_22_0.chargeItemList[iter_22_0] = var_22_3
	end

	gohelper.setActive(arg_22_0._goFrame, false)
	gohelper.setActive(arg_22_0._goMallItem, false)
	TaskDispatcher.runDelay(arg_22_0.recordItemPos, arg_22_0, 0.01)
end

function var_0_0.recordItemPos(arg_23_0)
	for iter_23_0 = 1, 7 do
		if iter_23_0 == 1 then
			local var_23_0, var_23_1 = recthelper.getAnchor(arg_23_0._goFreeFrame.transform)

			arg_23_0.freeItem:setPos(var_23_0, var_23_1)
		end

		local var_23_2, var_23_3 = recthelper.getAnchor(arg_23_0.chargeFrameList[iter_23_0])

		arg_23_0.chargeItemList[iter_23_0]:setPos(var_23_2, var_23_3)
	end
end

function var_0_0.refreshUI(arg_24_0)
	local var_24_0 = arg_24_0.chessMo.svrMall

	arg_24_0:refreshMallItem(var_24_0)

	local var_24_1 = AutoChessHelper.getMallRegionByType(var_24_0.regions, AutoChessEnum.MallType.Normal)
	local var_24_2 = lua_auto_chess_mall.configDict[var_24_1.mallId]
	local var_24_3 = var_24_2 and var_24_2.showLevel or 0

	UISpriteSetMgr.instance:setAutoChessSprite(arg_24_0._imageLevel, "v2a5_autochess_quality3_" .. var_24_3)

	arg_24_0._txtMallLvl.text = "Lv." .. var_24_3

	local var_24_4 = AutoChessEnum.ConstKey.ChessSellPrice

	arg_24_0._txtSellPrice.text = lua_auto_chess_const.configDict[var_24_4].value

	gohelper.setActive(arg_24_0._goCheckCost, not arg_24_0.chessMo.preview)
	arg_24_0:refreshLeaderEnergy()
	arg_24_0:refreshCoinRelative()
	arg_24_0:refreshRoundRelative()
	arg_24_0:refreshLeaderSkillRelative()
	arg_24_0:refreshMallLock()
end

function var_0_0.checkStartProgressAnim(arg_25_0)
	local var_25_0 = AutoChessEnum.ConstKey.RewardMaxStar

	arg_25_0.maxStarCnt = tonumber(lua_auto_chess_const.configDict[var_25_0].value)

	local var_25_1 = arg_25_0:playStartProgressAnim()

	if var_25_1 == 0 then
		arg_25_0:refreshStarProgress()

		arg_25_0.starProgressEnd = true

		arg_25_0:checkPopUp()
	else
		TaskDispatcher.runDelay(arg_25_0.starProgressFinish, arg_25_0, var_25_1)
	end
end

function var_0_0.refreshRoundRelative(arg_26_0)
	local var_26_0 = arg_26_0.chessMo.sceneRound

	if arg_26_0.chessMo.svrMall.freeRefreshCount > 0 then
		arg_26_0.freshCost = 0
	else
		arg_26_0.freshCost = tonumber(lua_auto_chess_mall_refresh.configDict[var_26_0].cost)
	end

	arg_26_0._txtFreshCost.text = arg_26_0.freshCost

	local var_26_1 = AutoChessModel.instance.episodeId
	local var_26_2 = lua_auto_chess_episode.configDict[var_26_1]

	arg_26_0._txtRound.text = string.format("%d/%d", var_26_0, var_26_2.maxRound)
end

function var_0_0.refreshMallLock(arg_27_0)
	local var_27_0 = arg_27_0.chargeMall.items[1] and arg_27_0.chargeMall.items[1].freeze and true or false

	gohelper.setActive(arg_27_0._btnLock, not var_27_0)
	gohelper.setActive(arg_27_0._btnUnlock, var_27_0)
end

function var_0_0.refreshLeaderSkillRelative(arg_28_0)
	ZProj.UGUIHelper.SetGrayscale(arg_28_0._simageLeaderSkill.gameObject, not arg_28_0.chessMo.svrFight.mySideMaster.skill.canUse)
	gohelper.setActive(arg_28_0._goSkillLock, not arg_28_0.chessMo.svrFight.mySideMaster.skill.unlock)
	arg_28_0:refreshLeaderSkillLight()
end

function var_0_0.refreshLeaderSkillLight(arg_29_0)
	local var_29_0 = arg_29_0:checkCanUseLeaderSkill()

	gohelper.setActive(arg_29_0._goLeaderSkillLight, var_29_0)
end

function var_0_0.refreshLeaderEnergy(arg_30_0)
	local var_30_0 = arg_30_0.chessMo.svrFight
	local var_30_1 = var_30_0.mySideMaster.id
	local var_30_2 = lua_auto_chess_master.configDict[var_30_1]

	arg_30_0._simageLeaderSkill:LoadImage(ResUrl.getAutoChessIcon(var_30_2.skillIcon, "skillicon"))

	local var_30_3 = lua_auto_chess_master_skill.configDict[var_30_2.skillId].cost

	if not string.nilorempty(var_30_3) then
		local var_30_4 = string.split(var_30_3, "#")
		local var_30_5 = "v2a5_autochess_cost" .. var_30_4[1]

		UISpriteSetMgr.instance:setAutoChessSprite(arg_30_0._imageLeaderSkillCost, var_30_5)

		arg_30_0._txtLeaderSkillCost.text = tonumber(var_30_4[2]) ~= 0 and var_30_4[2] or luaLang("autochess_mallview_nocost")
	else
		arg_30_0._txtLeaderSkillCost.text = luaLang("autochess_mallview_nocost")
	end

	local var_30_6 = AutoChessHelper.getBuffEnergy(var_30_0.mySideMaster.buffContainer.buffs)

	arg_30_0._txtLeaderEnergyP.text = var_30_6

	gohelper.setActive(arg_30_0._goLeaderEnergyP, var_30_6 ~= 0)

	local var_30_7 = AutoChessHelper.getBuffEnergy(var_30_0.enemyMaster.buffContainer.buffs)

	arg_30_0._txtLeaderEnergyE.text = var_30_7

	gohelper.setActive(arg_30_0._goLeaderEnergyE, var_30_7 ~= 0)
end

function var_0_0.refreshCoinRelative(arg_31_0)
	local var_31_0 = arg_31_0.chessMo.svrMall

	arg_31_0._txtCoin.text = var_31_0.coin

	local var_31_1 = arg_31_0.chessMo.previewCoin

	arg_31_0.previewCostEnough = arg_31_0.chessMo:checkCostEnough(AutoChessStrEnum.CostType.Coin, var_31_1)

	local var_31_2 = arg_31_0.previewCostEnough and var_31_1 or string.format("<color=#BD2C2C>%s</color>", var_31_1)

	arg_31_0._txtCheckCost.text = var_31_2

	gohelper.setActive(arg_31_0._goStartLight, var_31_0.coin == 0)
	arg_31_0:refreshLeaderSkillLight()
end

function var_0_0.refreshMallItem(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_1.regions) do
		local var_32_0 = lua_auto_chess_mall.configDict[iter_32_1.mallId]

		if var_32_0.type == AutoChessEnum.MallType.Normal then
			arg_32_0.chargeMall = iter_32_1

			table.sort(iter_32_1.items, function(arg_33_0, arg_33_1)
				local var_33_0 = lua_auto_chess_mall_item.configDict[arg_33_0.id]
				local var_33_1 = lua_auto_chess_mall_item.configDict[arg_33_1.id]

				return var_33_0.order < var_33_1.order
			end)

			for iter_32_2 = 1, 7 do
				arg_32_0.chargeItemList[iter_32_2]:setData(iter_32_1.mallId, iter_32_1.items[iter_32_2])
				gohelper.setActive(arg_32_0.chargeFrameList[iter_32_2].gameObject, iter_32_2 <= var_32_0.capacity)
			end
		else
			arg_32_0.freeMall = iter_32_1

			arg_32_0.freeItem:setData(iter_32_1.mallId, iter_32_1.items[1], true)
		end
	end
end

function var_0_0.onStartBuyFinish(arg_34_0)
	arg_34_0.startBuyEnd = true

	arg_34_0:checkPopUp()
end

function var_0_0.starProgressFinish(arg_35_0)
	arg_35_0.starProgressEnd = true

	arg_35_0:checkPopUp()
end

function var_0_0.checkPopUp(arg_36_0)
	if not arg_36_0.starProgressEnd or not arg_36_0.startBuyEnd then
		return
	end

	if arg_36_0.chessMo.mallUpgrade then
		ViewMgr.instance:openView(ViewName.AutoChessMallLevelUpView)

		arg_36_0.chessMo.mallUpgrade = false
	else
		arg_36_0:checkForcePick()
	end
end

function var_0_0.checkForcePick(arg_37_0)
	if #arg_37_0.freeMall.selectItems > 0 then
		ViewMgr.instance:openView(ViewName.AutoChessForcePickView, arg_37_0.freeMall)
	end
end

function var_0_0.onDragChess(arg_38_0)
	gohelper.setActive(arg_38_0._goCheckSell, true)
	gohelper.setActive(arg_38_0._goChargeRoot, false)
end

function var_0_0.onDragChessEnd(arg_39_0)
	gohelper.setActive(arg_39_0._goCheckSell, false)
	gohelper.setActive(arg_39_0._goChargeRoot, true)
end

function var_0_0.onCloseView(arg_40_0, arg_40_1)
	if arg_40_1 == ViewName.AutoChessMallLevelUpView then
		arg_40_0:checkForcePick()
	end
end

function var_0_0.onViewBoard(arg_41_0)
	gohelper.setActive(arg_41_0._btnLederSkill, false)
	gohelper.setActive(arg_41_0._goLeaderEnergyP, false)
	gohelper.setActive(arg_41_0._goStarProgress, false)
	gohelper.setActive(arg_41_0._btnCheckEnemy, false)
	gohelper.setActive(arg_41_0._btnStartFight, false)
	gohelper.setActive(arg_41_0._goRound, false)
	gohelper.setActive(arg_41_0._btnFresh, false)
	gohelper.setActive(arg_41_0._goLockBtns, false)
	gohelper.setActive(arg_41_0._goPickView, true)
end

function var_0_0.onForcePickReply(arg_42_0, arg_42_1)
	if not arg_42_1 then
		arg_42_0.animFreeFrame:Play("open", 0, 0)
		arg_42_0:refreshMallItem(arg_42_0.chessMo.svrMall)
		arg_42_0:checkForcePick()
	end
end

function var_0_0.onMallRegionChange(arg_43_0)
	arg_43_0.freeMall = AutoChessHelper.getMallRegionByType(arg_43_0.chessMo.svrMall.regions, AutoChessEnum.MallType.Free)

	arg_43_0.freeItem:setData(arg_43_0.freeMall.mallId, arg_43_0.freeMall.items[1], true)
	arg_43_0:checkForcePick()
end

function var_0_0.onDragMallItem(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_2 ~= 0 then
		arg_44_0._txtCoin.text = string.format("%d(-%d)", arg_44_0.chessMo.svrMall.coin, arg_44_2)

		arg_44_0.animCoin:Play("loop", 0, 0)
	end
end

function var_0_0.onDragMallItemEnd(arg_45_0)
	arg_45_0._txtCoin.text = arg_45_0.chessMo.svrMall.coin

	arg_45_0.animCoin:Play("idle", 0, 0)
end

function var_0_0.onBuyReply(arg_46_0)
	arg_46_0:refreshUI()

	if #arg_46_0.freeMall.selectItems > 0 then
		TaskDispatcher.runDelay(arg_46_0.checkForcePick, arg_46_0, 1.5)
	else
		arg_46_0:checkForcePick()
	end
end

function var_0_0.onBuildReply(arg_47_0)
	arg_47_0:refreshUI()

	if #arg_47_0.freeMall.selectItems > 0 then
		TaskDispatcher.runDelay(arg_47_0.checkForcePick, arg_47_0, 1.5)
	else
		arg_47_0:checkForcePick()
	end
end

function var_0_0.freezeReply(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	if arg_48_2 ~= 0 then
		return
	end

	local var_48_0 = arg_48_3.type == AutoChessEnum.FreeZeType.Freeze

	gohelper.setActive(arg_48_0._btnLock, not var_48_0)
	gohelper.setActive(arg_48_0._btnUnlock, var_48_0)

	for iter_48_0, iter_48_1 in ipairs(arg_48_0.chargeItemList) do
		iter_48_1:setLock(var_48_0)
	end
end

function var_0_0.checkCanUseLeaderSkill(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_0.chessMo.svrFight.mySideMaster
	local var_49_1 = lua_auto_chess_master.configDict[var_49_0.id]
	local var_49_2 = var_49_0.skill.id
	local var_49_3 = lua_auto_chess_master_skill.configDict[var_49_2]

	if var_49_3.type == AutoChessStrEnum.SkillType.Passive then
		if arg_49_1 then
			GameFacade.showToast(ToastEnum.AutoChessMasterSkill1)
		end

		return false
	else
		if not var_49_0.skill.unlock then
			if arg_49_1 then
				GameFacade.showToast(ToastEnum.AutoChessMasterSkill4)
			end

			return false
		end

		if not var_49_0.skill.canUse then
			if arg_49_1 then
				GameFacade.showToast(ToastEnum.AutoChessMasterSkill2)
			end

			return false
		end

		local var_49_4 = var_49_1.roundTriggerCountLimit

		if var_49_4 ~= 0 then
			local var_49_5 = arg_49_0.chessMo.svrFight.mySideMaster.skill.roundUseCounts
			local var_49_6 = 0

			for iter_49_0, iter_49_1 in ipairs(var_49_5) do
				if iter_49_1.round == arg_49_0.chessMo.sceneRound then
					var_49_6 = iter_49_1.count

					break
				end
			end

			if var_49_4 <= var_49_6 then
				if arg_49_1 then
					GameFacade.showToast(ToastEnum.AutoChessMasterSkill2)
				end

				return false
			end
		end

		local var_49_7 = var_49_1.totalTriggerCountLimit

		if var_49_7 ~= 0 then
			local var_49_8 = arg_49_0.chessMo.svrFight.mySideMaster.skill.roundUseCounts
			local var_49_9 = 0

			for iter_49_2, iter_49_3 in ipairs(var_49_8) do
				var_49_9 = var_49_9 + iter_49_3.count
			end

			if var_49_7 <= var_49_9 then
				if arg_49_1 then
					GameFacade.showToast(ToastEnum.AutoChessMasterSkill3)
				end

				return false
			end
		end

		local var_49_10 = string.split(var_49_3.cost, "#")

		if not arg_49_0.chessMo:checkCostEnough(var_49_10[1], tonumber(var_49_10[2])) then
			if arg_49_1 then
				GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
			end

			return false
		end
	end

	return true
end

function var_0_0.refreshStarProgress(arg_50_0)
	local var_50_0 = arg_50_0.chessMo.svrMall.rewardProgress

	arg_50_0._imageFreeP.fillAmount = var_50_0 / arg_50_0.maxStarCnt
	arg_50_0._txtFreeP.text = string.format("%d/%d", var_50_0, arg_50_0.maxStarCnt)
end

function var_0_0.playStartProgressAnim(arg_51_0)
	local var_51_0 = arg_51_0.chessMo.lastRewardProgress

	if not var_51_0 then
		return 0
	end

	local var_51_1 = arg_51_0.chessMo.svrMall.rewardProgress

	arg_51_0.chessMo.lastRewardProgress = nil

	if var_51_1 - var_51_0 > 0 then
		arg_51_0.animStarProgress:Play("add", 0, 0)

		arg_51_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_51_0, var_51_1, 0.67, arg_51_0._tweenFrameCb, arg_51_0._tweenFinish, arg_51_0)

		return 0.67
	elseif var_51_1 - var_51_0 < 0 then
		arg_51_0.animStarProgress:Play("add", 0, 0)

		arg_51_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_51_0, arg_51_0.maxStarCnt, 0.67, arg_51_0._tweenFrameCb, arg_51_0._tweenFinish, arg_51_0)

		return 0.67
	end

	return 0
end

function var_0_0._tweenFrameCb(arg_52_0, arg_52_1)
	arg_52_0._imageFreeP.fillAmount = arg_52_1 / arg_52_0.maxStarCnt
	arg_52_0._txtFreeP.text = string.format("%d/%d", arg_52_1, arg_52_0.maxStarCnt)
end

function var_0_0._tweenFinish(arg_53_0)
	arg_53_0:refreshStarProgress()
end

function var_0_0.setGuideButtonStatus(arg_54_0)
	local var_54_0 = GuideModel.instance:isGuideFinish(25403)

	gohelper.setActive(arg_54_0._btnCheckEnemy, var_54_0)

	local var_54_1 = GuideModel.instance:isGuideFinish(25404)

	gohelper.setActive(arg_54_0._goLockBtns, var_54_1)

	local var_54_2 = GuideModel.instance:isGuideFinish(25406) or GuideModel.instance:isGuideFinish(25407)

	gohelper.setActive(arg_54_0._goStarProgress, var_54_2)
	gohelper.setActive(arg_54_0._btnFresh, var_54_2)
	gohelper.setActive(arg_54_0._btnLederSkill, var_54_2)
end

return var_0_0
