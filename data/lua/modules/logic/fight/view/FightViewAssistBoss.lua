module("modules.logic.fight.view.FightViewAssistBoss", package.seeall)

local var_0_0 = class("FightViewAssistBoss", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.assistBossId2Behaviour = {
		FightAssistBoss1,
		FightAssistBoss2,
		FightAssistBoss3,
		FightAssistBoss4,
		FightAssistBoss5
	}
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:onOpen()
end

function var_0_0.onOpen(arg_6_0)
	if not FightDataHelper.fieldMgr:isPaTa() then
		return
	end

	arg_6_0:createAssistBossBehaviour()
	arg_6_0:createAssistBossScore()
end

function var_0_0.createAssistBossBehaviour(arg_7_0)
	local var_7_0 = FightDataHelper.entityMgr:getAssistBoss()

	if not var_7_0 then
		return
	end

	if arg_7_0.bossBehaviour then
		arg_7_0.bossBehaviour:refreshUI()

		return
	end

	local var_7_1 = var_7_0.modelId
	local var_7_2 = arg_7_0.assistBossId2Behaviour[var_7_1]

	if not var_7_2 then
		logError(string.format("boss id : %s, 没有对应的处理逻辑", var_7_1))

		var_7_2 = FightAssistBoss0
	end

	arg_7_0.bossBehaviour = var_7_2.New()

	local var_7_3 = arg_7_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.AssistBoss)

	arg_7_0.bossBehaviour:init(var_7_3)
	arg_7_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.AssistBoss)
end

function var_0_0.createAssistBossScore(arg_8_0)
	if not FightDataHelper.fieldMgr:isTowerLimited() then
		return
	end

	if arg_8_0.scoreComp then
		arg_8_0.scoreComp:refreshScore()

		return
	end

	arg_8_0.scoreComp = FightAssistBossScoreView.New()

	local var_8_0 = arg_8_0.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.AssistBossScore)

	arg_8_0.scoreComp:init(var_8_0)
	arg_8_0.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.AssistBossScore)
end

function var_0_0.onDestroyView(arg_9_0)
	if arg_9_0.bossBehaviour then
		arg_9_0.bossBehaviour:destroy()

		arg_9_0.bossBehaviour = nil
	end

	if arg_9_0.scoreComp then
		arg_9_0.scoreComp:destroy()

		arg_9_0.scoreComp = nil
	end
end

return var_0_0
