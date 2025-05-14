module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossFightIndicatorView", package.seeall)

local var_0_0 = class("VersionActivity1_6_BossFightIndicatorView", FightIndicatorBaseView)
local var_0_1 = {
	VersionActivity1_6DungeonEnum.ResPath.BossFightScoreTips
}

function var_0_0.startLoadPrefab(arg_1_0)
	arg_1_0._abLoader = MultiAbLoader.New()

	arg_1_0._abLoader:setPathList(var_0_1)
	arg_1_0._abLoader:startLoad(arg_1_0._onResLoadFinish, arg_1_0)
end

function var_0_0._onResLoadFinish(arg_2_0)
	VersionActivity1_6DungeonController.instance:registerCallback(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, arg_2_0._onScoreChange, arg_2_0)
	arg_2_0:_initView()
end

function var_0_0._initView(arg_3_0)
	local var_3_0 = VersionActivity1_6DungeonEnum.ResPath.BossFightScoreTips
	local var_3_1 = arg_3_0._abLoader:getAssetItem(var_3_0):GetResource(var_3_0)

	arg_3_0._go = gohelper.clone(var_3_1, arg_3_0.goIndicatorRoot, "VersionActivity1_6_BossFightIndicatorView")
	arg_3_0._txtScoreNum = gohelper.findChildText(arg_3_0._go, "Tips/#txt_ScoreNum")
	arg_3_0._txtScoreNum1 = gohelper.findChildText(arg_3_0._go, "Tips/#txt_ScoreNum/#txt_ScoreNum1")
	arg_3_0._goAssessIcon = gohelper.findChild(arg_3_0._go, "Tips/#go_AssessIcon")
	arg_3_0.imgtipbg = gohelper.findChildImage(arg_3_0._go, "Tips/image_BG")
	arg_3_0._aniScoreNum = arg_3_0._txtScoreNum.gameObject:GetComponent(typeof(UnityEngine.Animation))
	arg_3_0._animtip = arg_3_0._go.gameObject:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_3_0._goAssessIcon, false)
	arg_3_0:_setScore(VersionActivity1_6DungeonBossModel.instance:getFightScore())
end

function var_0_0._onScoreChange(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:_setScore(arg_4_2)
end

function var_0_0._setScore(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1 ~= 0 and arg_5_1 or luaLang("v1a4_bossRush_ig_scoretips_txt_scorenum")

	arg_5_0._txtScoreNum.text = var_5_0
	arg_5_0._txtScoreNum1.text = var_5_0

	arg_5_0._aniScoreNum:Stop()
	arg_5_0._aniScoreNum:Play()
end

function var_0_0.onDestroy(arg_6_0)
	VersionActivity1_6DungeonController.instance:unregisterCallback(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, arg_6_0._onScoreChange, arg_6_0)

	if arg_6_0._abLoader then
		arg_6_0._abLoader:dispose()
	end

	arg_6_0._abLoader = nil

	var_0_0.super.onDestroy(arg_6_0)
end

return var_0_0
