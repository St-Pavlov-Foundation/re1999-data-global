module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateView", package.seeall)

slot0 = class("EliminateView", BaseView)

function slot0.onInitView(slot0)
	slot0._viewGO = slot0.viewGO
	slot0.viewGO = gohelper.findChild(slot0._viewGO, "#go_cameraMain/Middle/#go_eliminatechess")
	slot0._goChessFrame = gohelper.findChild(slot0.viewGO, "Middle/#go_ChessFrame")
	slot0._goTimes = gohelper.findChild(slot0.viewGO, "Middle/#go_Times")
	slot0._txtTimes = gohelper.findChildText(slot0.viewGO, "Middle/#go_Times/#txt_Times")
	slot0._txtTimeseff = gohelper.findChildText(slot0.viewGO, "Middle/#go_Times/#txt_Times_eff")
	slot0._gochessBg = gohelper.findChild(slot0.viewGO, "Middle/#go_chessBg")
	slot0._gochessBoard = gohelper.findChild(slot0.viewGO, "Middle/#go_chessBg/#go_chessBoard")
	slot0._gochess = gohelper.findChild(slot0.viewGO, "Middle/#go_chessBg/#go_chess")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "Middle/#go_chessBg/#go_chess/#btn_click")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "Middle/#go_skill")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "Middle/#go_mask")
	slot0._goResourceList = gohelper.findChild(slot0.viewGO, "Middle/Resource/#go_ResourceList")
	slot0._goResourceItem = gohelper.findChild(slot0.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem")
	slot0._imageResourceQuality = gohelper.findChildImage(slot0.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem/#image_ResourceQuality")
	slot0._txtResourceNum = gohelper.findChildText(slot0.viewGO, "Middle/Resource/#go_ResourceList/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	slot0._btnChessBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_ChessBtn")
	slot0._goPointViewList = gohelper.findChild(slot0.viewGO, "Right/#go_PointViewList")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "Right/#go_PointViewList/#go_Item")
	slot0._imagePointPic = gohelper.findChildImage(slot0.viewGO, "Right/#go_PointViewList/#go_Item/#image_PointPic")
	slot0._txtselfHP = gohelper.findChildText(slot0.viewGO, "Right/#go_PointViewList/#go_Item/image_SelfHPNumBG/#txt_selfHP")
	slot0._txtenemyHP = gohelper.findChildText(slot0.viewGO, "Right/#go_PointViewList/#go_Item/imageEnemyHPNumBG/#txt_enemyHP")
	slot0._goChessViewTips = gohelper.findChild(slot0.viewGO, "Right/#go_ChessViewTips")
	slot0._btncloseChessViewTip = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_ChessViewTips/#btn_closeChessViewTip")
	slot0._imageTipsBG = gohelper.findChildImage(slot0.viewGO, "Right/#go_ChessViewTips/#image_TipsBG")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnChessBtn:AddClickListener(slot0._btnChessBtnOnClick, slot0)
	slot0._btncloseChessViewTip:AddClickListener(slot0._btncloseChessViewTipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnChessBtn:RemoveClickListener()
	slot0._btncloseChessViewTip:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
end

function slot0._btncloseChessViewTipOnClick(slot0)
	slot0:hideSoliderChessTip()
end

function slot0._btnChessBtnOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_open)

	slot0._isShowChessViewTips = not slot0._isShowChessViewTips

	if not slot0._isShowChessViewTips then
		if slot0._chessTipsAni then
			slot0._chessTipsAni:Play("close")
		end

		TaskDispatcher.runDelay(slot0.setChessViewTipsActive, slot0, 0.27)
	else
		slot0:setChessViewTipsActive()
	end
end

function slot0.setChessViewTipsActive(slot0)
	gohelper.setActive(slot0._goChessViewTips, slot0._isShowChessViewTips)

	if slot0._isShowChessViewTips then
		for slot4, slot5 in pairs(slot0._slotList) do
			slot5:refreshView()
		end
	end
end

slot1 = SLFramework.UGUI.UIClickListener

function slot0._editableInitView(slot0)
	slot0._goChessTipViewClick = uv0.Get(slot0._goChessViewTips)

	slot0._goChessTipViewClick:AddClickListener(slot0._btnChessBtnOnClick, slot0)

	slot0._soliderView = nil
	slot0._timeAni = slot0._goTimes:GetComponent(typeof(UnityEngine.Animator))
	slot0._chessTipsAni = slot0._goChessViewTips:GetComponent(typeof(UnityEngine.Animator))
	slot0._eliminateChessViewAni = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._btncloseChessViewTip, false)

	slot0._goDengKen = gohelper.findChild(slot0.viewGO, "Middle/#go_skill/skill_dengken")
	slot0._goLuoPeiLa = gohelper.findChild(slot0.viewGO, "Middle/#go_skill/skill_luopeila")
	slot0._goLuoPeiLaLeft = gohelper.findChild(slot0.viewGO, "Middle/#go_skill/skill_luopeila/left")
	slot0._goLuoPeiLaRight = gohelper.findChild(slot0.viewGO, "Middle/#go_skill/skill_luopeila/right")
	slot0._goLuoPeiLaTop = gohelper.findChild(slot0.viewGO, "Middle/#go_skill/skill_luopeila/top")
	slot0._goLuoPeiLaBottom = gohelper.findChild(slot0.viewGO, "Middle/#go_skill/skill_luopeila/bottom")
	slot0._goWeierting1 = gohelper.findChild(slot0.viewGO, "Middle/#go_skill/skill_weierting1")
	slot0._goWeierting2 = gohelper.findChild(slot0.viewGO, "Middle/#go_skill/skill_weierting2")
	slot0._goResource = gohelper.findChild(slot0.viewGO, "Middle/Resource")

	if EliminateChessItemController.instance:InitCloneGo(slot0._gochess, slot0._gochessBoard, slot0._gochessBg, slot0._gochessBg) then
		EliminateChessItemController.instance:InitChessBoard()
		EliminateChessItemController.instance:InitChess()
	end
end

function slot0.onOpen(slot0)
	slot0:maskControl(true)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.OnChessSelect, slot0.onSelectItem, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PerformBegin, slot0.onPerformBegin, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PerformEnd, slot0.onPerformEnd, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.ShowChessInfo, slot0.showSoliderChessTip, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.Match3ChessEndViewOpen, slot0.match3ChessEndViewOpen, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.Match3ChessBeginViewClose, slot0.match3ChessBeginViewClose, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffect, slot0.playResourceFlyEffect, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlayFinish, slot0.resourceFlyFinish, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.RefreshInitChessShow, slot0.refreshViewActive, slot0)
	slot0:addEventCb(EliminateChessController.instance, EliminateChessEvent.PlayEliminateEffect, slot0.playEliminateEffect, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChangeEnd, slot0.updateViewStateChangeEnd, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.EliminateRoundStateChange, slot0.updateViewState, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillViewOpen, slot0.characterSkillOpen, slot0)
	slot0:addEventCb(EliminateLevelController.instance, EliminateChessEvent.WarChessCharacterSkillCancel, slot0.characterSkillClose, slot0)
	slot0:addEventCb(EliminateTeamChessController.instance, EliminateChessEvent.StrongHoldPowerChange, slot0.updateStrongHoldItemInfo, slot0)
	slot0:initView()
	slot0:hideSoliderChessTip()
end

function slot0.onClose(slot0)
end

function slot0.onSelectItem(slot0, slot1, slot2, slot3)
	if slot0._maskState or slot0:checkSkillRelease(slot1, slot2) then
		if slot0._lastSelectX and slot0._lastSelectY then
			slot0:setSelect(false, slot0._lastSelectX, slot0._lastSelectY)
			slot0:recordLastSelect(nil, )
		end

		return
	end

	if slot0._lastSelectX and slot0._lastSelectY then
		slot0:setSelect(false, slot0._lastSelectX, slot0._lastSelectY)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_move)

		if EliminateChessController.instance:exchangeCell(slot0._lastSelectX, slot0._lastSelectY, slot1, slot2) then
			slot0:onPerformBegin()
			slot0:recordLastSelect(nil, )
		else
			if slot3 then
				slot0:setSelect(true, slot1, slot2)
			end

			slot0:recordLastSelect(slot1, slot2)
		end
	else
		if slot3 then
			slot0:setSelect(true, slot1, slot2)
		end

		slot0:recordLastSelect(slot1, slot2)
	end
end

function slot0.initView(slot0)
	gohelper.setActive(slot0._goChessViewTips, false)

	slot0._isShowChessViewTips = false

	slot0:calChessViewPosAndSize()
	slot0:initSlot()
	slot0:initResource()
	slot0:initStrongHoldItem()
end

function slot0.initSlot(slot0)
	slot0._slotList = slot0:getUserDataTb_()

	for slot7, slot8 in ipairs(EliminateTeamChessModel.instance:getSlotIds()) do
		slot9 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._imageTipsBG.gameObject, slot8)
		slot10 = MonoHelper.addNoUpdateLuaComOnceToGo(slot9, EliminateTeamChessDetailItem)

		gohelper.setActive(slot9, true)

		slot0._slotList[slot7] = slot10

		slot10:setSoliderId(slot8)
	end
end

function slot0.initResource(slot0)
	slot0._resourceItem = slot0:getUserDataTb_()

	for slot5, slot6 in pairs(EliminateTeamChessEnum.ResourceType) do
		slot7 = gohelper.clone(slot0._goResourceItem, slot0._goResourceList, slot5)
		slot8 = gohelper.findChildImage(slot7, "#image_ResourceQuality")
		slot9 = gohelper.findChildText(slot7, "#image_ResourceQuality/#txt_ResourceNum")

		UISpriteSetMgr.instance:setV2a2EliminateSprite(slot8, EliminateTeamChessEnum.ResourceTypeToImagePath[slot5], false)
		gohelper.setActive(slot7, true)

		slot9.text = EliminateTeamChessModel.instance:getResourceNumber(slot5) and slot10 or 0
		slot0._resourceItem[slot5] = {
			item = slot7,
			ani = slot7:GetComponent(typeof(UnityEngine.Animator)),
			resourceImage = slot8,
			resourceNumberText = slot9
		}
	end
end

function slot0.initStrongHoldItem(slot0)
	slot0._strongHoldItem = slot0:getUserDataTb_()

	for slot5 = 1, #EliminateTeamChessModel.instance:getStrongholds() do
		slot6 = slot1[slot5]
		slot8 = gohelper.clone(slot0._goItem, slot0._goPointViewList, slot6.id)
		slot9 = gohelper.findChildImage(slot8, "image_SelfHPNumBG")
		slot10 = gohelper.findChildImage(slot8, "imageEnemyHPNumBG")
		slot14 = gohelper.findChild(slot8, "image_SelfHPNumBG/vx_fire_01")
		slot15 = gohelper.findChild(slot8, "imageEnemyHPNumBG/vx_fire_01")
		gohelper.findChildText(slot8, "image_SelfHPNumBG/#txt_selfHP").text = slot6.myScore
		gohelper.findChildText(slot8, "imageEnemyHPNumBG/#txt_enemyHP").text = slot6.enemyScore

		if not string.nilorempty(slot6:getStrongholdConfig().eliminateBg) then
			UISpriteSetMgr.instance:setV2a2eliminatePointSprite(gohelper.findChildImage(slot8, "#image_PointPic"), slot16, false)
		end

		gohelper.setActive(slot8, true)

		slot0._strongHoldItem[slot5] = {
			item = slot8,
			myText = slot11,
			enemyText = slot12,
			myImage = slot9,
			enemyImage = slot10,
			enemyVx = slot15,
			selfVx = slot14
		}

		slot0:refreshStateByScore(slot0._strongHoldItem[slot5], slot6.myScore, slot6.enemyScore)
	end
end

function slot0.updateStrongHoldItemInfo(slot0)
	if slot0._strongHoldItem == nil or #slot0._strongHoldItem == 0 then
		return
	end

	for slot5 = 1, #EliminateTeamChessModel.instance:getStrongholds() do
		slot6 = slot0._strongHoldItem[slot5]
		slot6.myText.text = slot1[slot5].myScore
		slot6.enemyText.text = slot1[slot5].enemyScore

		slot0:refreshStateByScore(slot6, slot1[slot5].myScore, slot1[slot5].enemyScore)
	end
end

function slot0.refreshStateByScore(slot0, slot1, slot2, slot3)
	slot1.myText.color = slot3 < slot2 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	slot1.enemyText.color = slot2 < slot3 and EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor

	UISpriteSetMgr.instance:setV2a2EliminateSprite(slot1.myImage, slot3 < slot2 and EliminateLevelEnum.winImageName1 or EliminateLevelEnum.loserImageName1, true)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(slot1.enemyImage, slot2 < slot3 and EliminateLevelEnum.winImageName1 or EliminateLevelEnum.loserImageName1, true)
	gohelper.setActive(slot1.enemyVx, slot2 < slot3)
	gohelper.setActive(slot1.selfVx, slot3 < slot2)
end

function slot0.setTextColorAndSize(slot0, slot1, slot2, slot3)
	slot1.color = slot2
	slot1.fontSize = slot3
end

function slot0.updateMovePoint(slot0)
	if slot0._lastMovePoint and slot0._lastMovePoint == EliminateChessModel.instance:getMovePoint() then
		return
	end

	if slot0._lastMovePoint ~= nil and slot0._timeAni then
		slot0._timeAni:Play("refresh")
	end

	slot2 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_movePoint_txt"), slot1)
	slot0._txtTimes.text = slot2
	slot0._txtTimeseff.text = slot2
	slot0._lastMovePoint = slot1
end

function slot0.updateResource(slot0)
	for slot4, slot5 in pairs(slot0._resourceItem) do
		slot0:updateResourceDataChange(slot4, false)
	end
end

function slot0.updateResourceDataChange(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return
	end

	if slot0._resourceItem[slot1].resourceNumberText then
		slot4.resourceNumberText.text = EliminateTeamChessModel.instance:getResourceNumber(slot1)
		slot5 = slot4.ani

		if slot2 and slot5 then
			slot5:Play("add")
		end
	end
end

function slot0.setSelect(slot0, slot1, slot2, slot3)
	slot4 = nil

	if ((not slot2 or not slot3 or EliminateChessItemController.instance:getChessItem(slot2, slot3)) and EliminateChessItemController.instance:getChessItem(slot0._lastSelectX, slot0._lastSelectY)) ~= nil then
		slot4:setSelect(slot1)
	end
end

function slot0.recordLastSelect(slot0, slot1, slot2)
	slot0._lastSelectX = slot1
	slot0._lastSelectY = slot2

	slot0:updateTipTime()
	slot0:tip(false)
end

function slot0.updateTipTime(slot0)
	slot0._lastClickTime = os.time()
end

function slot0.checkTip(slot0)
	if slot0._lastClickTime == nil then
		slot0._lastClickTime = os.time()
	end

	if EliminateEnum.DotMoveTipInterval <= os.time() - slot0._lastClickTime then
		slot0:tip(true)
	end
end

function slot0.tip(slot0, slot1)
	if slot0._lastTipActive ~= nil and slot0._lastTipActive == slot1 then
		return
	end

	if slot1 and not slot0.canTip then
		return
	end

	if EliminateChessModel.instance:getTipInfo() and slot2.from ~= nil then
		for slot7 = 1, #slot2.eliminate, 2 do
			EliminateChessItemController.instance:getChessItem(slot3[slot7], slot3[slot7 + 1]):toTip(slot1)
		end
	end

	slot0._lastTipActive = slot1
end

function slot0.updateViewState(slot0)
	slot0:clearSelect()
	slot0:maskControl(not (EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.Match3Chess))
	slot0:setSendCheck(true)
end

function slot0.updateViewStateChangeEnd(slot0)
	if EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.Match3Chess and slot0._eliminateChessViewAni then
		slot0._eliminateChessViewAni:Play("open")
		TaskDispatcher.runDelay(slot0.refreshViewActive, slot0, 0.33)
	end

	if slot2 then
		EliminateChessController.instance:createInitMoveStepAndUpdatePos()
		slot0:updateMovePoint()
		slot0:updateResource()
	end

	slot0:changeTipState(slot2, false, true)
end

function slot0.refreshViewActive(slot0, slot1)
	slot3 = EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.Match3Chess

	if slot1 == nil then
		slot1 = true
	end

	if slot3 then
		if slot1 and EliminateChessController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.StartShowView, EliminateEnum.ShowStartTime)) then
			EliminateChessController.instance:startSeqStepFlow()
		end

		slot4, slot5 = EliminateChessController.instance:createInitMoveStep()

		if slot4 then
			EliminateChessController.instance:startSeqStepFlow()
		end

		EliminateChessController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.HandleData))

		slot0._roundBeginPerform = true
	end
end

function slot0.onPerformBegin(slot0)
	slot0:maskControl(true)
	slot0:changeTipState(false, true, false)
end

function slot0.onPerformEnd(slot0)
	slot0:changeTipState(true, false, true)
	slot0:updateTipTime()
	slot0:updateMovePoint()

	if slot0._roundBeginPerform then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.Match3RoundBegin, string.format("%s_%s", EliminateLevelModel.instance:getLevelId(), EliminateLevelModel.instance:getRoundNumber()))

		slot0._roundBeginPerform = false
	end

	slot1 = false
	slot1 = (not slot0.check or EliminateChessController.instance:checkState()) and true

	if false then
		slot0:setSendCheck(false)
	end

	slot0:maskControl(slot1)
end

function slot0.setSendCheck(slot0, slot1)
	slot0.check = slot1
end

function slot0.maskControl(slot0, slot1)
	slot0._maskState = slot1

	gohelper.setActive(slot0._gomask, slot1)
end

function slot0.showSoliderChessTip(slot0, slot1)
	if slot0._soliderView == nil then
		slot0._soliderView = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[6], slot0._goChessViewTips), EliminateChessTipView)
		slot4 = slot0._imageTipsBG.gameObject.transform

		if recthelper.getAnchorX(slot4) - recthelper.getWidth(slot4) + EliminateEnum.teamChessDescTipOffsetX < EliminateEnum.teamChessDescMinAnchorX then
			slot7 = EliminateEnum.teamChessDescMinAnchorX
		end

		recthelper.setAnchorX(slot3.transform, slot7)
		recthelper.setAnchorY(slot3.transform, EliminateEnum.teamChessDescTipOffsetY)
	end

	slot0._soliderView:setSoliderIdAndShowType(slot1, EliminateTeamChessEnum.ChessTipType.showDesc)
	gohelper.setActive(slot0._btncloseChessViewTip, true)
	slot0._btncloseChessViewTip:AddClickListener(slot0._btncloseChessViewTipOnClick, slot0)
end

function slot0.hideSoliderChessTip(slot0)
	if slot0._soliderView then
		slot0._soliderView:hideView(function ()
			gohelper.setActive(uv0._btncloseChessViewTip, false)
		end, nil)
	end

	slot0._btncloseChessViewTip:RemoveClickListener()
end

function slot0.onUpdateParam(slot0)
end

function slot0.calChessViewPosAndSize(slot0)
	slot1 = slot0._gochessBg.transform
	slot2, slot3 = EliminateChessItemController.instance:getMaxWidthAndHeight()

	recthelper.setSize(slot1, slot2, slot3)

	slot4, slot5 = EliminateChessItemController.instance:getMaxLineAndRow()
	slot6 = 0
	slot7 = 0
	slot7 = (EliminateEnum.ChessMaxLineValue - slot4) * EliminateEnum.ChessHeight * 0.5
	slot8, slot9 = recthelper.getAnchor(slot1)

	recthelper.setAnchor(slot1, slot8 + (EliminateEnum.ChessMaxRowValue - slot5) * EliminateEnum.ChessWidth * 0.5, slot9 + slot7)

	slot10, slot11 = recthelper.getAnchor(slot0._goResource.transform)

	recthelper.setAnchorY(slot0._goResource.transform, slot11 + slot7)
	recthelper.setSize(slot0._goChessFrame.transform, EliminateEnum.chessFrameBgMaxWidth * slot5 / EliminateEnum.ChessMaxRowValue, EliminateEnum.chessFrameBgMaxHeight * slot4 / EliminateEnum.ChessMaxLineValue)
end

function slot0.match3ChessEndViewOpen(slot0)
	slot0:changeTipState(false, true, false)
end

function slot0.match3ChessBeginViewClose(slot0)
	slot0:changeTipState(true, false, true)
end

function slot0.changeTipState(slot0, slot1, slot2, slot3)
	slot0.canTip = slot1

	if slot2 then
		slot0._lastClickTime = nil

		slot0:tip(false)
		TaskDispatcher.cancelTask(slot0.checkTip, slot0)
	end

	if slot3 then
		slot0._lastClickTime = nil

		TaskDispatcher.cancelTask(slot0.checkTip, slot0)
		TaskDispatcher.runRepeat(slot0.checkTip, slot0, 1)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.checkTip, slot0)
	TaskDispatcher.cancelTask(slot0.setChessViewTipsActive, slot0)
	TaskDispatcher.cancelTask(slot0.refreshViewActive, slot0)

	if slot0._soliderView then
		slot0._soliderView:onDestroy()

		slot0._soliderView = nil
	end

	if slot0._goChessTipViewClick then
		slot0._goChessTipViewClick:RemoveClickListener()

		slot0._goChessTipViewClick = nil
	end

	if slot0.flyItemPool then
		slot0.flyItemPool:dispose()

		slot0.flyItemPool = nil
	end

	slot0._timeAni = nil
	slot0._lastSelectX = nil
	slot0._lastSelectY = nil
end

function slot0.checkSkillRelease(slot0, slot1, slot2)
	if not EliminateLevelController.instance:canReleaseByRound() then
		return false
	end

	if EliminateLevelController.instance:getCurSelectSkill() ~= nil then
		if slot0.cacheTemp ~= nil then
			for slot6 = 1, #slot0.cacheTemp do
				if slot0.cacheTemp[slot6].x == slot1 and slot0.cacheTemp[slot6].y == slot2 then
					return false
				end
			end
		end

		EliminateLevelController.instance:setSkillDataParams(slot1, slot2)
		slot0:setSelect(true, slot1, slot2)

		if slot0.cacheTemp == nil then
			slot0.cacheTemp = {}
		end

		table.insert(slot0.cacheTemp, {
			x = slot1,
			y = slot2
		})

		if EliminateLevelController.instance:canRelease() then
			slot0:maskControl(true)
			EliminateLevelController.instance:releaseSkill(slot0.releaseSkillSuccess, slot0)

			return true
		end
	end

	return false
end

function slot0.clearSelect(slot0)
	if slot0.cacheTemp == nil then
		return
	end

	for slot4 = 1, #slot0.cacheTemp do
		slot0:setSelect(false, slot0.cacheTemp[slot4].x, slot0.cacheTemp[slot4].y)
	end

	slot0.cacheTemp = nil
end

function slot0.releaseSkillSuccess(slot0)
	slot0:characterSkillClose(false)
end

function slot0.characterSkillOpen(slot0)
	slot0:clearSelect()

	if slot0._lastSelectX ~= nil and slot0._lastSelectY ~= nil then
		slot0:setSelect(false, slot0._lastSelectX, slot0._lastSelectY)
		slot0:recordLastSelect(nil, )
	end

	slot0:changeTipState(false, true, false)
end

function slot0.characterSkillClose(slot0, slot1)
	if slot1 then
		slot0:maskControl(false)
	end

	slot0:clearSelect()
	slot0:changeTipState(true, false, true)
end

function slot0.playResourceFlyEffect(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = transformhelper.getPos(slot0._goResourceList.transform)

	for slot10 = 1, #slot1 do
		slot11 = slot1[slot10]

		if slot0._resourceItem and slot0._resourceItem[slot11] then
			slot4, slot5, slot6 = transformhelper.getPos(slot0._resourceItem[slot11].item.transform)
		end

		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffectPlay, slot11, slot2, slot3, slot4, slot5)
	end
end

function slot0.resourceFlyFinish(slot0, slot1)
	slot0:updateResourceDataChange(slot1, true)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sources_lit)
end

function slot0.playEliminateEffect(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = 0

	if slot1 == EliminateEnum.EffectType.crossEliminate then
		if slot6 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_luopeila_skill)
			transformhelper.setPos(slot0._goLuoPeiLa.transform, slot4, slot5, 0)

			slot9 = 0.8

			gohelper.setActive(slot0._goLuoPeiLaLeft, slot2 ~= 1)
			gohelper.setActive(slot0._goLuoPeiLaRight, slot2 ~= EliminateEnum.ChessMaxRowValue)
			gohelper.setActive(slot0._goLuoPeiLaTop, slot3 ~= EliminateEnum.ChessMaxLineValue)
			gohelper.setActive(slot0._goLuoPeiLaBottom, slot3 ~= 1)
		end

		gohelper.setActive(slot0._goLuoPeiLa, slot6)
	end

	if slot1 == EliminateEnum.EffectType.blockEliminate then
		if slot6 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_dengken_skill)
			transformhelper.setPos(slot0._goDengKen.transform, slot4, slot5, 0)
			gohelper.setActive(slot0._goDengKen, slot6)

			slot9 = 0.8
		end

		gohelper.setActive(slot0._goDengKen, slot6)
	end

	if slot1 == EliminateEnum.EffectType.exchange_1 then
		if slot6 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_weierting_skill)
			transformhelper.setPos(slot0._goWeierting1.transform, slot4, slot5, 0)

			slot9 = 0.6
		end

		gohelper.setActive(slot0._goWeierting1, slot6)
	end

	if slot1 == EliminateEnum.EffectType.exchange_2 then
		if slot6 then
			transformhelper.setPos(slot0._goWeierting2.transform, slot4, slot5, 0)

			slot9 = 0.6
		end

		gohelper.setActive(slot0._goWeierting2, slot6)
	end

	if slot7 then
		TaskDispatcher.runDelay(function ()
			if uv0 then
				uv0(uv1)
			end
		end, slot0, slot9)
	end
end

return slot0
