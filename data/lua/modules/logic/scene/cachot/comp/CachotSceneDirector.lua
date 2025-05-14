module("modules.logic.scene.cachot.comp.CachotSceneDirector", package.seeall)

local var_0_0 = class("CachotSceneDirector", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
end

function var_0_0.onSceneStart(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._compInitSequence = FlowSequence.New()

	arg_2_0._compInitSequence:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.preloader, V1a6_CachotEvent.ScenePreloaded))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.player))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.event))
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
		arg_4_0._compInitSequence:onDestroy()

		arg_4_0._compInitSequence = nil
	end
end

return var_0_0
