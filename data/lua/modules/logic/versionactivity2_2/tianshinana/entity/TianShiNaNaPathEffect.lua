module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPathEffect", package.seeall)

local var_0_0 = class("TianShiNaNaPathEffect", LuaCompBase)

function var_0_0.Create(arg_1_0)
	local var_1_0 = UnityEngine.GameObject.New("Effect")

	if arg_1_0 then
		var_1_0.transform:SetParent(arg_1_0.transform, false)
	end

	return (MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0))
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
end

function var_0_0.initData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	arg_3_0.x = arg_3_1
	arg_3_0.y = arg_3_2
	arg_3_0.type = arg_3_3
	arg_3_0.delay = arg_3_4
	arg_3_0.duration = arg_3_5

	local var_3_0 = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(arg_3_1, arg_3_2))

	transformhelper.setLocalPos(arg_3_0.go.transform, var_3_0.x, var_3_0.y, var_3_0.z)

	if arg_3_4 > 0 then
		TaskDispatcher.runDelay(arg_3_0.playEffect, arg_3_0, arg_3_4)
	else
		arg_3_0:playEffect()
	end

	TaskDispatcher.runDelay(arg_3_0._delayInPool, arg_3_0, arg_3_4 + arg_3_5)
end

function var_0_0.playEffect(arg_4_0)
	if not arg_4_0.loader then
		arg_4_0.loader = PrefabInstantiate.Create(arg_4_0.go)

		local var_4_0 = "scenes/v2a2_m_s12_tsnn_jshd/prefab/path_effect.prefab"

		arg_4_0.loader:startLoad(var_4_0, arg_4_0._onLoadEnd, arg_4_0)
	elseif arg_4_0.loader:getInstGO() then
		arg_4_0:_realPlayEffect()
	end
end

function var_0_0._onLoadEnd(arg_5_0)
	local var_5_0 = arg_5_0.loader:getInstGO()

	arg_5_0._goglow = gohelper.findChild(var_5_0, "1x1_glow")
	arg_5_0._gostar = gohelper.findChild(var_5_0, "vx_star")

	arg_5_0:_realPlayEffect()
end

function var_0_0._realPlayEffect(arg_6_0)
	gohelper.setActive(arg_6_0._goglow, false)
	gohelper.setActive(arg_6_0._gostar, false)
	gohelper.setActive(arg_6_0._goglow, arg_6_0.type == 1)
	gohelper.setActive(arg_6_0._gostar, arg_6_0.type == 2)
end

function var_0_0._delayInPool(arg_7_0)
	TianShiNaNaEffectPool.instance:returnToPool(arg_7_0)
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.playEffect, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._delayInPool, arg_8_0)
end

function var_0_0.dispose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.playEffect, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._delayInPool, arg_9_0)
	gohelper.destroy(arg_9_0.go)
end

return var_0_0
