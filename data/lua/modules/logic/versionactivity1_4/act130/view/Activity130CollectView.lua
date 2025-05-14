module("modules.logic.versionactivity1_4.act130.view.Activity130CollectView", package.seeall)

local var_0_0 = class("Activity130CollectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnCloseMask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_CloseMask")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "BG/#simage_PanelBG")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Title/txt_Title")
	arg_1_0._goquestion = gohelper.findChild(arg_1_0.viewGO, "Question")
	arg_1_0._txtQuestion = gohelper.findChildText(arg_1_0.viewGO, "Question/#txt_Question")
	arg_1_0._scrollChapterList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_ChapterList")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_ChapterList/Viewport/Content")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "#go_Empty")
	arg_1_0._txtEmpty = gohelper.findChildText(arg_1_0.viewGO, "#go_Empty/#txt_Empty")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnCloseMask:AddClickListener(arg_2_0._btnCloseMaskOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnCloseMask:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseMaskOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnCloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	NavigateMgr.instance:addEscape(ViewName.Activity130CollectView, arg_6_0._btnCloseOnClick, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._collectItems = {}

	local var_8_0 = VersionActivity1_4Enum.ActivityId.Role37
	local var_8_1 = Activity130Model.instance:getCurEpisodeId()

	arg_8_0._config = Activity130Config.instance:getActivity130EpisodeCo(var_8_0, var_8_1)

	arg_8_0:_refreshItem()
end

function var_0_0._refreshItem(arg_9_0)
	local var_9_0 = Activity130Model.instance:getEpisodeOperGroupId(arg_9_0._config.episodeId)

	gohelper.setActive(arg_9_0._goquestion, var_9_0 ~= 0)

	if var_9_0 ~= 0 then
		local var_9_1 = VersionActivity1_4Enum.ActivityId.Role37
		local var_9_2 = Activity130Model.instance:getEpisodeOperGroupId(arg_9_0._config.episodeId)
		local var_9_3 = Activity130Model.instance:getDecryptIdByGroupId(var_9_2)
		local var_9_4 = Activity130Config.instance:getActivity130DecryptCo(var_9_1, var_9_3)

		arg_9_0._txtQuestion.text = var_9_4.puzzleTxt
	end

	local var_9_5 = Activity130Model.instance:getCollects(arg_9_0._config.episodeId)

	if #var_9_5 < 1 then
		gohelper.setActive(arg_9_0._goEmpty, true)
		gohelper.setActive(arg_9_0._scrollChapterList.gameObject, false)

		local var_9_6, var_9_7 = Activity130Model.instance:getEpisodeTaskTip(arg_9_0._config.episodeId)

		if var_9_6 ~= 0 then
			local var_9_8 = Activity130Config.instance:getActivity130DialogCo(var_9_6, var_9_7)

			arg_9_0._txtEmpty.text = var_9_8.content
		end

		return
	end

	gohelper.setActive(arg_9_0._goEmpty, false)
	gohelper.setActive(arg_9_0._scrollChapterList.gameObject, true)

	for iter_9_0, iter_9_1 in pairs(arg_9_0._collectItems) do
		iter_9_1:hideItems()
	end

	for iter_9_2 = 1, #var_9_5 do
		if not arg_9_0._collectItems[iter_9_2] then
			local var_9_9 = arg_9_0.viewContainer:getSetting().otherRes[1]
			local var_9_10 = arg_9_0:getResInst(var_9_9, arg_9_0._gocontent, "item" .. tostring(iter_9_2))
			local var_9_11 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_10, Activity130CollectItem)

			var_9_11:init(var_9_10)
			table.insert(arg_9_0._collectItems, var_9_11)
		end

		local var_9_12 = VersionActivity1_4Enum.ActivityId.Role37
		local var_9_13 = Activity130Config.instance:getActivity130OperateGroupCos(var_9_12, var_9_0)[var_9_5[iter_9_2]]

		arg_9_0._collectItems[iter_9_2]:setItem(var_9_13, iter_9_2)
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
