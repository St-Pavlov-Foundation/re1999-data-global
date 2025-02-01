module("modules.logic.settings.view.SettingsGameView", package.seeall)

slot0 = class("SettingsGameView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorecordvideo = gohelper.findChild(slot0.viewGO, "scroll/Viewport/Content/#go_recordvideo")
	slot0._btnrecordvideo = gohelper.findChildButtonWithAudio(slot0._gorecordvideo, "switch/btn")
	slot0._gooffrecordvideo = gohelper.findChild(slot0._gorecordvideo, "switch/btn/off")
	slot0._goonrecordvideo = gohelper.findChild(slot0._gorecordvideo, "switch/btn/on")
	slot0._goenteranim = gohelper.findChild(slot0.viewGO, "scroll/Viewport/Content/#go_enteranim")
	slot0._goAuto = gohelper.findChild(slot0._goenteranim, "switch/btn/auto")
	slot0._goHand = gohelper.findChild(slot0._goenteranim, "switch/btn/hand")
	slot0._btnenteranim = gohelper.findChildButtonWithAudio(slot0._goenteranim, "switch/btn")
	slot0._gorecommend = gohelper.findChild(slot0.viewGO, "scroll/Viewport/Content/#go_recommend")
	slot0._gorecommendon = gohelper.findChild(slot0._gorecommend, "switch/btn/on")
	slot0._gorecommendoff = gohelper.findChild(slot0._gorecommend, "switch/btn/off")
	slot0._btnrecommend = gohelper.findChildButtonWithAudio(slot0._gorecommend, "switch/btn")
	slot0._gochangeenteranim = gohelper.findChild(slot0.viewGO, "scroll/Viewport/Content/#go_changeenteranim")
	slot0._btnchangeanimFirst = gohelper.findChildButtonWithAudio(slot0._gochangeenteranim, "switch/#btn_first")
	slot0._btnchangeanimEven = gohelper.findChildButtonWithAudio(slot0._gochangeenteranim, "switch/#btn_even")
	slot0._gochangeon1 = gohelper.findChild(slot0._gochangeenteranim, "switch/#btn_even/#go_evenon")
	slot0._gochangeoff1 = gohelper.findChild(slot0._gochangeenteranim, "switch/#btn_even/#go_evenoff")
	slot0._gochangeon2 = gohelper.findChild(slot0._gochangeenteranim, "switch/#btn_first/#go_firston")
	slot0._gochangeoff2 = gohelper.findChild(slot0._gochangeenteranim, "switch/#btn_first/#go_firstoff")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	if SettingsShowHelper.canShowRecordVideo() then
		slot0._btnrecordvideo:AddClickListener(slot0._btnrecordvideoOnClick, slot0)
	end

	slot0._btnenteranim:AddClickListener(slot0._btnenteranimOnClick, slot0)
	slot0._btnchangeanimFirst:AddClickListener(slot0._btnchangeanimFirstOnClick, slot0)
	slot0._btnchangeanimEven:AddClickListener(slot0._btnchangeanimEvenOnClick, slot0)
	slot0._btnrecommend:AddClickListener(slot0._btnchangerecommendOnClick, slot0)
end

function slot0.removeEvents(slot0)
	if SettingsShowHelper.canShowRecordVideo() then
		slot0._btnrecordvideo:RemoveClickListener()
	end

	slot0._btnenteranim:RemoveClickListener()
	slot0._btnchangeanimFirst:RemoveClickListener()
	slot0._btnchangeanimEven:RemoveClickListener()
	slot0._btnrecommend:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorecordvideo, SettingsShowHelper.canShowRecordVideo())
	slot0:refreshRecordVideo()
	slot0:refreshEnterAnim()
	slot0:refreshRecommend()
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshRecommend(slot0, slot1)
	if slot1 == nil then
		slot1 = SettingsModel.instance:isTypeOn(SettingsEnum.PushType.Allow_Recommend)
	end

	gohelper.setActive(slot0._gorecommendon, slot1)
	gohelper.setActive(slot0._gorecommendoff, not slot1)
end

function slot0.refreshRecordVideo(slot0)
	slot1 = SettingsModel.instance:getRecordVideo()

	gohelper.setActive(slot0._gooffrecordvideo, not slot1)
	gohelper.setActive(slot0._goonrecordvideo, slot1)
end

function slot0.refreshEnterAnim(slot0)
	slot1 = SettingsModel.instance.limitedRoleMO
	slot2 = slot1:isAuto()

	gohelper.setActive(slot0._goAuto, slot2)
	gohelper.setActive(slot0._goHand, not slot2)
	gohelper.setActive(slot0._gochangeenteranim, slot2)
	gohelper.setActive(slot0._gochangeon1, slot1:isEveryLogin())
	gohelper.setActive(slot0._gochangeoff1, not slot1:isEveryLogin())
	gohelper.setActive(slot0._gochangeon2, slot1:isDaily())
	gohelper.setActive(slot0._gochangeoff2, not slot1:isDaily())
end

function slot0._btnrecordvideoOnClick(slot0)
	if SettingsController.instance:checkSwitchRecordVideo() then
		slot0:refreshRecordVideo()
	end
end

function slot0._btnenteranimOnClick(slot0)
	if SettingsModel.instance.limitedRoleMO:isAuto() then
		slot1:setManual()
	else
		slot1:setAuto()
	end

	slot0:_delaySaveSetting()
	slot0:refreshEnterAnim()
end

function slot0._btnchangeanimFirstOnClick(slot0)
	if SettingsModel.instance.limitedRoleMO:isAuto() and not slot1:isDaily() then
		slot1:setDaily()
		slot0:_delaySaveSetting()
		slot0:refreshEnterAnim()
	end
end

function slot0._btnchangeanimEvenOnClick(slot0)
	if SettingsModel.instance.limitedRoleMO:isAuto() and not slot1:isEveryLogin() then
		slot1:setEveryLogin()
		slot0:_delaySaveSetting()
		slot0:refreshEnterAnim()
	end
end

function slot0._btnchangerecommendOnClick(slot0)
	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Allow_Recommend, SettingsModel.instance:isTypeOn(SettingsEnum.PushType.Allow_Recommend) and "0" or "1")
	slot0:refreshRecommend(not slot1)
	StatController.instance:track(StatEnum.EventName.SetFriendRecommended, {
		[StatEnum.EventProperties.Status] = slot1 and StatEnum.OpenCloseStatus.Close or StatEnum.OpenCloseStatus.Open
	})
end

function slot0._delaySaveSetting(slot0)
	TaskDispatcher.cancelTask(slot0._saveSetting, slot0)
	TaskDispatcher.runDelay(slot0._saveSetting, slot0, 0.15)
end

function slot0._saveSetting(slot0)
	if SDKMgr.instance:isEmulator() then
		PlayerPrefsHelper.save()
	end
end

return slot0
