module("modules.logic.act189.view.ShortenActView_impl", package.seeall)

local var_0_0 = class("ShortenActView_impl", Activity189BaseView)

function var_0_0._getStyleItem(arg_1_0, arg_1_1)
	return arg_1_0._styleItemList[arg_1_1]
end

function var_0_0._getCurStyleId(arg_2_0)
	if not arg_2_0._curStyleId then
		arg_2_0._curStyleId = arg_2_0:getStyleCO().id
	end

	return arg_2_0._curStyleId
end

function var_0_0._getCurStyleItem(arg_3_0)
	return arg_3_0:_getStyleItem(arg_3_0:_getCurStyleId())
end

function var_0_0._editableInitView(arg_4_0)
	if isDebugBuild then
		assert(arg_4_0._txttime)
	end

	arg_4_0._styleItemList = {}

	arg_4_0:_regStyleItem(arg_4_0._go28days, ShortenAct_28days, Activity189Enum.Style._28)
	arg_4_0:_regStyleItem(arg_4_0._go35days, ShortenAct_35days, Activity189Enum.Style._35)
end

function var_0_0._regStyleItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_2.New({
		parent = arg_5_0,
		baseViewContainer = arg_5_0.viewContainer
	})

	var_5_0:setIndex(arg_5_3)
	var_5_0:init(arg_5_1)
	gohelper.setActive(arg_5_1, arg_5_0:_getCurStyleId() == arg_5_3)

	arg_5_0._styleItemList[arg_5_3] = var_5_0

	return var_5_0
end

function var_0_0.onOpen(arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0._refreshTimeTick, arg_6_0, 1)
	var_0_0.super.onOpen(arg_6_0)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189OnceBonusReply, arg_6_0._onReceiveGetAct189OnceBonusReply, arg_6_0)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, arg_6_0._onReceiveGetAct189InfoReply, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_mln_page_turn_20260901)
end

function var_0_0.onDestroyView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._refreshTimeTick, arg_7_0)
	GameUtil.onDestroyViewMemberList(arg_7_0, "_styleItemList")
	var_0_0.super:onDestroyView(arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189OnceBonusReply, arg_8_0._onReceiveGetAct189OnceBonusReply, arg_8_0)
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, arg_8_0._onReceiveGetAct189InfoReply, arg_8_0)
	var_0_0.super.onClose(arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:_refreshTimeTick()
	arg_9_0:_refreshStyleItem()
	var_0_0.super.onUpdateParam(arg_9_0)
end

function var_0_0._refreshTimeTick(arg_10_0)
	arg_10_0._txttime.text = arg_10_0:getRemainTimeStr()
end

function var_0_0._refreshStyleItem(arg_11_0)
	arg_11_0:_getCurStyleItem():onUpdateMO()
end

function var_0_0._onReceiveGetAct189OnceBonusReply(arg_12_0)
	arg_12_0:_refreshStyleItem()
end

function var_0_0._onReceiveGetAct189InfoReply(arg_13_0)
	arg_13_0:_refreshStyleItem()
end

function var_0_0.getStyleCO(arg_14_0)
	return ShortenActConfig.instance:getStyleCO()
end

function var_0_0.getBonusList(arg_15_0)
	return ShortenActConfig.instance:getBonusList()
end

function var_0_0.onItemClick(arg_16_0)
	if arg_16_0:isClaimable() then
		Activity189Controller.instance:sendGetAct189OnceBonusRequest(arg_16_0:actId())

		return false
	end

	return true
end

function var_0_0.isClaimable(arg_17_0)
	return ShortenActModel.instance:isClaimable()
end

return var_0_0
