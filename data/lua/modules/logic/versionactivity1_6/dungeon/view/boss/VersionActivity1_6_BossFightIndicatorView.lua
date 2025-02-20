module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossFightIndicatorView", package.seeall)

slot0 = class("VersionActivity1_6_BossFightIndicatorView", FightIndicatorBaseView)
slot1 = {
	VersionActivity1_6DungeonEnum.ResPath.BossFightScoreTips
}

function slot0.startLoadPrefab(slot0)
	slot0._abLoader = MultiAbLoader.New()

	slot0._abLoader:setPathList(uv0)
	slot0._abLoader:startLoad(slot0._onResLoadFinish, slot0)
end

function slot0._onResLoadFinish(slot0)
	VersionActivity1_6DungeonController.instance:registerCallback(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, slot0._onScoreChange, slot0)
	slot0:_initView()
end

function slot0._initView(slot0)
	slot1 = VersionActivity1_6DungeonEnum.ResPath.BossFightScoreTips
	slot0._go = gohelper.clone(slot0._abLoader:getAssetItem(slot1):GetResource(slot1), slot0.goIndicatorRoot, "VersionActivity1_6_BossFightIndicatorView")
	slot0._txtScoreNum = gohelper.findChildText(slot0._go, "Tips/#txt_ScoreNum")
	slot0._txtScoreNum1 = gohelper.findChildText(slot0._go, "Tips/#txt_ScoreNum/#txt_ScoreNum1")
	slot0._goAssessIcon = gohelper.findChild(slot0._go, "Tips/#go_AssessIcon")
	slot0.imgtipbg = gohelper.findChildImage(slot0._go, "Tips/image_BG")
	slot0._aniScoreNum = slot0._txtScoreNum.gameObject:GetComponent(typeof(UnityEngine.Animation))
	slot0._animtip = slot0._go.gameObject:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._goAssessIcon, false)
	slot0:_setScore(VersionActivity1_6DungeonBossModel.instance:getFightScore())
end

function slot0._onScoreChange(slot0, slot1, slot2)
	slot0:_setScore(slot2)
end

function slot0._setScore(slot0, slot1)
	slot2 = slot1 ~= 0 and slot1 or luaLang("v1a4_bossRush_ig_scoretips_txt_scorenum")
	slot0._txtScoreNum.text = slot2
	slot0._txtScoreNum1.text = slot2

	slot0._aniScoreNum:Stop()
	slot0._aniScoreNum:Play()
end

function slot0.onDestroy(slot0)
	VersionActivity1_6DungeonController.instance:unregisterCallback(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, slot0._onScoreChange, slot0)

	if slot0._abLoader then
		slot0._abLoader:dispose()
	end

	slot0._abLoader = nil

	uv0.super.onDestroy(slot0)
end

return slot0
