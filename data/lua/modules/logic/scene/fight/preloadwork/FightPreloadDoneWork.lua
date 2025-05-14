module("modules.logic.scene.fight.preloadwork.FightPreloadDoneWork", package.seeall)

local var_0_0 = class("FightPreloadDoneWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	GameSceneMgr.instance:getScene(SceneType.Fight).preloader:dispatchEvent(FightSceneEvent.OnPreloadFinish)
	arg_1_0:onDone(true)
end

return var_0_0
