module("modules.logic.guide.controller.trigger.GuideTriggerDestinyStone", package.seeall)

local var_0_0 = class("GuideTriggerDestinyStone", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	CharacterDestinyController.instance:registerCallback(CharacterDestinyEvent.OnUnlockSlot, arg_1_0._OnUnlockSlot, arg_1_0)
	CharacterDestinyController.instance:registerCallback(CharacterDestinyEvent.OnUseStoneReply, arg_1_0._OnUseStone, arg_1_0)
	CharacterController.instance:registerCallback(CharacterEvent.successHeroRankUp, arg_1_0._characterLevelUp, arg_1_0)
	CharacterController.instance:registerCallback(CharacterEvent.successHeroLevelUp, arg_1_0._characterLevelUp, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == tonumber(arg_2_2) then
		return true
	end
end

function var_0_0._characterLevelUp(arg_3_0)
	if arg_3_0:_checkDestinyStone(arg_3_0.heroMo) then
		local var_3_0 = arg_3_0.heroMo.destinyStoneMo

		if var_3_0 and not var_3_0:isUnlockSlot() then
			arg_3_0:checkStartGuide(23301)
		end
	end
end

function var_0_0._onOpenView(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == ViewName.CharacterView then
		local var_4_0 = arg_4_2

		if arg_4_0:_checkDestinyStone(var_4_0) then
			local var_4_1 = var_4_0.destinyStoneMo
			local var_4_2 = 23301

			if var_4_1:isUnlockSlot() then
				local var_4_3 = GuideModel.instance:getById(var_4_2)

				if var_4_3 and not (var_4_3.serverStepId == -1 and var_4_3.clientStepId == -1) then
					GuideStepController.instance:clearFlow(var_4_2)
					GuideModel.instance:remove(var_4_3)
				end
			else
				arg_4_0:checkStartGuide(var_4_2)
			end
		end

		arg_4_0.heroMo = var_4_0
	end

	if arg_4_1 == ViewName.CharacterDestinySlotView then
		local var_4_4 = arg_4_2.heroMo

		if arg_4_0:_checkDestinyStone(var_4_4) then
			local var_4_5 = var_4_4.destinyStoneMo

			if var_4_5 and var_4_5:isUnlockSlot() then
				if var_4_5.curUseStoneId == 0 then
					if not var_4_5.unlockStoneIds or #var_4_5.unlockStoneIds == 0 then
						arg_4_0:checkStartGuide(23302)
					end
				else
					arg_4_0:checkStartGuide(23303)
				end
			end
		end
	end
end

function var_0_0._checkDestinyStone(arg_5_0, arg_5_1)
	if not arg_5_1 or not arg_5_1:isOwnHero() then
		return
	end

	if not arg_5_1:isCanOpenDestinySystem() then
		return
	end

	return true
end

function var_0_0._OnUnlockSlot(arg_6_0)
	arg_6_0:checkStartGuide(23302)
end

function var_0_0._OnUseStone(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:checkStartGuide(23303)
end

return var_0_0
