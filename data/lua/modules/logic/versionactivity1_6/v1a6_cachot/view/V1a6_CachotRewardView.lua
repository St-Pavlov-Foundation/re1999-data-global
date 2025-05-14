module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRewardView", package.seeall)

local var_0_0 = class("V1a6_CachotRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goScroll = gohelper.findChild(arg_1_0.viewGO, "scroll_view")
	arg_1_0._scrollRect = gohelper.findChildScrollRect(arg_1_0.viewGO, "scroll_view")
	arg_1_0._rewarditem = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/Content/rewarditem")
	arg_1_0._rewarditemParent = arg_1_0._rewarditem.transform.parent.gameObject
	arg_1_0._btnexit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_exit")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnexit:AddClickListener(arg_2_0._onClickExit, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventChange, arg_2_0._refreshView, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventRemove, arg_2_0._onRemoveEvent, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnReceiveFightReward, arg_2_0._checkCloseView, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, arg_2_0._playOpenAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnexit:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectEventChange, arg_3_0._refreshView, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectEventRemove, arg_3_0._onRemoveEvent, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnReceiveFightReward, arg_3_0._checkCloseView, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_3_0._playOpenAnim, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
	arg_6_0:_refreshView()

	arg_6_0._scrollRect.horizontalNormalizedPosition = 0
end

function var_0_0._onRemoveEvent(arg_7_0, arg_7_1)
	if arg_7_1 and arg_7_1 ~= arg_7_0.viewParam then
		return
	end

	local var_7_0 = arg_7_0.viewParam:getDropList()

	if not var_7_0 or #var_7_0 == 0 then
		arg_7_0._isAllRewardGeted = true
	end
end

function var_0_0._checkCloseView(arg_8_0)
	if arg_8_0._isAllRewardGeted then
		arg_8_0:closeThis()
	end
end

function var_0_0._refreshView(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1 ~= arg_9_0.viewParam then
		return
	end

	local var_9_0 = arg_9_0.viewParam:getDropList()

	if not var_9_0 or #var_9_0 == 0 then
		arg_9_0:closeThis()

		return
	end

	gohelper.CreateObjList(arg_9_0, arg_9_0._setitem, var_9_0, arg_9_0._rewarditemParent, arg_9_0._rewarditem, V1a6_CachotRewardItem)
end

function var_0_0._setitem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_1:updateMo(arg_10_2, arg_10_0._goScroll)
end

function var_0_0._onClickExit(arg_11_0)
	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.CachotAbandonAward, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_abandon_award"), nil, nil, nil, arg_11_0.abandonAward, nil, nil, arg_11_0, nil, nil)
end

function var_0_0._playOpenAnim(arg_12_0)
	gohelper.setActive(arg_12_0.viewGO, false)
	gohelper.setActive(arg_12_0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
end

function var_0_0.abandonAward(arg_13_0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, arg_13_0.viewParam.eventId, arg_13_0.closeThis, arg_13_0)
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
