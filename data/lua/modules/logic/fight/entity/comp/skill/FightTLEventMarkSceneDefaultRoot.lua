module("modules.logic.fight.entity.comp.skill.FightTLEventMarkSceneDefaultRoot", package.seeall)

local var_0_0 = class("FightTLEventMarkSceneDefaultRoot", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.sceneId = GameSceneMgr.instance:getCurSceneId()
	var_0_0.levelId = GameSceneMgr.instance:getCurLevelId()
	var_0_0.rootName = arg_1_3[1]
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
