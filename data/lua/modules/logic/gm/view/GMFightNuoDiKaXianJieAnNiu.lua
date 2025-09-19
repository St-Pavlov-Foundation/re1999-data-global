module("modules.logic.gm.view.GMFightNuoDiKaXianJieAnNiu", package.seeall)

local var_0_0 = class("GMFightNuoDiKaXianJieAnNiu", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnStart")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registClick(arg_2_0.btnStart, arg_2_0.onClickStart)
end

function var_0_0.onClickStart(arg_3_0)
	arg_3_0.time = arg_3_0.time or Time.time

	if Time.time - arg_3_0.time > arg_3_0.timeLimit then
		arg_3_0.time = Time.time

		arg_3_0:com_sendMsg(FightMsgId.OperationForPlayEffect, arg_3_0.effectType)
	end
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.effectType = arg_4_0.viewParam.effectType
	arg_4_0.timeLimit = arg_4_0.viewParam.timeLimit
	arg_4_0.time = 0
end

function var_0_0.onDestructor(arg_5_0)
	return
end

return var_0_0
