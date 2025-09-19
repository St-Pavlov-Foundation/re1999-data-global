module("modules.logic.fight.system.work.FightWorkChangeFightScene", package.seeall)

local var_0_0 = class("FightWorkChangeFightScene", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.episodeId = arg_1_1
	arg_1_0.battleId = arg_1_2

	local var_1_0, var_1_1 = FightHelper.buildSceneAndLevel(arg_1_1, arg_1_2)

	if var_1_0 and var_1_1 then
		arg_1_0.sceneId = var_1_0[1]
		arg_1_0.levelId = var_1_1[1]
	end

	arg_1_0.SAFETIME = 30
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:_startLoadLevel()
end

function var_0_0._startLoadLevel(arg_3_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_3_0._onLevelLoaded, arg_3_0)
	GameSceneMgr.instance:getScene(SceneType.Fight).level:onSceneStart(arg_3_0.sceneId, arg_3_0.levelId)
end

function var_0_0._onLevelLoaded(arg_4_0)
	GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
	arg_4_0:onDone(true)
end

return var_0_0
