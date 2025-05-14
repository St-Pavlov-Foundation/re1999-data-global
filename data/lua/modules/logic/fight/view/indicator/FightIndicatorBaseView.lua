module("modules.logic.fight.view.indicator.FightIndicatorBaseView", package.seeall)

local var_0_0 = class("FightIndicatorBaseView", UserDataDispose)

function var_0_0.initView(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0._indicatorMgrView = arg_1_1
	arg_1_0.indicatorId = arg_1_2
	arg_1_0.totalIndicatorNum = arg_1_3 or 0
	arg_1_0.viewGO = arg_1_0._indicatorMgrView.viewGO
	arg_1_0.goIndicatorRoot = gohelper.findChild(arg_1_0.viewGO, "root/indicator_container")
end

function var_0_0.startLoadPrefab(arg_2_0)
	return
end

function var_0_0.onIndicatorChange(arg_3_0)
	return
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0:__onDispose()
end

return var_0_0
