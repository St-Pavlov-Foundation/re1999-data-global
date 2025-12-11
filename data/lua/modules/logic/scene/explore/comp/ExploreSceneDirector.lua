module("modules.logic.scene.explore.comp.ExploreSceneDirector", package.seeall)

local var_0_0 = class("ExploreSceneDirector", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._compInitSequence = FlowSequence.New()

	local var_2_0 = FlowParallel.New()

	arg_2_0._compInitSequence:addWork(var_2_0)
	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.map, ExploreEvent.InitMapDone))
	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.level, CommonSceneLevelComp.OnLevelLoaded))
	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.preloader, ExploreEvent.OnExplorePreloadFinish))
	arg_2_0._compInitSequence:registerDoneListener(arg_2_0._compInitDone, arg_2_0)
	arg_2_0._compInitSequence:start({
		sceneId = arg_2_1,
		levelId = arg_2_2
	})
end

function var_0_0._compInitDone(arg_3_0)
	arg_3_0._scene:onPrepared()

	arg_3_0._compInitSequence = nil
end

function var_0_0.onSceneClose(arg_4_0)
	if arg_4_0._compInitSequence then
		arg_4_0._compInitSequence:destroy()

		arg_4_0._compInitSequence = nil
	end
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	return
end

return var_0_0
