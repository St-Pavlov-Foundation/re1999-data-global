module("modules.logic.character.view.CharacterTalentChessFilterItem", package.seeall)

slot0 = class("CharacterTalentChessFilterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._gousing = gohelper.findChild(slot0.viewGO, "#go_using")
	slot0._txtstylename = gohelper.findChildText(slot0.viewGO, "layout/#txt_stylename")
	slot0._gocareer = gohelper.findChild(slot0.viewGO, "layout/#go_career")
	slot0._txtlabel = gohelper.findChildText(slot0.viewGO, "layout/#go_career/#txt_label")
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
	TalentStyleModel.instance:UseStyle(slot0._heroId, slot0._mo)
end

function slot0._editableInitView(slot0)
	slot0._styleslot = gohelper.findChildImage(slot0.viewGO, "layout/slot")
	slot0._styleicon = gohelper.findChildImage(slot0.viewGO, "layout/slot/icon")
	slot0._styleglow = gohelper.findChildImage(slot0.viewGO, "layout/slot/glow")
	slot0._unlock = gohelper.findChild(slot0.viewGO, "unlock")
	slot0._layoutCanvasGroup = gohelper.findChild(slot0.viewGO, "layout"):GetComponent(typeof(UnityEngine.CanvasGroup))
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._heroId = TalentStyleModel.instance._heroId

	slot0:refreshItem()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.hideUnlockAnim, slot0)
end

function slot0.showItemState(slot0)
	gohelper.setActive(slot0._goselect, slot0._mo._isUnlock and slot0._mo._isSelect)
	gohelper.setActive(slot0._gousing, slot0._mo._isUnlock and slot0._mo._isUse)
	gohelper.setActive(slot0._golocked, not slot0._mo._isUnlock)

	if slot0._mo._isUnlock then
		if slot0._mo._styleId ~= 0 and TalentStyleModel.instance:isPlayAnim(slot0._heroId, slot1) then
			slot0._isPlayAnim = true

			gohelper.setActive(slot0._unlock, true)
			TalentStyleModel.instance:setPlayAnim(slot0._heroId, slot1)
			TaskDispatcher.runDelay(slot0.hideUnlockAnim, slot0, 0.5)
		end
	elseif not slot0._isPlayAnim then
		slot0:hideUnlockAnim()
	end

	slot0._layoutCanvasGroup.alpha = slot0._mo._isUnlock and 1 or 0.5
end

function slot0.hideUnlockAnim(slot0)
	gohelper.setActive(slot0._unlock, false)

	slot0._isPlayAnim = false
end

function slot0.refreshItem(slot0)
	slot1, slot2 = slot0._mo:getStyleTagIcon()
	slot0._txtstylename.text, slot0._txtlabel.text = slot0._mo:getStyleTag()

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleslot, slot2, true)

	if slot0._mo._isUse then
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleicon, slot1, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleglow, slot1, true)
	end

	slot0._styleicon.enabled = slot5
	slot0._styleglow.enabled = slot5

	slot0:showItemState()
end

return slot0
