module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaStoryView", package.seeall)

local var_0_0 = class("LanShouPaStoryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_PanelBG")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_Title")
	arg_1_0._scrollChapterList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_ChapterList")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._btncloseMask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeMask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btncloseMask:AddClickListener(arg_2_0._btncloseMaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btncloseMask:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseMaskOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._txtTitleEn = gohelper.findChildText(arg_6_0.viewGO, "Title/#txt_Title/txt_TitleEn")
end

function var_0_0.onOpen(arg_7_0)
	LanShouPaStoryListModel.instance:init(arg_7_0.viewParam.actId, arg_7_0.viewParam.episodeId)

	local var_7_0 = Activity164Config.instance:getEpisodeCo(arg_7_0.viewParam.actId, arg_7_0.viewParam.episodeId)
	local var_7_1 = Activity164Config.instance:getEpisodeCoList(arg_7_0.viewParam.actId)
	local var_7_2 = tabletool.indexOf(var_7_1, var_7_0)

	arg_7_0._txtTitle.text = var_7_0 and var_7_0.name or ""
	arg_7_0._txtTitleEn.text = string.format("STAGE %02d", var_7_2)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagePanelBG:UnLoadImage()
end

return var_0_0
