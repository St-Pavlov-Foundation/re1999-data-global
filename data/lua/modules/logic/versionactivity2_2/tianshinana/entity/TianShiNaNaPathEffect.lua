module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaPathEffect", package.seeall)

slot0 = class("TianShiNaNaPathEffect", LuaCompBase)

function slot0.Create(slot0)
	slot1 = UnityEngine.GameObject.New("Effect")

	if slot0 then
		slot1.transform:SetParent(slot0.transform, false)
	end

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot1, uv0)
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.initData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.x = slot1
	slot0.y = slot2
	slot0.type = slot3
	slot0.delay = slot4
	slot0.duration = slot5
	slot6 = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(slot1, slot2))

	transformhelper.setLocalPos(slot0.go.transform, slot6.x, slot6.y, slot6.z)

	if slot4 > 0 then
		TaskDispatcher.runDelay(slot0.playEffect, slot0, slot4)
	else
		slot0:playEffect()
	end

	TaskDispatcher.runDelay(slot0._delayInPool, slot0, slot4 + slot5)
end

function slot0.playEffect(slot0)
	if not slot0.loader then
		slot0.loader = PrefabInstantiate.Create(slot0.go)

		slot0.loader:startLoad("scenes/v2a2_m_s12_tsnn_jshd/prefab/path_effect.prefab", slot0._onLoadEnd, slot0)
	elseif slot0.loader:getInstGO() then
		slot0:_realPlayEffect()
	end
end

function slot0._onLoadEnd(slot0)
	slot1 = slot0.loader:getInstGO()
	slot0._goglow = gohelper.findChild(slot1, "1x1_glow")
	slot0._gostar = gohelper.findChild(slot1, "vx_star")

	slot0:_realPlayEffect()
end

function slot0._realPlayEffect(slot0)
	gohelper.setActive(slot0._goglow, false)
	gohelper.setActive(slot0._gostar, false)
	gohelper.setActive(slot0._goglow, slot0.type == 1)
	gohelper.setActive(slot0._gostar, slot0.type == 2)
end

function slot0._delayInPool(slot0)
	TianShiNaNaEffectPool.instance:returnToPool(slot0)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.playEffect, slot0)
	TaskDispatcher.cancelTask(slot0._delayInPool, slot0)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0.playEffect, slot0)
	TaskDispatcher.cancelTask(slot0._delayInPool, slot0)
	gohelper.destroy(slot0.go)
end

return slot0
