module("modules.logic.fight.buffbehaviours.FightBuffBehaviour_500M_DeepScore", package.seeall)

local var_0_0 = class("FightBuffBehaviour_500M_DeepScore", FightBuffBehaviourBase)
local var_0_1 = "ui/viewres/fight/fighttower/fightdepthview.prefab"

function var_0_0.onAddBuff(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.indicatorId = FightEnum.IndicatorId.TowerDeep
	arg_1_0.loaded = false
	arg_1_0.goRoot = arg_1_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.DeepScore_500M)

	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.DeepScore_500M)

	arg_1_0.loader = PrefabInstantiate.Create(arg_1_0.goRoot)

	arg_1_0.loader:startLoad(var_0_1, arg_1_0.onLoadFinish, arg_1_0)
end

function var_0_0.onLoadFinish(arg_2_0)
	arg_2_0.loaded = true
	arg_2_0.goDeepScore = arg_2_0.loader:getInstGO()
	arg_2_0.imageBg = gohelper.findChildImage(arg_2_0.goDeepScore, "#image_bg")
	arg_2_0.txtScore = gohelper.findChildText(arg_2_0.goDeepScore, "#txt_depth")
	arg_2_0.animLine = gohelper.findChildComponent(arg_2_0.goDeepScore, "ani_line", gohelper.Type_Animation)
	arg_2_0.animSwitchBg = gohelper.findChildComponent(arg_2_0.goDeepScore, "#ani_switch", gohelper.Type_Animation)

	arg_2_0:refreshScore()
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnTowerDeepChange, arg_2_0.onTowerDeepChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnMonsterChange, arg_2_0.onMonsterChange, arg_2_0)
end

function var_0_0.onMonsterChange(arg_3_0)
	arg_3_0:refreshBg()
	arg_3_0.animSwitchBg:Play()
	arg_3_0.animLine:Play()
	AudioMgr.instance:trigger(310008)
end

var_0_0.Duration = 0.5

function var_0_0.onTowerDeepChange(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:killTween()

	arg_4_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_4_1, arg_4_2, FightAssistBossScoreView.Duration, arg_4_0.onFrameCallback, arg_4_0.onTweenDone, arg_4_0, nil, EaseType.Linear)
end

function var_0_0.onFrameCallback(arg_5_0, arg_5_1)
	arg_5_0.txtScore.text = string.format("%dM", arg_5_1)
end

function var_0_0.onTweenDone(arg_6_0)
	arg_6_0.tweenId = nil

	arg_6_0:refreshScore()
end

function var_0_0.killTween(arg_7_0)
	if arg_7_0.tweenId then
		ZProj.TweenHelper.KillById(arg_7_0.tweenId)
	end
end

function var_0_0.refreshBg(arg_8_0)
	local var_8_0 = FightHelper.getBossCurStageCo_500M()

	UISpriteSetMgr.instance:setFightTowerSprite(arg_8_0.imageBg, var_8_0.param3)
end

function var_0_0.refreshScore(arg_9_0)
	if not arg_9_0.loaded then
		return
	end

	local var_9_0 = FightDataHelper.fieldMgr.indicatorDict[arg_9_0.indicatorId]
	local var_9_1 = var_9_0 and var_9_0.num or 0

	arg_9_0.txtScore.text = string.format("%dM", var_9_1)
end

function var_0_0.onRemoveBuff(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	gohelper.destroy(arg_10_0.goDeepScore)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.DeepScore_500M)
end

function var_0_0.onDestroy(arg_11_0)
	arg_11_0:killTween()

	if arg_11_0.loader then
		arg_11_0.loader:dispose()

		arg_11_0.loader = nil
	end

	var_0_0.super.onDestroy(arg_11_0)
end

return var_0_0
