module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryView", package.seeall)

local var_0_0 = class("Activity1_3ChessStoryView", BaseView)

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

	arg_6_0._simagePanelBG:LoadImage(ResUrl.get1_3ChessMapIcon("v1a3_role2_storybg"))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	Activity122StoryListModel.instance:init(arg_8_0.viewParam.actId, arg_8_0.viewParam.episodeId)

	local var_8_0 = Activity122Config.instance:getEpisodeCo(arg_8_0.viewParam.actId, arg_8_0.viewParam.episodeId)

	arg_8_0._txtTitle.text = var_8_0 and var_8_0.name or ""
	arg_8_0._txtTitleEn.text = var_8_0 and var_8_0.orderId or ""
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagePanelBG:UnLoadImage()
end

return var_0_0
