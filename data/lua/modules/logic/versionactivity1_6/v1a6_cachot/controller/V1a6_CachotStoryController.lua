module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotStoryController", package.seeall)

local var_0_0 = class("V1a6_CachotStoryController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_3_0.checkPlayStory, arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.CheckPlayStory, arg_3_0.onSwitchLevel, arg_3_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnFinishGame, arg_3_0.onFinishGame, arg_3_0)
end

function var_0_0.checkPlayStory(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == ViewName.V1a6_CachotMainView then
		local var_4_0 = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode1).value
		local var_4_1 = {}

		var_4_1.mark = true
		var_4_1.isReplay = false

		if var_4_0 and var_4_0 ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(var_4_0)) then
			StoryController.instance:playStory(tonumber(var_4_0), var_4_1, nil, arg_4_0)
		end
	end
end

function var_0_0.onSwitchLevel(arg_5_0, arg_5_1)
	local var_5_0
	local var_5_1 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_5_1 then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Cachot then
		return
	end

	if var_5_1.layer == 1 and V1a6_CachotRoomConfig.instance:checkNextRoomIsLastRoom(var_5_1.room) then
		var_5_0 = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode2).value
	elseif var_5_1.layer == 2 and V1a6_CachotRoomConfig.instance:checkNextRoomIsLastRoom(var_5_1.room) then
		var_5_0 = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode4).value
	end

	if var_5_0 and var_5_0 ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(var_5_0)) then
		local var_5_2 = {}

		var_5_2.mark = true
		var_5_2.isReplay = false

		StoryController.instance:playStory(tonumber(var_5_0), var_5_2, nil, arg_5_0)
	end
end

function var_0_0.onFinishGame(arg_6_0, arg_6_1)
	local var_6_0 = lua_rogue_ending.configDict[arg_6_1]
	local var_6_1 = var_6_0 and var_6_0.storyId

	if var_6_1 and var_6_1 ~= 0 then
		StoryController.instance:playStory(var_6_1, nil, arg_6_0._jump2CachotEndingView, arg_6_0)
	else
		logError(string.format("cannot find endingConfig or storyConfig, endingId = %s, storyId = %s", arg_6_1, var_6_1))
		arg_6_0:_jump2CachotEndingView()
	end
end

function var_0_0._jump2CachotEndingView(arg_7_0)
	V1a6_CachotController.instance:openV1a6_CachotEndingView()
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
