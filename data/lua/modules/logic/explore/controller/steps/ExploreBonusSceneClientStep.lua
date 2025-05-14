module("modules.logic.explore.controller.steps.ExploreBonusSceneClientStep", package.seeall)

local var_0_0 = class("ExploreBonusSceneClientStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0._onCloseViewFinish, arg_1_0)

	local var_1_0 = ExploreModel.instance:getMapId()
	local var_1_1 = ExploreConfig.instance:getMapIdConfig(var_1_0)

	ViewMgr.instance:openView(ViewName.ExploreBonusSceneRecordView, {
		chapterId = var_1_1.chapterId
	})
end

function var_0_0._onCloseViewFinish(arg_2_0, arg_2_1)
	if ViewName.ExploreBonusSceneRecordView == arg_2_1 then
		arg_2_0:onDone()
	end
end

function var_0_0.onDestory(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
	var_0_0.super.onDestory(arg_3_0)
end

return var_0_0
