module("modules.logic.fight.view.preview.SkillEffectStatView", package.seeall)

slot0 = class("SkillEffectStatView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnOpen = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnOpen")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnClose")
	slot0._btnClear = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnClear")
	slot0._btnSpeed = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnSpeed")
	slot0._txtSpeed = gohelper.findChildText(slot0.viewGO, "view/title/btnSpeed/Text")
	slot0._slider = gohelper.findChildSlider(slot0.viewGO, "view/title/slider")
	slot0._contentViewGO = gohelper.findChild(slot0.viewGO, "view")
	slot0._imgViewBg = slot0._contentViewGO:GetComponent(gohelper.Type_Image)

	slot0._slider:SetValue(slot0._imgViewBg.color.a)
	gohelper.setActive(slot0._btnOpen.gameObject, true)
	gohelper.setActive(slot0._btnClose.gameObject, false)
	gohelper.setActive(slot0._contentViewGO.gameObject, false)
end

function slot0.addEvents(slot0)
	slot0._btnOpen:AddClickListener(slot0._onClickOpen, slot0)
	slot0._btnClose:AddClickListener(slot0._onClickClose, slot0)
	slot0._btnClear:AddClickListener(slot0._onClickClear, slot0)
	slot0._btnSpeed:AddClickListener(slot0._onClickSpeed, slot0)
	slot0._slider:AddOnValueChanged(slot0._onValueChanged, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnHideSkillEditorUIEvent, slot0._onHideSkillEditorUIEvent, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnOpen:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
	slot0._btnClear:RemoveClickListener()
	slot0._btnSpeed:RemoveClickListener()
	slot0._slider:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnHideSkillEditorUIEvent, slot0._onHideSkillEditorUIEvent, slot0)
end

function slot0._onHideSkillEditorUIEvent(slot0, slot1)
	gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup)).alpha = slot1
end

function slot0._onClickOpen(slot0)
	gohelper.setActive(slot0._btnOpen.gameObject, false)
	gohelper.setActive(slot0._btnClose.gameObject, true)
	gohelper.setActive(slot0._contentViewGO.gameObject, true)
	TaskDispatcher.runRepeat(slot0._onFrame, slot0, 0.01)
end

function slot0._onClickClose(slot0)
	gohelper.setActive(slot0._btnOpen.gameObject, true)
	gohelper.setActive(slot0._btnClose.gameObject, false)
	gohelper.setActive(slot0._contentViewGO.gameObject, false)
	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
end

function slot0._onClickSpeed(slot0)
	if UnityEngine.Time.timeScale < 0.5 then
		slot0._txtSpeed.text = "速度0.01"
		UnityEngine.Time.timeScale = 1
	else
		UnityEngine.Time.timeScale = 0.01
		slot0._txtSpeed.text = "恢复速度"
	end
end

function slot0._onClickClear(slot0)
	SkillEffectStatModel.instance:clearStat()
end

function slot0._onValueChanged(slot0, slot1, slot2)
	slot3 = slot0._imgViewBg.color
	slot3.a = slot2
	slot0._imgViewBg.color = slot3
end

function slot0._onFrame(slot0)
	SkillEffectStatModel.instance:statistic()
end

return slot0
