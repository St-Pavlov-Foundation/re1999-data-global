module("modules.logic.dungeon.view.jump.DungeonJumpGameView", package.seeall)

local var_0_0 = class("DungeonJumpGameView", BaseViewExtended)
local var_0_1 = 0.5
local var_0_2 = 1
local var_0_3 = 800
local var_0_4 = 0.2
local var_0_5 = 1.5
local var_0_6 = 0.4
local var_0_7 = {
	Final = 4,
	Fall = 3,
	ToNext = 2,
	Original = 1
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goNodeItemRoot = gohelper.findChild(arg_1_0.viewGO, "Map/NodeRoot")
	arg_1_0._goNodeItem = gohelper.findChild(arg_1_0.viewGO, "Map/NodeRoot/nodeItem")
	arg_1_0._btnRestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._jumpChessRoot = gohelper.findChild(arg_1_0.viewGO, "Map/#go_chess")
	arg_1_0._jumpChess = gohelper.findChild(arg_1_0.viewGO, "Map/#go_chess/#chess")
	arg_1_0._jumpChessImage = gohelper.findChild(arg_1_0.viewGO, "Map/#go_chess/#chess/#image_chess")
	arg_1_0._jumpChessAnimator = arg_1_0._jumpChess:GetComponent(gohelper.Type_Animator)
	arg_1_0._jumpCircle = gohelper.findChild(arg_1_0.viewGO, "Map/#go_chess/#chess/circle")
	arg_1_0._pressStateCircle = gohelper.findChild(arg_1_0._jumpCircle, "StateRoot/#go_State/State2")
	arg_1_0._goGreenNormalRange = gohelper.findChild(arg_1_0._jumpCircle, "#go_CircleNormal")
	arg_1_0._goCurrentAreaRange = gohelper.findChild(arg_1_0._jumpCircle, "#go_CircleCurrent")
	arg_1_0._goGreenLightRange = gohelper.findChild(arg_1_0._jumpCircle, "#go_CircleLight")
	arg_1_0._goDrakRange = gohelper.findChild(arg_1_0._jumpCircle, "#go_CircleBlack")
	arg_1_0._outRangeStateCircle = gohelper.findChild(arg_1_0._jumpCircle, "StateRoot/#go_State/State3")
	arg_1_0._jumpBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "jumpClick")
	arg_1_0._jumpBtnGo = gohelper.findChild(arg_1_0.viewGO, "jumpClick")
	arg_1_0._jumpBtnlongpress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._jumpBtnGo)
	arg_1_0._jumpBtn = SLFramework.UGUI.UIClickListener.Get(arg_1_0._jumpBtnGo)
	arg_1_0._goMap = gohelper.findChild(arg_1_0.viewGO, "Map")
	arg_1_0._goBg = gohelper.findChild(arg_1_0.viewGO, "fullbg")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "Title")
	arg_1_0._textTitle = gohelper.findChildText(arg_1_0._goTitle, "#txt_Title")
	arg_1_0._tipsClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/tipsClick")
	arg_1_0._goSnowEffect1 = gohelper.findChild(arg_1_0.viewGO, "bg_eff/vx_snow01")
	arg_1_0._goSnowEffect2 = gohelper.findChild(arg_1_0.viewGO, "bg_eff/vx_snow02")
	arg_1_0._goSnowEffect3 = gohelper.findChild(arg_1_0.viewGO, "bg_eff/vx_snow03")
	arg_1_0._goFallEffect = gohelper.findChild(arg_1_0.viewGO, "vx_dead")
	arg_1_0._goCircleEffect1 = gohelper.findChild(arg_1_0.viewGO, "Map/#go_chess/#chess/circle/glow1")
	arg_1_0._goCircleEffect2 = gohelper.findChild(arg_1_0.viewGO, "Map/#go_chess/#chess/circle/glow2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._autoJump = false
	arg_2_0._preparingJump = false
	arg_2_0._maxDistance = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.MaxJumpDistance).size)
	arg_2_0._maxDistance = arg_2_0._maxDistance or 700
	arg_2_0._distancePerSecond = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.DistancePerSecond).size)
	arg_2_0._distancePerSecond = arg_2_0._distancePerSecond or 400
	arg_2_0._jumpTime = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.JumpTime).size)
	arg_2_0._jumpTime = arg_2_0._jumpTime or 0.5
	arg_2_0._maxCircleSize = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.MaxCircleSize).size)
	arg_2_0._maxCircleSize = arg_2_0._maxCircleSize or 200

	local var_2_0 = DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.ShowSnowEffectParams)
	local var_2_1 = var_2_0 and string.splitToNumber(var_2_0.size, "#") or {
		12,
		18
	}

	arg_2_0._showSnow2Idx = var_2_1[1]
	arg_2_0._showSnow3Idx = var_2_1[2]
	arg_2_0._maxDistance = arg_2_0._maxDistance or 700

	gohelper.setActive(arg_2_0._outRangeStateCircle, false)
	gohelper.setActive(arg_2_0._goGreenLightRange, true)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnRestart:AddClickListener(arg_3_0._doClickRestartAction, arg_3_0)
	arg_3_0._jumpBtnlongpress:AddLongPressListener(arg_3_0._onJumpLongPress, arg_3_0)
	arg_3_0._jumpBtnlongpress:SetLongPressTime({
		var_0_4,
		0.1
	})
	arg_3_0._jumpBtn:AddClickUpListener(arg_3_0._onClickJumpBtnUp, arg_3_0)
	arg_3_0._jumpBtn:AddClickDownListener(arg_3_0._onClickJumpDown, arg_3_0)
	arg_3_0._tipsClick:AddClickListener(arg_3_0._onClickTips, arg_3_0)
	arg_3_0:addEventCb(DungeonJumpGameController.instance, DungeonJumpGameEvent.AutoJumpOnMaxDistance, arg_3_0.onAutoJumpOnMaxDistance, arg_3_0)
	arg_3_0:addEventCb(DungeonJumpGameController.instance, DungeonJumpGameEvent.JumpGameReStart, arg_3_0.onRevertChess, arg_3_0)
	arg_3_0:addEventCb(DungeonJumpGameController.instance, DungeonJumpGameEvent.JumpGameCompleted, arg_3_0.onCompleted, arg_3_0)
	arg_3_0:addEventCb(DungeonJumpGameController.instance, DungeonJumpGameEvent.JumpGameExit, arg_3_0.onExit, arg_3_0)
	arg_3_0:addEventCb(DungeonJumpGameController.instance, DungeonJumpGameEvent.JumpGameGuideCompleted, arg_3_0.onGuideCompleted, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnRestart:RemoveClickListener()
	arg_4_0._jumpBtn:RemoveClickUpListener()
	arg_4_0._jumpBtn:RemoveClickDownListener()
	arg_4_0._jumpBtnlongpress:RemoveLongPressListener()
	arg_4_0._tipsClick:RemoveClickListener()
end

function var_0_0._doClickRestartAction(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeResetGame, MsgBoxEnum.BoxType.Yes_No, arg_5_0.onRestart, nil, nil, arg_5_0)
end

function var_0_0.onRestart(arg_6_0)
	DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[4], arg_6_0._curIdx)
	DungeonJumpGameController.instance:ClearProgress()
	DungeonJumpGameController.instance:initStatData()
	arg_6_0:setJumpable(true)
	arg_6_0:_refreashFallEffect(false)
	arg_6_0:_initMap()
	arg_6_0:doMapTrans()
end

function var_0_0._onJumpLongPress(arg_7_0)
	if not arg_7_0._preparingJump then
		return
	end

	local var_7_0 = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.JumpGameLongPressGuide)

	arg_7_0._currPercent = arg_7_0._currPercent + Time.deltaTime * var_0_5

	if var_7_0 then
		if arg_7_0._currPercent > var_0_6 then
			arg_7_0:setJumpable(false)
			DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.JumpGameLongPressGuide)
		else
			arg_7_0:_refreshJumpPressingView()
		end

		return
	end

	arg_7_0:_refreshJumpPressingView()
end

function var_0_0._refreshJumpPressingView(arg_8_0)
	if arg_8_0._autoJump then
		transformhelper.setLocalScale(arg_8_0._jumpChessImage.transform, 1, 1, 1)
		arg_8_0._nodeItemsDict[arg_8_0._curIdx]:setNodeScale(1, 1)

		return
	end

	local var_8_0 = 1 + arg_8_0._currPercent * 0.1

	if var_8_0 > 1.25 then
		var_8_0 = 1.25
	end

	local var_8_1 = 1 - arg_8_0._currPercent * 0.1

	if var_8_1 < 0.75 then
		var_8_1 = 0.75
	end

	transformhelper.setLocalScale(arg_8_0._jumpChessImage.transform, var_8_0, var_8_1, 1)
	arg_8_0._nodeItemsDict[arg_8_0._curIdx]:setNodeScale(var_8_0, var_8_1)
	arg_8_0:refreshPressState(arg_8_0._currPercent)
end

function var_0_0._onClickJumpDown(arg_9_0)
	if not arg_9_0:checkJumpable() then
		arg_9_0._preparingJump = false

		return
	end

	arg_9_0._preparingJump = true

	recthelper.setHeight(arg_9_0._pressStateCircle.transform, 0)

	local var_9_0, var_9_1 = recthelper.getAnchor(arg_9_0._jumpChess.transform)
	local var_9_2 = arg_9_0._curIdx + 1

	if var_9_2 > #arg_9_0._nodeDatas then
		return
	end

	gohelper.setActive(arg_9_0._goCircleEffect1, false)
	gohelper.setActive(arg_9_0._goCircleEffect2, false)

	local var_9_3 = arg_9_0._nodeDatas[var_9_2]
	local var_9_4 = var_9_3.x
	local var_9_5 = var_9_3.y
	local var_9_6 = var_9_3.size

	arg_9_0:refreshCircleSize(true, var_9_0, var_9_1, var_9_4, var_9_5, var_9_6)

	arg_9_0._currPercent = 0

	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_tiaoyitiao_xuli)
end

function var_0_0._onClickJumpBtnUp(arg_10_0)
	if arg_10_0._autoJump then
		arg_10_0._autoJump = false

		return
	end

	if not arg_10_0._preparingJump then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.JumpGameLongPressGuide) then
		return
	end

	arg_10_0:setJumpable(false)
	arg_10_0:_doJumpView()
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_tiaoyitiao_xuli)
end

function var_0_0._doJumpView(arg_11_0)
	arg_11_0:refreshCircleSize(false)
	transformhelper.setLocalScale(arg_11_0._jumpChessImage.transform, 1, 1, 1)
	arg_11_0._nodeItemsDict[arg_11_0._curIdx]:setNodeScale(1, 1)

	local var_11_0 = arg_11_0._curIdx
	local var_11_1 = arg_11_0._nodeDatas[var_11_0]
	local var_11_2 = var_11_1.x
	local var_11_3 = var_11_1.y
	local var_11_4, var_11_5 = recthelper.getAnchor(arg_11_0._jumpChess.transform)
	local var_11_6 = var_11_0 + 1
	local var_11_7 = arg_11_0._nodeDatas[var_11_6]
	local var_11_8 = var_11_7.x
	local var_11_9 = var_11_7.y
	local var_11_10 = math.sqrt((var_11_8 - var_11_4) * (var_11_8 - var_11_4) + (var_11_9 - var_11_5) * (var_11_9 - var_11_5))
	local var_11_11 = arg_11_0._currPercent * arg_11_0._distancePerSecond
	local var_11_12 = var_11_4 + (var_11_8 - var_11_4) * var_11_11 / var_11_10
	local var_11_13 = var_11_5 + (var_11_9 - var_11_5) * var_11_11 / var_11_10
	local var_11_14 = arg_11_0:checkJumpingResult(var_11_1, var_11_7, var_11_12, var_11_13)

	if var_11_14 == var_0_7.Original then
		arg_11_0:setJumpable(true)

		return
	elseif var_11_14 == var_0_7.ToNext then
		arg_11_0:_jumpTo(arg_11_0._jumpChess, var_11_4, var_11_5, var_11_8, var_11_9)
	else
		arg_11_0:_jumpTo(arg_11_0._jumpChess, var_11_4, var_11_5, var_11_12, var_11_13)
	end

	TaskDispatcher.runDelay(arg_11_0.onAfterJump, arg_11_0, var_0_1)
end

function var_0_0.onAfterJump(arg_12_0)
	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_tiaoyitiao_fall)

	arg_12_0.continueGame, arg_12_0.win = arg_12_0:checkJumpResult()

	arg_12_0:doMapTrans()

	if not arg_12_0:doNodeEvent() then
		arg_12_0:setJumpable(true)
		arg_12_0:_refreashNextNodeItem()

		if not arg_12_0.continueGame then
			if not arg_12_0.win then
				DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[2], arg_12_0._curIdx)

				local var_12_0 = recthelper.getAnchorY(arg_12_0._jumpChess.transform)
				local var_12_1 = recthelper.getAnchorX(arg_12_0._jumpChess.transform)

				arg_12_0._jumpChessRoot.transform:SetSiblingIndex(0)

				arg_12_0._dropingTween = ZProj.TweenHelper.DOAnchorPos(arg_12_0._jumpChess.transform, var_12_1 + 300, var_12_0 - var_0_3, var_0_2)

				arg_12_0:_refreashFallEffect(true)
			else
				DungeonJumpGameController.instance:sandStatData(DungeonMazeEnum.resultStat[1], arg_12_0._curIdx)
			end

			arg_12_0._gameResult = arg_12_0.win

			arg_12_0:setJumpable(false)
			TaskDispatcher.runDelay(arg_12_0._showGameResultView, arg_12_0, var_0_1)

			return
		end
	end

	DungeonJumpGameController.instance:SaveCurProgress(arg_12_0._curIdx)
	arg_12_0._jumpChessAnimator:Play(UIAnimationName.Jump, 0, 0)
end

function var_0_0._showGameResultView(arg_13_0)
	if arg_13_0._gameResult then
		DungeonRpc.instance:sendMapElementRequest(arg_13_0._elementId)
	end

	DungeonJumpGameController.instance:openResultView(arg_13_0._gameResult, arg_13_0._elementId)

	arg_13_0._gameResult = nil
end

function var_0_0.checkJumpingResult(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_1.x
	local var_14_1 = arg_14_1.y
	local var_14_2 = arg_14_2
	local var_14_3 = var_14_2.x
	local var_14_4 = var_14_2.y
	local var_14_5 = var_14_2.size
	local var_14_6 = math.sqrt((var_14_0 - arg_14_3) * (var_14_0 - arg_14_3) + (var_14_1 - arg_14_4) * (var_14_1 - arg_14_4))

	if var_14_6 - var_14_5 / 2 < 0 then
		return var_0_7.Original
	end

	local var_14_7 = math.sqrt((var_14_3 - arg_14_3) * (var_14_3 - arg_14_3) + (var_14_4 - arg_14_4) * (var_14_4 - arg_14_4))

	if var_14_6 - var_14_5 / 2 > 0 and var_14_7 - var_14_5 / 2 < 0 then
		return var_0_7.ToNext
	else
		return var_0_7.Fall
	end
end

function var_0_0.checkJumpResult(arg_15_0)
	local var_15_0 = arg_15_0._nodeDatas[arg_15_0._curIdx]
	local var_15_1 = var_15_0.x
	local var_15_2 = var_15_0.y
	local var_15_3, var_15_4 = recthelper.getAnchor(arg_15_0._jumpChess.transform)
	local var_15_5 = math.sqrt((var_15_1 - var_15_3) * (var_15_1 - var_15_3) + (var_15_2 - var_15_4) * (var_15_2 - var_15_4))
	local var_15_6 = var_15_0.size
	local var_15_7 = arg_15_0._nodeDatas[arg_15_0._curIdx + 1]
	local var_15_8 = var_15_7.x
	local var_15_9 = var_15_7.y
	local var_15_10 = var_15_7.size
	local var_15_11 = math.sqrt((var_15_8 - var_15_3) * (var_15_8 - var_15_3) + (var_15_9 - var_15_4) * (var_15_9 - var_15_4))

	if var_15_5 - var_15_6 / 2 < 0 then
		return true
	elseif var_15_5 - var_15_6 / 2 > 0 and var_15_11 - var_15_10 / 2 < 0 then
		if arg_15_0._curIdx + 1 == #arg_15_0._nodeDatas then
			arg_15_0._curIdx = arg_15_0._curIdx + 1

			return false, true
		end

		arg_15_0._curIdx = arg_15_0._curIdx + 1

		return true
	else
		return false, false
	end
end

function var_0_0.checkFinish(arg_16_0)
	return arg_16_0._curIdx == #arg_16_0._nodeDatas
end

function var_0_0.doMapTrans(arg_17_0)
	local var_17_0 = arg_17_0._jumpChess.transform.localPosition.x
	local var_17_1 = arg_17_0._jumpChess.transform.localPosition.y

	if arg_17_0._curIdx > #arg_17_0._nodeDatas - 1 then
		local var_17_2 = arg_17_0._nodeDatas[#arg_17_0._nodeDatas - 1]

		var_17_0 = var_17_2.x
		var_17_1 = var_17_2.y
	end

	arg_17_0._mapTween = ZProj.TweenHelper.DOAnchorPos(arg_17_0._goMap.transform, -var_17_0 - 100, -var_17_1 - 150, 0.5)

	ZProj.TweenHelper.DOAnchorPos(arg_17_0._goBg.transform, -var_17_0 - 100, -var_17_1 - 150, 0.5)
end

function var_0_0.doNodeEvent(arg_18_0)
	local var_18_0 = arg_18_0._nodeDatas[arg_18_0._curIdx]

	if not var_18_0 then
		return
	end

	if var_18_0.type == 2 then
		if var_18_0.toggled then
			return false
		end

		local var_18_1 = var_18_0.evenid

		arg_18_0._tipsEventArray = string.splitToNumber(var_18_1, "#")

		arg_18_0:_onClickTips()

		var_18_0.toggled = true

		return true
	elseif var_18_0.type == 4 then
		if var_18_0.toggled then
			return false
		end

		local var_18_2 = tonumber(var_18_0.evenid)

		DialogueController.instance:enterDialogue(var_18_2, arg_18_0._onPlayDialogFinished, arg_18_0)

		var_18_0.toggled = true

		return true
	elseif var_18_0.type == 5 then
		local var_18_3 = tonumber(var_18_0.evenid)
		local var_18_4 = 0
		local var_18_5 = DungeonConfig.instance:getEpisodeCO(var_18_3)

		if var_18_5 == nil then
			return false
		end

		local var_18_6 = DungeonModel.instance:hasPassLevel(var_18_3)

		if var_18_0.toggled and var_18_6 then
			return false
		end

		var_18_0.toggled = true

		DungeonModel.instance:SetSendChapterEpisodeId(var_18_4, var_18_3)
		DungeonFightController.instance:enterFightByBattleId(var_18_5.chapterId, var_18_3, var_18_5.battleId)

		return true
	elseif var_18_0.type == 3 then
		local var_18_7 = tonumber(var_18_0.evenid)

		if GuideModel.instance:isGuideRunning(var_18_7) then
			DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.JumpGameArriveNode, arg_18_0._curIdx)

			return true
		end

		return false
	end

	return false
end

function var_0_0.doNodeEventOnEnterGame(arg_19_0)
	local var_19_0 = arg_19_0._nodeDatas[arg_19_0._curIdx]

	if not var_19_0 then
		return
	end

	if var_19_0.type == 2 then
		if var_19_0.toggled then
			return
		end

		local var_19_1 = var_19_0.evenid

		arg_19_0._tipsEventArray = string.splitToNumber(var_19_1, "#")

		arg_19_0:_onClickTips()

		var_19_0.toggled = true
	elseif var_19_0.type == 4 then
		if var_19_0.toggled then
			return false
		end

		local var_19_2 = tonumber(var_19_0.evenid)

		DialogueController.instance:enterDialogue(var_19_2, arg_19_0._onPlayDialogFinished, arg_19_0)

		var_19_0.toggled = true
	elseif var_19_0.type == 3 then
		local var_19_3 = tonumber(var_19_0.evenid)

		if GuideModel.instance:isGuideRunning(var_19_3) then
			DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.JumpGameArriveNode, arg_19_0._curIdx)
		end
	end
end

function var_0_0._onClickTips(arg_20_0)
	if arg_20_0._tipsEventArray and #arg_20_0._tipsEventArray > 0 then
		local var_20_0 = DungeonGameConfig.instance:getJumpGameEventCfg(arg_20_0._tipsEventArray[1]).desc

		table.remove(arg_20_0._tipsEventArray, 1)
		gohelper.setActive(arg_20_0._goTitle, false)
		gohelper.setActive(arg_20_0._goTitle, true)

		arg_20_0._textTitle.text = var_20_0
	else
		gohelper.setActive(arg_20_0._goTitle, false)
		arg_20_0:setJumpable(true)
		arg_20_0:_refreashNextNodeItem()

		arg_20_0._showingTips = false
	end
end

function var_0_0._onClickFight(arg_21_0)
	local var_21_0 = arg_21_0._nodeDatas[arg_21_0._curIdx]

	if not var_21_0.isBattle then
		return
	end

	local var_21_1 = tonumber(var_21_0.evenid)

	if DungeonModel.instance:hasPassLevel(var_21_1) and var_21_0.toggled then
		return
	end

	local var_21_2 = 0
	local var_21_3 = DungeonConfig.instance:getEpisodeCO(var_21_1)

	if var_21_3 == nil then
		return
	end

	DungeonModel.instance:SetSendChapterEpisodeId(var_21_2, var_21_1)
	DungeonFightController.instance:enterFightByBattleId(var_21_3.chapterId, var_21_1, var_21_3.battleId)
end

function var_0_0._onPlayDialogFinished(arg_22_0)
	arg_22_0:setJumpable(true)
	arg_22_0:_refreashNextNodeItem()
end

function var_0_0.checkJumpable(arg_23_0)
	local var_23_0 = arg_23_0._nodeDatas[arg_23_0._curIdx]

	if var_23_0.isBattle then
		local var_23_1 = tonumber(var_23_0.evenid)

		if not DungeonModel.instance:hasPassLevel(var_23_1) then
			return false
		end
	end

	return true
end

function var_0_0.setJumpable(arg_24_0, arg_24_1)
	if not arg_24_1 then
		arg_24_0._jumpBtnlongpress:RemoveLongPressListener()
	else
		arg_24_0._jumpBtnlongpress:AddLongPressListener(arg_24_0._onJumpLongPress, arg_24_0)
		arg_24_0._jumpBtnlongpress:SetLongPressTime({
			var_0_4,
			0.1
		})
	end

	arg_24_0._jumpBtn.enabled = arg_24_1
end

function var_0_0.onAutoJumpOnMaxDistance(arg_25_0)
	if arg_25_0._gameResult ~= nil then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.stop_ui_fuleyuan_tiaoyitiao_xuli)
	arg_25_0:setJumpable(false)
	arg_25_0:_doJumpView()
end

function var_0_0.onRevertChess(arg_26_0)
	DungeonJumpGameController.instance:initStatData()
	arg_26_0:_refreashFallEffect(false)
	arg_26_0:setJumpable(true)
	recthelper.setAnchor(arg_26_0._jumpChess.transform, arg_26_0._nodeDatas[arg_26_0._curIdx].x, arg_26_0._nodeDatas[arg_26_0._curIdx].y)
	arg_26_0._jumpChessRoot.transform:SetSiblingIndex(1)
	arg_26_0:doMapTrans()
end

function var_0_0.onCompleted(arg_27_0)
	arg_27_0:closeThis()
end

function var_0_0.onExit(arg_28_0)
	arg_28_0:closeThis()
end

function var_0_0.onGuideCompleted(arg_29_0)
	arg_29_0:setJumpable(true)
	arg_29_0:refreshCircleSize(false)
	transformhelper.setLocalScale(arg_29_0._jumpChessImage.transform, 1, 1, 1)
	arg_29_0._nodeItemsDict[arg_29_0._curIdx]:setNodeScale(1, 1)
	arg_29_0:_refreashNextNodeItem()

	if arg_29_0:checkFinish() then
		arg_29_0._gameResult = true

		arg_29_0:setJumpable(false)
		TaskDispatcher.runDelay(arg_29_0._showGameResultView, arg_29_0, var_0_1)

		return
	elseif not arg_29_0.continueGame then
		arg_29_0._gameResult = arg_29_0.win

		arg_29_0:setJumpable(false)
		TaskDispatcher.runDelay(arg_29_0._showGameResultView, arg_29_0, var_0_1)

		return
	end
end

function var_0_0.onOpen(arg_30_0)
	arg_30_0._elementId = arg_30_0.viewParam and arg_30_0.viewParam.elementId
	arg_30_0._elementId = arg_30_0._elementId and arg_30_0._elementId or DungeonJumpGameEnum.elementId
	arg_30_0.jumpGameMapId = arg_30_0._elementId and DungeonJumpGameEnum.EleementId2JumpMapIdDict[arg_30_0._elementId]
	arg_30_0.jumpGameMapId = arg_30_0.jumpGameMapId or 1001
	arg_30_0._oriBgX, arg_30_0._oriBgY = recthelper.getAnchor(arg_30_0._goBg.transform)

	arg_30_0:_initMap()

	local var_30_0 = arg_30_0._nodeDatas[arg_30_0._curIdx]

	if var_30_0 and var_30_0.isBattle then
		GuideController.instance:startGudie(DungeonJumpGameEnum.battleGuideId)
	end

	arg_30_0:doNodeEventOnEnterGame()
end

function var_0_0.onOpenFinish(arg_31_0)
	DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.JumpGameEnter, arg_31_0._curIdx)
end

function var_0_0.onClose(arg_32_0)
	return
end

function var_0_0._initMap(arg_33_0)
	recthelper.setSize(arg_33_0._goGreenLightRange.transform, arg_33_0._maxCircleSize, arg_33_0._maxCircleSize)
	gohelper.setActive(arg_33_0._goTitle, false)
	recthelper.setAnchor(arg_33_0._goMap.transform, 0, 0)
	recthelper.setAnchor(arg_33_0._goBg.transform, arg_33_0._oriBgX, arg_33_0._oriBgY)

	local var_33_0 = DungeonJumpGameController.instance:LoadProgress()

	arg_33_0._curIdx = var_33_0 and var_33_0 or 1

	arg_33_0:_createNodeItems()
	recthelper.setAnchor(arg_33_0._jumpChess.transform, arg_33_0._nodeDatas[arg_33_0._curIdx].x, arg_33_0._nodeDatas[arg_33_0._curIdx].y)
	arg_33_0._jumpChessRoot.transform:SetSiblingIndex(1)
	arg_33_0:doMapTrans()
	arg_33_0:_refreashSnowEffect()

	arg_33_0.continueGame = true
	arg_33_0.win = false
end

function var_0_0._createNodeItems(arg_34_0)
	local var_34_0 = DungeonGameConfig.instance:getJumpMap(arg_34_0.jumpGameMapId)

	arg_34_0._nodeDatas = {}
	arg_34_0._nodeDatasForSibling = {}

	local var_34_1 = tonumber(DungeonGameConfig.instance:getJumpGameConst(DungeonJumpGameEnum.ConstId.NodeSize).size)

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		local var_34_2 = {}
		local var_34_3 = string.splitToNumber(iter_34_1.coord, "#")

		var_34_2.x = var_34_3[1]
		var_34_2.y = var_34_3[2]
		var_34_2.type = iter_34_1.celltype
		var_34_2.size = var_34_1
		var_34_2.evenid = iter_34_1.evenid
		var_34_2.toggled = false
		var_34_2.idx = iter_34_0
		var_34_2.bg = iter_34_1.cellspecies
		var_34_2.isBattle = iter_34_1.celltype == 5

		if iter_34_0 <= arg_34_0._curIdx then
			var_34_2.toggled = true
		end

		arg_34_0._nodeDatas[iter_34_0] = var_34_2
		arg_34_0._nodeDatasForSibling[#var_34_0 - iter_34_0 + 1] = var_34_2
	end

	arg_34_0._nodeItemsDict = {}

	gohelper.CreateObjList(arg_34_0, arg_34_0._createNodeItem, arg_34_0._nodeDatasForSibling, arg_34_0._goNodeItemRoot, arg_34_0._goNodeItem, DungeonJumpGameNodeItem)
end

function var_0_0._createNodeItem(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_1:onUpdateData(arg_35_2)
	arg_35_1:initNode()

	arg_35_0._nodeItemsDict[#arg_35_0._nodeDatasForSibling - arg_35_3 + 1] = arg_35_1

	local var_35_0 = arg_35_0:_checkNodeActive(#arg_35_0._nodeDatasForSibling - arg_35_3 + 1)

	arg_35_1:setNodeActive(var_35_0)
	arg_35_1:setFightAction(arg_35_0._onClickFight, arg_35_0)
end

function var_0_0._checkNodeActive(arg_36_0, arg_36_1)
	if arg_36_1 > arg_36_0._curIdx + 1 then
		return false
	end

	local var_36_0 = arg_36_0._nodeItemsDict[arg_36_1]

	if var_36_0.type == 2 or var_36_0.type == 4 then
		return var_36_0.toggled
	elseif var_36_0.type == 5 then
		local var_36_1 = tonumber(var_36_0.evenid)

		return not DungeonModel.instance:hasPassLevel(var_36_1)
	else
		return true
	end
end

function var_0_0._refreashNextNodeItem(arg_37_0)
	local var_37_0 = arg_37_0._nodeItemsDict[arg_37_0._curIdx + 1]

	if var_37_0 then
		var_37_0:setNodeActive(true)
	end

	AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_tiaoyitiao_drop)
	arg_37_0:_refreashSnowEffect()
end

function var_0_0._refreashSnowEffect(arg_38_0)
	local var_38_0 = arg_38_0._curIdx < arg_38_0._showSnow2Idx
	local var_38_1 = not var_38_0 and arg_38_0._curIdx < arg_38_0._showSnow3Idx
	local var_38_2 = arg_38_0._curIdx >= arg_38_0._showSnow3Idx

	gohelper.setActive(arg_38_0._goSnowEffect1, var_38_0)
	gohelper.setActive(arg_38_0._goSnowEffect2, var_38_1)
	gohelper.setActive(arg_38_0._goSnowEffect3, var_38_2)
end

function var_0_0._refreashFallEffect(arg_39_0, arg_39_1)
	if not arg_39_1 and arg_39_0._dropingTween then
		ZProj.TweenHelper.KillById(arg_39_0._dropingTween)

		arg_39_0._dropingTween = nil
	end

	gohelper.setActive(arg_39_0._goFallEffect, arg_39_1)
end

function var_0_0._jumpTo(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4, arg_40_5)
	local var_40_0 = 300
	local var_40_1 = 1

	ZProj.TweenHelper.DOLocalJump(arg_40_1.transform, Vector3(arg_40_4, arg_40_5, 0), var_40_0, var_40_1, var_0_1)
end

function var_0_0.getCurCellIdx(arg_41_0)
	return arg_41_0._curIdx
end

function var_0_0.refreshCircleSize(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	arg_42_0._jumpCircle:SetActive(arg_42_1)

	if not arg_42_1 then
		return
	end

	local var_42_0 = math.sqrt((arg_42_4 - arg_42_2) * (arg_42_4 - arg_42_2) + (arg_42_5 - arg_42_3) * (arg_42_5 - arg_42_3))

	if var_42_0 > arg_42_0._maxDistance - arg_42_6 / 2 then
		var_42_0 = arg_42_0._maxDistance - arg_42_6 / 2
	end

	arg_42_0._unCatchLength = var_42_0 - arg_42_6 / 2
	arg_42_0._overCatchLength = var_42_0 + arg_42_6 / 2
	arg_42_0._toNextNodeLength = var_42_0
	arg_42_0._jumpSuccessMaxDistance = arg_42_0._overCatchLength
	arg_42_0._jumpSuccessMinDistance = arg_42_0._unCatchLength
	arg_42_0._greenCirSize = arg_42_0._overCatchLength / arg_42_0._maxDistance * arg_42_0._maxCircleSize
	arg_42_0._drakCirSize = arg_42_0._unCatchLength / arg_42_0._maxDistance * arg_42_0._maxCircleSize

	recthelper.setSize(arg_42_0._goGreenNormalRange.transform, arg_42_0._greenCirSize, arg_42_0._greenCirSize)
	recthelper.setSize(arg_42_0._goCurrentAreaRange.transform, arg_42_0._greenCirSize, arg_42_0._greenCirSize)
	recthelper.setSize(arg_42_0._goDrakRange.transform, arg_42_0._drakCirSize, arg_42_0._drakCirSize)
	gohelper.setActive(arg_42_0._outRangeStateCircle, false)
	recthelper.setSize(arg_42_0._pressStateCircle.transform, 0, 0)
end

function var_0_0.refreshPressState(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1 * arg_43_0._distancePerSecond

	gohelper.setActive(arg_43_0._outRangeStateCircle, var_43_0 >= arg_43_0._jumpSuccessMaxDistance)
	gohelper.setActive(arg_43_0._goCurrentAreaRange, var_43_0 > arg_43_0._jumpSuccessMinDistance and var_43_0 < arg_43_0._jumpSuccessMaxDistance)
	gohelper.setActive(arg_43_0._goGreenNormalRange, var_43_0 < arg_43_0._jumpSuccessMinDistance or var_43_0 > arg_43_0._jumpSuccessMaxDistance)

	local var_43_1 = var_43_0 >= arg_43_0._jumpSuccessMinDistance and var_43_0 < arg_43_0._jumpSuccessMaxDistance

	gohelper.setActive(arg_43_0._goCircleEffect1, var_43_1)
	gohelper.setActive(arg_43_0._goCircleEffect2, var_43_1)

	local var_43_2 = var_43_0 / arg_43_0._maxDistance * arg_43_0._maxCircleSize

	if var_43_0 <= arg_43_0._maxDistance + 30 then
		recthelper.setSize(arg_43_0._pressStateCircle.transform, var_43_2, var_43_2)
		recthelper.setSize(arg_43_0._outRangeStateCircle.transform, var_43_2, var_43_2)
	else
		DungeonJumpGameController.instance:dispatchEvent(DungeonJumpGameEvent.AutoJumpOnMaxDistance)
	end
end

function var_0_0.onDestroyView(arg_44_0)
	return
end

return var_0_0
