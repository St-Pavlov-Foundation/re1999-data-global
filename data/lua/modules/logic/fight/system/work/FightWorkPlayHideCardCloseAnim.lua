module("modules.logic.fight.system.work.FightWorkPlayHideCardCloseAnim", package.seeall)

local var_0_0 = class("FightWorkPlayHideCardCloseAnim", FightWorkItem)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1)
	arg_1_0.cardEndEffectWork = arg_1_1
end

var_0_0.CloseAnimLen = 1
var_0_0.WaitRefreshCardIconLen = 0.03

function var_0_0.onStart(arg_2_0)
	arg_2_0.cloneItemList = arg_2_0.cardEndEffectWork and arg_2_0.cardEndEffectWork._cloneOperateItemList

	if not arg_2_0.cloneItemList then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = false

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.cloneItemList) do
		local var_2_1 = iter_2_1.viewGo
		local var_2_2 = gohelper.findChild(var_2_1, "card")
		local var_2_3 = var_2_2 and gohelper.findChild(var_2_2, FightViewCardItem.HideCardVxGoName)

		if var_2_3 and var_2_3.activeInHierarchy then
			var_2_0 = true

			local var_2_4 = gohelper.findChild(var_2_3, "normal")

			if var_2_4 and var_2_4.activeInHierarchy then
				gohelper.findChildComponent(var_2_4, "ani", gohelper.Type_Animator):Play("close")
			end

			local var_2_5 = gohelper.findChild(var_2_3, "ultimate")

			if var_2_5 and var_2_5.activeInHierarchy then
				gohelper.findChildComponent(var_2_5, "ani", gohelper.Type_Animator):Play("close")
			end
		end
	end

	if not var_2_0 then
		arg_2_0:onDone(true)

		return
	end

	AudioMgr.instance:trigger(310006)
	arg_2_0:com_registTimer(arg_2_0.delayRefreshCardIcon, var_0_0.WaitRefreshCardIconLen)
	arg_2_0:com_registTimer(arg_2_0.finishWork, var_0_0.CloseAnimLen)
end

function var_0_0.delayRefreshCardIcon(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.cloneItemList) do
		iter_3_1:refreshCardIcon()
	end
end

return var_0_0
