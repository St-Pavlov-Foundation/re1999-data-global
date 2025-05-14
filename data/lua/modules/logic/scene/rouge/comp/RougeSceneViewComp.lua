module("modules.logic.scene.rouge.comp.RougeSceneViewComp", package.seeall)

local var_0_0 = class("RougeSceneViewComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	if not ViewMgr.instance:isOpen(ViewName.RougeMapView) then
		ViewMgr.instance:openView(ViewName.RougeMapView)
	end

	ViewMgr.instance:openView(ViewName.RougeMapTipView)
end

function var_0_0.onSceneClose(arg_2_0, arg_2_1, arg_2_2)
	ViewMgr.instance:closeAllPopupViews()
	ViewMgr.instance:closeView(ViewName.RougeMapTipView)
end

return var_0_0
