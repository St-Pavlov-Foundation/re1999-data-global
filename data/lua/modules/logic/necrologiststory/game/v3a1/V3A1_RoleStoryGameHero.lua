module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryGameHero", package.seeall)

local var_0_0 = class("V3A1_RoleStoryGameHero", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.moveDuration = 0.3
end

function var_0_0.setHeroPos(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0:clearMoveTween()

	arg_2_0.callback = arg_2_4
	arg_2_0.callbackObj = arg_2_5

	if arg_2_3 then
		arg_2_0:showBlock()

		arg_2_0.moveTweenId = ZProj.TweenHelper.DOAnchorPos(arg_2_0.transform, arg_2_1, arg_2_2, arg_2_0.moveDuration, arg_2_0.onTweenEnd, arg_2_0)
	else
		recthelper.setAnchor(arg_2_0.transform, arg_2_1, arg_2_2)
		arg_2_0:onTweenEnd()
	end
end

function var_0_0.clearMoveTween(arg_3_0)
	if arg_3_0.moveTweenId then
		ZProj.TweenHelper.KillById(arg_3_0.moveTweenId)

		arg_3_0.moveTweenId = nil
	end
end

function var_0_0.onTweenEnd(arg_4_0)
	arg_4_0:closeBlock()

	if arg_4_0.callback then
		arg_4_0.callback(arg_4_0.callbackObj)
	end
end

function var_0_0.showBlock(arg_5_0)
	GameUtil.setActiveUIBlock("V3A1_RoleStoryGameHero", true, false)
end

function var_0_0.closeBlock(arg_6_0)
	GameUtil.setActiveUIBlock("V3A1_RoleStoryGameHero", false, false)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0:closeBlock()
	arg_7_0:clearMoveTween()
end

return var_0_0
