module("modules.logic.chessgame.game.effect.ChessHeroEffect", package.seeall)

local var_0_0 = class("ChessHeroEffect", ChessEffectBase)

function var_0_0.refreshEffect(arg_1_0)
	return
end

function var_0_0.onDispose(arg_2_0)
	return
end

function var_0_0.onSelected(arg_3_0)
	arg_3_0._isSelected = true

	arg_3_0:refreshPlayerSelected()
end

function var_0_0.onCancelSelect(arg_4_0)
	arg_4_0._isSelected = false

	arg_4_0:refreshPlayerSelected()
end

function var_0_0.refreshPlayerSelected(arg_5_0)
	if ChessGameController.instance:isTempSelectObj(arg_5_0._target.id) then
		return
	end

	local var_5_0 = not arg_5_0._isSelected

	gohelper.setActive(arg_5_0._target.avatar.goSelectable, var_5_0)
end

function var_0_0.onAvatarLoaded(arg_6_0)
	local var_6_0 = arg_6_0._loader

	if not arg_6_0._loader then
		return
	end

	local var_6_1 = var_6_0:getInstGO()

	if not gohelper.isNil(var_6_1) then
		local var_6_2 = gohelper.findChild(var_6_1, "vx_tracked")
		local var_6_3 = gohelper.findChild(var_6_1, "select")
		local var_6_4 = gohelper.findChild(var_6_1, "vx_daoju")

		gohelper.setActive(arg_6_0._target.avatar.goTracked, false)
		gohelper.setActive(arg_6_0._target.avatar.goInteractEff, false)
		gohelper.setActive(var_6_2, false)
		gohelper.setActive(var_6_3, false)
		gohelper.setActive(var_6_4, false)

		arg_6_0._target.avatar.goTracked = var_6_2
		arg_6_0._target.avatar.goSelectable = var_6_3
		arg_6_0._target.avatar.goInteractEff = var_6_4
	end

	arg_6_0:refreshPlayerSelected()
end

return var_0_0
