module("modules.logic.fight.view.FightViewMultiBossHp", package.seeall)

slot0 = class("FightViewMultiBossHp", FightViewBossHp)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._ani = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0._ani:Play("idle", nil, )
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._entityId = slot1
end

function slot0._checkBossAndUpdate(slot0)
	slot0._bossEntityMO = slot0:_getBossEntityMO()

	if slot0._bossEntityMO then
		gohelper.setActive(slot0.viewGO, true)
		gohelper.setActive(slot0._bossHpGO, true)
		slot0:_refreshBossHpUI()
	end
end

function slot0._onEntityDead(slot0, slot1)
	if slot0._bossEntityMO and slot0._bossEntityMO.id == slot1 then
		slot0._bossEntityMO = nil

		slot0:_tweenFillAmount()
		slot0._ani:Play("die", nil, )
	end
end

function slot0._getBossEntityMO(slot0)
	return FightDataHelper.entityMgr:getById(slot0._entityId)
end

return slot0
