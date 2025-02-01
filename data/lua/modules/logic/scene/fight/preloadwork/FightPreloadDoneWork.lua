module("modules.logic.scene.fight.preloadwork.FightPreloadDoneWork", package.seeall)

slot0 = class("FightPreloadDoneWork", BaseWork)

function slot0.onStart(slot0, slot1)
	GameSceneMgr.instance:getScene(SceneType.Fight).preloader:dispatchEvent(FightSceneEvent.OnPreloadFinish)
	slot0:onDone(true)
end

return slot0
