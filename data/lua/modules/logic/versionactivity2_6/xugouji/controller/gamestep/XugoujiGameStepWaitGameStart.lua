module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepWaitGameStart", package.seeall)

local var_0_0 = class("XugoujiGameStepWaitGameStart", XugoujiGameStepBase)
local var_0_1 = VersionActivity2_6Enum.ActivityId.Xugouji

function var_0_0.start(arg_1_0)
	XugoujiController.instance:registerCallback(XugoujiEvent.OpenGameViewFinish, arg_1_0.onOpenGameViewFinish, arg_1_0)
	Activity188Model.instance:setGameState(XugoujiEnum.GameStatus.UnOperatable)
end

function var_0_0.onOpenGameViewFinish(arg_2_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.OpenGameViewFinish, arg_2_0.onOpenGameViewFinish, arg_2_0)
	arg_2_0:_showGameTargetTips()
end

function var_0_0._showGameTargetTips(arg_3_0)
	local var_3_0 = 5
	local var_3_1 = 4
	local var_3_2 = tonumber(Activity188Config.instance:getConstCfg(var_0_1, var_3_0).value2)
	local var_3_3 = tonumber(Activity188Config.instance:getConstCfg(var_0_1, var_3_1).value2)

	if not Activity188Model.instance:isGameGuideMode() then
		TaskDispatcher.runDelay(arg_3_0._autoCloseTargetTips, arg_3_0, var_3_3)
		TaskDispatcher.runDelay(arg_3_0._showSkillTips, arg_3_0, var_3_2)
	elseif Activity188Model.instance:getCurEpisodeId() ~= XugoujiEnum.FirstEpisodeId then
		TaskDispatcher.runDelay(arg_3_0._autoCloseTargetTips, arg_3_0, var_3_3)
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoShowTargetTips)
	XugoujiController.instance:registerCallback(XugoujiEvent.HideTargetTips, arg_3_0._showTargetTipsDone, arg_3_0)
end

function var_0_0._autoCloseTargetTips(arg_4_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideTargetTips)
end

function var_0_0._showTargetTipsDone(arg_5_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideTargetTips, arg_5_0._showTargetTipsDone, arg_5_0)

	if arg_5_0._showingSkill then
		return
	else
		TaskDispatcher.cancelTask(arg_5_0._autoCloseTargetTips, arg_5_0)
		TaskDispatcher.cancelTask(arg_5_0._showSkillTips, arg_5_0)
		arg_5_0:_showSkillTips()
	end
end

function var_0_0._showSkillTips(arg_6_0)
	arg_6_0._showingSkill = true

	local var_6_0 = 6
	local var_6_1 = 7
	local var_6_2 = tonumber(Activity188Config.instance:getConstCfg(var_0_1, var_6_0).value2)
	local var_6_3 = tonumber(Activity188Config.instance:getConstCfg(var_0_1, var_6_1).value2)

	if not Activity188Model.instance:isGameGuideMode() then
		TaskDispatcher.runDelay(arg_6_0.finish, arg_6_0, var_6_3)
		TaskDispatcher.runDelay(arg_6_0._autoCloseSkillTips, arg_6_0, var_6_2)
	end

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoShowSkillTips)
	XugoujiController.instance:registerCallback(XugoujiEvent.HideSkillTips, arg_6_0._showSkillTipsDone, arg_6_0)
end

function var_0_0._autoCloseSkillTips(arg_7_0)
	arg_7_0.autoSkillTipsClosed = true

	XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideSkillTips)
end

function var_0_0._showSkillTipsDone(arg_8_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, arg_8_0._showSkillTipsDone, arg_8_0)

	if arg_8_0._finish then
		return
	else
		TaskDispatcher.cancelTask(arg_8_0.finish, arg_8_0)
		TaskDispatcher.cancelTask(arg_8_0._autoCloseSkillTips, arg_8_0)
		arg_8_0:finish()
	end
end

function var_0_0.finish(arg_9_0)
	arg_9_0._finish = true

	if not arg_9_0.autoSkillTipsClosed then
		XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, arg_9_0._showSkillTipsDone, arg_9_0)
		TaskDispatcher.cancelTask(arg_9_0._autoCloseSkillTips, arg_9_0)
		XugoujiController.instance:dispatchEvent(XugoujiEvent.AutoHideSkillTips)
	end

	XugoujiGameStepBase.finish(arg_9_0)
end

function var_0_0.dispose(arg_10_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.OpenGameViewFinish, arg_10_0.onOpenGameViewFinish, arg_10_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideSkillTips, arg_10_0._showSkillTipsDone, arg_10_0)
	XugoujiController.instance:unregisterCallback(XugoujiEvent.HideTargetTips, arg_10_0._showTargetTipsDone, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._autoCloseTargetTips, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._showSkillTips, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.finish, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._autoCloseSkillTips, arg_10_0)
	XugoujiGameStepBase.dispose(arg_10_0)
end

return var_0_0
