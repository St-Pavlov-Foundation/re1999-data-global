module("modules.logic.fight.view.FightSkipTimelineView", package.seeall)

local var_0_0 = class("FightSkipTimelineView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#go_btnright/#btn_skip")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskip:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.SkipAppearTimeline)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._timeline = arg_5_0.viewParam

	if var_0_0.getState(arg_5_0._timeline) == 0 then
		var_0_0.setState(arg_5_0._timeline, 1)
		gohelper.setActive(arg_5_0.viewGO, false)
	else
		gohelper.setActive(arg_5_0.viewGO, true)

		arg_5_0._canSkip = true
	end

	NavigateMgr.instance:addEscape(ViewName.FightSkipTimelineView, arg_5_0._onEscBtnClick, arg_5_0)
end

function var_0_0._onEscBtnClick(arg_6_0)
	if arg_6_0._canSkip then
		FightController.instance:dispatchEvent(FightEvent.SkipAppearTimeline)
	end
end

function var_0_0.getState(arg_7_0)
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.SkipAppearTimeline .. arg_7_0, 0)
end

function var_0_0.setState(arg_8_0, arg_8_1)
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.SkipAppearTimeline .. arg_8_0, arg_8_1 or 1)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
