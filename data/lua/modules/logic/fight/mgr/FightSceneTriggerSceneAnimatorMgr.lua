module("modules.logic.fight.mgr.FightSceneTriggerSceneAnimatorMgr", package.seeall)

local var_0_0 = class("FightSceneTriggerSceneAnimatorMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0:com_registEvent(GameSceneMgr.instance, SceneEventName.OnLevelLoaded, arg_1_0._onLevelLoaded)
end

function var_0_0._onLevelLoaded(arg_2_0)
	if arg_2_0.sceneItemClass then
		arg_2_0.sceneItemClass:disposeSelf()

		arg_2_0.sceneItemClass = nil
	end

	arg_2_0.sceneItemClass = arg_2_0:newClass(FightSceneTriggerSceneAnimatorItem)
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
