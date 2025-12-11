module("modules.logic.survival.view.SurvivalHeroGroupEquipView", package.seeall)

local var_0_0 = class("SurvivalHeroGroupEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_HeroEffect/#btn_equip")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._onOpenEquipView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequip:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._btnequip.gameObject, SurvivalEquipBtnComp)
end

function var_0_0._onOpenEquipView(arg_5_0)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

return var_0_0
