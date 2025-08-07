module("modules.logic.sp01.odyssey.view.OdysseyTrialCharacterTalentTreeView", package.seeall)

local var_0_0 = class("OdysseyTrialCharacterTalentTreeView", CharacterSkillTalentTreeView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, arg_2_0._onTrialTalentTreeChangeReply, arg_2_0)
	arg_2_0:addEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, arg_2_0._onTrialTalentTreeResetReply, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onClickTalentTreeNode, arg_2_0._onClickTalentTreeNode, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.onCloseSkillTalentTipView, arg_2_0._onCloseSkillTalentTipView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, arg_3_0._onTrialTalentTreeChangeReply, arg_3_0)
	arg_3_0:removeEventCb(OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, arg_3_0._onTrialTalentTreeResetReply, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onClickTalentTreeNode, arg_3_0._onClickTalentTreeNode, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.onCloseSkillTalentTipView, arg_3_0._onCloseSkillTalentTipView, arg_3_0)
end

function var_0_0._onTrialTalentTreeChangeReply(arg_4_0)
	arg_4_0:_refreshView()
end

function var_0_0._onTrialTalentTreeResetReply(arg_5_0)
	arg_5_0:_refreshView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.heroMo = arg_6_0.viewParam

	local var_6_0 = arg_6_0.heroMo.extraMo
	local var_6_1 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local var_6_2 = tonumber(var_6_1.value)

	arg_6_0.isActTrialHero = arg_6_0.heroMo.trialCo and arg_6_0.heroMo.trialCo.id == var_6_2
	arg_6_0.skillTalentMo = var_6_0 and arg_6_0.heroMo.trialCo and arg_6_0.isActTrialHero and OdysseyTalentModel.instance:getTrialCassandraTreeInfo() or var_6_0:getSkillTalentMo()

	arg_6_0:_refreshSubTree()
	arg_6_0:_refreshView()
end

return var_0_0
