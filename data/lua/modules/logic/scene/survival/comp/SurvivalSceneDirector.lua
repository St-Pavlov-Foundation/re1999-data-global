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
		var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.fog, SurvivalEvent.OnSurvivalFogLoaded))
	end

	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.block, SurvivalEvent.OnSurvivalBlockLoadFinish))

	if arg_2_0._scene.spBlock then
		var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.spBlock, SurvivalEvent.OnSurvivalBlockLoadFinish))
	end

	var_2_0:addWork(RoomSceneWaitEventCompWork.New(arg_2_0._scene.preloader, SurvivalEvent.OnSurvivalPreloadFinish))

	if arg_2_0._scene.cloud then
		arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.cloud))
	end

	arg_2_0._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	arg_2_0._compInitSequence:addWork(RoomSceneCommonCompWork.New(arg_2_0._scene.graphics))
	arg_2_0._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	arg_2_0._compInitSequence:registerDoneListener(arg_2_0._compInitDone, arg_2_0)
	arg_2_0._compInitSequence:start({
		sceneId = arg_2_1,
		levelId = arg_2_2
	})
end

function var_0_0._compInitDone(arg_3_0)
	arg_3_0._scene:onPrepared()

	arg_3_0._compInitSequence = nil

	arg_3_0:startEnterProgress()
end

function var_0_0.startEnterProgress(arg_4_0)
	local var_4_0 = SurvivalOpenViewWork.New({
		viewName = ViewName.SurvivalMapMainView
	})

	var_4_0:registerDoneListener(arg_4_0.onOpenView, arg_4_0)

	local var_4_1 = FlowParallel.New()

	var_4_1:addWork(var_4_0)

	arg_4_0.flow = FlowSequence.New()

	arg_4_0.flow:addWork(TimerWork.New(0.1))
	arg_4_0.flow:addWork(var_4_1)
	arg_4_0.flow:start()
end

function var_0_0.onOpenView(arg_5_0)
	arg_5_0:onSurvivalMainViewOpen()
end

function var_0_0.onSurvivalMainViewOpen(arg_6_0)
	ViewMgr.instance:closeView(ViewName.SurvivalLoadingView)
end

function var_0_0.onSceneClose(arg_7_0)
	if arg_7_0._compInitSequence then
		arg_7_0._compInitSequence:destroy()

		arg_7_0._compInitSequence = nil
	end

	arg_7_0:disposeEnterProgress()
end

function var_0_0.disposeEnterProgress(arg_8_0)
	if arg_8_0.flow then
		arg_8_0.flow:destroy()

		arg_8_0.flow = nil
	end
end

return var_0_0
