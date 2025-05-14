module("modules.logic.guide.controller.special.GuideSpecialRoomOpen", package.seeall)

local var_0_0 = class("GuideSpecialRoomOpen", BaseGuideAction)
local var_0_1 = 401
local var_0_2 = 17

function var_0_0.ctor(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._onGetInfoFinish, arg_1_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_1_0._onUpdateDungeonInfo, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.StartGuide, arg_1_0._onStartGuide, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_1_0._onFinishGuide, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._hasGetInfo = nil
end

function var_0_0._onGetInfoFinish(arg_3_0)
	arg_3_0._hasGetInfo = true
end

function var_0_0._onUpdateDungeonInfo(arg_4_0, arg_4_1)
	if arg_4_0._hasGetInfo then
		arg_4_0:_checkStart()
	end
end

function var_0_0._checkStart(arg_5_0)
	if not arg_5_0._hasGetInfo then
		return
	end

	if GuideController.instance:isForbidGuides() then
		return
	end

	local var_5_0 = GuideModel.instance:getDoingGuideId()

	if var_5_0 and var_5_0 ~= var_0_1 then
		return
	end

	if GuideModel.instance:isStepFinish(var_0_1, var_0_2) then
		return
	end

	if GuideConfig.instance:getTriggerType(var_0_1) == "EpisodeFinishAndInMainScene" then
		local var_5_1 = GuideConfig.instance:getTriggerParam(var_0_1)
		local var_5_2 = tonumber(var_5_1)
		local var_5_3 = OpenConfig.instance:getOpenCo(var_5_2)
		local var_5_4 = var_5_3 and var_5_3.episodeId or var_5_2
		local var_5_5 = DungeonModel.instance:getEpisodeInfo(var_5_4)
		local var_5_6 = DungeonConfig.instance:getEpisodeCO(var_5_4)

		if var_5_6 and var_5_5 and var_5_5.star > DungeonEnum.StarType.None and (var_5_6.afterStory <= 0 or var_5_6.afterStory > 0 and StoryModel.instance:isStoryFinished(var_5_6.afterStory)) then
			GuideModel.instance:setFlag(GuideModel.GuideFlag.DontOpenMain, true, var_0_1)
		end
	else
		logError("小屋401触发条件有修改")
	end
end

function var_0_0._onStartGuide(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	if arg_6_1 == var_0_1 then
		arg_6_0:_checkStart()
	else
		local var_6_0 = GuideConfig.instance:getGuideCO(arg_6_1)

		if var_6_0 and var_6_0.parallel ~= 1 then
			GuideModel.instance:setFlag(GuideModel.GuideFlag.DontOpenMain, nil)
		end
	end
end

function var_0_0._onFinishGuide(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	if arg_7_1 == var_0_1 then
		if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
			return
		end

		if ViewMgr.instance:isOpen(ViewName.MainView) then
			return
		end

		if ViewMgr.instance:hasOpenFullView() then
			return
		end

		ViewMgr.instance:openView(ViewName.MainView)
	else
		arg_7_0:_checkStart()
	end
end

function var_0_0._removeEvents(arg_8_0)
	LoginController.instance:unregisterCallback(LoginEvent.OnGetInfoFinish, arg_8_0._onGetInfoFinish, arg_8_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, arg_8_0._onUpdateDungeonInfo, arg_8_0)
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, arg_8_0._onStartGuide, arg_8_0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, arg_8_0._onFinishGuide, arg_8_0)
end

function var_0_0.clearWork(arg_9_0)
	arg_9_0:_removeEvents()
end

return var_0_0
