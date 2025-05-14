module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeDrawView", package.seeall)

local var_0_0 = class("PuzzleMazeDrawView", PuzzleMazeDrawBaseView)
local var_0_1 = 1.13
local var_0_2 = "PuzzleMazeDrawController;PuzzleEvent;EnableTriggerEffect"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "#go_map")
	arg_1_0._goconnect = gohelper.findChild(arg_1_0.viewGO, "#go_connect")
	arg_1_0._imagelinetemplater = gohelper.findChildImage(arg_1_0.viewGO, "#image_line_template_r")
	arg_1_0._imagelinetemplatel = gohelper.findChildImage(arg_1_0.viewGO, "#image_line_template_l")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._goplane = gohelper.findChild(arg_1_0.viewGO, "#go_map/#go_plane")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._txtTarget = gohelper.findChildText(arg_1_0.viewGO, "Target/txt_Target")
	arg_1_0._goCheckMark = gohelper.findChild(arg_1_0.viewGO, "Target/txt_Target/image_Check/image_CheckMark")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, arg_2_0._initGameDone, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	var_0_0.super.onOpen(arg_4_0)
	arg_4_0:registerAlertTriggerFunc(PuzzleEnum.MazeAlertType.VisitRepeat, arg_4_0.onVisitRepeatObj)
	arg_4_0:refreshTargetTips()

	arg_4_0._startGameTime = ServerTime.now()

	TaskDispatcher.cancelTask(arg_4_0._enableTriggerEffect, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._enableTriggerEffect, arg_4_0, var_0_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_EnterView)
end

function var_0_0._enableTriggerEffect(arg_5_0)
	arg_5_0._enableTrigger = true

	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.EnableTriggerEffect)
end

function var_0_0._btnresetOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		arg_6_0:_resetGame()
	end)
end

function var_0_0._resetGame(arg_8_0)
	if not arg_8_0:canTouch() then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	arg_8_0:stat(PuzzleEnum.GameResult.Restart)
	arg_8_0:restartGame()
end

function var_0_0.restartGame(arg_9_0)
	var_0_0.super.restartGame(arg_9_0)
	gohelper.setActive(arg_9_0._goplane, false)
	gohelper.setActive(arg_9_0._goCheckMark, false)
end

function var_0_0.getModelInst(arg_10_0)
	return PuzzleMazeDrawModel.instance
end

function var_0_0.getCtrlInst(arg_11_0)
	return PuzzleMazeDrawController.instance
end

function var_0_0.getDragGo(arg_12_0)
	return arg_12_0._gomap
end

function var_0_0.getLineParentGo(arg_13_0)
	return arg_13_0._goconnect
end

function var_0_0.getPawnParentGo(arg_14_0)
	return arg_14_0._gomap
end

function var_0_0.getObjectParentGo(arg_15_0)
	return arg_15_0._gomap
end

function var_0_0.getAlertParentGo(arg_16_0)
	return arg_16_0._gomap
end

function var_0_0.getMazeObjCls(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_0._mazeObjClsMap then
		arg_17_0._mazeObjClsMap = {
			[PuzzleEnum.MazeObjType.Start] = {
				[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeNormalObj
			},
			[PuzzleEnum.MazeObjType.End] = {
				[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeCheckObj
			},
			[PuzzleEnum.MazeObjType.CheckPoint] = {
				[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeCheckObj
			},
			[PuzzleEnum.MazeObjType.Switch] = {
				[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeSwitchObj
			},
			[PuzzleEnum.MazeObjType.Block] = {
				[PuzzleEnum.MazeObjSubType.Default] = PuzzleMazeNormalObj
			}
		}
	end

	arg_17_2 = arg_17_2 or PuzzleEnum.MazeObjSubType.Default

	local var_17_0 = arg_17_0._mazeObjClsMap[arg_17_1]
	local var_17_1 = var_17_0 and var_17_0[arg_17_2]

	if not var_17_1 then
		logError(string.format("find mazeObjCls failed, objType = %s, subType = %s, group = %s", arg_17_1, arg_17_2, arg_17_3))
	end

	return var_17_1
end

function var_0_0.getPawnObjCls(arg_18_0)
	return PuzzleMazePawnObj
end

function var_0_0.getLineObjCls(arg_19_0, arg_19_1)
	if arg_19_1 == PuzzleEnum.LineType.Map then
		return PuzzleMazeMapLine
	end

	return PuzzleMazeLine
end

function var_0_0.getAlertObjCls(arg_20_0, arg_20_1)
	return PuzzleMazeObjAlert
end

function var_0_0.getPawnResUrl(arg_21_0)
	return arg_21_0.viewContainer:getSetting().otherRes[3]
end

function var_0_0.getLineResUrl(arg_22_0)
	return arg_22_0.viewContainer:getSetting().otherRes[2]
end

function var_0_0.getObjectResUrl(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_1 == PuzzleEnum.MazeObjType.Switch then
		return arg_23_0.viewContainer:getSetting().otherRes[4]
	else
		return arg_23_0.viewContainer:getSetting().otherRes[1]
	end
end

function var_0_0.getAlertResUrl(arg_24_0, arg_24_1)
	return arg_24_0.viewContainer:getSetting().otherRes[1]
end

function var_0_0.getLineTemplateFillOrigin(arg_25_0)
	return arg_25_0._imagelinetemplatel.fillOrigin, arg_25_0._imagelinetemplater.fillOrigin
end

function var_0_0.onVisitRepeatObj(arg_26_0, arg_26_1)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)
end

function var_0_0.onEndRefreshCheckPoint(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if arg_27_1 ~= nil and arg_27_1 ~= arg_27_2 and arg_27_3 <= arg_27_4 then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_unlock)
	end

	var_0_0.super.onEndRefreshCheckPoint(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
end

function var_0_0.onBeginDragFailed(arg_28_0, arg_28_1)
	GameFacade.showToast(ToastEnum.DungeonPuzzle)
end

function var_0_0.onBeginDrag_SyncPawn(arg_29_0)
	var_0_0.super.onBeginDrag_SyncPawn(arg_29_0)

	if not arg_29_0._alreadyDrag then
		local var_29_0, var_29_1 = PuzzleMazeDrawModel.instance:getStartPoint()

		arg_29_0:closeCheckObject(var_29_0, var_29_1)

		arg_29_0._alreadyDrag = true
	end
end

function var_0_0._initGameDone(arg_30_0)
	arg_30_0:destroy_EndDrag_NoneAlert_Flow()

	arg_30_0._endDrag_NoneAlert_Flow = FlowSequence.New()

	arg_30_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_30_0.tryTriggerEffect, arg_30_0, arg_30_0._endDrag_NoneAlert_Flow))
	arg_30_0._endDrag_NoneAlert_Flow:start()
end

function var_0_0.onEndDrag_NoneAlert(arg_31_0)
	arg_31_0:destroy_EndDrag_NoneAlert_Flow()

	arg_31_0._endDrag_NoneAlert_Flow = FlowSequence.New()

	arg_31_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_31_0.onEndDrag_SyncPawn, arg_31_0))
	arg_31_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_31_0.syncPath, arg_31_0))
	arg_31_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_31_0.cleanDragLine, arg_31_0))
	arg_31_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_31_0.tryTriggerEffect, arg_31_0, arg_31_0._endDrag_NoneAlert_Flow))
	arg_31_0._endDrag_NoneAlert_Flow:registerDoneListener(arg_31_0.checkGameFinished, arg_31_0)
	arg_31_0._endDrag_NoneAlert_Flow:start()
end

function var_0_0.destroy_EndDrag_NoneAlert_Flow(arg_32_0)
	if arg_32_0._endDrag_NoneAlert_Flow ~= nil then
		arg_32_0._endDrag_NoneAlert_Flow:destroy()

		arg_32_0._endDrag_NoneAlert_Flow = nil
	end
end

function var_0_0.tryTriggerEffect(arg_33_0, arg_33_1)
	local var_33_0, var_33_1 = arg_33_0._ctrlInst:getLastPos()
	local var_33_2 = PuzzleMazeDrawModel.instance:getObjAtPos(var_33_0, var_33_1)

	if not var_33_2 or not var_33_2.effects or #var_33_2.effects <= 0 then
		return
	end

	if not PuzzleMazeDrawModel.instance:canTriggerEffect(var_33_0, var_33_1) then
		return
	end

	arg_33_0:setCanTouch(false)

	arg_33_0._triggerEffectPosX = var_33_0
	arg_33_0._triggerEffectPosY = var_33_1

	arg_33_0:buildTriggerEffectFlow(var_33_2.effects, arg_33_1)
end

function var_0_0.buildTriggerEffectFlow(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_0._enableTrigger then
		arg_34_2:addWork(WaitEventWork.New(var_0_2))
	end

	local var_34_0 = FlowSequence.New()

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		local var_34_1 = arg_34_0:getTriggerEffectCls(iter_34_1.type)

		if var_34_1 then
			local var_34_2 = var_34_1.New()

			var_34_2:initData(iter_34_1)
			var_34_0:addWork(var_34_2)
		end
	end

	var_34_0:registerDoneListener(arg_34_0.onTriggerEffectDone, arg_34_0)
	arg_34_2:addWork(var_34_0)
end

function var_0_0.getTriggerEffectCls(arg_35_0, arg_35_1)
	if not arg_35_0._effectClsMap then
		arg_35_0._effectClsMap = {
			[PuzzleEnum.EffectType.Dialog] = ZhiXinQuanErDialogStep,
			[PuzzleEnum.EffectType.Story] = ZhiXinQuanErStoryStep,
			[PuzzleEnum.EffectType.Guide] = ZhiXinQuanErGuideStep
		}
	end

	return arg_35_0._effectClsMap[arg_35_1]
end

function var_0_0.onTriggerEffectDone(arg_36_0)
	PuzzleMazeDrawModel.instance:setTriggerEffectDone(arg_36_0._triggerEffectPosX, arg_36_0._triggerEffectPosY)

	arg_36_0._triggerEffectPosX = nil
	arg_36_0._triggerEffectPosY = nil

	arg_36_0:setCanTouch(true)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnTriggerEffectDone)
end

function var_0_0.closeCheckObject(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = PuzzleMazeHelper.getPosKey(arg_37_1, arg_37_2)
	local var_37_1 = arg_37_0._objectMap[var_37_0]

	if var_37_1 and var_37_1.setCheckIconVisible then
		var_37_1:setCheckIconVisible(false)
	end
end

function var_0_0.onGameSucc(arg_38_0)
	var_0_0.super.onGameSucc(arg_38_0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	gohelper.setActive(arg_38_0._gofinish, true)
	gohelper.setActive(arg_38_0._goCheckMark, true)
	PuzzleMazeDrawController.instance:restartGame()
	arg_38_0:stat(PuzzleEnum.GameResult.Success)
end

function var_0_0.refreshTargetTips(arg_39_0)
	local var_39_0 = arg_39_0:getModelInst()
	local var_39_1 = var_39_0 and var_39_0:getElementCo()
	local var_39_2 = var_39_1 and var_39_1.id
	local var_39_3 = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, var_39_2)

	arg_39_0._txtTarget.text = var_39_3 and var_39_3.target or ""
end

function var_0_0.onClose(arg_40_0)
	var_0_0.super.onClose(arg_40_0)
	arg_40_0:destroy_EndDrag_NoneAlert_Flow()
	TaskDispatcher.cancelTask(arg_40_0._enableTriggerEffect, arg_40_0)
end

local var_0_3 = {
	[PuzzleEnum.GameResult.Success] = "成功",
	[PuzzleEnum.GameResult.Abort] = "中断",
	[PuzzleEnum.GameResult.Restart] = "重新开始"
}

function var_0_0.stat(arg_41_0, arg_41_1)
	local var_41_0 = ServerTime.now() - arg_41_0._startGameTime
	local var_41_1 = PuzzleMazeDrawModel.instance:getElementCo()
	local var_41_2 = var_41_1 and var_41_1.id
	local var_41_3 = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, var_41_2)
	local var_41_4 = var_41_3 and var_41_3.id
	local var_41_5 = var_0_3 and var_0_3[arg_41_1]

	StatController.instance:track(StatEnum.EventName.Exit_Flutterpage_activity, {
		[StatEnum.EventProperties.UseTime] = var_41_0,
		[StatEnum.EventProperties.MapId] = tostring(var_41_4),
		[StatEnum.EventProperties.Result] = var_41_5
	})
end

return var_0_0
