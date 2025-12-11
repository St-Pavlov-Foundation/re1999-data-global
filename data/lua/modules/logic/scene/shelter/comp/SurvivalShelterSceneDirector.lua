module("modules.logic.scene.shelter.comp.SurvivalShelterSceneDirector", package.seeall)

local var_0_0 = class("SurvivalShelterSceneDirector", SurvivalSceneDirector)

function var_0_0.startEnterProgress(arg_1_0)
	arg_1_0.survivalOpenViewWork = SurvivalOpenViewWork.New({
		viewName = ViewName.SurvivalMainView
	})

	arg_1_0.survivalOpenViewWork:registerDoneListener(arg_1_0.onOpenView, arg_1_0)

	arg_1_0.viewPopupFlow = FlowParallel.New()

	arg_1_0.viewPopupFlow:addWork(arg_1_0.survivalOpenViewWork)

	if PopupController.instance:getPopupCount() > 0 then
		arg_1_0.viewPopupFlow:addWork(PopupViewFinishWork.New())
	end

	arg_1_0.viewPopupFlow:start()
	arg_1_0.viewPopupFlow:registerDoneListener(arg_1_0.onSceneViewPopupFinish, arg_1_0)
end

function var_0_0.onSceneViewPopupFinish(arg_2_0)
	SurvivalController.instance:onScenePopupFinish()
end

function var_0_0.disposeEnterProgress(arg_3_0)
	if arg_3_0.viewPopupFlow then
		arg_3_0.viewPopupFlow:destroy()

		arg_3_0.viewPopupFlow = nil
	end
end

return var_0_0
