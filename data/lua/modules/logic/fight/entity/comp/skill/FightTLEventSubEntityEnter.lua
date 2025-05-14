module("modules.logic.fight.entity.comp.skill.FightTLEventSubEntityEnter", package.seeall)

local var_0_0 = class("FightTLEventSubEntityEnter")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	local var_1_0 = FightEntityModel.instance:getSubModel(FightEnum.EntitySide.MySide):getList()[1]

	if var_1_0 then
		arg_1_0.nextSubEntityMO = var_1_0

		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_1_0._onSubSpineLoaded, arg_1_0)

		arg_1_0._nextSubEntity = GameSceneMgr.instance:getCurScene().entityMgr:buildSubSpine(var_1_0)
	end
end

function var_0_0._onSubSpineLoaded(arg_2_0, arg_2_1)
	if arg_2_1.unitSpawn.id == arg_2_0.nextSubEntityMO.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_2_0._onSubSpineLoaded, arg_2_0)

		local var_2_0 = GameSceneMgr.instance:getCurScene().entityMgr:getEntity(arg_2_0.nextSubEntityMO.id)

		arg_2_0._nextSubBornFlow = FlowSequence.New()

		arg_2_0._nextSubBornFlow:addWork(FightWorkStartBornNormal.New(var_2_0, true))
		arg_2_0._nextSubBornFlow:start()
	end
end

function var_0_0.reset(arg_3_0)
	arg_3_0:dispose()
end

function var_0_0.dispose(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_4_0._onSubSpineLoaded, arg_4_0)

	if arg_4_0._nextSubBornFlow then
		arg_4_0._nextSubBornFlow:stop()

		arg_4_0._nextSubBornFlow = nil
	end
end

function var_0_0.onSkillEnd(arg_5_0)
	return
end

return var_0_0
