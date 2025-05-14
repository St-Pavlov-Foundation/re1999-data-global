module("modules.logic.chessgame.game.effect.ChessEffectBase", package.seeall)

local var_0_0 = class("ChessEffectBase")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
end

function var_0_0.dispose(arg_2_0)
	arg_2_0:onDispose()

	if arg_2_0._loader then
		arg_2_0._loader:dispose()

		arg_2_0._loader = nil
	end

	gohelper.destroy(arg_2_0.effectGO)

	arg_2_0.effectGO = nil
end

function var_0_0.onDispose(arg_3_0)
	return
end

function var_0_0.onAvatarFinish(arg_4_0, arg_4_1)
	if arg_4_0._isLoading then
		return
	end

	if not arg_4_0.isLoadFinish then
		arg_4_0._isLoading = true
		arg_4_0.effectGO = UnityEngine.GameObject.New("effect_" .. arg_4_1)
		arg_4_0._loader = PrefabInstantiate.Create(arg_4_0.effectGO)

		gohelper.addChild(arg_4_0._target.avatar.effectNode, arg_4_0.effectGO)
		transformhelper.setLocalPos(arg_4_0.effectGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(arg_4_0.effectGO.transform, 0.8, 0.8, 0.8)

		local var_4_0 = ChessGameEnum.ChessGameEnum.EffectPath[arg_4_1]

		arg_4_0._loader:startLoad(var_4_0, arg_4_0.onSceneObjectLoadFinish, arg_4_0)
	else
		gohelper.setActive(arg_4_0.effectGO, true)
		ChessGameInteractModel.instance:setShowEffect(arg_4_0._target.mo.id)
	end
end

function var_0_0.onSceneObjectLoadFinish(arg_5_0)
	if arg_5_0._loader and arg_5_0._loader:getInstGO() then
		arg_5_0.isLoadFinish = true
		arg_5_0._isLoading = false

		transformhelper.setLocalPos(arg_5_0._loader:getInstGO().transform, 0, 0, 0)
		ChessGameInteractModel.instance:setShowEffect(arg_5_0._target.mo.id)
		arg_5_0:onAvatarLoaded()
	end
end

function var_0_0.hideEffect(arg_6_0)
	if arg_6_0.effectGO then
		gohelper.setActive(arg_6_0.effectGO, false)
		ChessGameInteractModel.instance:setHideEffect(arg_6_0._target.mo.id)
	end
end

function var_0_0.getIsLoadEffect(arg_7_0)
	return arg_7_0.isLoadFinish
end

function var_0_0.onSelected(arg_8_0)
	return
end

function var_0_0.onCancelSelect(arg_9_0)
	return
end

function var_0_0.onAvatarLoaded(arg_10_0)
	return
end

return var_0_0
