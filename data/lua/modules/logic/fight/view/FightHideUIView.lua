module("modules.logic.fight.view.FightHideUIView", package.seeall)

local var_0_0 = class("FightHideUIView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnsGo = gohelper.findChild(arg_1_0.viewGO, "root/btns")
	arg_1_0._imgRoundGo = gohelper.findChild(arg_1_0.viewGO, "root/topLeftContent/imgRound")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_3_0._checkHideUI, arg_3_0)
	arg_3_0:_checkHideUI()
end

function var_0_0._checkHideUI(arg_4_0)
	gohelper.setActive(arg_4_0._btnsGo, GMFightShowState.topRightPause)
	gohelper.setActive(arg_4_0._imgRoundGo, GMFightShowState.topRightRound)
end

function var_0_0.onClose(arg_5_0)
	arg_5_0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, arg_5_0._checkHideUI, arg_5_0)
end

return var_0_0
