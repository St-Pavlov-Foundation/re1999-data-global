module("modules.logic.scene.survival.comp.SurvivalSceneDirector", package.seeall)

local var_0_0 = class("SurvivalSceneDirector", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._compInitSequence = FlowSequence.New()

	local var_2_0 = FlowParallel.New()

	arg_2_0._compInitSequence:addWork(var_2_0)
	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.level, CommonSceneLevelComp.OnLevelLoaded))

	if arg_2_0._scene.fog then
		var_2_0:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.fog))
	end

	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.block, SurvivalEvent.OnSurvivalBlockLoadFinish))
	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.preloader, SurvivalEvent.OnSurvivalPreloadFinish))
	arg_2_0._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.graphics))
	arg_2_0._compInitSequence:registerDoneListener(arg_2_0._compInitDone, arg_2_0)
	arg_2_0._compInitSequence:start({
		sceneId = arg_2_1,
		levelId = arg_2_2
	})
end

function var_0_0._compInitDone(arg_3_0)
	arg_3_0._scene:onPrepared()
end

function var_0_0.onSceneClose(arg_4_0)
	return
end

function var_0_0._onLevelLoaded(arg_5_0, arg_5_1)
	return
end

return var_0_0
