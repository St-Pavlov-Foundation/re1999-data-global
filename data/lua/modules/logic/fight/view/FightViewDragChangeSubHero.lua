module("modules.logic.fight.view.FightViewDragChangeSubHero", package.seeall)

local var_0_0 = class("FightViewDragChangeSubHero", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._containerGO = gohelper.findChild(arg_1_0.viewGO, "root/changeSub")

	gohelper.setActive(arg_1_0._containerGO, false)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	return
end

function var_0_0.onClose(arg_5_0)
	return
end

return var_0_0
