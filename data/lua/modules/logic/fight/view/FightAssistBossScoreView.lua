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
end

function var_0_0.killTween(arg_6_0)
	if arg_6_0.tweenId then
		ZProj.TweenHelper.KillById(arg_6_0.tweenId)
	end
end

function var_0_0.destroy(arg_7_0)
	removeAssetLoadCb(var_0_1, arg_7_0._onLoadCallback, arg_7_0)

	if arg_7_0._assetItem then
		arg_7_0._assetItem:Release()

		arg_7_0._assetItem = nil
	end

	arg_7_0:killTween()
	arg_7_0:__onDispose()
end

return var_0_0
