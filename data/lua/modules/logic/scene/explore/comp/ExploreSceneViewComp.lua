module("modules.logic.scene.explore.comp.ExploreSceneViewComp", package.seeall)

local var_0_0 = class("ExploreSceneViewComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	ViewMgr.instance:openView(ViewName.ExploreView)

	local var_1_0 = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	arg_1_0._uiRoot = gohelper.create2d(var_1_0, "ExploreUnitUI")
end

function var_0_0.getRoot(arg_2_0)
	return arg_2_0._uiRoot
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0._uiRoot, arg_3_1)
end

function var_0_0.onSceneClose(arg_4_0, arg_4_1, arg_4_2)
	ViewMgr.instance:closeView(ViewName.ExploreView)
	gohelper.destroy(arg_4_0._uiRoot)

	arg_4_0._uiRoot = nil
end

return var_0_0
