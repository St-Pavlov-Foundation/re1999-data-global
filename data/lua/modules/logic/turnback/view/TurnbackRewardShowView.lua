module("modules.logic.turnback.view.TurnbackRewardShowView", package.seeall)

local var_0_0 = class("TurnbackRewardShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "timebg/#txt_time")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_reward")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_rewardContent")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_canget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_hasget")
	arg_1_0._btnstory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_story")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnstory:AddClickListener(arg_2_0._btnstoryOnClick, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, arg_2_0._refreshOnceBonusGetState, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_2_0._refreshRemainTime, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnstory:RemoveClickListener()
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshOnceBonusGetState, arg_3_0._refreshOnceBonusGetState, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_3_0._refreshRemainTime, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0._btnrewardOnClick(arg_4_0)
	if not arg_4_0.hasGet then
		TurnbackRpc.instance:sendTurnbackOnceBonusRequest(arg_4_0.turnbackId)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_task_slide)
	end
end

function var_0_0._btnstoryOnClick(arg_5_0)
	local var_5_0 = TurnbackModel.instance:getCurTurnbackMo()
	local var_5_1 = var_5_0 and var_5_0.config and var_5_0.config.startStory

	if var_5_1 then
		StoryController.instance:playStory(var_5_1)
	else
		logError(string.format("TurnbackRewardShowView startStoryId is nil", var_5_1))
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_rewardfullbg"))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.parent

	gohelper.addChild(var_8_0, arg_8_0.viewGO)

	arg_8_0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	arg_8_0:_createReward()
	arg_8_0:_refreshUI()
	arg_8_0:_refreshOnceBonusGetState()
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0.config = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_9_0.viewParam.actId)
	arg_9_0._txtdesc.text = arg_9_0.config.actDesc

	arg_9_0:_refreshRemainTime()
	gohelper.setActive(arg_9_0._btnstory, true)
end

function var_0_0._refreshRemainTime(arg_10_0)
	arg_10_0._txttime.text = TurnbackController.instance:refreshRemainTime()
end

function var_0_0._createReward(arg_11_0)
	local var_11_0 = TurnbackConfig.instance:getTurnbackCo(arg_11_0.turnbackId)
	local var_11_1 = string.split(var_11_0.onceBonus, "|")

	for iter_11_0 = 1, #var_11_1 do
		local var_11_2 = string.split(var_11_1[iter_11_0], "#")
		local var_11_3 = IconMgr.instance:getCommonPropItemIcon(arg_11_0._gorewardContent)

		var_11_3:setMOValue(var_11_2[1], var_11_2[2], var_11_2[3], nil, true)
		var_11_3:setPropItemScale(0.9)
		var_11_3:setCountFontSize(36)
		var_11_3:setHideLvAndBreakFlag(true)
		var_11_3:hideEquipLvAndBreak(true)
		gohelper.setActive(var_11_3.go, true)
	end
end

function var_0_0._refreshOnceBonusGetState(arg_12_0)
	arg_12_0.hasGet = TurnbackModel.instance:getOnceBonusGetState()

	gohelper.setActive(arg_12_0._gocanget, not arg_12_0.hasGet)
	gohelper.setActive(arg_12_0._gohasget, arg_12_0.hasGet)
end

function var_0_0.onClose(arg_13_0)
	arg_13_0._simagebg:UnLoadImage()
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0
