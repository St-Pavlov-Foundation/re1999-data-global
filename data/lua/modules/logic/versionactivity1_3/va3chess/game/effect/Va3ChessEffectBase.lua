module("modules.logic.versionactivity1_3.va3chess.game.effect.Va3ChessEffectBase", package.seeall)

local var_0_0 = class("Va3ChessEffectBase")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0._effectCfg = arg_1_0._target.effectCfg
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

function var_0_0.onAvatarFinish(arg_4_0)
	if arg_4_0._effectCfg and not string.nilorempty(arg_4_0._effectCfg.avatar) then
		arg_4_0.effectGO = UnityEngine.GameObject.New("effect_" .. arg_4_0._effectCfg.id)
		arg_4_0._loader = PrefabInstantiate.Create(arg_4_0.effectGO)

		gohelper.addChild(arg_4_0._target.avatar.sceneGo, arg_4_0.effectGO)

		local var_4_0

		if arg_4_0._target.avatar.loader and not string.nilorempty(arg_4_0._effectCfg.piontName) then
			var_4_0 = gohelper.findChild(arg_4_0._target.avatar.loader:getInstGO(), arg_4_0._effectCfg.piontName)
		end

		if not gohelper.isNil(var_4_0) then
			local var_4_1, var_4_2, var_4_3 = transformhelper.getPos(var_4_0.transform)

			transformhelper.setPos(arg_4_0.effectGO.transform, var_4_1, var_4_2, var_4_3)
		else
			transformhelper.setLocalPos(arg_4_0.effectGO.transform, 0, 0, 0)
		end

		local var_4_4 = string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, arg_4_0._effectCfg.avatar)

		arg_4_0._loader:startLoad(var_4_4, arg_4_0.onSceneObjectLoadFinish, arg_4_0)
	else
		arg_4_0.isLoadFinish = true

		arg_4_0:onAvatarLoaded()
		arg_4_0:onCheckEffect()
	end
end

function var_0_0.onSceneObjectLoadFinish(arg_5_0)
	if arg_5_0._loader then
		arg_5_0.isLoadFinish = true

		transformhelper.setLocalPos(arg_5_0._loader:getInstGO().transform, 0, 0, 0)
		arg_5_0:onAvatarLoaded()
		arg_5_0:onCheckEffect()
	end
end

function var_0_0.onSelected(arg_6_0)
	return
end

function var_0_0.onCancelSelect(arg_7_0)
	return
end

function var_0_0.onAvatarLoaded(arg_8_0)
	return
end

function var_0_0.onCheckEffect(arg_9_0)
	if arg_9_0._target then
		local var_9_0 = arg_9_0._target.originData

		if var_9_0 and var_9_0.data and var_9_0.data.lostTarget ~= nil then
			arg_9_0._target.effect:refreshSearchFailed()
			arg_9_0._target.goToObject:refreshTarget()
		end

		arg_9_0._target.goToObject:refreshSource()
	end
end

return var_0_0
