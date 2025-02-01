module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameStateItem", package.seeall)

slot0 = class("AiZiLaGameStateItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goState = gohelper.findChild(slot0.viewGO, "#go_State")
	slot0._goeffdown = gohelper.findChild(slot0.viewGO, "#go_State/#go_effdown")
	slot0._goeffup = gohelper.findChild(slot0.viewGO, "#go_State/#go_effup")
	slot0._txteffDesc = gohelper.findChildText(slot0.viewGO, "#go_State/#txt_effDesc")

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
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0.setStateStr(slot0, slot1)
	slot0._txteffDesc.text = slot1
end

function slot0.setShowUp(slot0, slot1)
	gohelper.setActive(slot0._goeffdown, not slot1)
	gohelper.setActive(slot0._goeffup, slot1)
end

return slot0
