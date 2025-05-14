module("modules.logic.bossrush.view.V1a4_BossRush_Assess_Score", package.seeall)

local var_0_0 = class("V1a4_BossRush_Assess_Score", V1a4_BossRush_AssessIcon)

function var_0_0.init(arg_1_0, arg_1_1)
	V1a4_BossRush_AssessIcon.init(arg_1_0, arg_1_1)

	arg_1_0._txtScoreNum = gohelper.findChildText(arg_1_1, "Score/#txt_ScoreNum")
	arg_1_0._txtScoreTran = gohelper.findChild(arg_1_1, "Score/#txt_Score").transform
	arg_1_0._newRecordTran = gohelper.findChild(arg_1_1, "Score/#txt_ScoreNum/NewRecord").transform
	arg_1_0.vxassess = {
		[BossRushEnum.ScoreLevel.S] = gohelper.findChild(arg_1_0._imageAssessIcon.gameObject, "vx_s"),
		[BossRushEnum.ScoreLevel.S_A] = gohelper.findChild(arg_1_0._imageAssessIcon.gameObject, "vx_ss"),
		[BossRushEnum.ScoreLevel.S_AA] = gohelper.findChild(arg_1_0._imageAssessIcon.gameObject, "vx_sss")
	}

	arg_1_0:setActiveNewRecord(false)
	arg_1_0:showVX(false)

	arg_1_0._txtScoreNum.text = ""
end

function var_0_0.setActiveDesc(arg_2_0, arg_2_1)
	GameUtil.setActive01(arg_2_0._txtScoreTran, arg_2_1)
end

function var_0_0.setActiveNewRecord(arg_3_0, arg_3_1)
	GameUtil.setActive01(arg_3_0._newRecordTran, arg_3_1)
end

function var_0_0.setData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	V1a4_BossRush_AssessIcon.setData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)

	local var_4_0, var_4_1 = BossRushConfig.instance:getAssessSpriteName(arg_4_1, arg_4_2, arg_4_3)

	arg_4_0._txtScoreNum.text = BossRushConfig.instance:getScoreStr(arg_4_2)

	arg_4_0:showVX(var_4_1)

	if var_4_1 > 0 then
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources_rare)
	end
end

function var_0_0.setData_ResultView(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:setData(arg_5_1, arg_5_2, arg_5_3)

	local var_5_0, var_5_1 = BossRushConfig.instance:getAssessSpriteName(arg_5_1, arg_5_2, arg_5_3)

	if var_5_1 > 0 then
		AudioMgr.instance:trigger(AudioEnum.ui_settleaccounts.play_ui_settleaccounts_resources)
	end
end

function var_0_0.onDestroyView(arg_6_0)
	return
end

function var_0_0.showVX(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.vxassess) do
		gohelper.setActive(iter_7_1, arg_7_1 == iter_7_0)
	end
end

return var_0_0
