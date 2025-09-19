module("modules.logic.guide.controller.GuideConfigChecker", package.seeall)

local var_0_0 = class("GuideConfigChecker")

function var_0_0.addConstEvents(arg_1_0)
	if isDebugBuild then
		GuideController.instance:registerCallback(GuideEvent.StartGuideStep, arg_1_0._onCheckForceGuideStep, arg_1_0)
		GuideController.instance:registerCallback(GuideEvent.FinishStep, arg_1_0._onFinishStep, arg_1_0)
	end
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._checkForceGuideId = nil
end

function var_0_0.reInit(arg_3_0)
	if isDebugBuild then
		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, arg_3_0._onFinishGuide, arg_3_0)
		GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, arg_3_0._onTouch, arg_3_0)
		GuideController.instance:registerCallback(GuideEvent.StartGuideStep, arg_3_0._onCheckForceGuideStep, arg_3_0)
	end

	arg_3_0._checkForceGuideId = nil
end

function var_0_0._onCheckForceGuideStep(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = GuideConfig.instance:getGuideCO(arg_4_1)

	if arg_4_1 >= 600 and var_4_0.parallel == 0 then
		arg_4_0._checkForceGuideId = arg_4_1

		GuideController.instance:unregisterCallback(GuideEvent.StartGuideStep, arg_4_0._onCheckForceGuideStep, arg_4_0)
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_4_0._onFinishGuide, arg_4_0)
		GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, arg_4_0._onTouch, arg_4_0)
	end
end

function var_0_0._onTouch(arg_5_0)
	if not arg_5_0._filterViews then
		arg_5_0._filterViews = {
			ViewName.GuideView,
			ViewName.FightGuideView,
			ViewName.StoryView
		}
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._filterViews) do
		if ViewMgr.instance:isOpen(iter_5_1) then
			arg_5_0._touchCount = 0

			break
		end
	end

	arg_5_0._touchCount = arg_5_0._touchCount and arg_5_0._touchCount + 1 or 1

	if arg_5_0._touchCount > 10 then
		if arg_5_0._checkForceGuideId then
			local var_5_0 = GuideConfig.instance:getGuideCO(arg_5_0._checkForceGuideId)

			logError("是否可以改成弱指引：" .. arg_5_0._checkForceGuideId .. " " .. var_5_0.desc)
		end

		arg_5_0._checkForceGuideId = nil

		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, arg_5_0._onFinishGuide, arg_5_0)
		GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, arg_5_0._onTouch, arg_5_0)
	end
end

function var_0_0._onFinishGuide(arg_6_0, arg_6_1)
	if arg_6_0._checkForceGuideId == arg_6_1 then
		GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, arg_6_0._onFinishGuide, arg_6_0)
	end
end

function var_0_0._onFinishStep(arg_7_0, arg_7_1, arg_7_2)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.DungeonView) then
		return
	end

	local var_7_0 = DungeonMainStoryModel.instance:getConflictGuides()

	if arg_7_1 ~= DungeonMainStoryEnum.Guide.PreviouslyOn and arg_7_1 ~= DungeonMainStoryEnum.Guide.EarlyAccess and not tabletool.indexOf(var_7_0, arg_7_1) then
		logError(string.format("严重log,必须处理!!!请往DungeonMainStoryModel.instance:getConflictGuides()添加该指引:%s,否则会跟28005指引冲突", arg_7_1))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
