module("modules.logic.fight.view.cardeffect.FightCardUniversalAppearEffect", package.seeall)

local var_0_0 = class("FightCardUniversalAppearEffect", BaseWork)
local var_0_1 = "ui/viewres/fight/ui_effect_dna_a.prefab"

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = 1.2 / FightModel.instance:getUISpeed()
	local var_1_1 = FightDataHelper.handCardMgr.handCard
	local var_1_2 = arg_1_1.handCardItemList[#var_1_1]
	local var_1_3 = gohelper.findChild(var_1_2.go, "downEffect") or gohelper.create2d(var_1_2.go, "downEffect")

	arg_1_0._forAnimGO = gohelper.findChild(var_1_2.go, "foranim")
	arg_1_0._canvasGroup = gohelper.onceAddComponent(arg_1_0._forAnimGO, typeof(UnityEngine.CanvasGroup))
	arg_1_0._canvasGroup.alpha = 0
	arg_1_0._downEffectLoader = PrefabInstantiate.Create(var_1_3)

	arg_1_0._downEffectLoader:startLoad(var_0_1, function(arg_2_0)
		arg_1_0._tweenId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_1_0._forAnimGO, 0, 1, var_1_0)
	end)
	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, var_1_0)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	arg_4_0._forAnimGO = nil

	if not gohelper.isNil(arg_4_0._canvasGroup) then
		arg_4_0._canvasGroup.alpha = 1
	end

	arg_4_0._canvasGroup = nil

	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)

	if arg_4_0._downEffectLoader then
		arg_4_0._downEffectLoader:dispose()
	end

	arg_4_0._downEffectLoader = nil

	if arg_4_0._tweenId then
		ZProj.TweenHelper.KillById(arg_4_0._tweenId)
	end

	arg_4_0._tweenId = nil
end

return var_0_0
