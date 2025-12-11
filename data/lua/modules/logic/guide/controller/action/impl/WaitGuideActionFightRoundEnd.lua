module("modules.logic.guide.controller.action.impl.WaitGuideActionFightRoundEnd", package.seeall)

local var_0_0 = class("WaitGuideActionFightRoundEnd", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0.msgItem = FightMsgMgr.registMsg(FightMsgId.CheckGuideBeforeOperate, arg_1_0.onCheckGuideBeforeOperate, arg_1_0)
	arg_1_0.msgItem1 = FightMsgMgr.registMsg(FightMsgId.ContinueGuideBeforeOperate, arg_1_0.onContinueGuideBeforeOperate, arg_1_0)
end

function var_0_0.onCheckGuideBeforeOperate(arg_2_0)
	FightMsgMgr.replyMsg(FightMsgId.CheckGuideBeforeOperate, true)
end

function var_0_0.onContinueGuideBeforeOperate(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	FightMsgMgr.removeMsg(arg_4_0.msgItem)
	FightMsgMgr.removeMsg(arg_4_0.msgItem1)
end

return var_0_0
