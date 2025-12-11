module("modules.logic.fight.view.FightAiJiAoQteView", package.seeall)

local var_0_0 = class("FightAiJiAoQteView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onConstructor(arg_4_0)
	return
end

function var_0_0._onBtnEsc(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	FightController.instance:dispatchEvent(FightEvent.StopCardCameraAnimator)
	NavigateMgr.instance:addEscape(arg_6_0.viewContainer.viewName, arg_6_0._onBtnEsc, arg_6_0)

	if arg_6_0.logicView then
		arg_6_0.logicView:disposeSelf()
	end

	local var_6_0 = arg_6_0.viewParam.fromId
	local var_6_1 = arg_6_0.viewParam.toId

	arg_6_0.logicView = arg_6_0:com_openSubView(FightAiJiAoQteLogicView, "ui/viewres/fight/fightaijiaoqteview.prefab", arg_6_0.viewGO, var_6_0, var_6_1)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:onOpen()
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0.autoQte(arg_9_0, arg_9_1)
	local var_9_0 = FightDataModel.instance.aiJiAoAutoSequenceForGM

	if var_9_0 then
		local var_9_1 = var_9_0.autoSequence

		if var_9_1 and #var_9_1 > 0 then
			local var_9_2 = var_9_0.index + 1

			if not var_9_1[var_9_2] then
				var_9_2 = 1
			end

			var_9_0.index = var_9_2

			local var_9_3 = var_9_1[var_9_2]

			FightRpc.instance:sendUseClothSkillRequest(var_9_3, arg_9_0, arg_9_1, FightEnum.ClothSkillType.EzioBigSkill)

			return
		end
	end

	local var_9_4 = FightDataHelper.entityMgr:getById(arg_9_1)

	if var_9_4 then
		if var_9_4.currentHp / var_9_4.attrMO.hp >= 0.5 then
			FightRpc.instance:sendUseClothSkillRequest(2, arg_9_0, arg_9_1, FightEnum.ClothSkillType.EzioBigSkill)
		else
			FightRpc.instance:sendUseClothSkillRequest(1, arg_9_0, arg_9_1, FightEnum.ClothSkillType.EzioBigSkill)
		end
	end
end

return var_0_0
