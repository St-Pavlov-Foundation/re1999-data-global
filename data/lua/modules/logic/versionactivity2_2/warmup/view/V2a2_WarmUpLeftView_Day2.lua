module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day2", package.seeall)

slot1 = class("V2a2_WarmUpLeftView_Day2", require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase"))

function slot1.onInitView(slot0)
	slot0._btn1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "before/#btn_1")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "after/#simage_icon2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot1.addEvents(slot0)
	slot0._btn1:AddClickListener(slot0._btn1OnClick, slot0)
end

function slot1.removeEvents(slot0)
	slot0._btn1:RemoveClickListener()
end

function slot1._btn1OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220217)

	if not slot0._allowClick then
		return
	end

	slot0:markGuided()
	slot0:_setActive_guide(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_horn_20220218)
	slot0:playAnim_before_click(slot0._click_before_doneCb, slot0)
end

function slot1._click_before_doneCb(slot0)
	slot0._allowClick = false
	slot0._needWaitCount = 2

	slot0:playAnim_before_out(slot0._onAfterDone, slot0)
	slot0:playAnim_after_in(slot0._onAfterDone, slot0)
end

function slot1._onAfterDone(slot0)
	slot0._needWaitCount = slot0._needWaitCount - 1

	if slot0._needWaitCount > 0 then
		return
	end

	slot0:markIsFinishedInteractive(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_release_20220219)
	slot0:saveStateDone(true)
	slot0:setActive_before(false)
	slot0:setActive_after(true)
	slot0:openDesc()
end

function slot1.ctor(slot0, slot1)
	uv0.ctor(slot0, slot1)

	slot0._needWaitCount = 0
	slot0._allowClick = false
end

function slot1._editableInitView(slot0)
	uv0._editableInitView(slot0)

	slot0._guideGo = gohelper.findChild(slot0.viewGO, "guide_day2")
	slot0._click_after = gohelper.getClick(slot0._simageicon2.gameObject)

	slot0._click_after:AddClickListener(slot0._onclick_after, slot0)
end

function slot1._onclick_after(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220217)
end

function slot1.onDestroyView(slot0)
	uv0.onDestroyView(slot0)
	slot0._click_after:RemoveClickListener()
end

function slot1.setData(slot0)
	uv0.setData(slot0)

	if not slot0:checkIsDone() then
		slot0:playAnimRaw_before_idle(0, 1)
	end

	slot0._allowClick = not slot1

	slot0:setActive_before(not slot1)
	slot0:setActive_after(slot1)
end

return slot1
