module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateNoticeView", package.seeall)

local var_0_0 = class("EliminateNoticeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goOccupy = gohelper.findChild(arg_1_0.viewGO, "#go_Occupy")
	arg_1_0._simageMaskBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Occupy/#simage_MaskBG")
	arg_1_0._simageOccupy = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Occupy/#simage_Occupy")
	arg_1_0._goStart = gohelper.findChild(arg_1_0.viewGO, "#go_Start")
	arg_1_0._simageStart = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Start/#simage_Start")
	arg_1_0._txtStart = gohelper.findChildText(arg_1_0.viewGO, "#go_Start/#txt_Start")
	arg_1_0._goFinish = gohelper.findChild(arg_1_0.viewGO, "#go_Finish")
	arg_1_0._simageFinish = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Finish/#simage_Finish")
	arg_1_0._goAssess1 = gohelper.findChild(arg_1_0.viewGO, "#go_Assess1")
	arg_1_0._goAssess2 = gohelper.findChild(arg_1_0.viewGO, "#go_Assess2")
	arg_1_0._goAssess3 = gohelper.findChild(arg_1_0.viewGO, "#go_Assess3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam

	arg_5_0._isFinish = var_5_0.isFinish or false
	arg_5_0._isStart = var_5_0.isStart or false
	arg_5_0._isTeamChess = var_5_0.isTeamChess or false
	arg_5_0._closeCallback = var_5_0.closeCallback
	arg_5_0._time = var_5_0.closeTime or 1
	arg_5_0._closeCallbackTarget = var_5_0.closeCallbackTarget
	arg_5_0._isShowEvaluate = var_5_0.isShowEvaluate or false
	arg_5_0._evaluateLevel = var_5_0.evaluateLevel or 1

	if arg_5_0._isFinish then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_succeed)
	end

	if arg_5_0._isStart then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_clearing)
	end

	if arg_5_0._isTeamChess then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_leimi_season_clearing)
	end

	if arg_5_0._isShowEvaluate then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess["play_ui_youyu_appraise_text_" .. arg_5_0._evaluateLevel])
	end

	gohelper.setActive(arg_5_0._goFinish, arg_5_0._isFinish)
	gohelper.setActive(arg_5_0._goStart, arg_5_0._isStart)
	gohelper.setActive(arg_5_0._goOccupy, arg_5_0._isTeamChess)
	gohelper.setActive(arg_5_0._goAssess1, arg_5_0._isShowEvaluate and arg_5_0._evaluateLevel == 3)
	gohelper.setActive(arg_5_0._goAssess2, arg_5_0._isShowEvaluate and arg_5_0._evaluateLevel == 2)
	gohelper.setActive(arg_5_0._goAssess3, arg_5_0._isShowEvaluate and arg_5_0._evaluateLevel == 1)

	if arg_5_0._time then
		TaskDispatcher.runDelay(arg_5_0.close, arg_5_0, arg_5_0._time)
	end
end

function var_0_0.close(arg_6_0)
	ViewMgr.instance:closeView(ViewName.EliminateNoticeView)

	if arg_6_0._closeCallbackTarget and arg_6_0._closeCallback then
		arg_6_0._closeCallback(arg_6_0._closeCallbackTarget)
	end
end

function var_0_0.onClose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.close, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
