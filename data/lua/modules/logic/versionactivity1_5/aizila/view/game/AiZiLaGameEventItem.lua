module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventItem", package.seeall)

slot0 = class("AiZiLaGameEventItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goEnable = gohelper.findChild(slot0.viewGO, "#go_Enable")
	slot0._goDisable = gohelper.findChild(slot0.viewGO, "#go_Disable")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0._mo then
		AiZiLaGameController.instance:selectOption(slot0._mo.optionId)
	end
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if not slot0._mo then
		return
	end

	slot2 = slot0._mo.optionId
	slot5 = AiZiLaModel.instance:isSelectOptionId(slot2)

	if not (slot0._mo.eventType == AiZiLaEnum.EventType.BranchLine) and slot5 then
		slot6 = string.format("%s\n<color=#85541b>%s</color>", AiZiLaConfig.instance:getOptionCo(slot0._mo.actId, slot2) and slot4.name or slot2, slot4 and slot4.optionDesc or slot2)
	end

	slot0._txtname.text = slot6

	gohelper.setActive(slot0._goEnable, not slot5)
	gohelper.setActive(slot0._goEnable, not slot5)
	gohelper.setActive(slot0._goDisable, slot5)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtname, slot5 and "#7c684f" or "#442a0d")
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
