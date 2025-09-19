module("modules.logic.guide.controller.GuideInvalidController", package.seeall)

local var_0_0 = class("GuideInvalidController", BaseController)
local var_0_1 = "EndFight"
local var_0_2 = "ActivityEnd"
local var_0_3 = "InvalidCondition"
local var_0_4 = "checkFinishGuide"
local var_0_5 = "checkFinishGuideAndValidAct"
local var_0_6 = "FinishElement"
local var_0_7 = "InvalidNotInWindows"

function var_0_0.addConstEvents(arg_1_0)
	PlayerController.instance:registerCallback(PlayerEvent.PlayerLevelUp, arg_1_0._checkFinishGuideInMainView, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.StartGuide, arg_1_0._onStartGuide, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_1_0._onFinishedGuide, arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._onEnterOneSceneFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, arg_1_0._respBeginFight, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnEndFightForGuide, arg_1_0._onEndFight, arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.CheckGuideOnEndActivity, arg_1_0._onActivityEnd, arg_1_0)
end

function var_0_0.isInvalid(arg_2_0, arg_2_1)
	local var_2_0 = GuideConfig.instance:getGuideCO(arg_2_1)

	if not var_2_0 or var_2_0.isOnline == 0 then
		return true
	end

	local var_2_1 = GuideConfig.instance:getInvalidList(arg_2_1)
	local var_2_2 = false

	if not var_2_1 then
		return var_2_2
	end

	local var_2_3 = GuideModel.instance:getById(arg_2_1)

	for iter_2_0, iter_2_1 in ipairs(var_2_1) do
		local var_2_4 = iter_2_1[1]
		local var_2_5 = iter_2_1[2]

		if var_2_4 == "PlayerLv" then
			var_2_2 = tonumber(var_2_5) <= PlayerModel.instance:getPlayinfo().level
		elseif var_2_4 == "EpisodeFinish" then
			local var_2_6 = tonumber(var_2_5)
			local var_2_7 = DungeonModel.instance:getEpisodeInfo(var_2_6)
			local var_2_8 = DungeonConfig.instance:getEpisodeCO(var_2_6)

			var_2_2 = var_2_7 and var_2_7.star > DungeonEnum.StarType.None

			if var_2_2 and var_2_8 then
				var_2_2 = var_2_8.afterStory <= 0 or var_2_8.afterStory > 0 and StoryModel.instance:isStoryFinished(var_2_8.afterStory)
			end
		elseif var_2_4 == "FinishTask" then
			local var_2_9 = tonumber(var_2_5)
			local var_2_10 = TaskModel.instance:getTaskById(var_2_9)

			var_2_2 = var_2_10 and var_2_10.finishCount > 0
		elseif var_2_4 == "EnterEpisode" then
			local var_2_11 = tonumber(var_2_5)
			local var_2_12 = FightModel.instance:getFightParam()
			local var_2_13 = var_2_12 and var_2_12.episodeId and var_2_11 and var_2_12.episodeId == var_2_11

			var_2_2 = GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and var_2_13
		elseif var_2_4 == "ExitEpisode" then
			var_2_2 = var_2_3 ~= nil and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight
		elseif var_2_4 == var_0_6 then
			local var_2_14 = tonumber(var_2_5)

			var_2_2 = DungeonMapModel.instance:elementIsFinished(var_2_14)
		elseif var_2_4 == var_0_1 then
			var_2_2 = var_2_3 ~= nil and arg_2_0._hasEndFight
		elseif var_2_4 == var_0_3 then
			var_2_2 = GuideInvalidCondition[var_2_5](arg_2_1, iter_2_1)
		elseif var_2_4 == var_0_2 then
			local var_2_15 = tonumber(var_2_5)

			if ActivityModel.instance:getActMO(var_2_15) then
				local var_2_16 = ActivityHelper.getActivityStatus(var_2_15)

				var_2_2 = var_2_3 ~= nil and var_2_16 == ActivityEnum.ActivityStatus.Expired
			end
		elseif var_2_4 == var_0_7 then
			var_2_2 = not BootNativeUtil.isWindows()
		else
			var_2_2 = false
		end

		if var_2_2 then
			break
		end
	end

	return var_2_2
end

function var_0_0._checkFinishGuideInMainView(arg_3_0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		arg_3_0:_checkFinishGuide()
	end
end

function var_0_0.hasInvalidGuide(arg_4_0)
	local var_4_0 = GuideConfig.instance:getGuideList()

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = iter_4_1.id
		local var_4_2 = GuideModel.instance:getById(var_4_1)

		if (var_4_2 == nil or not var_4_2.isFinish) and arg_4_0:isInvalid(var_4_1) then
			return true
		end
	end

	return false
end

function var_0_0.checkInvalid(arg_5_0)
	arg_5_0:_checkFinishGuide()
end

function var_0_0._checkFinishGuide(arg_6_0)
	local var_6_0 = GuideConfig.instance:getGuideList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = iter_6_1.id
		local var_6_2 = GuideModel.instance:getById(var_6_1)

		if (var_6_2 == nil or not var_6_2.isFinish) and arg_6_0:isInvalid(var_6_1) then
			GuideController.instance:oneKeyFinishGuide(var_6_1, true)
		end
	end
end

function var_0_0._onStartGuide(arg_7_0, arg_7_1)
	if not GuideModel.instance:isGMStartGuide(arg_7_1) then
		local var_7_0 = GuideModel.instance:getById(arg_7_1)

		if (var_7_0 == nil or not var_7_0.isFinish) and arg_7_0:isInvalid(arg_7_1) then
			GuideController.instance:oneKeyFinishGuide(arg_7_1, true)
		end
	end
end

function var_0_0._onFinishedGuide(arg_8_0, arg_8_1)
	local var_8_0 = GuideModel.instance:getList()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = var_8_0[iter_8_0]
		local var_8_2 = var_8_1.id
		local var_8_3 = var_8_1 == nil or not var_8_1.isFinish
		local var_8_4 = GuideConfig.instance:getInvalidList(var_8_2)

		if var_8_3 and var_8_4 then
			for iter_8_1, iter_8_2 in ipairs(var_8_4) do
				local var_8_5 = iter_8_2[1]
				local var_8_6 = iter_8_2[2]

				if var_8_5 == var_0_3 and (var_8_6 == var_0_4 or var_8_6 == var_0_5) and GuideInvalidCondition[var_8_6](var_8_2, iter_8_2) then
					GuideController.instance:oneKeyFinishGuide(var_8_2, true)
				end
			end
		end
	end
end

function var_0_0._onEnterOneSceneFinish(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == SceneType.Fight then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			return
		end

		arg_9_0:_checkFinishGuide()

		arg_9_0._hasEnterBattle = true
	else
		if arg_9_0._hasEnterBattle then
			arg_9_0:_checkFinishGuide()
		end

		arg_9_0._hasEnterBattle = nil
	end
end

function var_0_0._respBeginFight(arg_10_0)
	arg_10_0._hasEndFight = false
end

function var_0_0._onEndFight(arg_11_0)
	arg_11_0._hasEndFight = true

	local var_11_0 = GuideModel.instance:getList()

	for iter_11_0 = 1, #var_11_0 do
		local var_11_1 = var_11_0[iter_11_0].id
		local var_11_2 = GuideConfig.instance:getInvalidTypeList(var_11_1)

		if var_11_2 and tabletool.indexOf(var_11_2, var_0_1) then
			local var_11_3 = GuideModel.instance:getById(var_11_1)

			if (var_11_3 == nil or not var_11_3.isFinish) and arg_11_0:isInvalid(var_11_1) then
				GuideController.instance:oneKeyFinishGuide(var_11_1, true)
			end
		end
	end
end

function var_0_0._onActivityEnd(arg_12_0)
	local var_12_0 = GuideModel.instance:getList()

	for iter_12_0 = 1, #var_12_0 do
		local var_12_1 = var_12_0[iter_12_0].id
		local var_12_2 = GuideConfig.instance:getInvalidTypeList(var_12_1)

		if var_12_2 and tabletool.indexOf(var_12_2, var_0_2) then
			local var_12_3 = GuideModel.instance:getById(var_12_1)

			if (var_12_3 == nil or not var_12_3.isFinish) and arg_12_0:isInvalid(var_12_1) then
				GuideController.instance:oneKeyFinishGuide(var_12_1, true)
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
