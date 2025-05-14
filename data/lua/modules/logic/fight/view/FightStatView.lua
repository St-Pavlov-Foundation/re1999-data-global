module("modules.logic.fight.view.FightStatView", package.seeall)

local var_0_0 = class("FightStatView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")
	arg_1_0._simagebgicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "frame/#simage_bgicon1")
	arg_1_0._simagebgicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "frame/#simage_bgicon2")
	arg_1_0._btndata = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "switch/#btn_data")
	arg_1_0._btnskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "switch/#btn_skill")
	arg_1_0._godataselect = gohelper.findChild(arg_1_0.viewGO, "switch/#btn_data/go_select")
	arg_1_0._godatanormal = gohelper.findChild(arg_1_0.viewGO, "switch/#btn_data/go_normal")
	arg_1_0._goskillselect = gohelper.findChild(arg_1_0.viewGO, "switch/#btn_skill/go_select")
	arg_1_0._goskillnormal = gohelper.findChild(arg_1_0.viewGO, "switch/#btn_skill/go_normal")
	arg_1_0._godatatxt = gohelper.findChild(arg_1_0.viewGO, "view/#go_datatxt")
	arg_1_0._goskilltxt = gohelper.findChild(arg_1_0.viewGO, "view/#go_skilltxt")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btndata:AddClickListener(arg_2_0._btnDataOnClick, arg_2_0)
	arg_2_0._btnskill:AddClickListener(arg_2_0._btnSkillOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btndata:RemoveClickListener()
	arg_3_0._btnskill:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._simagebgicon1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_4_0._simagebgicon2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0._btnDataOnClick(arg_5_0)
	if arg_5_0._statType == FightEnum.FightStatType.DataView then
		return
	end

	arg_5_0._statType = FightEnum.FightStatType.DataView

	arg_5_0:_refreshUI()
end

function var_0_0._btnSkillOnClick(arg_6_0)
	if arg_6_0._statType == FightEnum.FightStatType.SkillView then
		return
	end

	arg_6_0._statType = FightEnum.FightStatType.SkillView

	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	gohelper.setActive(arg_7_0._godataselect, arg_7_0._statType == FightEnum.FightStatType.DataView)
	gohelper.setActive(arg_7_0._godatanormal, arg_7_0._statType ~= FightEnum.FightStatType.DataView)
	gohelper.setActive(arg_7_0._goskillselect, arg_7_0._statType == FightEnum.FightStatType.SkillView)
	gohelper.setActive(arg_7_0._goskillnormal, arg_7_0._statType ~= FightEnum.FightStatType.SkillView)
	gohelper.setActive(arg_7_0._godatatxt, arg_7_0._statType == FightEnum.FightStatType.DataView)
	gohelper.setActive(arg_7_0._goskilltxt, arg_7_0._statType == FightEnum.FightStatType.SkillView)
	FightController.instance:dispatchEvent(FightEvent.SwitchInfoState, arg_7_0._statType)
end

function var_0_0.getStatType(arg_8_0)
	return arg_8_0._statType
end

function var_0_0.onCloseFinish(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebgicon1:UnLoadImage()
	arg_10_0._simagebgicon2:UnLoadImage()
end

function var_0_0.onClickModalMask(arg_11_0)
	arg_11_0:closeThis()
end

return var_0_0
