module("modules.logic.fight.entity.comp.skill.FightTLEventCameraRotate", package.seeall)

local var_0_0 = class("FightTLEventCameraRotate", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = tonumber(arg_1_3[1]) or 0
	local var_1_1 = tonumber(arg_1_3[2]) or 0
	local var_1_2 = arg_1_3[3] == "1"

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		local var_1_3 = GameSceneMgr.instance:getCurScene().camera

		var_1_3:setEaseTime(var_1_2 and 0 or arg_1_2)
		var_1_3:setRotate(var_1_0, var_1_1)
	end
end

return var_0_0
