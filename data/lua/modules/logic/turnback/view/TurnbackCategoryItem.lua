module("modules.logic.turnback.view.TurnbackCategoryItem", package.seeall)

slot0 = class("TurnbackCategoryItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goselect = gohelper.findChild(slot1, "beselected")
	slot0._gounselect = gohelper.findChild(slot1, "noselected")
	slot0._txtnamecn = gohelper.findChildText(slot1, "beselected/activitynamecn")
	slot0._txtnameen = gohelper.findChildText(slot1, "beselected/activitynamecn/activitynameen")
	slot0._txtunselectnamecn = gohelper.findChildText(slot1, "noselected/noactivitynamecn")
	slot0._txtunselectnameen = gohelper.findChildText(slot1, "noselected/noactivitynamecn/noactivitynameen")
	slot0._goreddot = gohelper.findChild(slot1, "#go_reddot")
	slot0._itemClick = gohelper.getClickWithAudio(slot0.go)
	slot0._anim = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	slot0._openAnimTime = 0.43

	slot0:playEnterAnim()
end

function slot0.addEventListeners(slot0)
	slot0._itemClick:AddClickListener(slot0._onItemClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._itemClick:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	if slot0._selected then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Activity_switch)
	slot0:_setLoginReddOtData(slot0._mo.id)
	TurnbackModel.instance:setTargetCategoryId(slot0._mo.id)
	TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)
	slot0:_refreshItem()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshItem()

	if slot0._openAnimTime < Time.realtimeSinceStartup - TurnbackBeginnerCategoryListModel.instance.openViewTime then
		slot0._anim:Play(UIAnimationName.Idle, 0, 1)
	end
end

function slot0._refreshItem(slot0)
	slot0._selected = slot0._mo.id == TurnbackModel.instance:getTargetCategoryId(slot0.curTurnbackId)
	slot1 = TurnbackConfig.instance:getTurnbackSubModuleCo(slot0._mo.id)

	RedDotController.instance:addRedDot(slot0._goreddot, slot1.reddotId, nil, slot0._checkCustomShowRedDotData, slot0)

	slot0._txtnamecn.text = slot1.name
	slot0._txtnameen.text = slot1.nameEn
	slot0._txtunselectnamecn.text = slot1.name
	slot0._txtunselectnameen.text = slot1.nameEn

	gohelper.setActive(slot0._goselect, slot0._selected)
	gohelper.setActive(slot0._gounselect, not slot0._selected)
end

function slot0._checkCustomShowRedDotData(slot0, slot1)
	TurnbackController.instance:_checkCustomShowRedDotData(slot1, slot0._mo.id)
end

function slot0._setLoginReddOtData(slot0, slot1)
	TimeUtil.setDayFirstLoginRed(slot0.curTurnbackId .. "_" .. slot1)
end

function slot0.playEnterAnim(slot0)
	slot0._anim:Play(UIAnimationName.Open, 0, Mathf.Clamp01((Time.realtimeSinceStartup - TurnbackBeginnerCategoryListModel.instance.openViewTime) / slot0._openAnimTime))
end

function slot0.onDestroy(slot0)
end

return slot0
