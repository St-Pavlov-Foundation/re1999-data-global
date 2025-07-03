module("modules.logic.fight.entity.comp.skill.FightTLEventPlaySceneAnimator", package.seeall)

local var_0_0 = class("FightTLEventPlaySceneAnimator", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_3[1]
	local var_1_1 = arg_1_3[2]
	local var_1_2 = GameSceneMgr.instance:getCurScene()

	if var_1_2 then
		local var_1_3 = var_1_2.level:getSceneGo()
		local var_1_4 = gohelper.findChildComponent(var_1_3, var_1_0, typeof(UnityEngine.Animator))

		if var_1_4 then
			var_1_4.speed = FightModel.instance:getSpeed()

			if arg_1_3[3] == "1" then
				SLFramework.AnimatorPlayer.Get(var_1_4.gameObject):Play(var_1_1, nil, nil)
			else
				var_1_4:Play(var_1_1, 0, 0)
			end
		end
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

return var_0_0
