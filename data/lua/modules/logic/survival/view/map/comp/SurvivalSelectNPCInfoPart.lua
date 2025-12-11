module("modules.logic.survival.view.map.comp.SurvivalSelectNPCInfoPart", package.seeall)

local var_0_0 = class("SurvivalSelectNPCInfoPart", ShelterManagerInfoView)

function var_0_0.initNpc(arg_1_0)
	var_0_0.super.initNpc(arg_1_0)

	arg_1_0.btnInTeam = gohelper.findChildButtonWithAudio(arg_1_0.goNpc, "bottom/#btn_inteam")
	arg_1_0.btnOutTeam = gohelper.findChildButtonWithAudio(arg_1_0.goNpc, "bottom/#btn_outteam")
end

function var_0_0.addEventListeners(arg_2_0)
	var_0_0.super.addEventListeners(arg_2_0)
	arg_2_0.btnInTeam:AddClickListener(arg_2_0._onClickInTeam, arg_2_0)
	arg_2_0.btnOutTeam:AddClickListener(arg_2_0._onClickOutTeam, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	var_0_0.super.removeEventListeners(arg_3_0)
	arg_3_0.btnInTeam:RemoveClickListener()
	arg_3_0.btnOutTeam:RemoveClickListener()
end

function var_0_0.updateMo(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._npcMo = arg_4_1
	arg_4_0.showId = arg_4_1.id
	arg_4_0.otherParam = {}

	arg_4_0:refreshNpc()
	gohelper.setActive(arg_4_0.goNpcReset, false)
	gohelper.setActive(arg_4_0.btnNpcGoto, false)
	gohelper.setActive(arg_4_0.btnNpcReset, false)

	if arg_4_2 then
		gohelper.setActive(arg_4_0.btnInTeam, false)
		gohelper.setActive(arg_4_0.btnOutTeam, false)

		return
	end

	local var_4_0 = SurvivalMapModel.instance:getInitGroup()
	local var_4_1 = tabletool.indexOf(var_4_0.allSelectNpcs, arg_4_1)
	local var_4_2 = tabletool.len(var_4_0.allSelectNpcs) == var_4_0:getCarryNPCCount()
	local var_4_3 = true

	gohelper.setActive(arg_4_0.btnInTeam, var_4_3 and not var_4_2 and not var_4_1)
	gohelper.setActive(arg_4_0.btnOutTeam, var_4_3 and var_4_1)
	ZProj.UGUIHelper.SetGrayscale(arg_4_0.imgNpcChess.gameObject, not var_4_3)

	arg_4_0._initGroup = var_4_0
end

function var_0_0._onClickInTeam(arg_5_0)
	table.insert(arg_5_0._initGroup.allSelectNpcs, arg_5_0._npcMo)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNPCInTeamChange)
end

function var_0_0._onClickOutTeam(arg_6_0)
	tabletool.removeValue(arg_6_0._initGroup.allSelectNpcs, arg_6_0._npcMo)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNPCInTeamChange)
end

return var_0_0
