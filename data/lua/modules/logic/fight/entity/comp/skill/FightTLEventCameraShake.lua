module("modules.logic.fight.entity.comp.skill.FightTLEventCameraShake", package.seeall)

local var_0_0 = class("FightTLEventCameraShake", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = tonumber(arg_1_3[1]) or 0
	local var_1_1 = tonumber(arg_1_3[2]) or 0
	local var_1_2 = tonumber(arg_1_3[3]) or 0

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		GameSceneMgr.instance:getCurScene().camera:shake(arg_1_2, var_1_0, var_1_2, var_1_1)
	end
end

return var_0_0
