module("modules.logic.fight.view.preview.FightViewSkillFrame", package.seeall)

slot0 = class("FightViewSkillFrame", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._show = slot1 and true or false
end

function slot0.onInitView(slot0)
	slot0._text = gohelper.findChildText(slot0.viewGO, "Text")
	slot0._goAutoProgress = gohelper.findChild(slot0.viewGO, "autoprogress")
	slot0._btnstop = gohelper.findChildButtonWithAudio(slot0.viewGO, "btnstop")
	slot0._txtRoleProgress = gohelper.findChildText(slot0.viewGO, "autoprogress/left/role")
	slot0._txtSkillProgress = gohelper.findChildText(slot0.viewGO, "autoprogress/right/skill")

	if not gohelper.isNil(slot0._text) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), slot0._text.gameObject)
		gohelper.setActive(slot0._text.gameObject, true)
	end

	if not gohelper.isNil(slot0._goAutoProgress) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), slot0._goAutoProgress)
	end

	if not gohelper.isNil(slot0._btnstop) then
		gohelper.addChild(ViewMgr.instance:getUIRoot(), slot0._btnstop.gameObject)
	end
end

function slot0.addEvents(slot0)
	if not gohelper.isNil(slot0._text) then
		slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillStart, slot0)
		slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillFinish, slot0)
		slot0:addEventCb(FightController.instance, FightEvent.OnEditorPlaySpineAniStart, slot0._onPlaySpineAniStart, slot0)
		slot0:addEventCb(FightController.instance, FightEvent.OnEditorPlaySpineAniEnd, slot0._onPlaySpineAniEnd, slot0)
		slot0:addEventCb(FightController.instance, FightEvent.OnEditorPlayBuffStart, slot0._onPlayBuffStart, slot0)
		slot0:addEventCb(FightController.instance, FightEvent.OnHideSkillEditorUIEvent, slot0._onHideSkillEditorUIEvent, slot0)

		if isDebugBuild then
			slot0._text.raycastTarget = true

			SLFramework.UGUI.UIClickListener.Get(slot0._text.gameObject):AddClickListener(slot0._onClickShow, slot0)
		end
	end

	if not gohelper.isNil(slot0._goAutoProgress) then
		SkillEditorMgr.instance:registerCallback(SkillEditorMgr._onSwitchEnityOrSkill, slot0._onSwitchEnityOrSkill, slot0)
	end

	if not gohelper.isNil(slot0._btnstop) then
		slot0._btnstop:AddClickListener(slot0._stopFlow, slot0)
	end
end

function slot0.removeEvents(slot0)
	if not gohelper.isNil(slot0._text) then
		slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillStart, slot0)
		slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillFinish, slot0)
		slot0:removeEventCb(FightController.instance, FightEvent.OnEditorPlaySpineAniStart, slot0._onPlaySpineAniStart, slot0)
		slot0:removeEventCb(FightController.instance, FightEvent.OnEditorPlaySpineAniEnd, slot0._onPlaySpineAniEnd, slot0)
		slot0:removeEventCb(FightController.instance, FightEvent.OnEditorPlayBuffStart, slot0._onPlayBuffStart, slot0)
		slot0:removeEventCb(FightController.instance, FightEvent.OnHideSkillEditorUIEvent, slot0._onHideSkillEditorUIEvent, slot0)
		TaskDispatcher.cancelTask(slot0._setFrameText, slot0)
		TaskDispatcher.cancelTask(slot0._setAniFrameText, slot0)

		if isDebugBuild then
			SLFramework.UGUI.UIClickListener.Get(slot0._text.gameObject):RemoveClickListener()
		end
	end

	if not gohelper.isNil(slot0._goAutoProgress) then
		SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._onSwitchEnityOrSkill, slot0._onSwitchEnityOrSkill, slot0)
	end

	if not gohelper.isNil(slot0._btnstop) then
		slot0._btnstop:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
	if not gohelper.isNil(slot0._text) then
		gohelper.destroy(slot0._text.gameObject)

		slot0._text = nil
	end

	if not gohelper.isNil(slot0._goAutoProgress) then
		gohelper.destroy(slot0._goAutoProgress)

		slot0._goAutoProgress = nil
	end

	if not gohelper.isNil(slot0._btnstop) then
		gohelper.destroy(slot0._btnstop.gameObject)
	end
end

function slot0._onHideSkillEditorUIEvent(slot0, slot1)
	if not gohelper.isNil(slot0._text) then
		gohelper.onceAddComponent(slot0._text.gameObject, typeof(UnityEngine.CanvasGroup)).alpha = slot1
	end
end

function slot0._onClickShow(slot0)
	slot0._show = true
end

function slot0._stopFlow(slot0)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._StopAutoPlayFlow1)
end

function slot0._onSkillStart(slot0, slot1, slot2)
	if not slot0._show then
		return
	end

	slot0._entity = slot1

	TaskDispatcher.runRepeat(slot0._setFrameText, slot0, 0.01)
	slot0:_setFrameText()
end

function slot0._onSkillFinish(slot0, slot1, slot2)
	if not slot0._show then
		return
	end

	TaskDispatcher.cancelTask(slot0._setFrameText, slot0)
end

function slot0._setFrameText(slot0)
	if not slot0._show then
		return
	end

	if slot0._entity and slot0._entity.skill and slot0._entity.skill:getBinder() and slot0._entity.skill:getCurFrame() > 0 then
		slot0._text.text = "技能预览\n" .. slot1
	end
end

function slot0._onPlaySpineAniStart(slot0, slot1)
	if not slot0._show then
		return
	end

	slot0._entity = slot1

	TaskDispatcher.runRepeat(slot0._setAniFrameText, slot0, 0.01)
	slot0:_setAniFrameText()
end

function slot0._onPlaySpineAniEnd(slot0)
	if not slot0._show then
		return
	end

	TaskDispatcher.cancelTask(slot0._setAniFrameText, slot0)
end

function slot0._setAniFrameText(slot0)
	if not slot0._show then
		return
	end

	if slot0._entity and slot0._entity.spine then
		slot0._text.text = "小人动作\n" .. math.ceil(slot0._entity.spine._skeletonAnim:GetCurFrame())
	end
end

function slot0._onPlayBuffStart(slot0)
	if not slot0._show then
		return
	end

	slot0._buff_startTime = Time.time

	TaskDispatcher.runRepeat(slot0._seBuffFrameText, slot0, 0.01)
	slot0:_seBuffFrameText()
end

function slot0._onPlayBuffEnd(slot0)
	if not slot0._show then
		return
	end

	TaskDispatcher.cancelTask(slot0._seBuffFrameText, slot0)
	FightController.instance:dispatchEvent(FightEvent.OnEditorPlayBuffEnd)

	slot0._text.text = ""
end

function slot0._seBuffFrameText(slot0)
	if not slot0._show then
		return
	end

	slot0._text.text = "buff时间\n" .. math.ceil((Time.time - slot0._buff_startTime) * 60)

	if Time.time - slot0._buff_startTime >= 3 then
		slot0:_onPlayBuffEnd()
	end
end

function slot0._onSwitchEnityOrSkill(slot0, slot1)
	if slot1 then
		slot3 = slot1.skillstr

		if slot1.rolestr or slot3 then
			gohelper.setActive(slot0.viewGO, false)
			gohelper.setActive(slot0._goAutoProgress, true)
			gohelper.setActive(slot0._btnstop.gameObject, true)

			slot0._txtRoleProgress.text = slot2 or slot0._txtRoleProgress.text
			slot0._txtSkillProgress.text = slot3 or slot0._txtSkillProgress.text
		end
	else
		gohelper.setActive(slot0.viewGO, true)
		gohelper.setActive(slot0._goAutoProgress, false)
		gohelper.setActive(slot0._btnstop.gameObject, false)
	end
end

return slot0
