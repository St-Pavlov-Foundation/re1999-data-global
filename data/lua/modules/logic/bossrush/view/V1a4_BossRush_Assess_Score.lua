module("modules.logic.bossrush.view.V1a4_BossRush_Assess_Score", package.seeall)

slot0 = class("V1a4_BossRush_Assess_Score", V1a4_BossRush_AssessIcon)

function slot0.init(slot0, slot1)
	V1a4_BossRush_AssessIcon.init(slot0, slot1)

	slot0._txtScoreNum = gohelper.findChildText(slot1, "Score/#txt_ScoreNum")
	slot0._txtScoreTran = gohelper.findChild(slot1, "Score/#txt_Score").transform
	slot0._newRecordTran = gohelper.findChild(slot1, "Score/#txt_ScoreNum/NewRecord").transform
	slot0.vxassess = {
		[BossRushEnum.ScoreLevel.S] = gohelper.findChild(slot0._imageAssessIcon.gameObject, "vx_s"),
		[BossRushEnum.ScoreLevel.S_A] = gohelper.findChild(slot0._imageAssessIcon.gameObject, "vx_ss"),
		[BossRushEnum.ScoreLevel.S_AA] = gohelper.findChild(slot0._imageAssessIcon.gameObject, "vx_sss")
	}

	slot0:setActiveNewRecord(false)
	slot0:showVX(false)

	slot0._txtScoreNum.text = ""
end

function slot0.setActiveDesc(slot0, slot1)
	GameUtil.setActive01(slot0._txtScoreTran, slot1)
end

function slot0.setActiveNewRecord(slot0, slot1)
	GameUtil.setActive01(slot0._newRecordTran, slot1)
end

function slot0.setData(slot0, slot1, slot2, slot3)
	V1a4_BossRush_AssessIcon.setData(slot0, slot1, slot2, slot3)

	slot4, slot5 = BossRushConfig.instance:getAssessSpriteName(slot1, slot2, slot3)
	slot0._txtScoreNum.text = BossRushConfig.instance:getScoreStr(slot2)

	slot0:showVX(slot5)

	if slot5 > 0 then
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
	end
end

function slot0.setData_ResultView(slot0, slot1, slot2, slot3)
	slot0:setData(slot1, slot2, slot3)

	slot4, slot5 = BossRushConfig.instance:getAssessSpriteName(slot1, slot2, slot3)

	if slot5 > 0 then
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources)
	end
end

function slot0.onDestroyView(slot0)
end

function slot0.showVX(slot0, slot1)
	for slot5, slot6 in pairs(slot0.vxassess) do
		gohelper.setActive(slot6, slot1 == slot5)
	end
end

return slot0
