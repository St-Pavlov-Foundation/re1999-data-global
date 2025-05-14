module("modules.logic.settings.view.SettingsGameView", package.seeall)

local var_0_0 = class("SettingsGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorecordvideo = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/Content/#go_recordvideo")
	arg_1_0._btnrecordvideo = gohelper.findChildButtonWithAudio(arg_1_0._gorecordvideo, "switch/btn")
	arg_1_0._gooffrecordvideo = gohelper.findChild(arg_1_0._gorecordvideo, "switch/btn/off")
	arg_1_0._goonrecordvideo = gohelper.findChild(arg_1_0._gorecordvideo, "switch/btn/on")
	arg_1_0._goenteranim = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/Content/#go_enteranim")
	arg_1_0._goAuto = gohelper.findChild(arg_1_0._goenteranim, "switch/btn/auto")
	arg_1_0._goHand = gohelper.findChild(arg_1_0._goenteranim, "switch/btn/hand")
	arg_1_0._btnenteranim = gohelper.findChildButtonWithAudio(arg_1_0._goenteranim, "switch/btn")
	arg_1_0._gorecommend = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/Content/#go_recommend")
	arg_1_0._gorecommendon = gohelper.findChild(arg_1_0._gorecommend, "switch/btn/on")
	arg_1_0._gorecommendoff = gohelper.findChild(arg_1_0._gorecommend, "switch/btn/off")
	arg_1_0._btnrecommend = gohelper.findChildButtonWithAudio(arg_1_0._gorecommend, "switch/btn")
	arg_1_0._gochangeenteranim = gohelper.findChild(arg_1_0.viewGO, "scroll/Viewport/Content/#go_changeenteranim")
	arg_1_0._btnchangeanimFirst = gohelper.findChildButtonWithAudio(arg_1_0._gochangeenteranim, "switch/#btn_first")
	arg_1_0._btnchangeanimEven = gohelper.findChildButtonWithAudio(arg_1_0._gochangeenteranim, "switch/#btn_even")
	arg_1_0._gochangeon1 = gohelper.findChild(arg_1_0._gochangeenteranim, "switch/#btn_even/#go_evenon")
	arg_1_0._gochangeoff1 = gohelper.findChild(arg_1_0._gochangeenteranim, "switch/#btn_even/#go_evenoff")
	arg_1_0._gochangeon2 = gohelper.findChild(arg_1_0._gochangeenteranim, "switch/#btn_first/#go_firston")
	arg_1_0._gochangeoff2 = gohelper.findChild(arg_1_0._gochangeenteranim, "switch/#btn_first/#go_firstoff")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if SettingsShowHelper.canShowRecordVideo() then
		arg_2_0._btnrecordvideo:AddClickListener(arg_2_0._btnrecordvideoOnClick, arg_2_0)
	end

	arg_2_0._btnenteranim:AddClickListener(arg_2_0._btnenteranimOnClick, arg_2_0)
	arg_2_0._btnchangeanimFirst:AddClickListener(arg_2_0._btnchangeanimFirstOnClick, arg_2_0)
	arg_2_0._btnchangeanimEven:AddClickListener(arg_2_0._btnchangeanimEvenOnClick, arg_2_0)
	arg_2_0._btnrecommend:AddClickListener(arg_2_0._btnchangerecommendOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	if SettingsShowHelper.canShowRecordVideo() then
		arg_3_0._btnrecordvideo:RemoveClickListener()
	end

	arg_3_0._btnenteranim:RemoveClickListener()
	arg_3_0._btnchangeanimFirst:RemoveClickListener()
	arg_3_0._btnchangeanimEven:RemoveClickListener()
	arg_3_0._btnrecommend:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gorecordvideo, SettingsShowHelper.canShowRecordVideo())
	arg_4_0:refreshRecordVideo()
	arg_4_0:refreshEnterAnim()
	arg_4_0:refreshRecommend()
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.refreshRecommend(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		arg_6_1 = SettingsModel.instance:isTypeOn(SettingsEnum.PushType.Allow_Recommend)
	end

	gohelper.setActive(arg_6_0._gorecommendon, arg_6_1)
	gohelper.setActive(arg_6_0._gorecommendoff, not arg_6_1)
end

function var_0_0.refreshRecordVideo(arg_7_0)
	local var_7_0 = SettingsModel.instance:getRecordVideo()

	gohelper.setActive(arg_7_0._gooffrecordvideo, not var_7_0)
	gohelper.setActive(arg_7_0._goonrecordvideo, var_7_0)
end

function var_0_0.refreshEnterAnim(arg_8_0)
	local var_8_0 = SettingsModel.instance.limitedRoleMO
	local var_8_1 = var_8_0:isAuto()

	gohelper.setActive(arg_8_0._goAuto, var_8_1)
	gohelper.setActive(arg_8_0._goHand, not var_8_1)
	gohelper.setActive(arg_8_0._gochangeenteranim, var_8_1)
	gohelper.setActive(arg_8_0._gochangeon1, var_8_0:isEveryLogin())
	gohelper.setActive(arg_8_0._gochangeoff1, not var_8_0:isEveryLogin())
	gohelper.setActive(arg_8_0._gochangeon2, var_8_0:isDaily())
	gohelper.setActive(arg_8_0._gochangeoff2, not var_8_0:isDaily())
end

function var_0_0._btnrecordvideoOnClick(arg_9_0)
	if SettingsController.instance:checkSwitchRecordVideo() then
		arg_9_0:refreshRecordVideo()
	end
end

function var_0_0._btnenteranimOnClick(arg_10_0)
	local var_10_0 = SettingsModel.instance.limitedRoleMO

	if var_10_0:isAuto() then
		var_10_0:setManual()
	else
		var_10_0:setAuto()
	end

	arg_10_0:_delaySaveSetting()
	arg_10_0:refreshEnterAnim()
end

function var_0_0._btnchangeanimFirstOnClick(arg_11_0)
	local var_11_0 = SettingsModel.instance.limitedRoleMO

	if var_11_0:isAuto() and not var_11_0:isDaily() then
		var_11_0:setDaily()
		arg_11_0:_delaySaveSetting()
		arg_11_0:refreshEnterAnim()
	end
end

function var_0_0._btnchangeanimEvenOnClick(arg_12_0)
	local var_12_0 = SettingsModel.instance.limitedRoleMO

	if var_12_0:isAuto() and not var_12_0:isEveryLogin() then
		var_12_0:setEveryLogin()
		arg_12_0:_delaySaveSetting()
		arg_12_0:refreshEnterAnim()
	end
end

function var_0_0._btnchangerecommendOnClick(arg_13_0)
	local var_13_0 = SettingsModel.instance:isTypeOn(SettingsEnum.PushType.Allow_Recommend)

	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Allow_Recommend, var_13_0 and "0" or "1")
	arg_13_0:refreshRecommend(not var_13_0)
	StatController.instance:track(StatEnum.EventName.SetFriendRecommended, {
		[StatEnum.EventProperties.Status] = var_13_0 and StatEnum.OpenCloseStatus.Close or StatEnum.OpenCloseStatus.Open
	})
end

function var_0_0._delaySaveSetting(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._saveSetting, arg_14_0)
	TaskDispatcher.runDelay(arg_14_0._saveSetting, arg_14_0, 0.15)
end

function var_0_0._saveSetting(arg_15_0)
	if SDKMgr.instance:isEmulator() then
		PlayerPrefsHelper.save()
	end
end

return var_0_0
