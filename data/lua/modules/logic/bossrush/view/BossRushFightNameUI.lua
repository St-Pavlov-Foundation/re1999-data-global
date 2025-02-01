module("modules.logic.bossrush.view.BossRushFightNameUI", package.seeall)

slot0 = class("BossRushFightNameUI", FightNameUI)

function slot0._onLoaded(slot0)
	uv0.super._onLoaded(slot0)

	slot0._topHp = gohelper.findChildImage(slot0._uiGO, "layout/top/hp/container/#img_unlimitedtophp")
	slot0._botHp = gohelper.findChildImage(slot0._uiGO, "layout/top/hp/container/#img_unlimitedbothp")

	slot0:_checkBoss()

	if slot0.isBoss then
		if slot0._imgHp then
			gohelper.setActive(slot0._imgHp.gameObject, false)
		end

		slot0._imgHp = slot0._topHp
		slot0._imgHp.fillAmount = slot0:_getFillAmount()
		slot0._unlimitHp = BossRushModel.instance._unlimitHp

		if slot0._unlimitHp then
			slot0:_onChangeUnlimitedHpColor(slot0._unlimitHp.index)
			ZProj.TweenHelper.KillByObj(slot0._imgHp)

			if slot0._unlimitHp.fillAmount < slot1 then
				ZProj.TweenHelper.DOFillAmount(slot0._imgHp, slot0._unlimitHp.fillAmount, 0.5 / FightModel.instance:getUISpeed())
			else
				slot0._imgHp.fillAmount = slot0._unlimitHp.fillAmount
			end

			gohelper.setActive(slot0._botHp.gameObject, true)
		else
			gohelper.setActive(slot0._botHp.gameObject, false)
			SLFramework.UGUI.GuiHelper.SetColor(slot0._topHp, "#9C4F30")
		end

		gohelper.setActive(slot0._topHp.gameObject, true)
	else
		gohelper.setActive(slot0._topHp.gameObject, false)
		gohelper.setActive(slot0._botHp.gameObject, false)
	end

	BossRushController.instance:registerCallback(BossRushEvent.OnUnlimitedHp, slot0._onUnlimitedHp, slot0)
end

function slot0.beforeDestroy(slot0)
	uv0.super.beforeDestroy(slot0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnUnlimitedHp, slot0._onUnlimitedHp, slot0)
end

function slot0._checkBoss(slot0)
	slot2 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot1]
	slot0.isBoss = FightHelper.isBossId(slot2 and not string.nilorempty(slot2.bossId) and slot2.bossId or nil, slot0.entity:getMO():getCO().id)
end

function slot0._onChangeUnlimitedHpColor(slot0, slot1)
	if not slot0.isBoss then
		return
	end

	slot2, slot3 = BossRushModel.instance:getUnlimitedTopAndBotHpColor(slot1)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._topHp, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._botHp, slot3)
	gohelper.setActive(slot0._botHp.gameObject, true)
end

function slot0._onUnlimitedHp(slot0, slot1, slot2)
	if slot0.isBoss then
		slot0._unlimitHp = BossRushModel.instance._unlimitHp

		ZProj.TweenHelper.KillByObj(slot0._imgHp)

		if slot0._unlimitHp then
			slot3 = slot0._topHp.fillAmount
			slot4 = 0.5 / FightModel.instance:getUISpeed()

			if slot3 < slot3 then
				slot0._topHp.fillAmount = 1
			end

			ZProj.TweenHelper.DOFillAmount(slot0._imgHp, slot2, slot4)
			slot0:_onChangeUnlimitedHpColor(slot1)
			gohelper.setActive(slot0._botHp.gameObject, true)
		else
			gohelper.setActive(slot0._botHp.gameObject, false)
		end
	end
end

return slot0
