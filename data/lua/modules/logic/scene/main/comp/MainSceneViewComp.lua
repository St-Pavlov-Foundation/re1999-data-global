module("modules.logic.scene.main.comp.MainSceneViewComp", package.seeall)

slot0 = class("MainSceneViewComp", BaseSceneComp)

function slot0.onScenePrepared(slot0, slot1, slot2)
	if DungeonController.instance:needShowDungeonView() then
		if DungeonController.instance:showDungeonView() then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, slot3)
		end
	elseif not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain) then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.MainView)
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function slot0.onSceneClose(slot0)
	ViewMgr.instance:closeView(ViewName.MainView)
end

return slot0
