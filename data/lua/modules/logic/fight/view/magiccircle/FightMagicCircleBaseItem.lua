module("modules.logic.fight.view.magiccircle.FightMagicCircleBaseItem", package.seeall)

local var_0_0 = class("FightMagicCircleBaseItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.destroyed = nil
	arg_1_0._aniPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.go)
	arg_1_0._ani = arg_1_0.go:GetComponent(gohelper.Type_Animator)

	arg_1_0:initView()
end

function var_0_0.destroy(arg_2_0)
	arg_2_0.destroyed = true

	if arg_2_0._aniPlayer then
		arg_2_0._aniPlayer:Stop()
	end

	arg_2_0:hideGo()
	arg_2_0:__onDispose()
end

function var_0_0.getUIType(arg_3_0)
	return FightEnum.MagicCircleUIType.Normal
end

function var_0_0.hideGo(arg_4_0)
	gohelper.setActive(arg_4_0.go, false)
end

function var_0_0.showGo(arg_5_0)
	gohelper.setActive(arg_5_0.go, true)
end

function var_0_0.initView(arg_6_0)
	return
end

function var_0_0.onCreateMagic(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:showGo()
	arg_7_0:playAnim("open")
	arg_7_0:refreshUI(arg_7_1, arg_7_2)
end

function var_0_0.onUpdateMagic(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:refreshUI(arg_8_1, arg_8_2, arg_8_3)
end

function var_0_0.onRemoveMagic(arg_9_0)
	arg_9_0:destroy()
end

function var_0_0.playAnim(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0._ani.speed = FightModel.instance:getSpeed()

	arg_10_0._aniPlayer:Play(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0.refreshUI(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return
end

return var_0_0
