module("modules.logic.fight.view.FightStatView", package.seeall)

slot0 = class("FightStatView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._simagebgicon1 = gohelper.findChildSingleImage(slot0.viewGO, "frame/#simage_bgicon1")
	slot0._simagebgicon2 = gohelper.findChildSingleImage(slot0.viewGO, "frame/#simage_bgicon2")
	slot0._btndata = gohelper.findChildButtonWithAudio(slot0.viewGO, "switch/#btn_data")
	slot0._btnskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "switch/#btn_skill")
	slot0._godataselect = gohelper.findChild(slot0.viewGO, "switch/#btn_data/go_select")
	slot0._godatanormal = gohelper.findChild(slot0.viewGO, "switch/#btn_data/go_normal")
	slot0._goskillselect = gohelper.findChild(slot0.viewGO, "switch/#btn_skill/go_select")
	slot0._goskillnormal = gohelper.findChild(slot0.viewGO, "switch/#btn_skill/go_normal")
	slot0._godatatxt = gohelper.findChild(slot0.viewGO, "view/#go_datatxt")
	slot0._goskilltxt = gohelper.findChild(slot0.viewGO, "view/#go_skilltxt")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btndata:AddClickListener(slot0._btnDataOnClick, slot0)
	slot0._btnskill:AddClickListener(slot0._btnSkillOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btndata:RemoveClickListener()
	slot0._btnskill:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0._simagebgicon1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebgicon2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function slot0._btnDataOnClick(slot0)
	if slot0._statType == FightEnum.FightStatType.DataView then
		return
	end

	slot0._statType = FightEnum.FightStatType.DataView

	slot0:_refreshUI()
end

function slot0._btnSkillOnClick(slot0)
	if slot0._statType == FightEnum.FightStatType.SkillView then
		return
	end

	slot0._statType = FightEnum.FightStatType.SkillView

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	gohelper.setActive(slot0._godataselect, slot0._statType == FightEnum.FightStatType.DataView)
	gohelper.setActive(slot0._godatanormal, slot0._statType ~= FightEnum.FightStatType.DataView)
	gohelper.setActive(slot0._goskillselect, slot0._statType == FightEnum.FightStatType.SkillView)
	gohelper.setActive(slot0._goskillnormal, slot0._statType ~= FightEnum.FightStatType.SkillView)
	gohelper.setActive(slot0._godatatxt, slot0._statType == FightEnum.FightStatType.DataView)
	gohelper.setActive(slot0._goskilltxt, slot0._statType == FightEnum.FightStatType.SkillView)
	FightController.instance:dispatchEvent(FightEvent.SwitchInfoState, slot0._statType)
end

function slot0.getStatType(slot0)
	return slot0._statType
end

function slot0.onCloseFinish(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebgicon1:UnLoadImage()
	slot0._simagebgicon2:UnLoadImage()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
