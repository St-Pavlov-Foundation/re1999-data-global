module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenViewInFirstWithCondition", package.seeall)

local var_0_0 = class("WaitGuideActionOpenViewInFirstWithCondition", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._viewName = ViewName[var_1_0[1]]

	local var_1_1 = var_1_0[2]

	arg_1_0._conditionParam = var_1_0[3]
	arg_1_0._delayTime = var_1_0[4] and tonumber(var_1_0[4]) or 0.2
	arg_1_0._conditionCheckFun = arg_1_0[var_1_1]

	if arg_1_0:checkDone() then
		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._checkOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, arg_1_0._checkOpenView, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._checkOpenView, arg_1_0)
end

function var_0_0.clearWork(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayDone, arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0._checkOpenView, arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.ReOpenWhileOpen, arg_2_0._checkOpenView, arg_2_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_2_0._checkOpenView, arg_2_0)
end

function var_0_0._checkOpenView(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == ViewName.CharacterView then
		var_0_0.heroMo = arg_3_2
	end

	arg_3_0:checkDone()
end

function var_0_0.checkDone(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)

	local var_4_0 = arg_4_0:_check()

	if var_4_0 then
		if arg_4_0._delayTime and arg_4_0._delayTime > 0 then
			TaskDispatcher.runDelay(arg_4_0._delayDone, arg_4_0, arg_4_0._delayTime)
		else
			arg_4_0:onDone(true)
		end
	end

	return var_4_0
end

function var_0_0._delayDone(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0._check(arg_6_0)
	local var_6_0 = ViewMgr.instance:getOpenViewNameList()

	if #var_6_0 > 0 then
		return arg_6_0:isFirstView(var_6_0, arg_6_0._viewName) and (arg_6_0._conditionCheckFun == nil or arg_6_0._conditionCheckFun(arg_6_0._conditionParam, arg_6_0))
	else
		return false
	end
end

function var_0_0.isFirstView(arg_7_0, arg_7_1, arg_7_2)
	if not var_0_0.excludeView then
		var_0_0.excludeView = {
			[ViewName.GMGuideStatusView] = 1,
			[ViewName.GMToolView2] = 1,
			[ViewName.GMToolView] = 1,
			[ViewName.ToastView] = 1
		}
	end

	local var_7_0 = false
	local var_7_1

	for iter_7_0 = #arg_7_1, 1, -1 do
		local var_7_2 = arg_7_1[iter_7_0]

		if not var_0_0.excludeView[var_7_2] then
			var_7_0 = var_7_2 == arg_7_2

			break
		end
	end

	if not var_7_0 then
		logNormal(string.format("<color=#FFA500>guide_%d_%d %s not is first view! %s</color>", arg_7_0.guideId, arg_7_0.stepId, arg_7_2, table.concat(arg_7_1, "#")))
	end

	return var_7_0
end

local var_0_1 = 8

function var_0_0.activity109ChessOpenNextStage()
	local var_8_0 = Activity109ChessModel.instance:getActId()
	local var_8_1 = var_8_0 and Activity109Config.instance:getEpisodeCo(var_8_0, var_0_1)

	if not var_8_1 then
		return false
	end

	local var_8_2 = ActivityModel.instance:getActivityInfo()

	if not var_8_2 then
		return false
	end

	local var_8_3 = var_8_2[var_8_0]

	if not var_8_3 then
		return false
	end

	if var_8_3:getRealStartTimeStamp() + (var_8_1.openDay - 1) * 24 * 60 * 60 > ServerTime.now() then
		return false
	end

	return true
end

function var_0_0.checkDestinyStone()
	local var_9_0 = var_0_0.heroMo

	if var_9_0 and var_9_0:isOwnHero() and var_9_0:isCanOpenDestinySystem() then
		return true
	end
end

function var_0_0.checkTowerLimitGuideTrigger()
	return GuideTriggerOpenViewCondition.checkTowerLimitOpen()
end

function var_0_0.NoOtherGuideExecute(arg_11_0, arg_11_1)
	if not DungeonModel.instance:chapterListIsNormalType() then
		return false
	end

	local var_11_0 = DungeonMainStoryModel.instance:getConflictGuides()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = GuideModel.instance:getById(iter_11_1)

		if var_11_1 and not var_11_1.isFinish and var_11_1.clientStepId ~= 0 then
			if SLFramework.FrameworkSettings.IsEditor then
				logWarn("有其它引导在跑 id:", tostring(iter_11_1), tostring(var_11_1.isFinish), tostring(var_11_1.clientStepId))
			end

			return false
		end
	end

	local var_11_2 = DungeonConfig.instance:getLastEarlyAccessChapterId()

	if arg_11_1.guideId == DungeonMainStoryEnum.Guide.PreviouslyOn then
		return not DungeonMainStoryModel.instance:showPreviewChapterFlag(var_11_2)
	end

	if arg_11_1.guideId == DungeonMainStoryEnum.Guide.EarlyAccess then
		return DungeonMainStoryModel.instance:showPreviewChapterFlag(var_11_2)
	end

	return false
end

return var_0_0
