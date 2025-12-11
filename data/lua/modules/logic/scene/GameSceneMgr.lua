module("modules.logic.scene.GameSceneMgr", package.seeall)

local var_0_0 = class("GameSceneMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._curSceneType = nil
	arg_1_0._curSceneId = nil
	arg_1_0._preSceneType = nil
	arg_1_0._preSceneId = nil
	arg_1_0._preLevelId = nil
	arg_1_0._nextSceneType = nil
	arg_1_0._allScenes = {}
	arg_1_0._allRootGo = nil
	arg_1_0._isStarting = false
	arg_1_0._isClosing = false
	arg_1_0._startArgs = {}

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.init(arg_2_0)
	arg_2_0._allRootGo = CameraMgr.instance:getSceneRoot()

	local var_2_0 = SceneMacro

	arg_2_0:_addScenes()
end

function var_0_0._addScenes(arg_3_0)
	arg_3_0:_addSceneObj(SceneType.Main, MainScene)
	arg_3_0:_addSceneObj(SceneType.Fight, FightScene)
	arg_3_0:_addSceneObj(SceneType.Newbie, NewbieScene)
	arg_3_0:_addSceneObj(SceneType.Room, RoomScene)
	arg_3_0:_addSceneObj(SceneType.Explore, ExploreScene)
	arg_3_0:_addSceneObj(SceneType.PushBox, PushBoxScene)
	arg_3_0:_addSceneObj(SceneType.Cachot, CachotScene)
	arg_3_0:_addSceneObj(SceneType.Rouge, RougeScene)
	arg_3_0:_addSceneObj(SceneType.Survival, SurvivalScene)
	arg_3_0:_addSceneObj(SceneType.SurvivalShelter, SurvivalShelterScene)
	arg_3_0:_addSceneObj(SceneType.SurvivalSummaryAct, SurvivalSummaryAct)
end

function var_0_0._addSceneObj(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = gohelper.findChild(arg_4_0._allRootGo, arg_4_2.__cname) or gohelper.create3d(arg_4_0._allRootGo, arg_4_2.__cname)
	local var_4_1 = arg_4_2.New(var_4_0)

	var_4_1:setOnPreparedCb(arg_4_0.onScenePrepared, arg_4_0)
	var_4_1:setOnPreparedOneCb(arg_4_0.onScenePreparedOne, arg_4_0)

	arg_4_0._allScenes[arg_4_1] = var_4_1
end

function var_0_0.getScene(arg_5_0, arg_5_1)
	return arg_5_0._allScenes[arg_5_1]
end

function var_0_0.getCurSceneType(arg_6_0)
	return arg_6_0._curSceneType
end

function var_0_0.getCurSceneId(arg_7_0)
	return arg_7_0._curSceneId
end

function var_0_0.getCurLevelId(arg_8_0)
	local var_8_0 = arg_8_0:getCurScene()

	if var_8_0 then
		return var_8_0:getCurLevelId()
	end
end

function var_0_0.getPreSceneType(arg_9_0)
	return arg_9_0._preSceneType
end

function var_0_0.getPreSceneId(arg_10_0)
	return arg_10_0._preSceneId
end

function var_0_0.getPreLevelId(arg_11_0)
	return arg_11_0._preLevelId
end

function var_0_0.setPrevScene(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._preSceneType = arg_12_1
	arg_12_0._preSceneId = arg_12_2
	arg_12_0._preLevelId = arg_12_3
end

function var_0_0.getCurScene(arg_13_0)
	return arg_13_0._curSceneType and arg_13_0._allScenes[arg_13_0._curSceneType] or nil
end

function var_0_0.onScenePrepared(arg_14_0)
	arg_14_0._isStarting = false

	arg_14_0:hideLoading()
	arg_14_0:_runNextArgs()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 0.1, arg_14_0)
	var_0_0.instance:dispatchEvent(arg_14_0._curSceneType, arg_14_0._curSceneId, 1)
	var_0_0.instance:dispatchEvent(SceneEventName.EnterSceneFinish, arg_14_0._curSceneType, arg_14_0._curSceneId)
end

function var_0_0.onScenePreparedOne(arg_15_0)
	return
end

function var_0_0._runNextArgs(arg_16_0)
	if #arg_16_0._startArgs > 0 then
		local var_16_0 = arg_16_0._startArgs[1]

		table.remove(arg_16_0._startArgs, 1)
		arg_16_0:startScene(var_16_0[1], var_16_0[2], var_16_0[3])
	end
end

function var_0_0.startSceneDefaultLevel(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = SceneConfig.instance:getSceneLevelCOs(arg_17_2)

	if var_17_0 then
		arg_17_0:startScene(arg_17_1, arg_17_2, var_17_0[1].id, arg_17_3, arg_17_4)
	else
		logError("scene config not exist, sceneId = " .. arg_17_2)
	end
end

function var_0_0.startScene(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	if arg_18_0:useDefaultScene() and arg_18_1 == SceneType.Fight then
		arg_18_2 = 13101
		arg_18_3 = 13101
	end

	if not arg_18_4 and arg_18_0._isStarting then
		local var_18_0 = {
			arg_18_1,
			arg_18_2,
			arg_18_3
		}

		table.insert(arg_18_0._startArgs, var_18_0)

		return
	end

	if not arg_18_5 and arg_18_0._curSceneType == arg_18_1 and arg_18_0._curSceneId == arg_18_2 then
		arg_18_0:_runNextArgs()

		return
	end

	arg_18_0._nextSceneType = arg_18_1

	arg_18_0:showLoading(arg_18_1)
	arg_18_0:closeScene(arg_18_1, arg_18_2, arg_18_3)

	if arg_18_1 == SceneType.Main or arg_18_1 == SceneType.Room or arg_18_1 == SceneType.Explore or arg_18_1 == SceneType.SurvivalShelter or arg_18_1 == SceneType.SurvivalSummaryAct or arg_18_1 == SceneType.Survival or arg_18_1 == SceneType.Cachot then
		TaskDispatcher.runDelay(arg_18_0._onDelayStartScene, arg_18_0, 1.467)
	else
		arg_18_0._isStarting = true
		arg_18_0._curSceneType = arg_18_1
		arg_18_0._curSceneId = arg_18_2
		arg_18_0._curSceneLevel = arg_18_3

		TaskDispatcher.runDelay(arg_18_0._onOtherDelayStartScene, arg_18_0, 0.1)
	end
end

function var_0_0._onOtherDelayStartScene(arg_19_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, arg_19_0)
	arg_19_0:getCurScene():onStart(arg_19_0._curSceneId, arg_19_0._curSceneLevel)
	var_0_0.instance:dispatchEvent(SceneEventName.EnterScene, arg_19_0._curSceneType, arg_19_0._curSceneId)

	local var_19_0 = SceneType.NameDict[arg_19_0._curSceneType]

	logNormal(string.format("start scene: %s %d level_%d", var_19_0, arg_19_0._curSceneId, arg_19_0._curSceneLevel))
end

function var_0_0._onDelayStartScene(arg_20_0)
	arg_20_0._isStarting = true
	arg_20_0._curSceneType = arg_20_0._nextSceneType and arg_20_0._nextSceneType or arg_20_0._curSceneType
	arg_20_0._nextSceneType = nil
	arg_20_0._curSceneId = arg_20_0._nextSceneId and arg_20_0._nextSceneId or arg_20_0._curSceneId
	arg_20_0._nextSceneId = nil
	arg_20_0._curSceneLevel = arg_20_0._nextLevelId and arg_20_0._nextLevelId or arg_20_0._curSceneLevel
	arg_20_0._nextLevelId = nil

	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, arg_20_0)
	arg_20_0:getCurScene():onStart(arg_20_0._curSceneId, arg_20_0._curSceneLevel)
	var_0_0.instance:dispatchEvent(SceneEventName.EnterScene, arg_20_0._curSceneType, arg_20_0._curSceneId)

	local var_20_0 = SceneType.NameDict[arg_20_0._curSceneType]

	logNormal(string.format("start scene: %s %d level_%d", var_20_0, arg_20_0._curSceneId, arg_20_0._curSceneLevel))
end

function var_0_0.closeScene(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	TaskDispatcher.cancelTask(arg_21_0._onDelayStartScene, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._onOtherDelayStartScene, arg_21_0)

	arg_21_0._nextSceneType = arg_21_1
	arg_21_0._nextSceneId = arg_21_2
	arg_21_0._nextLevelId = arg_21_3

	if not arg_21_0._curSceneType or not arg_21_0._curSceneId then
		return
	end

	arg_21_0._isClosing = true
	arg_21_0._preSceneType = arg_21_0._curSceneType
	arg_21_0._preSceneId = arg_21_0._curSceneId
	arg_21_0._preLevelId = arg_21_0:getCurLevelId()

	if arg_21_4 then
		TaskDispatcher.cancelTask(arg_21_0._delayCloseScene, arg_21_0)
		arg_21_0:_delayCloseScene()
	elseif arg_21_0._nextSceneType == SceneType.Main or arg_21_0._nextSceneType == SceneType.Room or arg_21_0._nextSceneType == SceneType.Explore or arg_21_0._nextSceneType == SceneType.Cachot then
		TaskDispatcher.runDelay(arg_21_0._delayCloseScene, arg_21_0, 0.5)
	else
		TaskDispatcher.cancelTask(arg_21_0._delayCloseScene, arg_21_0)
		arg_21_0:_delayCloseScene()
	end
end

function var_0_0._delayCloseScene(arg_22_0)
	arg_22_0:getCurScene():onClose()
	var_0_0.instance:dispatchEvent(arg_22_0._curSceneType, arg_22_0._curSceneId, 0)
	var_0_0.instance:dispatchEvent(SceneEventName.ExitScene, arg_22_0._curSceneType, arg_22_0._curSceneId, arg_22_0._nextSceneType)

	local var_22_0 = SceneType.NameDict[arg_22_0._preSceneType]
	local var_22_1 = arg_22_0._preSceneId or -1
	local var_22_2 = arg_22_0._preLevelId or -1

	logNormal(string.format("close scene: %s %d level_%d", var_22_0, var_22_1, var_22_2))

	arg_22_0._curSceneType = nil
	arg_22_0._curSceneId = nil
	arg_22_0._isStarting = false
	arg_22_0._isClosing = false
end

function var_0_0.showLoading(arg_23_0, arg_23_1)
	if not arg_23_0._allScenes[arg_23_1] then
		return
	end

	var_0_0.instance:dispatchEvent(SceneEventName.OpenLoading, arg_23_1)
end

function var_0_0.hideLoading(arg_24_0)
	var_0_0.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function var_0_0.isLoading(arg_25_0)
	return arg_25_0._isStarting
end

function var_0_0.isClosing(arg_26_0)
	return arg_26_0._isClosing
end

function var_0_0.isSpScene(arg_27_0)
	local var_27_0 = arg_27_0:getCurScene()
	local var_27_1 = var_27_0 and var_27_0.level and var_27_0.level._sceneId

	if var_27_1 and var_27_1 == 11501 then
		return true
	end
end

function var_0_0.isFightScene(arg_28_0)
	return arg_28_0:getCurSceneType() == SceneType.Fight
end

function var_0_0.isPushBoxScene(arg_29_0)
	return arg_29_0:getCurSceneType() == SceneType.PushBox
end

function var_0_0.getNextSceneType(arg_30_0)
	return arg_30_0._nextSceneType
end

function var_0_0.useDefaultScene(arg_31_0)
	return VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS()
end

var_0_0.instance = var_0_0.New()

return var_0_0
