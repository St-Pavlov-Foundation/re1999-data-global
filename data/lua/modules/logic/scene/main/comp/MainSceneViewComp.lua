module("modules.logic.scene.main.comp.MainSceneViewComp", package.seeall)

local var_0_0 = class("MainSceneViewComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	if DungeonController.instance:needShowDungeonView() then
		local var_1_0 = DungeonController.instance:showDungeonView()

		if var_1_0 then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, var_1_0)
		end
	elseif GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain) then
		-- block empty
	else
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.MainView)
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function var_0_0.onSceneClose(arg_2_0)
	ViewMgr.instance:closeView(ViewName.MainView)
end

return var_0_0
