module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordItem", package.seeall)

slot0 = class("AiZiLaRecordItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtEventTitle = gohelper.findChildText(slot0.viewGO, "Title/#txt_EventTitle")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "Title/#txt_EventTitle/#txt_TitleEn")
	slot0._goredPoint = gohelper.findChild(slot0.viewGO, "Title/#go_redPoint")
	slot0._txtEventDesc = gohelper.findChildText(slot0.viewGO, "#txt_EventDesc")
	slot0._goOption = gohelper.findChild(slot0.viewGO, "#go_Option")
	slot0._txtOptionTitle = gohelper.findChildText(slot0.viewGO, "#go_Option/#txt_OptionTitle")
	slot0._txtOptionDesc = gohelper.findChildText(slot0.viewGO, "#go_Option/#txt_OptionDesc")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._txtLocked = gohelper.findChildText(slot0.viewGO, "#go_Locked/#txt_Locked")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
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

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	if not slot0._mo then
		return
	end

	slot3 = slot1:getFinishedEventMO() and true or false

	gohelper.setActive(slot0._goOption, slot3)
	gohelper.setActive(slot0._txtEventDesc, slot3)
	gohelper.setActive(slot0._goLocked, not slot3)

	if slot3 then
		slot0:_refreshUnLockUI(slot2)
	else
		slot0._txtEventTitle.text = luaLang("v1a5_aizila_unknown_question_mark")
		slot0._txtLocked.text = slot1:getLockDesc()
	end
end

function slot0._refreshUnLockUI(slot0, slot1)
	slot2 = slot1.config
	slot0._txtEventTitle.text = GameUtil.setFirstStrSize(slot2.name, 60)
	slot0._txtEventDesc.text = slot2.desc
	slot3 = slot1:getSelectOptionCfg()
	slot0._txtOptionTitle.text = slot3.name
	slot0._txtOptionDesc.text = slot3.optionDesc
end

return slot0
