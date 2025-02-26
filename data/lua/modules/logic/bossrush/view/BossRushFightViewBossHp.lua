module("modules.logic.bossrush.view.BossRushFightViewBossHp", package.seeall)

slot0 = class("BossRushFightViewBossHp", FightViewBossHp)

function slot0.onInitView(slot0)
	FightViewBossHp.onInitView(slot0)

	slot0._gounlimited = gohelper.findChild(slot0.viewGO, "Alpha/bossHp/mask/container/imgHp/#go_unlimited")
	slot0._imgunlimited = gohelper.findChildImage(slot0.viewGO, "Alpha/bossHp/mask/container/unlimitedhp")
	slot1 = gohelper.findChild(slot0._gounlimited, "vx_hp")
	slot0._vxColor = {
		[BossRushEnum.HpColor.Red] = gohelper.findChild(slot1, "red"),
		[BossRushEnum.HpColor.Orange] = gohelper.findChild(slot1, "orange"),
		[BossRushEnum.HpColor.Yellow] = gohelper.findChild(slot1, "yellow"),
		[BossRushEnum.HpColor.Green] = gohelper.findChild(slot1, "green"),
		[BossRushEnum.HpColor.Blue] = gohelper.findChild(slot1, "blue"),
		[BossRushEnum.HpColor.Purple] = gohelper.findChild(slot1, "purple")
	}
end

slot1 = "ui/viewres/bossrush/bossrushfightviewbosshpext.prefab"

function slot0.onOpen(slot0)
	slot0._damage = 0

	slot0:_resetUnlimitedHp()
	uv0.super.onOpen(slot0)
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
	slot0:_resetUnlimitedHp()
end

function slot0._onHpChange(slot0, slot1, slot2)
	uv0.super._onHpChange(slot0, slot1, slot2)

	if slot2 ~= 0 and slot0._bossEntityMO and slot1.id == slot0._bossEntityMO.id then
		if slot0._isUnlimitedHp then
			slot0._damage = slot0._damage + slot2

			slot0:_checkUnlimitedHp()
		else
			slot0._damage = 0
		end
	end
end

function slot0._checkUnlimitedHp(slot0)
	slot1 = slot0:_getFinalBossHp()
	slot2 = Mathf.Floor(Mathf.Abs(slot0._damage / slot1))
	slot4 = 0.5 / FightModel.instance:getUISpeed()
	slot5 = (slot1 - Mathf.Abs(slot0._damage) % slot1) / slot1
	slot0._unlimitedFillAmount = slot5

	ZProj.TweenHelper.KillByObj(slot0._imgHp)

	if slot0._imgHp.fillAmount < slot5 and slot0._curShield == 0 then
		slot7 = slot0._imgHp.fillAmount / (slot0._imgHp.fillAmount + slot5) * slot4
		slot0._unlimitedTime2 = slot4 - slot7

		ZProj.TweenHelper.DOFillAmount(slot0._imgHp, 0, slot7)

		if slot0._curShield == 0 then
			ZProj.TweenHelper.KillByObj(slot0._imgHpShield)

			slot0._imgHpShield.fillAmount = 0
		end

		TaskDispatcher.cancelTask(slot0._onEndTween, slot0)
		TaskDispatcher.runDelay(slot0._onEndTween, slot0, slot7)
	else
		ZProj.TweenHelper.DOFillAmount(slot0._imgHp, slot5, slot4)
		BossRushModel.instance:syncUnlimitedHp(nil, slot5)
	end
end

function slot0._onEndTween(slot0)
	slot1, slot2 = slot0:_getFillAmount()

	if slot0._unlimitedFillAmount then
		slot1 = slot0._unlimitedFillAmount

		slot0:_changeUnlimitedHpColor(slot0._unlimitedHpNum + 1, slot1)
		ZProj.TweenHelper.KillByObj(slot0._imgHp)

		slot0._imgHp.fillAmount = 1

		ZProj.TweenHelper.DOFillAmount(slot0._imgHp, slot1, slot0._unlimitedTime2 or 0.5)
	end

	slot0:_changeShieldPos(slot1)
	ZProj.TweenHelper.KillByObj(slot0._imgHpShield)

	slot0._imgHpShield.fillAmount = slot2
end

function slot0._updateUI(slot0)
	uv0.super._updateUI(slot0)

	if slot0._unlimitedHpNum and slot0._unlimitedHpNum > 0 then
		slot1 = slot0:_getFinalBossHp()

		if slot0._curHp ~= slot1 - Mathf.Abs(slot0._damage) % slot1 then
			slot0._damage = -(slot1 * slot0._unlimitedHpNum + slot1 - slot0._curHp)
		end
	end
end

function slot0._detectBossMultiHp(slot0)
	slot1 = BossRushModel.instance:getMultiHpInfo()
	slot3 = slot1.multiHpNum

	if not slot0._hpMultiAni or slot1.multiHpIdx == 0 then
		slot0._hpMultiAni = {}
	end

	gohelper.setActive(slot0._multiHpRoot, slot3 > 1)

	if slot3 > 1 then
		slot0:com_createObjList(slot0._onMultiHpItemShow, slot3, slot0._multiHpItemContent, slot0._multiHpItem)
	end

	gohelper.setActive(slot0._multiHpItem.gameObject, true)
	gohelper.setActive(gohelper.findChild(slot0._multiHpItem.gameObject, "hp_unlimited"), true)
	gohelper.setActive(gohelper.findChild(slot0._multiHpItem.gameObject, "hp"), false)
	slot0._multiHpItem.transform:SetSiblingIndex(0)

	if not slot0._lastMultiHpIdx or slot0._lastMultiHpIdx ~= slot2 then
		slot0:_oneHpClear(slot2 - slot3 + 1)
	end

	slot0._lastMultiHpIdx = slot2

	if slot0._imgHp.fillAmount == 0 then
		ZProj.TweenHelper.KillByObj(slot0._imgHp)

		slot0._imgHp.fillAmount = 1
	end
end

slot2 = "idle"
slot3 = "close"

function slot0._onMultiHpItemShow(slot0, slot1, slot2, slot3)
	if slot3 == 1 then
		gohelper.setActive(slot1, false)
	else
		slot4 = BossRushModel.instance:getMultiHpInfo()
		slot8 = slot1:GetComponent(typeof(UnityEngine.Animator))
		slot9 = slot3 <= slot4.multiHpNum - slot4.multiHpIdx

		if not slot0._hpMultiAni[slot3] then
			gohelper.setActive(gohelper.findChild(slot1, "hp"), slot9)

			slot0._hpMultiAni[slot3] = slot9 and uv0 or uv1
		elseif slot0._hpMultiAni[slot3] ~= (slot9 and uv0 or uv1) then
			slot0._hpMultiAni[slot3] = slot10

			slot8:Play(slot0._hpMultiAni[slot3])
		end
	end
end

function slot0._changeUnlimitedHpColor(slot0, slot1, slot2)
	slot3, slot4, slot5 = BossRushModel.instance:getUnlimitedTopAndBotHpColor(slot1)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imgHp, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imgunlimited, slot4)

	for slot9, slot10 in ipairs(slot0._vxColor) do
		gohelper.setActive(slot10, slot9 == slot5)
	end

	BossRushModel.instance:syncUnlimitedHp(slot1, slot2)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnUnlimitedHp, slot1, slot2)
end

function slot0._oneHpClear(slot0, slot1)
	slot0._unlimitedHpNum = slot1

	if slot0._unlimitedHpNum >= 0 then
		slot0._isUnlimitedHp = true

		gohelper.setActive(slot0._gounlimited, true)
		gohelper.setActive(slot0._imgunlimited.gameObject, true)
	end

	if slot0._unlimitedHpNum == 0 then
		ZProj.TweenHelper.KillByObj(slot0._imgHp)

		slot0._imgHp.fillAmount = 1

		slot0:_changeUnlimitedHpColor(slot0._unlimitedHpNum, 1)
	end
end

function slot0._getFinalBossHp(slot0)
	if slot0._bossEntityMO then
		return slot1.attrMO and slot1.attrMO.hp > 0 and slot1.attrMO.hp or 1
	end
end

function slot0._resetUnlimitedHp(slot0)
	slot0._unlimitedHpNum = nil
	slot0._isUnlimitedHp = nil

	ZProj.TweenHelper.KillByObj(slot0._imgHp)
	TaskDispatcher.cancelTask(slot0._onEndTween, slot0)
	gohelper.setActive(slot0._gounlimited, false)
	gohelper.setActive(slot0._imgunlimited, false)
	BossRushModel.instance:resetUnlimitedHp()
end

function slot0._onMonsterChange(slot0, slot1, slot2)
	uv0.super._onMonsterChange(slot0, slot1, slot2)

	if slot2 then
		BossRushController.instance:_refreshCurBossHP()
	end
end

return slot0
