module("modules.logic.versionactivity3_0.karong.view.KaRongDrawView", package.seeall)

local var_0_0 = class("KaRongDrawView", KaRongDrawBaseView)
local var_0_1 = 1.13
local var_0_2 = "KaRongDrawController;KaRongDrawEvent;EnableTriggerEffect"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_BG")
	arg_1_0._goTarget = gohelper.findChild(arg_1_0.viewGO, "#go_Target")
	arg_1_0._goLine = gohelper.findChild(arg_1_0.viewGO, "#go_Line")
	arg_1_0._goCheckPoint = gohelper.findChild(arg_1_0.viewGO, "#go_Checkpoint")
	arg_1_0._btnMask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Mask")
	arg_1_0._goDynamic = gohelper.findChild(arg_1_0.viewGO, "#go_Dynamic")
	arg_1_0._goDrag = gohelper.findChild(arg_1_0.viewGO, "#go_Dynamic/#go_Drag")
	arg_1_0._imagelinetemplater = gohelper.findChildImage(arg_1_0.viewGO, "#image_line_template_r")
	arg_1_0._imagelinetemplatel = gohelper.findChildImage(arg_1_0.viewGO, "#image_line_template_l")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_finish")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._btnSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Skill")
	arg_1_0._goNoLight = gohelper.findChild(arg_1_0.viewGO, "#btn_Skill/#go_NoLight")
	arg_1_0._goLight = gohelper.findChild(arg_1_0.viewGO, "#btn_Skill/#go_Light")
	arg_1_0._txtTimes = gohelper.findChildText(arg_1_0.viewGO, "#btn_Skill/#txt_Times")
	arg_1_0._goTip = gohelper.findChild(arg_1_0.viewGO, "#go_Tip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnMask:AddClickListener(arg_2_0._btnMaskOnClick, arg_2_0)
	arg_2_0._btnSkill:AddClickListener(arg_2_0._btnSkillOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnMask:RemoveClickListener()
	arg_3_0._btnSkill:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btnMaskOnClick(arg_4_0)
	if arg_4_0._ctrlInst.usingSkill then
		arg_4_0._ctrlInst:setUsingSkill(false)
	end
end

function var_0_0._btnSkillOnClick(arg_5_0)
	if arg_5_0._ctrlInst.skillCnt <= 0 then
		return
	end

	arg_5_0._ctrlInst:setUsingSkill(true)
end

function var_0_0._btnresetOnClick(arg_6_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act176PuzzleMazeResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		arg_6_0:_resetGame()
	end)
end

function var_0_0._editableInitView(arg_8_0)
	var_0_0.super._editableInitView(arg_8_0)

	arg_8_0._txtTarget = gohelper.findChildText(arg_8_0.viewGO, "#go_Target/txt_Target")
	arg_8_0.animBtnSkill = arg_8_0._btnSkill.gameObject:GetComponent(gohelper.Type_Animator)
	arg_8_0.effectGray = gohelper.findChild(arg_8_0.viewGO, "#simage_BG/#effect_gray")
	arg_8_0.effectColour = gohelper.findChild(arg_8_0.viewGO, "#simage_BG/#effect_colour")
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_burn_loop)
	arg_9_0:addEventCb(KaRongDrawController.instance, KaRongDrawEvent.InitGameDone, arg_9_0._initGameDone, arg_9_0)
	arg_9_0:addEventCb(KaRongDrawController.instance, KaRongDrawEvent.UpdateAvatarPos, arg_9_0._syncAvatar, arg_9_0)
	arg_9_0:addEventCb(KaRongDrawController.instance, KaRongDrawEvent.SkillCntChange, arg_9_0._refreshSkillCnt, arg_9_0)
	arg_9_0:addEventCb(KaRongDrawController.instance, KaRongDrawEvent.UsingSkill, arg_9_0._onUsingSkill, arg_9_0)
	arg_9_0:startGame()
	arg_9_0:registerAlertTriggerFunc(KaRongDrawEnum.MazeAlertType.VisitRepeat, arg_9_0.onVisitRepeatObj)

	arg_9_0._startGameTime = ServerTime.now()

	TaskDispatcher.runDelay(arg_9_0._enableTriggerEffect, arg_9_0, var_0_1)
	arg_9_0:_refreshUI()
end

function var_0_0.onClose(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.stop_ui_lushang_burn_loop)
end

function var_0_0.onDestroyView(arg_11_0)
	var_0_0.super.onDestroyView(arg_11_0)
	arg_11_0:destroy_EndDrag_NoneAlert_Flow()
	TaskDispatcher.cancelTask(arg_11_0._enableTriggerEffect, arg_11_0)
end

function var_0_0.startGame(arg_12_0)
	var_0_0.super.startGame(arg_12_0)
	gohelper.setActive(arg_12_0._btnSkill, false)
end

function var_0_0._refreshUI(arg_13_0)
	local var_13_0 = arg_13_0._modelInst:getElementCo()
	local var_13_1 = var_13_0 and var_13_0.id
	local var_13_2 = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity3_0Enum.ActivityId.KaRong, var_13_1)

	if var_13_2 then
		if var_13_2.uiTemplate == 1 then
			arg_13_0._simageBG:LoadImage("singlebg/v3a0_karong_singlebg/v3a0_karong_puzzle_fullbg2.png")
			gohelper.setActive(arg_13_0.effectColour, true)
		else
			arg_13_0._simageBG:LoadImage("singlebg/v3a0_karong_singlebg/v3a0_karong_puzzle_fullbg1.png")
			gohelper.setActive(arg_13_0.effectGray, true)
		end

		arg_13_0._txtTarget.text = var_13_2.target
	end

	arg_13_0:_refreshSkillCnt()
end

function var_0_0._enableTriggerEffect(arg_14_0)
	arg_14_0._enableTrigger = true

	KaRongDrawController.instance:dispatchEvent(KaRongDrawEvent.EnableTriggerEffect)
end

function var_0_0._resetGame(arg_15_0)
	if not arg_15_0._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	arg_15_0:stat(KaRongDrawEnum.GameResult.Restart)
	arg_15_0:restartGame()
	arg_15_0:_refreshSkillCnt()
end

function var_0_0.getModelInst(arg_16_0)
	return KaRongDrawModel.instance
end

function var_0_0.getCtrlInst(arg_17_0)
	return KaRongDrawController.instance
end

function var_0_0.getDragGo(arg_18_0)
	return arg_18_0._goDrag
end

function var_0_0.getLineParentGo(arg_19_0)
	return arg_19_0._goLine
end

function var_0_0.getPawnParentGo(arg_20_0)
	return arg_20_0._goDynamic
end

function var_0_0.getObjectParentGo(arg_21_0, arg_21_1)
	if arg_21_1 == KaRongDrawEnum.MazeObjType.Block then
		return arg_21_0._goDynamic
	else
		return arg_21_0._goCheckPoint
	end
end

function var_0_0.getAlertParentGo(arg_22_0)
	return arg_22_0._goCheckPoint
end

function var_0_0.getMazeObjCls(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if not arg_23_0._mazeObjClsMap then
		arg_23_0._mazeObjClsMap = {
			[KaRongDrawEnum.MazeObjType.Start] = {
				[KaRongDrawEnum.MazeObjSubType.Default] = KaRongDrawNormalObj,
				[KaRongDrawEnum.MazeObjSubType.Two] = KaRongDrawNormalObj,
				[KaRongDrawEnum.MazeObjSubType.Three] = KaRongDrawNormalObj
			},
			[KaRongDrawEnum.MazeObjType.End] = {
				[KaRongDrawEnum.MazeObjSubType.Default] = KaRongDrawCheckObj,
				[KaRongDrawEnum.MazeObjSubType.Two] = KaRongDrawCheckObj,
				[KaRongDrawEnum.MazeObjSubType.Three] = KaRongDrawCheckObj
			},
			[KaRongDrawEnum.MazeObjType.CheckPoint] = {
				[KaRongDrawEnum.MazeObjSubType.Default] = KaRongDrawCheckObj
			},
			[KaRongDrawEnum.MazeObjType.Block] = {
				[KaRongDrawEnum.MazeObjSubType.Default] = KaRongDrawBlockObj
			}
		}
	end

	arg_23_2 = arg_23_2 or KaRongDrawEnum.MazeObjSubType.Default

	local var_23_0 = arg_23_0._mazeObjClsMap[arg_23_1]
	local var_23_1 = var_23_0 and var_23_0[arg_23_2]

	if not var_23_1 then
		logError(string.format("find mazeObjCls failed, objType = %s, subType = %s, group = %s", arg_23_1, arg_23_2, arg_23_3))
	end

	return var_23_1
end

function var_0_0.getPawnObjCls(arg_24_0)
	return KaRongDrawPawnObj
end

function var_0_0.getLineObjCls(arg_25_0, arg_25_1)
	if arg_25_1 == KaRongDrawEnum.LineType.Map then
		return KaRongDrawMapLine
	end

	return KaRongDrawLine
end

function var_0_0.getAlertObjCls(arg_26_0, arg_26_1)
	return KaRongDrawObjAlert
end

function var_0_0.getPawnResUrl(arg_27_0)
	return arg_27_0.viewContainer:getSetting().otherRes[3]
end

function var_0_0.getLineResUrl(arg_28_0)
	return arg_28_0.viewContainer:getSetting().otherRes[2]
end

function var_0_0.getObjectResUrl(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_1 == KaRongDrawEnum.MazeObjType.Block then
		return arg_29_0.viewContainer:getSetting().otherRes[4]
	else
		return arg_29_0.viewContainer:getSetting().otherRes[1]
	end
end

function var_0_0.getAlertResUrl(arg_30_0, arg_30_1)
	return arg_30_0.viewContainer:getSetting().otherRes[1]
end

function var_0_0.getLineTemplateFillOrigin(arg_31_0)
	return arg_31_0._imagelinetemplatel.fillOrigin, arg_31_0._imagelinetemplater.fillOrigin
end

function var_0_0.onVisitRepeatObj(arg_32_0, arg_32_1)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)
end

function var_0_0._initGameDone(arg_33_0)
	arg_33_0:destroy_EndDrag_NoneAlert_Flow()

	arg_33_0._endDrag_NoneAlert_Flow = FlowSequence.New()

	arg_33_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_33_0.tryTriggerEffect, arg_33_0, arg_33_0._endDrag_NoneAlert_Flow))
	arg_33_0._endDrag_NoneAlert_Flow:start()
end

function var_0_0.onEndDrag_NoneAlert(arg_34_0)
	arg_34_0:destroy_EndDrag_NoneAlert_Flow()

	arg_34_0._endDrag_NoneAlert_Flow = FlowSequence.New()

	arg_34_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_34_0.onEndDrag_SyncPawn, arg_34_0))
	arg_34_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_34_0.syncPath, arg_34_0))
	arg_34_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_34_0.cleanDragLine, arg_34_0))
	arg_34_0._endDrag_NoneAlert_Flow:addWork(FunctionWork.New(arg_34_0.tryTriggerEffect, arg_34_0, arg_34_0._endDrag_NoneAlert_Flow))
	arg_34_0._endDrag_NoneAlert_Flow:registerDoneListener(arg_34_0.checkGameFinished, arg_34_0)
	arg_34_0._endDrag_NoneAlert_Flow:start()
end

function var_0_0.destroy_EndDrag_NoneAlert_Flow(arg_35_0)
	if arg_35_0._endDrag_NoneAlert_Flow ~= nil then
		arg_35_0._endDrag_NoneAlert_Flow:destroy()

		arg_35_0._endDrag_NoneAlert_Flow = nil
	end
end

function var_0_0.tryTriggerEffect(arg_36_0, arg_36_1)
	local var_36_0 = {}
	local var_36_1, var_36_2 = arg_36_0._ctrlInst:getLastPos()
	local var_36_3 = KaRongDrawModel.instance:getObjAtPos(var_36_1, var_36_2)

	if KaRongDrawModel.instance:canTriggerEffect(var_36_1, var_36_2) then
		var_36_0[#var_36_0 + 1] = var_36_3.effects
		arg_36_0._triggerEffectPosX = var_36_1
		arg_36_0._triggerEffectPosY = var_36_2
	end

	local var_36_4 = arg_36_0._ctrlInst:getAvatarPos()

	if var_36_4 then
		local var_36_5 = KaRongDrawModel.instance:getObjAtPos(var_36_4.x, var_36_4.y)

		if KaRongDrawModel.instance:canTriggerEffect(var_36_4.x, var_36_4.y) then
			var_36_0[#var_36_0 + 1] = var_36_5.effects
			arg_36_0._triggerEffectPos = Vector2.New(var_36_4.x, var_36_4.y)
		end
	end

	if #var_36_0 == 0 then
		return
	end

	arg_36_0:setCanTouch(false)
	arg_36_0:buildTriggerEffectFlow(var_36_0, arg_36_1)
end

function var_0_0.buildTriggerEffectFlow(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_0._enableTrigger then
		arg_37_2:addWork(WaitEventWork.New(var_0_2))
	end

	local var_37_0 = FlowSequence.New()

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		for iter_37_2, iter_37_3 in ipairs(iter_37_1) do
			local var_37_1 = arg_37_0:getTriggerEffectWork(iter_37_3)

			if var_37_1 then
				var_37_0:addWork(var_37_1)
			end
		end
	end

	var_37_0:registerDoneListener(arg_37_0.onTriggerEffectDone, arg_37_0)
	arg_37_2:addWork(var_37_0)
end

function var_0_0.getTriggerEffectWork(arg_38_0, arg_38_1)
	if not arg_38_0._effectClsMap then
		arg_38_0._effectClsMap = {
			[KaRongDrawEnum.EffectType.Dialog] = KaRongDialogStep,
			[KaRongDrawEnum.EffectType.Story] = KaRongStoryStep,
			[KaRongDrawEnum.EffectType.Guide] = KaRongGuideStep,
			[KaRongDrawEnum.EffectType.PopView] = KaRongPopViewStep,
			[KaRongDrawEnum.EffectType.AddSkill] = FunctionWork
		}
	end

	local var_38_0 = arg_38_0._effectClsMap[arg_38_1.type]

	if var_38_0 then
		if arg_38_1.type == KaRongDrawEnum.EffectType.AddSkill then
			return var_38_0.New(KaRongDrawController.addSkillCnt, KaRongDrawController.instance)
		else
			return var_38_0.New(arg_38_1)
		end
	end
end

function var_0_0.onTriggerEffectDone(arg_39_0)
	if arg_39_0._triggerEffectPosX then
		KaRongDrawModel.instance:setTriggerEffectDone(arg_39_0._triggerEffectPosX, arg_39_0._triggerEffectPosY)

		arg_39_0._triggerEffectPosX = nil
		arg_39_0._triggerEffectPosY = nil
	end

	if arg_39_0._triggerEffectPos then
		KaRongDrawModel.instance:setTriggerEffectDone(arg_39_0._triggerEffectPos.x, arg_39_0._triggerEffectPos.y)

		arg_39_0._triggerEffectPos = nil
	end

	arg_39_0:setCanTouch(true)
	KaRongDrawController.instance:dispatchEvent(KaRongDrawEvent.OnTriggerEffectDone)
end

function var_0_0.onGameSucc(arg_40_0)
	var_0_0.super.onGameSucc(arg_40_0)
	AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_level_complete)
	gohelper.setActive(arg_40_0._gofinish, true)
	gohelper.setActive(arg_40_0._goTarget, false)
	KaRongDrawController.instance:restartGame()
	arg_40_0:stat(KaRongDrawEnum.GameResult.Success)
end

local var_0_3 = {
	[KaRongDrawEnum.GameResult.Success] = "成功",
	[KaRongDrawEnum.GameResult.Abort] = "中断",
	[KaRongDrawEnum.GameResult.Restart] = "重新开始"
}

function var_0_0.stat(arg_41_0, arg_41_1)
	local var_41_0 = ServerTime.now() - arg_41_0._startGameTime
	local var_41_1 = KaRongDrawModel.instance:getElementCo()
	local var_41_2 = var_41_1 and var_41_1.id
	local var_41_3 = Activity176Config.instance:getEpisodeCoByElementId(VersionActivity3_0Enum.ActivityId.KaRong, var_41_2)
	local var_41_4 = var_41_3 and var_41_3.id
	local var_41_5 = var_0_3 and var_0_3[arg_41_1]

	StatController.instance:track(StatEnum.EventName.Exit_Charon_activity, {
		[StatEnum.EventProperties.UseTime] = var_41_0,
		[StatEnum.EventProperties.MapId] = tostring(var_41_4),
		[StatEnum.EventProperties.Result] = var_41_5
	})
end

function var_0_0._refreshSkillCnt(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0._ctrlInst.skillCnt
	local var_42_1 = luaLang("karongdrawview_remaintimes")

	arg_42_0._txtTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_42_1, var_42_0)

	if arg_42_1 then
		if arg_42_0._btnSkill.gameObject.activeInHierarchy then
			arg_42_0.animBtnSkill:Play("get", 0, 0)
		else
			gohelper.setActive(arg_42_0._btnSkill, true)
			arg_42_0.animBtnSkill:Play("open", 0, 0)
		end
	else
		arg_42_0.animBtnSkill:Play("use", 0, 0)
	end
end

function var_0_0._onUsingSkill(arg_43_0, arg_43_1)
	gohelper.setActive(arg_43_0._goNoLight, not arg_43_1)
	gohelper.setActive(arg_43_0._goLight, arg_43_1)
	gohelper.setActive(arg_43_0._goTip, arg_43_1)
	gohelper.setActive(arg_43_0._goTarget, not arg_43_1)
	gohelper.setActive(arg_43_0._btnMask, arg_43_1)
	gohelper.setActive(arg_43_0._goDrag, not arg_43_1)
end

return var_0_0
