module("modules.logic.fight.entity.comp.skill.FightTLEventChangeScene", package.seeall)

local var_0_0 = class("FightTLEventChangeScene", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not string.nilorempty(arg_1_3[1]) then
		GameSceneMgr.instance:getScene(SceneType.Fight).level:loadLevelNoEffect(tonumber(arg_1_3[1]))
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

return var_0_0
