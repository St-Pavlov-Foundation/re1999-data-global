module("modules.logic.bossrush.view.V1a4_BossRush_ig_ScoreTips", package.seeall)

local var_0_0 = class("V1a4_BossRush_ig_ScoreTips", FightIndicatorBaseView)
local var_0_1 = {
	BossRushEnum.ResPath.v1a4_bossrush_ig_scoretips,
	BossRushEnum.ResPath.v1a4_bossrush_battle_assessicon
}

function var_0_0.startLoadPrefab(arg_1_0)
	arg_1_0._abLoader = MultiAbLoader.New()

	arg_1_0._abLoader:setPathList(var_0_1)
	arg_1_0._abLoader:startLoad(arg_1_0._onResLoadFinish, arg_1_0)
end

function var_0_0._onResLoadFinish(arg_2_0)
	arg_2_0._curStage, arg_2_0._curLayer = BossRushModel.instance:getBattleStageAndLayer()

	arg_2_0:_initView()
	BossRushController.instance:registerCallback(BossRushEvent.OnScoreChange, arg_2_0._onScoreChange, arg_2_0)
end

function var_0_0._initView(arg_3_0)
	local var_3_0 = BossRushEnum.ResPath.v1a4_bossrush_ig_scoretips
	local var_3_1 = arg_3_0._abLoader:getAssetItem(var_3_0):GetResource(var_3_0)

	arg_3_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.BossRush)

	local var_3_2 = arg_3_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.BossRush)

	arg_3_0._go = gohelper.clone(var_3_1, var_3_2, "v1a4_bossrush_ig_scoretips")
	arg_3_0._txtScoreNum = gohelper.findChildText(arg_3_0._go, "Tips/#txt_ScoreNum")
	arg_3_0._txtScoreNum1 = gohelper.findChildText(arg_3_0._go, "Tips/#txt_ScoreNum/#txt_ScoreNum1")
	arg_3_0._goAssessIcon = gohelper.findChild(arg_3_0._go, "Tips/#go_AssessIcon")
	arg_3_0.imgtipbg = gohelper.findChildImage(arg_3_0._go, "Tips/image_BG")
	arg_3_0.vx = gohelper.findChild(arg_3_0._goAssessIcon, "vx_iconglow"):GetComponent(typeof(UnityEngine.ParticleSystem))
	arg_3_0._goeffnormal = gohelper.findChild(arg_3_0._go, "Tips/#txt_ScoreNum/eff_normal")
	arg_3_0._goefflayer4 = gohelper.findChild(arg_3_0._go, "Tips/#txt_ScoreNum/eff_layer4")
	arg_3_0._goeffnormal_1 = gohelper.findChild(arg_3_0._go, "Tips/vx_levelup/eff_normal")
	arg_3_0._goefflayer4_1 = gohelper.findChild(arg_3_0._go, "Tips/vx_levelup/eff_layer4")
	arg_3_0._aniScoreNum = arg_3_0._txtScoreNum.gameObject:GetComponent(typeof(UnityEngine.Animation))
	arg_3_0._animtip = arg_3_0._go.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_3_0.isSpecial = BossRushModel.instance:isSpecialLayerCurBattle()

	gohelper.setActive(arg_3_0._goeffnormal.gameObject, false)
	gohelper.setActive(arg_3_0._goefflayer4.gameObject, false)
	gohelper.setActive(arg_3_0._goeffnormal_1.gameObject, not arg_3_0.isSpecial)
	gohelper.setActive(arg_3_0._goefflayer4_1.gameObject, arg_3_0.isSpecial)

	arg_3_0._assessLevel = nil

	arg_3_0:_initAssessIcon()
	arg_3_0:_setScore(BossRushModel.instance:getFightScore())
end

function var_0_0._initAssessIcon(arg_4_0)
	local var_4_0 = V1a4_BossRush_AssessIcon
	local var_4_1 = BossRushEnum.ResPath.v1a4_bossrush_battle_assessicon
	local var_4_2 = arg_4_0._abLoader:getAssetItem(var_4_1):GetResource(var_4_1)
	local var_4_3 = gohelper.clone(var_4_2, arg_4_0._goAssessIcon, var_4_0.__cname)

	arg_4_0._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_3, var_4_0)

	arg_4_0._assessIcon:initData(arg_4_0, true)
end

function var_0_0._onScoreChange(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:_setScore(arg_5_2)
end

function var_0_0._setScore(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._curStage
	local var_6_1 = BossRushModel.instance:isSpecialLayer(arg_6_0._curLayer)

	arg_6_0._assessIcon:setData(var_6_0, arg_6_1, var_6_1)

	local var_6_2 = arg_6_1 ~= 0 and BossRushConfig.instance:getScoreStr(arg_6_1) or luaLang("v1a4_bossRush_ig_scoretips_txt_scorenum")

	arg_6_0._txtScoreNum.text = var_6_2
	arg_6_0._txtScoreNum1.text = var_6_2

	local var_6_3, var_6_4 = BossRushConfig.instance:getAssessBattleIconBgName(var_6_0, arg_6_1, var_6_1)

	UISpriteSetMgr.instance:setV1a4BossRushSprite(arg_6_0.imgtipbg, var_6_3)

	local var_6_5 = var_6_4 > 0 and arg_6_0._assessLevel ~= var_6_4

	arg_6_0._aniScoreNum:Stop()

	if arg_6_1 > 0 then
		gohelper.setActive(arg_6_0._goeffnormal.gameObject, not arg_6_0.isSpecial)
		gohelper.setActive(arg_6_0._goefflayer4.gameObject, arg_6_0.isSpecial)
		arg_6_0._aniScoreNum:Play()

		if var_6_5 then
			arg_6_0._animtip:Play(BossRushEnum.AnimScoreTips.LevelUp, 0, 0)
			arg_6_0._assessIcon:playVX()
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_refresh)

			arg_6_0._assessLevel = var_6_4
		end
	end
end

function var_0_0.onDestroy(arg_7_0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnScoreChange, arg_7_0._onScoreChange, arg_7_0)

	if arg_7_0._abLoader then
		arg_7_0._abLoader:dispose()
	end

	arg_7_0._abLoader = nil
	arg_7_0._assessLevel = nil

	var_0_0.super.onDestroy(arg_7_0)
end

function var_0_0.playVX(arg_8_0)
	if arg_8_0.vx then
		gohelper.setActive(arg_8_0.vx.gameObject, false)
	end
end

function var_0_0.stopVX(arg_9_0)
	if arg_9_0.vx then
		-- block empty
	end
end

return var_0_0
