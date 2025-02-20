module("modules.logic.bossrush.view.V1a4_BossRush_ig_ScoreTips", package.seeall)

slot0 = class("V1a4_BossRush_ig_ScoreTips", FightIndicatorBaseView)
slot1 = {
	BossRushEnum.ResPath.v1a4_bossrush_ig_scoretips,
	BossRushEnum.ResPath.v1a4_bossrush_battle_assessicon
}

function slot0.startLoadPrefab(slot0)
	slot0._abLoader = MultiAbLoader.New()

	slot0._abLoader:setPathList(uv0)
	slot0._abLoader:startLoad(slot0._onResLoadFinish, slot0)
end

function slot0._onResLoadFinish(slot0)
	slot0._curStage, slot0._curLayer = BossRushModel.instance:getBattleStageAndLayer()

	slot0:_initView()
	BossRushController.instance:registerCallback(BossRushEvent.OnScoreChange, slot0._onScoreChange, slot0)
end

function slot0._initView(slot0)
	slot1 = BossRushEnum.ResPath.v1a4_bossrush_ig_scoretips
	slot0._go = gohelper.clone(slot0._abLoader:getAssetItem(slot1):GetResource(slot1), slot0.goIndicatorRoot, "v1a4_bossrush_ig_scoretips")
	slot0._txtScoreNum = gohelper.findChildText(slot0._go, "Tips/#txt_ScoreNum")
	slot0._txtScoreNum1 = gohelper.findChildText(slot0._go, "Tips/#txt_ScoreNum/#txt_ScoreNum1")
	slot0._goAssessIcon = gohelper.findChild(slot0._go, "Tips/#go_AssessIcon")
	slot0.imgtipbg = gohelper.findChildImage(slot0._go, "Tips/image_BG")
	slot0.vx = gohelper.findChild(slot0._goAssessIcon, "vx_iconglow"):GetComponent(typeof(UnityEngine.ParticleSystem))
	slot0._goeffnormal = gohelper.findChild(slot0._go, "Tips/#txt_ScoreNum/eff_normal")
	slot0._goefflayer4 = gohelper.findChild(slot0._go, "Tips/#txt_ScoreNum/eff_layer4")
	slot0._goeffnormal_1 = gohelper.findChild(slot0._go, "Tips/vx_levelup/eff_normal")
	slot0._goefflayer4_1 = gohelper.findChild(slot0._go, "Tips/vx_levelup/eff_layer4")
	slot0._aniScoreNum = slot0._txtScoreNum.gameObject:GetComponent(typeof(UnityEngine.Animation))
	slot0._animtip = slot0._go.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0.isSpecial = BossRushModel.instance:isSpecialLayerCurBattle()

	gohelper.setActive(slot0._goeffnormal.gameObject, false)
	gohelper.setActive(slot0._goefflayer4.gameObject, false)
	gohelper.setActive(slot0._goeffnormal_1.gameObject, not slot0.isSpecial)
	gohelper.setActive(slot0._goefflayer4_1.gameObject, slot0.isSpecial)

	slot0._assessLevel = nil

	slot0:_initAssessIcon()
	slot0:_setScore(BossRushModel.instance:getFightScore())
end

function slot0._initAssessIcon(slot0)
	slot1 = V1a4_BossRush_AssessIcon
	slot2 = BossRushEnum.ResPath.v1a4_bossrush_battle_assessicon
	slot0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._abLoader:getAssetItem(slot2):GetResource(slot2), slot0._goAssessIcon, slot1.__cname), slot1)

	slot0._assessIcon:initData(slot0, true)
end

function slot0._onScoreChange(slot0, slot1, slot2)
	slot0:_setScore(slot2)
end

function slot0._setScore(slot0, slot1)
	slot0._assessIcon:setData(slot0._curStage, slot1, BossRushModel.instance:isSpecialLayer(slot0._curLayer))

	slot4 = slot1 ~= 0 and BossRushConfig.instance:getScoreStr(slot1) or luaLang("v1a4_bossRush_ig_scoretips_txt_scorenum")
	slot0._txtScoreNum.text = slot4
	slot0._txtScoreNum1.text = slot4
	slot5, slot6 = BossRushConfig.instance:getAssessBattleIconBgName(slot2, slot1, slot3)

	UISpriteSetMgr.instance:setV1a4BossRushSprite(slot0.imgtipbg, slot5)
	slot0._aniScoreNum:Stop()

	if slot1 > 0 then
		gohelper.setActive(slot0._goeffnormal.gameObject, not slot0.isSpecial)
		gohelper.setActive(slot0._goefflayer4.gameObject, slot0.isSpecial)
		slot0._aniScoreNum:Play()

		if slot6 > 0 and slot0._assessLevel ~= slot6 then
			slot0._animtip:Play(BossRushEnum.AnimScoreTips.LevelUp, 0, 0)
			slot0._assessIcon:playVX()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_refresh)

			slot0._assessLevel = slot6
		end
	end
end

function slot0.onDestroy(slot0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnScoreChange, slot0._onScoreChange, slot0)

	if slot0._abLoader then
		slot0._abLoader:dispose()
	end

	slot0._abLoader = nil
	slot0._assessLevel = nil

	uv0.super.onDestroy(slot0)
end

function slot0.playVX(slot0)
	if slot0.vx then
		gohelper.setActive(slot0.vx.gameObject, false)
	end
end

function slot0.stopVX(slot0)
	if slot0.vx then
		-- Nothing
	end
end

return slot0
