module("modules.logic.scene.pushbox.comp.PushBoxSceneViewComp", package.seeall)

local var_0_0 = class("PushBoxSceneViewComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	ViewMgr.instance:openView(ViewName.VersionActivityPushBoxLevelView)
end

function var_0_0.onSceneClose(arg_2_0, arg_2_1, arg_2_2)
	ViewMgr.instance:closeView(ViewName.PushBoxView)
end

return var_0_0
