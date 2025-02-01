module("modules.logic.toughbattle.view.ToughBattleRoleItem", package.seeall)

slot0 = class("ToughBattleRoleItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._goselect = gohelper.findChild(slot1, "#go_select")
	slot0._imgrole = gohelper.findChildImage(slot1, "#simage_rolehead")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot1, "#btn_click")
end

function slot0.addEventListeners(slot0)
	slot0._btnclick:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0.initData(slot0, slot1)
	slot0._isNew = slot1.isNewGet
	slot0._co = slot1.co

	if slot0._co and not slot0._isNew then
		UISpriteSetMgr.instance:setToughBattleRoleSprite(slot0._imgrole, "roleheadpic0" .. slot0._co.sort)
	else
		UISpriteSetMgr.instance:setToughBattleRoleSprite(slot0._imgrole, "roleheadempty")
	end
end

function slot0.playFirstAnim(slot0)
	if slot0._isNew then
		slot0._anim:Play("get", 0, 0)
		TaskDispatcher.runDelay(slot0._delaySetIcon, slot0, 0.3)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_hero37_checkpoint_gather)
	else
		slot0._anim:Play("idle")
	end
end

function slot0._delaySetIcon(slot0)
	UISpriteSetMgr.instance:setToughBattleRoleSprite(slot0._imgrole, "roleheadpic0" .. slot0._co.sort)
end

function slot0.setClickCallBack(slot0, slot1, slot2)
	slot0._clickCallBack = slot1
	slot0._callobj = slot2
end

function slot0._onClick(slot0)
	if not slot0._co then
		GameFacade.showToast(ToastEnum.ToughBattleClickEmptyHero)

		return
	end

	if slot0._clickCallBack then
		slot0._clickCallBack(slot0._callobj, slot0._co)
	end
end

function slot0.setSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1 and slot1 == slot0._co)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delaySetIcon, slot0)

	slot0._clickCallBack = nil
	slot0._callobj = nil
end

return slot0
