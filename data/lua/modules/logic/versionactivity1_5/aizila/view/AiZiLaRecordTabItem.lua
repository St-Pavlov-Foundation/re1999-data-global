module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordTabItem", package.seeall)

slot0 = class("AiZiLaRecordTabItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._txtLockedTitle = gohelper.findChildText(slot0.viewGO, "#go_Locked/image_Locked/#txt_LockedTitle")
	slot0._goUnSelected = gohelper.findChild(slot0.viewGO, "#go_UnSelected")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#go_UnSelected/image_UnSelected/#txt_Title")
	slot0._goSelected = gohelper.findChild(slot0.viewGO, "#go_Selected")
	slot0._txtSelectTitle = gohelper.findChildText(slot0.viewGO, "#go_Selected/image_Selected/#txt_SelectTitle")
	slot0._btnTabClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_TabClick")
	slot0._goredPoint = gohelper.findChild(slot0.viewGO, "#go_redPoint")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTabClick:AddClickListener(slot0._btnTabClickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnTabClick:RemoveClickListener()
end

function slot0._btnTabClickOnClick(slot0)
	if slot0._isUnLock and slot0._mo then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.UISelectRecordTabItem, slot0._mo.id)
	else
		GameFacade.showToast(ToastEnum.V1a5AiZiLaRecordNotOpen)
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

function slot0.onSelect(slot0, slot1)
	slot0._isSelect = slot1 and true or false

	gohelper.setActive(slot0._goLocked, not slot0._isUnLock)
	gohelper.setActive(slot0._goUnSelected, slot0._isUnLock and not slot0._isSelect)
	gohelper.setActive(slot0._goSelected, slot0._isUnLock and slot0._isSelect)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	slot0._isUnLock = true

	if not slot0._mo then
		return
	end

	slot2 = slot1.config.name

	if not slot1:isUnLock() then
		slot2 = luaLang("v1a5_aizila_unknown_question_mark")
	end

	slot0._txtTitle.text = slot2
	slot0._txtSelectTitle.text = slot2

	RedDotController.instance:addRedDot(slot0._goredPoint, RedDotEnum.DotNode.V1a5AiZiLaRecordNew, slot1:getRedUid())
	slot0:onSelect(slot0._isSelect)
end

return slot0
