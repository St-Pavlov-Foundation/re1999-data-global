module("modules.logic.guide.controller.trigger.GuideTriggerTalentStyle", package.seeall)

local var_0_0 = class("GuideTriggerTalentStyle", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	CharacterController.instance:registerCallback(CharacterEvent.onReturnTalentView, arg_1_0._onReturnTalentView, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_1 then
		return false
	end

	return arg_2_1 >= tonumber(arg_2_2)
end

function var_0_0._checkStartGuide(arg_3_0, arg_3_1)
	local var_3_0 = HeroModel.instance:getByHeroId(arg_3_1)

	if var_3_0 then
		arg_3_0:checkStartGuide(var_3_0.talent)
	end
end

function var_0_0._onOpenView(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == ViewName.CharacterTalentView then
		local var_4_0 = arg_4_2.heroid

		arg_4_0:_checkStartGuide(var_4_0)
	end
end

function var_0_0._onReturnTalentView(arg_5_0, arg_5_1)
	arg_5_0:_checkStartGuide(arg_5_1)
end

return var_0_0
