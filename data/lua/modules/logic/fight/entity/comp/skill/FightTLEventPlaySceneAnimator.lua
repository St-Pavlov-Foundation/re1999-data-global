module("modules.logic.fight.entity.comp.skill.FightTLEventPlaySceneAnimator", package.seeall)

local var_0_0 = class("FightTLEventPlaySceneAnimator", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0
	local var_1_1 = GameSceneMgr.instance:getCurScene()

	if var_1_1 then
		local var_1_2 = var_1_1.level:getSceneGo()

		var_1_0 = var_1_2 and gohelper.findChild(var_1_2, arg_1_3[1])
	end

	if not var_1_0 then
		return
	end

	arg_1_0.playObj = var_1_0
	arg_1_0.paramsArr = arg_1_3

	local var_1_3 = arg_1_3[4]

	if not string.nilorempty(var_1_3) then
		local var_1_4 = arg_1_0:com_registWork(FightWorkLoadAnimator, var_1_3, var_1_0)

		var_1_4:registFinishCallback(arg_1_0.playAnimator, arg_1_0)
		var_1_4:start()
	else
		arg_1_0:playAnimator()
	end
end

function var_0_0.playAnimator(arg_2_0)
	local var_2_0 = arg_2_0.paramsArr[2]
	local var_2_1 = gohelper.onceAddComponent(arg_2_0.playObj, typeof(UnityEngine.Animator))

	if var_2_1 then
		var_2_1.speed = FightModel.instance:getSpeed()

		if arg_2_0.paramsArr[3] == "1" then
			SLFramework.AnimatorPlayer.Get(var_2_1.gameObject):Play(var_2_0, nil, nil)
		else
			var_2_1:Play(var_2_0, 0, 0)
		end
	end
end

function var_0_0.onTrackEnd(arg_3_0)
	return
end

return var_0_0
