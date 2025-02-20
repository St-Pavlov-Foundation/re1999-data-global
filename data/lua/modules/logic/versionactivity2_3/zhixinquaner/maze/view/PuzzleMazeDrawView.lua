module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeDrawView", package.seeall)

slot0 = class("PuzzleMazeDrawView", PuzzleMazeDrawBaseView)
slot1 = 1.13
slot2 = "PuzzleMazeDrawController;PuzzleEvent;EnableTriggerEffect"

function slot0.onInitView(slot0)
	slot0._gomap = gohelper.findChild(slot0.viewGO, "#go_map")
	slot0._goconnect = gohelper.findChild(slot0.viewGO, "#go_connect")
	slot0._imagelinetemplater = gohelper.findChildImage(slot0.viewGO, "#image_line_template_r")
	slot0._imagelinetemplatel = gohelper.findChildImage(slot0.viewGO, "#image_line_template_l")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._goplane = gohelper.findChild(slot0.viewGO, "#go_map/#go_plane")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_finish")
	slot0._txtTarget = gohelper.findChildText(slot0.viewGO, "Target/txt_Target")
	slot0._goCheckMark = gohelper.findChild(slot0.viewGO, "Target/txt_Target/image_Check/image_CheckMark")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, slot0._initGameDone, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:registerAlertTriggerFunc(PuzzleEnum.MazeAlertType.VisitRepeat, slot0.onVisitRepeatObj)
	slot0:refreshTargetTips()

	slot0._startGameTime = ServerTime.now()

	TaskDispatcher.cancelTask(slot0._enableTriggerEffect, slot0)
	TaskDispatcher.runDelay(slot0._enableTriggerEffect, slot0, uv1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_EnterView)
end

function slot0._enableTriggerEffect(slot0)
	slot0._enableTrigger = true

	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.EnableTriggerEffect)
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeResetGame, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_resetGame()
	end)
end

function slot0._resetGame(slot0)
	if not slot0:canTouch() then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	slot0:stat(PuzzleEnum.GameResult.Restart)
	slot0:restartGame()
end

function slot0.restartGame(slot0)
	uv0.super.restartGame(slot0)
	gohelper.setActive(slot0._goplane, false)
	gohelper.setActive(slot0._goCheckMark, false)
end

function slot0.getModelInst(slot0)
	return PuzzleMazeDrawModel.instance
end

function slot0.getCtrlInst(slot0)
	return PuzzleMazeDrawController.instance
end

function slot0.getDragGo(slot0)
	return slot0._gomap
end

function slot0.getLineParentGo(slot0)
	return slot0._goconnect
end

function slot0.getPawnParentGo(slot0)
	return slot0._gomap
end

function slot0.getObjectParentGo(slot0)
	return slot0._gomap
end

function slot0.getAlertParentGo(slot0)
	return slot0._gomap
end

function slot0.getMazeObjCls(slot0, slot1, slot2, slot3)
	if not slot0._mazeObjClsMap then
		slot0._mazeObjClsMap = {
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

	if not (slot0._mazeObjClsMap[slot1] and slot4[slot2 or PuzzleEnum.MazeObjSubType.Default]) then
		logError(string.format("find mazeObjCls failed, objType = %s, subType = %s, group = %s", slot1, slot2, slot3))
	end

	return slot5
end

function slot0.getPawnObjCls(slot0)
	return PuzzleMazePawnObj
end

function slot0.getLineObjCls(slot0, slot1)
	if slot1 == PuzzleEnum.LineType.Map then
		return PuzzleMazeMapLine
	end

	return PuzzleMazeLine
end

function slot0.getAlertObjCls(slot0, slot1)
	return PuzzleMazeObjAlert
end

function slot0.getPawnResUrl(slot0)
	return slot0.viewContainer:getSetting().otherRes[3]
end

function slot0.getLineResUrl(slot0)
	return slot0.viewContainer:getSetting().otherRes[2]
end

function slot0.getObjectResUrl(slot0, slot1, slot2, slot3)
	if slot1 == PuzzleEnum.MazeObjType.Switch then
		return slot0.viewContainer:getSetting().otherRes[4]
	else
		return slot0.viewContainer:getSetting().otherRes[1]
	end
end

function slot0.getAlertResUrl(slot0, slot1)
	return slot0.viewContainer:getSetting().otherRes[1]
end

function slot0.getLineTemplateFillOrigin(slot0)
	return slot0._imagelinetemplatel.fillOrigin, slot0._imagelinetemplater.fillOrigin
end

function slot0.onVisitRepeatObj(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)
end

function slot0.onEndRefreshCheckPoint(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= nil and slot1 ~= slot2 and slot3 <= slot4 then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_unlock)
	end

	uv0.super.onEndRefreshCheckPoint(slot0, slot1, slot2, slot3, slot4)
end

function slot0.onBeginDragFailed(slot0, slot1)
	GameFacade.showToast(ToastEnum.DungeonPuzzle)
end

function slot0.onBeginDrag_SyncPawn(slot0)
	uv0.super.onBeginDrag_SyncPawn(slot0)

	if not slot0._alreadyDrag then
		slot1, slot2 = PuzzleMazeDrawModel.instance:getStartPoint()

		slot0:closeCheckObject(slot1, slot2)

		slot0._alreadyDrag = true
	end
end

function slot0._initGameDone(slot0)
	slot0:destroy_EndDrag_NoneAlert_Flow()

	slot0._endDrag_NoneAlert_Flow = FlowSequence.New()

	slot0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(slot0.tryTriggerEffect, slot0, slot0._endDrag_NoneAlert_Flow))
	slot0._endDrag_NoneAlert_Flow:start()
end

function slot0.onEndDrag_NoneAlert(slot0)
	slot0:destroy_EndDrag_NoneAlert_Flow()

	slot0._endDrag_NoneAlert_Flow = FlowSequence.New()

	slot0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(slot0.onEndDrag_SyncPawn, slot0))
	slot0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(slot0.syncPath, slot0))
	slot0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(slot0.cleanDragLine, slot0))
	slot0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(slot0.tryTriggerEffect, slot0, slot0._endDrag_NoneAlert_Flow))
	slot0._endDrag_NoneAlert_Flow:registerDoneListener(slot0.checkGameFinished, slot0)
	slot0._endDrag_NoneAlert_Flow:start()
end

function slot0.destroy_EndDrag_NoneAlert_Flow(slot0)
	if slot0._endDrag_NoneAlert_Flow ~= nil then
		slot0._endDrag_NoneAlert_Flow:destroy()

		slot0._endDrag_NoneAlert_Flow = nil
	end
end

function slot0.tryTriggerEffect(slot0, slot1)
	slot2, slot3 = slot0._ctrlInst:getLastPos()

	if not PuzzleMazeDrawModel.instance:getObjAtPos(slot2, slot3) or not slot4.effects or #slot4.effects <= 0 then
		return
	end

	if not PuzzleMazeDrawModel.instance:canTriggerEffect(slot2, slot3) then
		return
	end

	slot0:setCanTouch(false)

	slot0._triggerEffectPosX = slot2
	slot0._triggerEffectPosY = slot3

	slot0:buildTriggerEffectFlow(slot4.effects, slot1)
end

function slot0.buildTriggerEffectFlow(slot0, slot1, slot2)
	if not slot0._enableTrigger then
		slot2:addWork(WaitEventWork.New(uv0))
	end

	slot3 = FlowSequence.New()

	for slot7, slot8 in ipairs(slot1) do
		if slot0:getTriggerEffectCls(slot8.type) then
			slot10 = slot9.New()

			slot10:initData(slot8)
			slot3:addWork(slot10)
		end
	end

	slot3:registerDoneListener(slot0.onTriggerEffectDone, slot0)
	slot2:addWork(slot3)
end

function slot0.getTriggerEffectCls(slot0, slot1)
	if not slot0._effectClsMap then
		slot0._effectClsMap = {
			[PuzzleEnum.EffectType.Dialog] = ZhiXinQuanErDialogStep,
			[PuzzleEnum.EffectType.Story] = ZhiXinQuanErStoryStep,
			[PuzzleEnum.EffectType.Guide] = ZhiXinQuanErGuideStep
		}
	end

	return slot0._effectClsMap[slot1]
end

function slot0.onTriggerEffectDone(slot0)
	PuzzleMazeDrawModel.instance:setTriggerEffectDone(slot0._triggerEffectPosX, slot0._triggerEffectPosY)

	slot0._triggerEffectPosX = nil
	slot0._triggerEffectPosY = nil

	slot0:setCanTouch(true)
	PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.OnTriggerEffectDone)
end

function slot0.closeCheckObject(slot0, slot1, slot2)
	if slot0._objectMap[PuzzleMazeHelper.getPosKey(slot1, slot2)] and slot4.setCheckIconVisible then
		slot4:setCheckIconVisible(false)
	end
end

function slot0.onGameSucc(slot0)
	uv0.super.onGameSucc(slot0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	gohelper.setActive(slot0._gofinish, true)
	gohelper.setActive(slot0._goCheckMark, true)
	PuzzleMazeDrawController.instance:restartGame()
	slot0:stat(PuzzleEnum.GameResult.Success)
end

function slot0.refreshTargetTips(slot0)
	slot2 = slot0:getModelInst() and slot1:getElementCo()
	slot0._txtTarget.text = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, slot2 and slot2.id) and slot4.target or ""
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
	slot0:destroy_EndDrag_NoneAlert_Flow()
	TaskDispatcher.cancelTask(slot0._enableTriggerEffect, slot0)
end

slot3 = {
	[PuzzleEnum.GameResult.Success] = "成功",
	[PuzzleEnum.GameResult.Abort] = "中断",
	[PuzzleEnum.GameResult.Restart] = "重新开始"
}

function slot0.stat(slot0, slot1)
	StatController.instance:track(StatEnum.EventName.Exit_Flutterpage_activity, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0._startGameTime,
		[StatEnum.EventProperties.MapId] = tostring(Activity176Config.instance:getEpisodeCoByElementId(VersionActivity2_3Enum.ActivityId.ZhiXinQuanEr, PuzzleMazeDrawModel.instance:getElementCo() and slot3.id) and slot5.id),
		[StatEnum.EventProperties.Result] = uv0 and uv0[slot1]
	})
end

return slot0
