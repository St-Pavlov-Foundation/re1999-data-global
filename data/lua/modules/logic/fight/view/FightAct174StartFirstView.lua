module("modules.logic.fight.view.FightAct174StartFirstView", package.seeall)

slot0 = class("FightAct174StartFirstView", FightBaseView)

function slot0.onInitView(slot0)
	slot0._titlebgGo = gohelper.findChild(slot0.viewGO, "titlebg")
	slot0._ttitlebgAnimator = slot0._titlebgGo:GetComponent(gohelper.Type_Animator)
	slot0._playerFirst = gohelper.findChild(slot0.viewGO, "titlebg/#simage_player")
	slot0._enemyFirst = gohelper.findChild(slot0.viewGO, "titlebg/#simage_enemy")
	slot0._title = gohelper.findChild(slot0.viewGO, "titlebg/#simage_title")
	slot0._title1 = gohelper.findChild(slot0.viewGO, "titlebg/#simage_title1")
	slot0._playerPoint = gohelper.findChildText(slot0.viewGO, "player/#txt_num")
	slot0._playPointEffect = gohelper.findChildText(slot0.viewGO, "player/#txt_eff")
	slot0._enemyPoint = gohelper.findChildText(slot0.viewGO, "enemy/#txt_num")
	slot0._enemyPointEffect = gohelper.findChildText(slot0.viewGO, "enemy/#txt_eff")
end

function slot0.onInitialization(slot0, slot1)
	slot0._effectMO = slot1
end

function slot0.onOpen(slot0)
	if slot0._effectMO.reserveId == "1" then
		slot0._ttitlebgAnimator:Play("player", 0, 0)
	end

	if slot0._effectMO.reserveId == "0" then
		slot0._ttitlebgAnimator:Play("enemy", 0, 0)
	end

	slot0:com_registTimer(slot0.disposeSelf, FightEnum.PerformanceTime.DouQuQuXianHouShou)

	slot1 = string.splitToNumber(slot0._effectMO.reserveStr, "#")
	slot2 = slot0._effectMO.reserveId == "1" and slot1[1] or slot1[2]
	slot0._playerPoint.text = slot2
	slot0._playPointEffect.text = slot2
	slot3 = slot0._effectMO.reserveId == "0" and slot1[1] or slot1[2]
	slot0._enemyPoint.text = slot3
	slot0._enemyPointEffect.text = slot3

	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_dice)
end

return slot0
