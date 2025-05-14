module("modules.logic.fight.entity.comp.skill.FightTLEventEntityEnter", package.seeall)

local var_0_0 = class("FightTLEventEntityEnter")

function var_0_0.handleSkillEvent(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_1.fromId
	local var_1_1 = arg_1_1.toId
	local var_1_2 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_1_3 = var_1_0

	if arg_1_3[1] == "2" then
		var_1_3 = var_1_1
	end

	local var_1_4 = FightDataHelper.entityMgr:getById(var_1_3)

	if arg_1_1.customType == "change_hero" then
		local var_1_5 = FightEntityModel.instance:getModel(var_1_4.side)

		FightEntityModel.instance:getSubModel(var_1_4.side):remove(var_1_4)
		var_1_5:addAtLast(var_1_4)

		var_1_4.position = arg_1_1.toPosition
	end

	arg_1_0._newEntity = var_1_2:buildSpine(var_1_4)
	arg_1_0._work = FightWorkStartBornNormal.New(arg_1_0._newEntity, false)

	arg_1_0._work:registerDoneListener(arg_1_0._onEntityBornDone, arg_1_0)
	arg_1_0._work:onStart()

	if arg_1_0._newEntity:isMySide() then
		FightAudioMgr.instance:playHeroVoiceRandom(var_1_4.modelId, CharacterEnum.VoiceType.EnterFight)
	end
end

function var_0_0._onEntityBornDone(arg_2_0)
	arg_2_0._work:unregisterDoneListener(arg_2_0._onEntityBornDone, arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeEntity, arg_2_0._newEntity)
end

function var_0_0.reset(arg_3_0)
	arg_3_0:dispose()
end

function var_0_0.dispose(arg_4_0)
	if arg_4_0._work then
		arg_4_0._work:unregisterDoneListener(arg_4_0._onEntityBornDone, arg_4_0)
		arg_4_0._work:onStop()

		arg_4_0._work = nil
	end
end

function var_0_0.onSkillEnd(arg_5_0)
	return
end

return var_0_0
