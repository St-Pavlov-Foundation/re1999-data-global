module("modules.logic.character.view.CharacterTalentStyleItem", package.seeall)

slot0 = class("CharacterTalentStyleItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")
	slot0._txtstyle = gohelper.findChildText(slot0.viewGO, "#txt_style")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._gouse = gohelper.findChild(slot0.viewGO, "#go_use")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_new")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "#go_unlock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._hideNewAnim, slot0)
	TaskDispatcher.cancelTask(slot0._hideUnlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0._hideSelectAnim, slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0._mo then
		TalentStyleModel.instance:selectCubeStyle(slot0._heroId, slot0._mo._styleId)
		gohelper.setActive(slot0._gonew, false)
	end
end

function slot0._editableInitView(slot0)
	slot0._styleslot = gohelper.findChildImage(slot0.viewGO, "slot")
	slot0._styleicon = gohelper.findChildImage(slot0.viewGO, "slot/icon")
	slot0._styleglow = gohelper.findChildImage(slot0.viewGO, "slot/glow")
	slot0._goselectQuan = gohelper.findChild(slot0.viewGO, "#go_select/quan")
	slot0._gohot = gohelper.findChild(slot0.viewGO, "#go_hot")
	slot0._imglock = slot0._golocked:GetComponent(typeof(UnityEngine.UI.Image))
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
	TaskDispatcher.cancelTask(slot0._hideUnlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0._hideSelectAnim, slot0)
end

function slot0.showItemState(slot0)
	gohelper.setActive(slot0._gouse, slot0._mo._isUse)
	gohelper.setActive(slot0._golocked, not slot0._mo._isUnlock)
	gohelper.setActive(slot0._gonormal, slot0._mo._isUnlock)
	TaskDispatcher.cancelTask(slot0._hideUnlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0._hideSelectAnim, slot0)
	TaskDispatcher.cancelTask(slot0._hideNewAnim, slot0)
	gohelper.setActive(slot0._gounlock, TalentStyleModel.instance:getNewUnlockStyle() == slot0._mo._styleId)
	gohelper.setActive(slot0._goselectQuan, TalentStyleModel.instance:getNewSelectStyle() == slot0._mo._styleId)
	gohelper.setActive(slot0._goselect, slot0._mo._isSelect)

	if slot1 == slot0._mo._styleId then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_resonate_unlock_01)
		TaskDispatcher.runDelay(slot0._hideUnlockAnim, slot0, 0.5)
	end

	if slot2 then
		TaskDispatcher.runDelay(slot0._hideSelectAnim, slot0, 0.5)
	end

	gohelper.setActive(slot0._gonew, slot0._mo._isNew)

	slot0._styleglow.color = Color(1, 1, 1, slot0._mo._isUnlock and 1 or 0.3)
	slot0._imglock.color = Color(1, 1, 1, slot0._mo._isUnlock and 1 or 0.5)
	slot0._styleslot.enabled = slot0._mo._isUnlock
	slot0._styleicon.enabled = slot0._mo._isUnlock

	gohelper.setActive(slot0._gohot, slot0._mo:isHotUnlock())
end

function slot0._hideUnlockAnim(slot0)
	gohelper.setActive(slot0._gounlock, false)
	TalentStyleModel.instance:setNewUnlockStyle()
end

function slot0._hideNewAnim(slot0)
	gohelper.setActive(slot0._gonew, false)

	slot0._isShowNew = false
end

function slot0._hideSelectAnim(slot0)
	gohelper.setActive(slot0._goselectQuan, false)
	TalentStyleModel.instance:setNewSelectStyle()
end

function slot0.refreshItem(slot0)
	slot1, slot2 = slot0._mo:getStyleTagIcon()

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleslot, slot2, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleicon, slot1, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleglow, slot1, true)
	slot0:showItemState()
end

return slot0
