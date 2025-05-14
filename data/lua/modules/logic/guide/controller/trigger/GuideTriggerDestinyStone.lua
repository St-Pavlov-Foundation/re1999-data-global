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
	if arg_3_0.heroMo and arg_3_0.heroMo:isOwnHero() and arg_3_0.heroMo:isCanOpenDestinySystem() then
		arg_3_0:checkStartGuide(23301)
	end
end

function var_0_0._onOpenView(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == ViewName.CharacterView then
		local var_4_0 = arg_4_2

		if var_4_0 and var_4_0:isOwnHero() and var_4_0:isCanOpenDestinySystem() then
			arg_4_0:checkStartGuide(23301)
		end

		arg_4_0.heroMo = var_4_0
	end

	if arg_4_1 == ViewName.CharacterDestinySlotView then
		local var_4_1 = arg_4_2.heroMo

		if var_4_1 and var_4_1:isOwnHero() then
			if var_4_1.destinyStoneMo:isUnlockSlot() then
				arg_4_0:checkStartGuide(23302)
			end

			if var_4_1.destinyStoneMo.curUseStoneId ~= 0 then
				arg_4_0:checkStartGuide(23303)
			end
		end
	end
end

function var_0_0._OnUnlockSlot(arg_5_0)
	arg_5_0:checkStartGuide(23302)
end

function var_0_0._OnUseStone(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:checkStartGuide(23303)
end

return var_0_0
