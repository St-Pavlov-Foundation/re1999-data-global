module("modules.logic.bossrush.view.BossRushFightViewBossHpExt", package.seeall)

slot0 = class("BossRushFightViewBossHpExt", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._txtmyblood = gohelper.findChildText(slot0.viewGO, "#txt_myblood")
	slot0._txtbloodnum = gohelper.findChildText(slot0.viewGO, "#txt_bloodnum")
	slot0._txtbloodnum.text = ""
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._parentGo = slot1
end

function slot0.onOpen(slot0)
	slot0._isInitedInfinitBlood = false

	gohelper.setSiblingAfter(slot0.viewGO, slot0._parentGo)
	slot0:_setMyBossBlood(BossRushModel.instance:getBossCurHP(), BossRushModel.instance:getBossCurMaxHP())
	BossRushController.instance:registerCallback(BossRushEvent.OnBossDeadSumChange, slot0._onBossDeadSumChange, slot0)
	BossRushController.instance:registerCallback(BossRushEvent.OnHpChange, slot0._onHpChange, slot0)
end

function slot0.onClose(slot0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnHpChange, slot0._onHpChange, slot0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnBossDeadSumChange, slot0._onBossDeadSumChange, slot0)

	slot0._isInitedInfinitBlood = false
end

function slot0._onBossDeadSumChange(slot0, slot1, slot2)
	slot0:_setBossDeadNum(slot2)
end

function slot0._onHpChange(slot0, slot1, slot2)
	slot0:_setMyBossBlood(slot2, BossRushModel.instance:getBossCurMaxHP())
end

function slot0._setMyBossBlood(slot0, slot1, slot2)
	slot4 = BossRushModel.instance:getBossBloodMaxCount()
	slot5 = string.format("%.2f%%", slot1 / slot2 * 100)

	if BossRushModel.instance:getBossBloodCount() == 1 and slot1 == 0 and not slot0._isInitedInfinitBlood then
		slot0:_setBossDeadNum(0)

		slot0._isInitedInfinitBlood = true
	end

	slot0._txtmyblood.text = string.format("%s/%s (%s) %s/%s", slot1, slot2, slot5, math.max(0, slot3 - 1), math.max(0, slot4 - 1))
end

function slot0._setBossDeadNum(slot0, slot1)
	slot0._txtbloodnum.text = string.format("<color=#FFFF00>(x%s)</color>", slot1)
end

return slot0
