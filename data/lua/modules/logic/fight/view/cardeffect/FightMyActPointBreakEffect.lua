module("modules.logic.fight.view.cardeffect.FightMyActPointBreakEffect", package.seeall)

local var_0_0 = class("FightMyActPointBreakEffect", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	if not arg_1_1.myHasDeadEntity or arg_1_1.myBreakActPoint == 0 then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = arg_1_1.myNowActPoint + arg_1_1.myBreakActPoint

	for iter_1_0 = 1, var_1_0 do
		local var_1_1 = gohelper.findChild(arg_1_1.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. iter_1_0)

		if var_1_1 then
			local var_1_2, var_1_3 = FightViewPlayCard.calcCardPosX(iter_1_0, var_1_0)

			recthelper.setAnchor(var_1_1.transform, var_1_2, var_1_3)
		end
	end

	for iter_1_1 = arg_1_1.myNowActPoint + 1, var_1_0 do
		local var_1_4 = gohelper.findChild(arg_1_1.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. iter_1_1)

		if var_1_4 then
			gohelper.setActive(var_1_4, true)
			gohelper.setActive(gohelper.findChild(var_1_4, "imgEmpty"), false)
			gohelper.setActive(gohelper.findChild(var_1_4, "imgMove"), false)
			gohelper.setActive(gohelper.findChild(var_1_4, "conversion"), false)
			gohelper.setActive(gohelper.findChild(var_1_4, "die"), true)
			gohelper.onceAddComponent(var_1_4, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

			local var_1_5 = var_1_4:GetComponent(typeof(UnityEngine.Animation))

			if var_1_5 then
				var_1_5:Play()
			end
		end
	end

	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 0.8 / FightModel.instance:getUISpeed())
end

function var_0_0.clearWork(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._delayDone, arg_2_0)
end

function var_0_0._delayDone(arg_3_0)
	for iter_3_0 = arg_3_0.context.myNowActPoint + 1, arg_3_0.context.myNowActPoint + arg_3_0.context.myBreakActPoint do
		local var_3_0 = gohelper.findChild(arg_3_0.context.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. iter_3_0)

		if var_3_0 then
			gohelper.setActive(gohelper.findChild(var_3_0, "die"), false)

			local var_3_1 = var_3_0:GetComponent(typeof(UnityEngine.Animation))

			if var_3_1 then
				var_3_1:Stop()
			end

			gohelper.setActive(var_3_0, false)
		end
	end

	local var_3_2 = arg_3_0.context.myNowActPoint

	for iter_3_1 = 1, var_3_2 do
		local var_3_3 = gohelper.findChild(arg_3_0.context.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem" .. iter_3_1)

		if var_3_3 then
			local var_3_4, var_3_5 = FightViewPlayCard.calcCardPosX(iter_3_1, var_3_2)

			recthelper.setAnchor(var_3_3.transform, var_3_4, var_3_5)
		end
	end

	arg_3_0:onDone(true)
end

return var_0_0
