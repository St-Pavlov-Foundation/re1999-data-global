module("modules.logic.story.controller.StoryGCController", package.seeall)

local var_0_0 = class("StoryGCController", BaseController)
local var_0_1 = 3
local var_0_2 = 10
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3
local var_0_6 = 4
local var_0_7 = 5

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_3_0._onStart, arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_3_0._onFinish, arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, arg_3_0._onStep, arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.OnBgmStop, arg_3_0._onTriggerBgmStop, arg_3_0)
	StoryController.instance:registerCallback(StoryEvent.VideoStart, arg_3_0._onVideoStart, arg_3_0)
end

function var_0_0._onStart(arg_4_0, arg_4_1)
	arg_4_0._storyId = arg_4_1
	arg_4_0._markUseDict = {}
	arg_4_0._markUseList = {}
	arg_4_0._usingList = {}
	arg_4_0._currBg = nil
	arg_4_0._videoStepCountDown = nil
	arg_4_0._stepCount = 0

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and FightModel.instance:isFinish() then
		logNormal("战斗内播放战后剧情，清理战斗资源")
		FightFloatMgr.instance:dispose()
		ViewMgr.instance:closeView(ViewName.FightSkillSelectView, true)
		GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:removeAllUnits()
		FightPreloadController.instance:dispose()
		FightRoundPreloadController.instance:dispose()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, arg_4_0)
	end
end

function var_0_0._onFinish(arg_5_0, arg_5_1)
	arg_5_0._storyId = nil
	arg_5_0._markUseDict = {}
	arg_5_0._markUseList = {}
	arg_5_0._usingList = {}
	arg_5_0._currBg = nil

	GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, arg_5_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayAudioGC, arg_5_0)
end

function var_0_0._onStep(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.stepType
	local var_6_1 = arg_6_1.stepId

	arg_6_0._stepId = var_6_1

	local var_6_2 = arg_6_1.branches

	arg_6_0._usingList = {}

	local var_6_3 = var_6_1 and StoryStepModel.instance:getStepListById(var_6_1)
	local var_6_4 = var_6_3 and var_6_3.bg

	if var_6_4 and var_6_4.transType ~= StoryEnum.BgTransType.Keep then
		if not arg_6_0._markUseDict[var_6_4.bgImg] then
			arg_6_0._markUseDict[var_6_4.bgImg] = true

			local var_6_5 = {
				type = var_0_3,
				path = var_6_4.bgImg
			}

			table.insert(arg_6_0._markUseList, var_6_5)
			table.insert(arg_6_0._usingList, var_6_5)

			arg_6_0._currBg = var_6_4.bgImg
		elseif arg_6_0._currBg then
			table.insert(arg_6_0._usingList, {
				type = var_0_3,
				path = arg_6_0._currBg
			})
		end
	elseif arg_6_0._currBg then
		table.insert(arg_6_0._usingList, {
			type = var_0_3,
			path = arg_6_0._currBg
		})
	end

	local var_6_6 = var_6_3 and var_6_3.heroList

	for iter_6_0, iter_6_1 in ipairs(var_6_6) do
		local var_6_7 = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(iter_6_1.heroIndex)
		local var_6_8 = var_6_7.type == 0
		local var_6_9 = var_6_8 and var_6_7.prefab or var_6_7.live2dPrefab

		if not arg_6_0._markUseDict[var_6_9] then
			arg_6_0._markUseDict[var_6_9] = true

			local var_6_10 = {
				type = var_6_8 and var_0_4 or var_0_5,
				path = var_6_9
			}

			table.insert(arg_6_0._markUseList, var_6_10)
			table.insert(arg_6_0._usingList, var_6_10)
		end
	end

	local var_6_11 = var_6_3 and var_6_3.effList

	for iter_6_2, iter_6_3 in ipairs(var_6_11) do
		if not arg_6_0._markUseDict[iter_6_3.effect] then
			arg_6_0._markUseDict[iter_6_3.effect] = true

			local var_6_12 = {
				type = var_0_7,
				path = iter_6_3.effect
			}

			table.insert(arg_6_0._markUseList, var_6_12)
			table.insert(arg_6_0._usingList, var_6_12)
		end
	end

	local var_6_13 = var_6_3 and var_6_3.videoList
	local var_6_14 = 5
	local var_6_15 = #var_6_13 > 0
	local var_6_16 = false

	if var_6_15 then
		arg_6_0._videoStepCountDown = var_6_14
	elseif arg_6_0._videoStepCountDown then
		arg_6_0._videoStepCountDown = arg_6_0._videoStepCountDown - 1

		if arg_6_0._videoStepCountDown <= 0 then
			arg_6_0._videoStepCountDown = nil
			var_6_16 = true
		end
	end

	arg_6_0:_checkGC(var_6_16)
end

function var_0_0._onVideoStart(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:_checkGC(true)
end

function var_0_0._checkGC(arg_8_0, arg_8_1)
	if #arg_8_0._markUseList - #arg_8_0._usingList >= var_0_1 or arg_8_1 then
		arg_8_0._markUseList = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_0._usingList) do
			if iter_8_1.path then
				arg_8_0._markUseDict[iter_8_1.path] = true

				table.insert(arg_8_0._markUseList, iter_8_1)
			end
		end

		GameGCMgr.instance:dispatchEvent(GameGCEvent.StoryGC, arg_8_0)
	end

	arg_8_0._stepCount = arg_8_0._stepCount + 1

	if arg_8_0._stepCount % var_0_2 == 0 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, arg_8_0)
	end
end

function var_0_0._onTriggerBgmStop(arg_9_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayAudioGC, 0.5, arg_9_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
