module("modules.logic.survival.view.SurvivalHeroGroupEquipView", package.seeall)

local var_0_0 = class("SurvivalHeroGroupEquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_HeroEffect/#btn_talent")
	arg_1_0._imagetalentskill = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_container/#go_HeroEffect/#btn_talent/#image_skill")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_HeroEffect/#btn_equip")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntalent:AddClickListener(arg_2_0._onOpenTalentView, arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._onOpenEquipView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntalent:RemoveClickListener()
	arg_3_0._btnequip:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._btnequip.gameObject, SurvivalEquipBtnComp)
	arg_4_0:updateTalentIcon()
end

function var_0_0.updateTalentIcon(arg_5_0)
	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_5_0 then
		return
	end

	local var_5_1 = var_5_0.talentBox.groupId
	local var_5_2 = lua_survival_talent_group.configDict[var_5_1]

	arg_5_0._imagetalentskill:LoadImage(ResUrl.getSurvivalTalentIcon(var_5_2.folder .. "/icon_1"))
end

function var_0_0._onOpenTalentView(arg_6_0)
	ViewMgr.instance:openView(ViewName.SurvivalTalentOverView)
end

function var_0_0._onOpenEquipView(arg_7_0)
	ViewMgr.instance:openView(ViewName.SurvivalEquipView)
end

return var_0_0
