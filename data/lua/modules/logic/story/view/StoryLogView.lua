module("modules.logic.story.view.StoryLogView", package.seeall)

local var_0_0 = class("StoryLogView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#btn_close")
	arg_1_0._scrolllog = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_log")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:_refreshView()
end

function var_0_0._refreshView(arg_8_0)
	local var_8_0 = StoryModel.instance:getLog()

	StoryLogListModel.instance:setLogList(var_8_0)

	arg_8_0._scrolllog.verticalNormalizedPosition = 0
end

function var_0_0.onClose(arg_9_0)
	AudioEffectMgr.instance:stopAudio(StoryLogListModel.instance:getPlayingLogAudioId(), 0)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
