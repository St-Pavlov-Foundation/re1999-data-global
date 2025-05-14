module("modules.logic.versionactivity1_5.act142.view.Activity142StoryView", package.seeall)

local var_0_0 = class("Activity142StoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollChapterList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_storylist")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#simage_blackbg/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	Activity142StoryListModel.instance:init(arg_6_0.viewParam.actId, arg_6_0.viewParam.episodeId)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
