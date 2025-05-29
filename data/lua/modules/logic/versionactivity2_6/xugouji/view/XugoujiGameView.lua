module("modules.logic.versionactivity2_6.xugouji.view.XugoujiGameView", package.seeall)

local var_0_0 = class("XugoujiGameView", BaseView)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goCardItemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Middle/#scroll_FileList/Viewport/#go_Content")
	arg_1_0._cardGridlayout = arg_1_0._goCardItemRoot:GetComponent(gohelper.Type_GridLayoutGroup)
	arg_1_0._goCardItem = gohelper.findChild(arg_1_0._goCardItemRoot, "#go_FlieItem")
	arg_1_0._gotargetPanel = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	arg_1_0._gotargetItemRoot = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG")
	arg_1_0._gotargetItem = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel/#image_TaskBG/#go_Item")
	arg_1_0._btntarget = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#btn_Task")
	arg_1_0._btntargetHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#btn_Task_cancel")
	arg_1_0._goTipsRoot = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/#go_TipsRoot")
	arg_1_0._goMyTurnTips = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Bottom/#go_SelfTurn")
	arg_1_0._goEnemyTurnTips = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Bottom/#go_EnemyTurn")
	arg_1_0._goTurnEffect = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/#go_Turn/vx_fresh")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/#txt_Turns")
	arg_1_0._goRoundEffect = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Middle/Title/vx_fresh")
	arg_1_0._btnCardBox = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_cameraMain/Right/#btn_WarehouseBtn")
	arg_1_0._goWarehouseInfo = gohelper.findChild(arg_1_0.viewGO, "#go_warehouseInfo")
	arg_1_0._btnCardBoxHide = gohelper.findChildButtonWithAudio(arg_1_0._goWarehouseInfo, "#btnCardHouseHide")
	arg_1_0._goCardBoxItemRoot = gohelper.findChild(arg_1_0._goWarehouseInfo, "#scroll_Detail/Viewport/Content/#go_escaperulecontainer")
	arg_1_0._goCardBoxItem = gohelper.findChild(arg_1_0._goWarehouseInfo, "#scroll_Detail/Viewport/Content/#go_escaperulecontainer/#go_ItemList")
	arg_1_0._goTaskPanel = gohelper.findChild(arg_1_0.viewGO, "#go_cameraMain/Left/Task/#go_TaskPanel")
	arg_1_0._warehouseAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goWarehouseInfo)
	arg_1_0._taskTipsAnimator = ZProj.ProjAnimatorPlayer.Get(arg_1_0._goTaskPanel)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntarget:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btntargetHide:AddClickListener(arg_2_0._btntaskHideOnClick, arg_2_0)
	arg_2_0._btnCardBox:AddClickListener(arg_2_0._btnCardBoxOnClick, arg_2_0)
	arg_2_0._btnCardBoxHide:AddClickListener(arg_2_0._btnCardBoxHideOnClick, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, arg_2_0._onTurnChanged, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.NewCards, arg_2_0._createCardItems, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.GameResult, arg_2_0._onGameResultPush, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.ExitGame, arg_2_0._onGameResultExit, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, arg_2_0._onGameReStart, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.AutoShowTargetTips, arg_2_0._onShowTargetTips, arg_2_0)
	arg_2_0:addEventCb(XugoujiController.instance, XugoujiEvent.AutoHideTargetTips, arg_2_0._autoHideTargetTips, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntarget:RemoveClickListener()
	arg_3_0._btntargetHide:RemoveClickListener()
	arg_3_0._btnCardBox:RemoveClickListener()
	arg_3_0._btnCardBoxHide:RemoveClickListener()
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.TurnChanged, arg_3_0._onTurnChanged, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.NewCards, arg_3_0._createCardItems, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameResult, arg_3_0._onGameResultPush, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.ExitGame, arg_3_0._onGameResultExit, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.GameRestart, arg_3_0._onGameReStart, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.AutoShowTargetTips, arg_3_0._onShowTargetTips, arg_3_0)
	arg_3_0:removeEventCb(XugoujiController.instance, XugoujiEvent.AutoHideTargetTips, arg_3_0._autoHideTargetTips, arg_3_0)
end

function var_0_0._btntaskOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gotargetPanel, true)
	gohelper.setActive(arg_4_0._btntargetHide.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.showGameTarget)
	arg_4_0._taskTipsAnimator:Play(UIAnimationName.Open, nil, nil)
end

function var_0_0._btntaskHideOnClick(arg_5_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HideTargetTips)
	gohelper.setActive(arg_5_0._btntargetHide.gameObject, false)
	arg_5_0._taskTipsAnimator:Play(UIAnimationName.Close, arg_5_0.onTaskPanelCloseAniFinish, arg_5_0)
end

function var_0_0.onTaskPanelCloseAniFinish(arg_6_0)
	gohelper.setActive(arg_6_0._gotargetPanel, false)
end

function var_0_0._btnCardBoxOnClick(arg_7_0)
	if Activity188Model.instance:isGameGuideMode() then
		return
	end

	gohelper.setActive(arg_7_0._goWarehouseInfo, true)
	gohelper.setActive(arg_7_0._btnCardBoxHide.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardBoxOpen)
	arg_7_0._warehouseAnimator:Play(UIAnimationName.Open, nil, nil)
	arg_7_0:_createCardBoxItems()
end

function var_0_0._btnCardBoxHideOnClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum2_6.Xugouji.cardBoxClose)
	gohelper.setActive(arg_8_0._btnCardBoxHide.gameObject, false)
	arg_8_0._warehouseAnimator:Play(UIAnimationName.Close, arg_8_0.onCardBoxCloseAniFinish, arg_8_0)
end

function var_0_0.onCardBoxCloseAniFinish(arg_9_0)
	gohelper.setActive(arg_9_0._goWarehouseInfo, false)
end

function var_0_0._onShowTargetTips(arg_10_0)
	arg_10_0:_btntaskOnClick()
end

function var_0_0._autoHideTargetTips(arg_11_0)
	arg_11_0:_btntaskHideOnClick()
end

function var_0_0._editableInitView(arg_12_0)
	gohelper.setActive(arg_12_0._goTipsRoot, false)
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:_createCardItems()
	arg_13_0:_createTargetList()
	arg_13_0:_refreshRoundNum()
	arg_13_0:_refreshTurnTips(true)
end

function var_0_0.onOpenFinish(arg_14_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.OpenGameViewFinish)
end

function var_0_0._createCardItems(arg_15_0)
	arg_15_0._cardGridlayout.constraintCount = Activity188Model.instance:getCardColNum()
	arg_15_0._cardInfoList = Activity188Model.instance:getCardsInfoSortedList()
	arg_15_0._cardIdNumDict = {}

	gohelper.CreateObjList(arg_15_0, arg_15_0._createCardItem, arg_15_0._cardInfoList, arg_15_0._goCardItemRoot, arg_15_0._goCardItem, XugoujiCardItem)
end

function var_0_0._createCardItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_1:onUpdateData(arg_16_2)
	arg_16_1:refreshUI()
	arg_16_1:refreshCardIcon()

	arg_16_1._view = arg_16_0

	if not arg_16_0._cardIdNumDict[arg_16_2.id] then
		arg_16_0._cardIdNumDict[arg_16_2.id] = 1
	else
		arg_16_0._cardIdNumDict[arg_16_2.id] = arg_16_0._cardIdNumDict[arg_16_2.id] + 1
	end

	arg_16_1.viewGO.name = arg_16_2.id .. arg_16_0._cardIdNumDict[arg_16_2.id]
end

function var_0_0._createCardBoxItems(arg_17_0)
	gohelper.setActive(arg_17_0._goCardBoxAttackItemFlag, false)
	gohelper.setActive(arg_17_0._goCardBoxFuncItemFlag, false)
	gohelper.setActive(arg_17_0._goCardBoxImmediateItemFlag, false)

	local var_17_0
	local var_17_1
	local var_17_2

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._cardInfoList) do
		local var_17_3 = iter_17_1.id

		if iter_17_1.status ~= XugoujiEnum.CardStatus.Disappear and iter_17_1.status ~= XugoujiEnum.CardStatus.Front then
			local var_17_4 = Activity188Config.instance:getCardCfg(var_0_1, var_17_3)

			if var_17_4.type == XugoujiEnum.CardType.Attack then
				var_17_0 = var_17_0 or {}
				var_17_0[var_17_3] = var_17_0[var_17_3] or 0
				var_17_0[var_17_3] = var_17_0[var_17_3] + 1
			elseif var_17_4.type == XugoujiEnum.CardType.Func then
				var_17_1 = var_17_1 or {}
				var_17_1[var_17_3] = var_17_1[var_17_3] or 0
				var_17_1[var_17_3] = var_17_1[var_17_3] + 1
			elseif var_17_4.type == XugoujiEnum.CardType.Immediate then
				var_17_2 = var_17_2 or {}
				var_17_2[var_17_3] = var_17_2[var_17_3] or 0
				var_17_2[var_17_3] = var_17_2[var_17_3] + 1
			end
		end
	end

	arg_17_0._cardboxCfgList = {}

	if var_17_0 then
		table.insert(arg_17_0._cardboxCfgList, {
			cardFlag = XugoujiEnum.CardType.Attack
		})

		for iter_17_2, iter_17_3 in pairs(var_17_0) do
			table.insert(arg_17_0._cardboxCfgList, {
				cardId = iter_17_2,
				count = iter_17_3
			})
		end
	end

	if var_17_1 then
		table.insert(arg_17_0._cardboxCfgList, {
			cardFlag = XugoujiEnum.CardType.Func
		})

		for iter_17_4, iter_17_5 in pairs(var_17_1) do
			table.insert(arg_17_0._cardboxCfgList, {
				cardId = iter_17_4,
				count = iter_17_5
			})
		end
	end

	if var_17_2 then
		table.insert(arg_17_0._cardboxCfgList, {
			cardFlag = XugoujiEnum.CardType.Immediate
		})

		for iter_17_6, iter_17_7 in pairs(var_17_2) do
			table.insert(arg_17_0._cardboxCfgList, {
				cardId = iter_17_6,
				count = iter_17_7
			})
		end
	end

	arg_17_0.cardBoxItems = arg_17_0:getUserDataTb_()

	gohelper.CreateObjList(arg_17_0, arg_17_0._createCardBoxItem, arg_17_0._cardboxCfgList, arg_17_0._goCardBoxItemRoot, arg_17_0._goCardBoxItem)
end

function var_0_0._createCardBoxItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = gohelper.findChild(arg_18_1, "Attack")
	local var_18_1 = gohelper.findChild(arg_18_1, "Function")
	local var_18_2 = gohelper.findChild(arg_18_1, "Immediate")
	local var_18_3 = gohelper.findChild(arg_18_1, "#go_item")

	gohelper.setActive(var_18_0, arg_18_2.cardFlag and arg_18_2.cardFlag == XugoujiEnum.CardType.Attack)
	gohelper.setActive(var_18_1, arg_18_2.cardFlag and arg_18_2.cardFlag == XugoujiEnum.CardType.Func)
	gohelper.setActive(var_18_2, arg_18_2.cardFlag and arg_18_2.cardFlag == XugoujiEnum.CardType.Immediate)
	gohelper.setActive(var_18_3, not arg_18_2.cardFlag)

	if arg_18_2.cardFlag then
		return
	end

	local var_18_4 = gohelper.findChildImage(var_18_3, "image_icon")
	local var_18_5 = gohelper.findChildText(var_18_3, "txt_desc")
	local var_18_6 = gohelper.findChildText(var_18_3, "image_icon/image_Count/#txt_Count")
	local var_18_7 = arg_18_2.cardId
	local var_18_8 = Activity188Config.instance:getCardCfg(var_0_1, var_18_7)
	local var_18_9 = var_18_8.resource

	if var_18_9 and var_18_9 ~= "" then
		UISpriteSetMgr.instance:setXugoujiSprite(var_18_4, var_18_9)
	end

	var_18_6.text = string.format("x%d", arg_18_2.count)
	var_18_5.text = var_18_8.desc
	arg_18_0.cardBoxItems[var_18_7] = var_18_3

	local var_18_10 = gohelper.findChild(var_18_3, "image_Line")

	gohelper.setActive(var_18_10, arg_18_3 ~= #arg_18_0._cardboxCfgList)
end

function var_0_0._onTurnChanged(arg_19_0)
	local var_19_0 = Activity188Model.instance:isMyTurn()

	arg_19_0:_refreshTurnTips(var_19_0)
	arg_19_0:_refreshRoundNum()
end

function var_0_0._refreshRoundNum(arg_20_0)
	local var_20_0 = Activity188Model.instance:getRound()
	local var_20_1 = Activity188Model.instance:getCurGameId()
	local var_20_2 = Activity188Config.instance:getGameCfg(var_0_1, var_20_1).round

	if var_20_2 < var_20_0 or var_20_0 == arg_20_0._curRoundNum then
		return
	end

	arg_20_0._txtRound.text = string.format("%d/%d", var_20_0, var_20_2)

	gohelper.setActive(arg_20_0._goRoundEffect, false)
	gohelper.setActive(arg_20_0._goRoundEffect, true)

	arg_20_0._curRoundNum = var_20_0
end

function var_0_0._refreshTurnTips(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._goMyTurnTips, arg_21_1)
	gohelper.setActive(arg_21_0._goEnemyTurnTips, not arg_21_1)
	gohelper.setActive(arg_21_0._goTurnEffect, arg_21_1)
end

function var_0_0._createTargetList(arg_22_0)
	arg_22_0._targetDataList = {}
	arg_22_0._targetItemList = arg_22_0:getUserDataTb_()

	local var_22_0 = Activity188Model.instance:getCurGameId()
	local var_22_1 = Activity188Config.instance:getGameCfg(var_0_1, var_22_0)
	local var_22_2 = string.split(var_22_1.passRound, "#")

	for iter_22_0, iter_22_1 in ipairs(var_22_2) do
		local var_22_3 = iter_22_1

		table.insert(arg_22_0._targetDataList, var_22_3)
	end

	gohelper.CreateObjList(arg_22_0, arg_22_0._createTargetItem, arg_22_0._targetDataList, arg_22_0._gotargetItemRoot, arg_22_0._gotargetItem)
end

function var_0_0._createTargetItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("xugouji_round_target"), arg_23_2)

	gohelper.setActive(arg_23_1, true)

	local var_23_1 = gohelper.findChildText(arg_23_1, "#txt_TaskTarget")
	local var_23_2 = gohelper.findChild(arg_23_1, "image_Star")

	ZProj.UGUIHelper.SetGrayFactor(var_23_2, 1)

	var_23_1.text = var_23_0
	arg_23_0._targetItemList[arg_23_3] = arg_23_1
end

function var_0_0._onGameResultPush(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.star

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._targetItemList) do
		local var_24_1 = gohelper.findChild(iter_24_1, "image_Star")

		ZProj.UGUIHelper.SetGrayFactor(var_24_1, var_24_0 < iter_24_0 and 1 or 0)
	end

	arg_24_0._resultParams = arg_24_1

	TaskDispatcher.runDelay(arg_24_0._delayOpenResultView, arg_24_0, 0.5)
end

function var_0_0._delayOpenResultView(arg_25_0)
	XugoujiController.instance:openGameResultView(arg_25_0._resultParams)
end

function var_0_0._onGameResultExit(arg_26_0)
	arg_26_0:closeThis()
end

function var_0_0._onGameReStart(arg_27_0)
	arg_27_0:_createCardItems()
	arg_27_0:_createTargetList()
	arg_27_0:_refreshRoundNum()
end

function var_0_0.onClose(arg_28_0)
	return
end

function var_0_0.onDestroyView(arg_29_0)
	return
end

return var_0_0
