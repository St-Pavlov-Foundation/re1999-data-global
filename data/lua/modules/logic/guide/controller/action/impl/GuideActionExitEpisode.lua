module("modules.logic.guide.controller.action.impl.GuideActionExitEpisode", package.seeall)

slot0 = class("GuideActionExitEpisode", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightSystem.instance:dispose()
		FightController.instance:exitFightScene()
	else
		logError("not in episode, guide_" .. slot0.guideId .. "_" .. slot0.stepId)
		slot0:onDone(true)
	end
end

return slot0
