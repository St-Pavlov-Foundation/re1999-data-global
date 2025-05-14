module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateView", package.seeall)

local var_0_0 = class("EliminateView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._viewGO = arg_1_0.viewGO
	arg_1_0.viewGO = gohelper.findChild(arg_1_0._viewGO, "#go_cameraMain/Middle/#go_eliminatechess")
	arg_1_0._goChessFrame = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_ChessFrame")
	arg_1_0._goTimes = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_Times")
	arg_1_0._txtTimes = gohelper.findChildText(arg_1_0.viewGO, "Middle/#go_Times/#txt_Times")
	arg_1_0._txtTimeseff = gohelper.findChildText(arg_1_0.viewGO, "Middle/#go_Times/#txt_Times_eff")
	arg_1_0._gochessBg = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_chessBg")
	arg_1_0._gochessBoard = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_chessBg/#go_chessBoard")
	arg_1_0._gochess = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_chessBg/#go_chess")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#go_chessBg/#go_chess/#btn_click")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_skill")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "Middle/#go_mask")
	arg_1_0._goResourceList = gohelper.findChild(arg_1_0.viewGO, "Middle/Resource/#go_ResourceList")
	arg_1_0._goResourceItem = gohelper.findChild(arg_1_0.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem")
	arg_1_0._imageResourceQuality = gohelper.findChildImage(arg_1_0.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem/#image_ResourceQuality")
	arg_1_0._txtResourceNum = gohelper.findChildText(arg_1_0.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	arg_1_0._btnChessBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_ChessBtn")
	arg_1_0._goPointViewList = gohelper.findChild(arg_1_0.viewGO, "Right/#go_PointViewList")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_PointViewList/#go_Item")
	arg_1_0._imagePointPic = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_PointViewList/#go_Item/#image_PointPic")
	arg_1_0._txtselfHP = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_PointViewList/#go_Item/image_SelfHPNumBG/#txt_selfHP")
	arg_1_0._txtenemyHP = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_PointViewList/#go_Item/imageEnemyHPNumBG/#txt_enemyHP")
	arg_1_0._goChessViewTips = gohelper.findChild(arg_1_0.viewGO, "Right/#go_ChessViewTips")
	arg_1_0._btncloseChessViewTip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_ChessViewTips/#btn_closeChessViewTip")
	arg_1_0._imageTipsBG = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_ChessViewTips/#image_TipsBG")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnChessBtn:AddClickListener(arg_2_0._btnChessBtnOnClick, arg_2_0)
	arg_2_0._btncloseChessViewTip:AddClickListener(arg_2_0._btncloseChessViewTipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnChessBtn:RemoveClickListener()
	arg_3_0._btncloseChessViewTip:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	return
end

function var_0_0._btncloseChessViewTipOnClick(arg_5_0)
	arg_5_0:hideSoliderChessTip()
end

function var_0_0._btnChessBtnOnClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)

	arg_6_0._isShowChessViewTips = not arg_6_0._isShowChessViewTips

	if not arg_6_0._isShowChessViewTips then
		if arg_6_0._chessTipsAni then
			arg_6_0._chessTipsAni:Play("close")
		end

		TaskDispatcher.runDelay(arg_6_0.setChessViewTipsActive, arg_6_0, 0.27)
	else
		arg_6_0:setChessViewTipsActive()
	end
end

function var_0_0.setChessViewTipsActive(arg_7_0)
	gohelper.setActive(arg_7_0._goChessViewTips, arg_7_0._isShowChessViewTips)

	if arg_7_0._isShowChessViewTips then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._slotList) do
			iter_7_1:refreshView()
		end
	end
end

local var_0_1 = SLFramework.UGUI.UIClickListener

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._goChessTipViewClick = var_0_1.Get(arg_8_0._goChessViewTips)

	arg_8_0._goChessTipViewClick:AddClickListener(arg_8_0._btnChessBtnOnClick, arg_8_0)

	arg_8_0._soliderView = nil
	arg_8_0._timeAni = arg_8_0._goTimes:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._chessTipsAni = arg_8_0._goChessViewTips:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._eliminateChessViewAni = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_8_0._btncloseChessViewTip, false)

	arg_8_0._goDengKen = gohelper.findChild(arg_8_0.viewGO, "Middle/#go_skill/skill_dengken")
	arg_8_0._goLuoPeiLa = gohelper.findChild(arg_8_0.viewGO, "Middle/#go_skill/skill_luopeila")
	arg_8_0._goLuoPeiLaLeft = gohelper.findChild(arg_8_0.viewGO, "Middle/#go_skill/skill_luopeila/left")
	arg_8_0._goLuoPeiLaRight = gohelper.findChild(arg_8_0.viewGO, "Middle/#go_skill/skill_luopeila/right")
	arg_8_0._goLuoPeiLaTop = gohelper.findChild(arg_8_0.viewGO, "Middle/#go_skill/skill_luopeila/top")
	arg_8_0._goLuoPeiLaBottom = gohelper.findChild(arg_8_0.viewGO, "Middle/#go_skill/skill_luopeila/bottom")
	arg_8_0._goWeierting1 = gohelper.findChild(arg_8_0.viewGO, "Middle/#go_skill/skill_weierting1")
	arg_8_0._goWeierting2 = gohelper.findChild(arg_8_0.viewGO, "Middle/#go_skill/skill_weierting2")
	arg_8_0._goResource = gohelper.findChild(arg_8_0.viewGO, "Middle/Resource")

	if EliminateChessItemController.instance:InitCloneGo(arg_8_0._gochess, arg_8_0._gochessBoard, arg_8_0._gochessBg, arg_8_0._gochessBg) then
		EliminateChessItemController.instance:InitChessBoard()
		EliminateChessItemController.instance:InitChess()
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:maskControl(true)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.OnChessSelect, arg_9_0.onSelectItem, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PerformBegin, arg_9_0.onPerformBegin, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PerformEnd, arg_9_0.onPerformEnd, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.ShowChessInfo, arg_9_0.showSoliderChessTip, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.Match3ChessEndViewOpen, arg_9_0.match3ChessEndViewOpen, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.Match3ChessBeginViewClose, arg_9_0.match3ChessBeginViewClose, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffect, arg_9_0.playResourceFlyEffect, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlayFinish, arg_9_0.resourceFlyFinish, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.RefreshInitChessShow, arg_9_0.refreshViewActive, arg_9_0)
	arg_9_0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PlayEliminateEffect, arg_9_0.playEliminateEffect, arg_9_0)
	arg_9_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, arg_9_0.updateViewStateChangeEnd, arg_9_0)
	arg_9_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, arg_9_0.updateViewState, arg_9_0)
	arg_9_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillViewOpen, arg_9_0.characterSkillOpen, arg_9_0)
	arg_9_0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillCancel, arg_9_0.characterSkillClose, arg_9_0)
	arg_9_0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPowerChange, arg_9_0.updateStrongHoldItemInfo, arg_9_0)
	arg_9_0:initView()
	arg_9_0:hideSoliderChessTip()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onSelectItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_0._maskState or arg_11_0:checkSkillRelease(arg_11_1, arg_11_2) then
		if arg_11_0._lastSelectX and arg_11_0._lastSelectY then
			arg_11_0:setSelect(false, arg_11_0._lastSelectX, arg_11_0._lastSelectY)
			arg_11_0:recordLastSelect(nil, nil)
		end

		return
	end

	if arg_11_0._lastSelectX and arg_11_0._lastSelectY then
		arg_11_0:setSelect(false, arg_11_0._lastSelectX, arg_11_0._lastSelectY)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_move)

		if EliminateChessController.instance:exchangeCell(arg_11_0._lastSelectX, arg_11_0._lastSelectY, arg_11_1, arg_11_2) then
			arg_11_0:onPerformBegin()
			arg_11_0:recordLastSelect(nil, nil)
		else
			if arg_11_3 then
				arg_11_0:setSelect(true, arg_11_1, arg_11_2)
			end

			arg_11_0:recordLastSelect(arg_11_1, arg_11_2)
		end
	else
		if arg_11_3 then
			arg_11_0:setSelect(true, arg_11_1, arg_11_2)
		end

		arg_11_0:recordLastSelect(arg_11_1, arg_11_2)
	end
end

function var_0_0.initView(arg_12_0)
	gohelper.setActive(arg_12_0._goChessViewTips, false)

	arg_12_0._isShowChessViewTips = false

	arg_12_0:calChessViewPosAndSize()
	arg_12_0:initSlot()
	arg_12_0:initResource()
	arg_12_0:initStrongHoldItem()
end

function var_0_0.initSlot(arg_13_0)
	arg_13_0._slotList = arg_13_0:getUserDataTb_()

	local var_13_0 = EliminateTeamChessModel.instance:getSlotIds()
	local var_13_1 = arg_13_0.viewContainer:getSetting().otherRes[1]
	local var_13_2 = arg_13_0._imageTipsBG.gameObject

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_3 = arg_13_0:getResInst(var_13_1, var_13_2, iter_13_1)
		local var_13_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_3, EliminateTeamChessDetailItem)

		gohelper.setActive(var_13_3, true)

		arg_13_0._slotList[iter_13_0] = var_13_4

		var_13_4:setSoliderId(iter_13_1)
	end
end

function var_0_0.initResource(arg_14_0)
	local var_14_0 = EliminateTeamChessEnum.ResourceType

	arg_14_0._resourceItem = arg_14_0:getUserDataTb_()

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		local var_14_1 = gohelper.clone(arg_14_0._goResourceItem, arg_14_0._goResourceList, iter_14_0)
		local var_14_2 = gohelper.findChildImage(var_14_1, "#image_ResourceQuality")
		local var_14_3 = gohelper.findChildText(var_14_1, "#image_ResourceQuality/#txt_ResourceNum")
		local var_14_4 = EliminateTeamChessModel.instance:getResourceNumber(iter_14_0)
		local var_14_5 = var_14_1:GetComponent(typeof(UnityEngine.Animator))
		local var_14_6 = var_14_4 and var_14_4 or 0

		UISpriteSetMgr.instance:setV2a2EliminateSprite(var_14_2, EliminateTeamChessEnum.ResourceTypeToImagePath[iter_14_0], false)
		gohelper.setActive(var_14_1, true)

		var_14_3.text = var_14_6
		arg_14_0._resourceItem[iter_14_0] = {
			item = var_14_1,
			ani = var_14_5,
			resourceImage = var_14_2,
			resourceNumberText = var_14_3
		}
	end
end

function var_0_0.initStrongHoldItem(arg_15_0)
	arg_15_0._strongHoldItem = arg_15_0:getUserDataTb_()

	local var_15_0 = EliminateTeamChessModel.instance:getStrongholds()

	for iter_15_0 = 1, #var_15_0 do
		local var_15_1 = var_15_0[iter_15_0]
		local var_15_2 = var_15_1:getStrongholdConfig()
		local var_15_3 = gohelper.clone(arg_15_0._goItem, arg_15_0._goPointViewList, var_15_1.id)
		local var_15_4 = gohelper.findChildImage(var_15_3, "image_SelfHPNumBG")
		local var_15_5 = gohelper.findChildImage(var_15_3, "imageEnemyHPNumBG")
		local var_15_6 = gohelper.findChildText(var_15_3, "image_SelfHPNumBG/#txt_selfHP")
		local var_15_7 = gohelper.findChildText(var_15_3, "imageEnemyHPNumBG/#txt_enemyHP")
		local var_15_8 = gohelper.findChildImage(var_15_3, "#image_PointPic")
		local var_15_9 = gohelper.findChild(var_15_3, "image_SelfHPNumBG/vx_fire_01")
		local var_15_10 = gohelper.findChild(var_15_3, "imageEnemyHPNumBG/vx_fire_01")

		var_15_6.text = var_15_1.myScore
		var_15_7.text = var_15_1.enemyScore

		local var_15_11 = var_15_2.eliminateBg

		if not string.nilorempty(var_15_11) then
			UISpriteSetMgr.instance:setV2a2eliminatePointSprite(var_15_8, var_15_11, false)
		end

		gohelper.setActive(var_15_3, true)

		arg_15_0._strongHoldItem[iter_15_0] = {
			item = var_15_3,
			myText = var_15_6,
			enemyText = var_15_7,
			myImage = var_15_4,
			enemyImage = var_15_5,
			enemyVx = var_15_10,
			selfVx = var_15_9
		}

		arg_15_0:refreshStateByScore(arg_15_0._strongHoldItem[iter_15_0], var_15_1.myScore, var_15_1.enemyScore)
	end
end

function var_0_0.updateStrongHoldItemInfo(arg_16_0)
	if arg_16_0._strongHoldItem == nil or #arg_16_0._strongHoldItem == 0 then
		return
	end

	local var_16_0 = EliminateTeamChessModel.instance:getStrongholds()

	for iter_16_0 = 1, #var_16_0 do
		local var_16_1 = arg_16_0._strongHoldItem[iter_16_0]

		var_16_1.myText.text = var_16_0[iter_16_0].myScore
		var_16_1.enemyText.text = var_16_0[iter_16_0].enemyScore

		arg_16_0:refreshStateByScore(var_16_1, var_16_0[iter_16_0].myScore, var_16_0[iter_16_0].enemyScore)
	end
end

function var_0_0.refreshStateByScore(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_1.myText
	local var_17_1 = arg_17_1.enemyText
	local var_17_2 = arg_17_1.myImage
	local var_17_3 = arg_17_1.enemyImage
	local var_17_4 = arg_17_1.selfVx
	local var_17_5 = arg_17_1.enemyVx

	var_17_0.color = arg_17_3 < arg_17_2 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	var_17_1.color = arg_17_2 < arg_17_3 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor

	local var_17_6 = arg_17_3 < arg_17_2 and EliminateLevelEnum.winImageName1 or EliminateLevelEnum.loserImageName1
	local var_17_7 = arg_17_2 < arg_17_3 and EliminateLevelEnum.winImageName1 or EliminateLevelEnum.loserImageName1

	UISpriteSetMgr.instance:setV2a2EliminateSprite(var_17_2, var_17_6, true)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(var_17_3, var_17_7, true)
	gohelper.setActive(var_17_5, arg_17_2 < arg_17_3)
	gohelper.setActive(var_17_4, arg_17_3 < arg_17_2)
end

function var_0_0.setTextColorAndSize(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_1.color = arg_18_2
	arg_18_1.fontSize = arg_18_3
end

function var_0_0.updateMovePoint(arg_19_0)
	local var_19_0 = EliminateChessModel.instance:getMovePoint()

	if arg_19_0._lastMovePoint and arg_19_0._lastMovePoint == var_19_0 then
		return
	end

	if arg_19_0._lastMovePoint ~= nil and arg_19_0._timeAni then
		arg_19_0._timeAni:Play("refresh")
	end

	local var_19_1 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_movePoint_txt"), var_19_0)

	arg_19_0._txtTimes.text = var_19_1
	arg_19_0._txtTimeseff.text = var_19_1
	arg_19_0._lastMovePoint = var_19_0
end

function var_0_0.updateResource(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._resourceItem) do
		arg_20_0:updateResourceDataChange(iter_20_0, false)
	end
end

function var_0_0.updateResourceDataChange(arg_21_0, arg_21_1, arg_21_2)
	if string.nilorempty(arg_21_1) then
		return
	end

	local var_21_0 = EliminateTeamChessModel.instance:getResourceNumber(arg_21_1)
	local var_21_1 = arg_21_0._resourceItem[arg_21_1]

	if var_21_1.resourceNumberText then
		var_21_1.resourceNumberText.text = var_21_0

		local var_21_2 = var_21_1.ani

		if arg_21_2 and var_21_2 then
			var_21_2:Play("add")
		end
	end
end

function var_0_0.setSelect(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0

	if arg_22_2 and arg_22_3 then
		var_22_0 = EliminateChessItemController.instance:getChessItem(arg_22_2, arg_22_3)
	else
		var_22_0 = EliminateChessItemController.instance:getChessItem(arg_22_0._lastSelectX, arg_22_0._lastSelectY)
	end

	if var_22_0 ~= nil then
		var_22_0:setSelect(arg_22_1)
	end
end

function var_0_0.recordLastSelect(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._lastSelectX = arg_23_1
	arg_23_0._lastSelectY = arg_23_2

	arg_23_0:updateTipTime()
	arg_23_0:tip(false)
end

function var_0_0.updateTipTime(arg_24_0)
	arg_24_0._lastClickTime = os.time()
end

function var_0_0.checkTip(arg_25_0)
	if arg_25_0._lastClickTime == nil then
		arg_25_0._lastClickTime = os.time()
	end

	if os.time() - arg_25_0._lastClickTime >= EliminateEnum.DotMoveTipInterval then
		arg_25_0:tip(true)
	end
end

function var_0_0.tip(arg_26_0, arg_26_1)
	if arg_26_0._lastTipActive ~= nil and arg_26_0._lastTipActive == arg_26_1 then
		return
	end

	if arg_26_1 and not arg_26_0.canTip then
		return
	end

	local var_26_0 = EliminateChessModel.instance:getTipInfo()

	if var_26_0 and var_26_0.from ~= nil then
		local var_26_1 = var_26_0.eliminate

		for iter_26_0 = 1, #var_26_1, 2 do
			local var_26_2 = var_26_1[iter_26_0]
			local var_26_3 = var_26_1[iter_26_0 + 1]

			EliminateChessItemController.instance:getChessItem(var_26_2, var_26_3):toTip(arg_26_1)
		end
	end

	arg_26_0._lastTipActive = arg_26_1
end

function var_0_0.updateViewState(arg_27_0)
	local var_27_0 = EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.Match3Chess

	arg_27_0:clearSelect()
	arg_27_0:maskControl(not var_27_0)
	arg_27_0:setSendCheck(true)
end

function var_0_0.updateViewStateChangeEnd(arg_28_0)
	local var_28_0 = EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.Match3Chess

	if var_28_0 and arg_28_0._eliminateChessViewAni then
		arg_28_0._eliminateChessViewAni:Play("open")
		TaskDispatcher.runDelay(arg_28_0.refreshViewActive, arg_28_0, 0.33)
	end

	if var_28_0 then
		EliminateChessController.instance:createInitMoveStepAndUpdatePos()
		arg_28_0:updateMovePoint()
		arg_28_0:updateResource()
	end

	arg_28_0:changeTipState(var_28_0, false, true)
end

function var_0_0.refreshViewActive(arg_29_0, arg_29_1)
	local var_29_0 = EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.Match3Chess

	if arg_29_1 == nil then
		arg_29_1 = true
	end

	if var_29_0 then
		if arg_29_1 then
			local var_29_1 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.StartShowView, EliminateEnum.ShowStartTime)

			if EliminateChessController.instance:buildSeqFlow(var_29_1) then
				EliminateChessController.instance:startSeqStepFlow()
			end
		end

		local var_29_2, var_29_3 = EliminateChessController.instance:createInitMoveStep()

		if var_29_2 then
			EliminateChessController.instance:startSeqStepFlow()
		end

		local var_29_4 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData)

		EliminateChessController.instance:buildSeqFlow(var_29_4)

		arg_29_0._roundBeginPerform = true
	end
end

function var_0_0.onPerformBegin(arg_30_0)
	arg_30_0:maskControl(true)
	arg_30_0:changeTipState(false, true, false)
end

function var_0_0.onPerformEnd(arg_31_0)
	arg_31_0:changeTipState(true, false, true)
	arg_31_0:updateTipTime()
	arg_31_0:updateMovePoint()

	if arg_31_0._roundBeginPerform then
		local var_31_0 = EliminateLevelModel.instance:getRoundNumber()
		local var_31_1 = EliminateLevelModel.instance:getLevelId()

		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.Match3RoundBegin, string.format("%s_%s", var_31_1, var_31_0))

		arg_31_0._roundBeginPerform = false
	end

	local var_31_2 = false
	local var_31_3 = false

	if arg_31_0.check then
		var_31_3 = EliminateChessController.instance:checkState()
		var_31_2 = var_31_3
	else
		var_31_2 = true
	end

	if var_31_3 then
		arg_31_0:setSendCheck(false)
	end

	arg_31_0:maskControl(var_31_2)
end

function var_0_0.setSendCheck(arg_32_0, arg_32_1)
	arg_32_0.check = arg_32_1
end

function var_0_0.maskControl(arg_33_0, arg_33_1)
	arg_33_0._maskState = arg_33_1

	gohelper.setActive(arg_33_0._gomask, arg_33_1)
end

function var_0_0.showSoliderChessTip(arg_34_0, arg_34_1)
	if arg_34_0._soliderView == nil then
		local var_34_0 = arg_34_0.viewContainer:getSetting().otherRes[6]
		local var_34_1 = arg_34_0:getResInst(var_34_0, arg_34_0._goChessViewTips)

		arg_34_0._soliderView = MonoHelper.addNoUpdateLuaComOnceToGo(var_34_1, EliminateChessTipView)

		local var_34_2 = arg_34_0._imageTipsBG.gameObject.transform
		local var_34_3 = recthelper.getAnchorX(var_34_2) - recthelper.getWidth(var_34_2) + EliminateEnum.teamChessDescTipOffsetX

		if var_34_3 < EliminateEnum.teamChessDescMinAnchorX then
			var_34_3 = EliminateEnum.teamChessDescMinAnchorX
		end

		recthelper.setAnchorX(var_34_1.transform, var_34_3)
		recthelper.setAnchorY(var_34_1.transform, EliminateEnum.teamChessDescTipOffsetY)
	end

	arg_34_0._soliderView:setSoliderIdAndShowType(arg_34_1, EliminateTeamChessEnum.ChessTipType.showDesc)
	gohelper.setActive(arg_34_0._btncloseChessViewTip, true)
	arg_34_0._btncloseChessViewTip:AddClickListener(arg_34_0._btncloseChessViewTipOnClick, arg_34_0)
end

function var_0_0.hideSoliderChessTip(arg_35_0)
	if arg_35_0._soliderView then
		arg_35_0._soliderView:hideView(function()
			gohelper.setActive(arg_35_0._btncloseChessViewTip, false)
		end, nil)
	end

	arg_35_0._btncloseChessViewTip:RemoveClickListener()
end

function var_0_0.onUpdateParam(arg_37_0)
	return
end

function var_0_0.calChessViewPosAndSize(arg_38_0)
	local var_38_0 = arg_38_0._gochessBg.transform
	local var_38_1, var_38_2 = EliminateChessItemController.instance:getMaxWidthAndHeight()

	recthelper.setSize(var_38_0, var_38_1, var_38_2)

	local var_38_3, var_38_4 = EliminateChessItemController.instance:getMaxLineAndRow()
	local var_38_5 = 0
	local var_38_6 = 0
	local var_38_7 = (EliminateEnum.ChessMaxLineValue - var_38_3) * EliminateEnum.ChessHeight * 0.5
	local var_38_8 = (EliminateEnum.ChessMaxRowValue - var_38_4) * EliminateEnum.ChessWidth * 0.5
	local var_38_9, var_38_10 = recthelper.getAnchor(var_38_0)

	recthelper.setAnchor(var_38_0, var_38_9 + var_38_8, var_38_10 + var_38_7)

	local var_38_11, var_38_12 = recthelper.getAnchor(arg_38_0._goResource.transform)

	recthelper.setAnchorY(arg_38_0._goResource.transform, var_38_12 + var_38_7)

	local var_38_13 = EliminateEnum.chessFrameBgMaxWidth * var_38_4 / EliminateEnum.ChessMaxRowValue
	local var_38_14 = EliminateEnum.chessFrameBgMaxHeight * var_38_3 / EliminateEnum.ChessMaxLineValue

	recthelper.setSize(arg_38_0._goChessFrame.transform, var_38_13, var_38_14)
end

function var_0_0.match3ChessEndViewOpen(arg_39_0)
	arg_39_0:changeTipState(false, true, false)
end

function var_0_0.match3ChessBeginViewClose(arg_40_0)
	arg_40_0:changeTipState(true, false, true)
end

function var_0_0.changeTipState(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	arg_41_0.canTip = arg_41_1

	if arg_41_2 then
		arg_41_0._lastClickTime = nil

		arg_41_0:tip(false)
		TaskDispatcher.cancelTask(arg_41_0.checkTip, arg_41_0)
	end

	if arg_41_3 then
		arg_41_0._lastClickTime = nil

		TaskDispatcher.cancelTask(arg_41_0.checkTip, arg_41_0)
		TaskDispatcher.runRepeat(arg_41_0.checkTip, arg_41_0, 1)
	end
end

function var_0_0.onDestroyView(arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0.checkTip, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0.setChessViewTipsActive, arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0.refreshViewActive, arg_42_0)

	if arg_42_0._soliderView then
		arg_42_0._soliderView:onDestroy()

		arg_42_0._soliderView = nil
	end

	if arg_42_0._goChessTipViewClick then
		arg_42_0._goChessTipViewClick:RemoveClickListener()

		arg_42_0._goChessTipViewClick = nil
	end

	if arg_42_0.flyItemPool then
		arg_42_0.flyItemPool:dispose()

		arg_42_0.flyItemPool = nil
	end

	arg_42_0._timeAni = nil
	arg_42_0._lastSelectX = nil
	arg_42_0._lastSelectY = nil
end

function var_0_0.checkSkillRelease(arg_43_0, arg_43_1, arg_43_2)
	if not EliminateLevelController.instance:canReleaseByRound() then
		return false
	end

	if EliminateLevelController.instance:getCurSelectSkill() ~= nil then
		if arg_43_0.cacheTemp ~= nil then
			for iter_43_0 = 1, #arg_43_0.cacheTemp do
				if arg_43_0.cacheTemp[iter_43_0].x == arg_43_1 and arg_43_0.cacheTemp[iter_43_0].y == arg_43_2 then
					return false
				end
			end
		end

		EliminateLevelController.instance:setSkillDataParams(arg_43_1, arg_43_2)
		arg_43_0:setSelect(true, arg_43_1, arg_43_2)

		if arg_43_0.cacheTemp == nil then
			arg_43_0.cacheTemp = {}
		end

		table.insert(arg_43_0.cacheTemp, {
			x = arg_43_1,
			y = arg_43_2
		})

		if EliminateLevelController.instance:canRelease() then
			arg_43_0:maskControl(true)
			EliminateLevelController.instance:releaseSkill(arg_43_0.releaseSkillSuccess, arg_43_0)

			return true
		end
	end

	return false
end

function var_0_0.clearSelect(arg_44_0)
	if arg_44_0.cacheTemp == nil then
		return
	end

	for iter_44_0 = 1, #arg_44_0.cacheTemp do
		arg_44_0:setSelect(false, arg_44_0.cacheTemp[iter_44_0].x, arg_44_0.cacheTemp[iter_44_0].y)
	end

	arg_44_0.cacheTemp = nil
end

function var_0_0.releaseSkillSuccess(arg_45_0)
	arg_45_0:characterSkillClose(false)
end

function var_0_0.characterSkillOpen(arg_46_0)
	arg_46_0:clearSelect()

	if arg_46_0._lastSelectX ~= nil and arg_46_0._lastSelectY ~= nil then
		arg_46_0:setSelect(false, arg_46_0._lastSelectX, arg_46_0._lastSelectY)
		arg_46_0:recordLastSelect(nil, nil)
	end

	arg_46_0:changeTipState(false, true, false)
end

function var_0_0.characterSkillClose(arg_47_0, arg_47_1)
	if arg_47_1 then
		arg_47_0:maskControl(false)
	end

	arg_47_0:clearSelect()
	arg_47_0:changeTipState(true, false, true)
end

function var_0_0.playResourceFlyEffect(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	local var_48_0, var_48_1, var_48_2 = transformhelper.getPos(arg_48_0._goResourceList.transform)

	for iter_48_0 = 1, #arg_48_1 do
		local var_48_3 = arg_48_1[iter_48_0]

		if arg_48_0._resourceItem and arg_48_0._resourceItem[var_48_3] then
			local var_48_4

			var_48_0, var_48_1, var_48_4 = transformhelper.getPos(arg_48_0._resourceItem[var_48_3].item.transform)
		end

		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffectPlay, var_48_3, arg_48_2, arg_48_3, var_48_0, var_48_1)
	end
end

function var_0_0.resourceFlyFinish(arg_49_0, arg_49_1)
	arg_49_0:updateResourceDataChange(arg_49_1, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_lit)
end

function var_0_0.playEliminateEffect(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5, arg_50_6, arg_50_7, arg_50_8)
	local var_50_0 = 0

	if arg_50_1 == EliminateEnum.EffectType.crossEliminate then
		if arg_50_6 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_luopeila_skill)
			transformhelper.setPos(arg_50_0._goLuoPeiLa.transform, arg_50_4, arg_50_5, 0)

			var_50_0 = 0.8

			gohelper.setActive(arg_50_0._goLuoPeiLaLeft, arg_50_2 ~= 1)
			gohelper.setActive(arg_50_0._goLuoPeiLaRight, arg_50_2 ~= EliminateEnum.ChessMaxRowValue)
			gohelper.setActive(arg_50_0._goLuoPeiLaTop, arg_50_3 ~= EliminateEnum.ChessMaxLineValue)
			gohelper.setActive(arg_50_0._goLuoPeiLaBottom, arg_50_3 ~= 1)
		end

		gohelper.setActive(arg_50_0._goLuoPeiLa, arg_50_6)
	end

	if arg_50_1 == EliminateEnum.EffectType.blockEliminate then
		if arg_50_6 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_dengken_skill)
			transformhelper.setPos(arg_50_0._goDengKen.transform, arg_50_4, arg_50_5, 0)
			gohelper.setActive(arg_50_0._goDengKen, arg_50_6)

			var_50_0 = 0.8
		end

		gohelper.setActive(arg_50_0._goDengKen, arg_50_6)
	end

	if arg_50_1 == EliminateEnum.EffectType.exchange_1 then
		if arg_50_6 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_weierting_skill)
			transformhelper.setPos(arg_50_0._goWeierting1.transform, arg_50_4, arg_50_5, 0)

			var_50_0 = 0.6
		end

		gohelper.setActive(arg_50_0._goWeierting1, arg_50_6)
	end

	if arg_50_1 == EliminateEnum.EffectType.exchange_2 then
		if arg_50_6 then
			transformhelper.setPos(arg_50_0._goWeierting2.transform, arg_50_4, arg_50_5, 0)

			var_50_0 = 0.6
		end

		gohelper.setActive(arg_50_0._goWeierting2, arg_50_6)
	end

	if arg_50_7 then
		TaskDispatcher.runDelay(function()
			if arg_50_7 then
				arg_50_7(arg_50_8)
			end
		end, arg_50_0, var_50_0)
	end
end

return var_0_0
