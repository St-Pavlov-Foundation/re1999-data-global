module("modules.logic.fight.view.FightAssistBossScoreView", package.seeall)

local var_0_0 = class("FightAssistBossScoreView", UserDataDispose)
local var_0_1 = "ui/viewres/assistboss/assistbossscore.prefab"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.goAssistBossContainer = arg_1_1

	arg_1_0:addEventCb(FightController.instance, FightEvent.OnAssistBossScoreChange, arg_1_0.onScoreChange, arg_1_0)

	arg_1_0.loadDone = false

	loadAbAsset(var_0_1, false, arg_1_0.onLoadCallback, arg_1_0)
end

function var_0_0.onLoadCallback(arg_2_0, arg_2_1)
	if arg_2_1.IsLoadSuccess then
		arg_2_0.loadDone = true
		arg_2_0._assetItem = arg_2_1

		arg_2_0._assetItem:Retain()

		arg_2_0.instanceGo = gohelper.clone(arg_2_0._assetItem:GetResource(var_0_1), arg_2_0.goAssistBossContainer)

		gohelper.setAsFirstSibling(arg_2_0.instanceGo)

		arg_2_0.txtScore = gohelper.findChildText(arg_2_0.instanceGo, "Score/#txt_num")
		arg_2_0.txtScore1 = gohelper.findChildText(arg_2_0.instanceGo, "Score/#txt_num/#txt_num1")
		arg_2_0.imageScoreIcon = gohelper.findChildImage(arg_2_0.instanceGo, "Score/#image_ScoreIcon")
		arg_2_0.canvasGroupScoreIcon = arg_2_0.imageScoreIcon.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
		arg_2_0._animLevelUp = gohelper.findChild(arg_2_0.instanceGo, "Score/#ani_levelup"):GetComponent(gohelper.Type_Animator)
		arg_2_0.lastLevel = 0

		arg_2_0:refreshScore()

		arg_2_0.animation = arg_2_0.txtScore.gameObject:GetComponent(typeof(UnityEngine.Animation))
	end
end

function var_0_0.refreshScore(arg_3_0)
	if not arg_3_0.loadDone then
		return
	end

	local var_3_0 = FightDataHelper.fieldMgr:getIndicatorNum(arg_3_0.indicatorId)

	arg_3_0.txtScore.text = var_3_0
	arg_3_0.txtScore1.text = var_3_0

	arg_3_0:refreshScoreStar(var_3_0)
end

var_0_0.Duration = 0.5

function var_0_0.onScoreChange(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0.loadDone then
		return
	end

	arg_4_0:killTween()

	arg_4_0.tweenId = ZProj.TweenHelper.DOTweenFloat(arg_4_1, arg_4_2, var_0_0.Duration, arg_4_0.onFrameCallback, nil, arg_4_0, nil, EaseType.Linear)

	arg_4_0.animation:Play()
end

function var_0_0.onFrameCallback(arg_5_0, arg_5_1)
	arg_5_1 = math.floor(arg_5_1)
	arg_5_0.txtScore.text = arg_5_1
	arg_5_0.txtScore1.text = arg_5_1

	arg_5_0:refreshScoreStar(arg_5_1)
end

function var_0_0.refreshScoreStar(arg_6_0, arg_6_1)
	local var_6_0 = TowerConfig.instance:getScoreToStarConfig(arg_6_1)

	if var_6_0 ~= arg_6_0.lastLevel then
		arg_6_0._animLevelUp:Play("levelup", 0, 0)

		arg_6_0.lastLevel = var_6_0
	end

	local var_6_1 = var_6_0 > 0 and "tower_assist_point" .. Mathf.Min(var_6_0, TowerEnum.MaxShowStarNum) or "tower_assist_point1"

	UISpriteSetMgr.instance:setTowerSprite(arg_6_0.imageScoreIcon, var_6_1)

	arg_6_0.canvasGroupScoreIcon.alpha = var_6_0 > 0 and 1 or 0.3
end

function var_0_0.killTween(arg_7_0)
	if arg_7_0.tweenId then
		ZProj.TweenHelper.KillById(arg_7_0.tweenId)
	end
end

function var_0_0.destroy(arg_8_0)
	removeAssetLoadCb(var_0_1, arg_8_0._onLoadCallback, arg_8_0)

	if arg_8_0._assetItem then
		arg_8_0._assetItem:Release()

		arg_8_0._assetItem = nil
	end

	arg_8_0:killTween()
	arg_8_0:__onDispose()
end

return var_0_0
