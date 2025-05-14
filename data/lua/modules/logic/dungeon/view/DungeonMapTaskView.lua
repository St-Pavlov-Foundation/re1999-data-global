module("modules.logic.dungeon.view.DungeonMapTaskView", package.seeall)

local var_0_0 = class("DungeonMapTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._gotasklist = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist")
	arg_1_0._gotaskitem = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_taskitem")
	arg_1_0._txtopen = gohelper.findChildText(arg_1_0.viewGO, "#go_tipbg/#txt_open")
	arg_1_0._gotipsbg = gohelper.findChild(arg_1_0.viewGO, "#go_tipbg")

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
	arg_5_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_5_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickGuidepost)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	local var_7_0 = arg_7_0.viewParam.viewParam

	arg_7_0:_showTaskList(var_7_0)

	local var_7_1 = DungeonConfig.instance:getUnlockEpisodeId(var_7_0)
	local var_7_2 = lua_episode.configDict[var_7_1]
	local var_7_3 = DungeonConfig.instance:getChapterCO(var_7_2.chapterId)

	if var_7_2 and var_7_3 then
		local var_7_4 = var_7_3.chapterIndex
		local var_7_5, var_7_6 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_7_3.id, var_7_2.id)

		if var_7_6 == DungeonEnum.EpisodeType.Sp then
			var_7_4 = "SP"
		end

		local var_7_7 = string.format("%s-%s", var_7_4, var_7_5)

		arg_7_0._txtopen.text = string.format(lua_language_coder.configDict.dungeonmaptaskview_open.lang)
	end
end

function var_0_0._showTaskList(arg_8_0, arg_8_1)
	local var_8_0 = DungeonConfig.instance:getElementList(arg_8_1)
	local var_8_1 = string.splitToNumber(var_8_0, "#")

	arg_8_0._listCount = #var_8_1

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = gohelper.cloneInPlace(arg_8_0._gotaskitem)
		local var_8_3 = MonoHelper.addLuaComOnceToGo(var_8_2, DungeonMapTaskItem)

		var_8_3:setParam({
			iter_8_0,
			iter_8_1
		})
		gohelper.setActive(var_8_3.viewGO, true)
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageleftbg:UnLoadImage()
	arg_10_0._simagerightbg:UnLoadImage()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, true)
end

return var_0_0
