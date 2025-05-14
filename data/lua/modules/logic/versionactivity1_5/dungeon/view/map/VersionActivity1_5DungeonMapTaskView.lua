module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskView", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg")
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
	arg_5_0._simagebg:LoadImage(ResUrl.getV1a5DungeonSingleBg("v1a5_dungeonmaptask_tipbg"))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.episodeId

	arg_7_0:_showTaskList(var_7_0)

	arg_7_0._txtopen.text = luaLang("v1a5_revival_task_finish_tip")
end

function var_0_0._showTaskList(arg_8_0, arg_8_1)
	local var_8_0 = DungeonConfig.instance:getEpisodeCO(arg_8_1).elementList

	if string.nilorempty(var_8_0) then
		return
	end

	local var_8_1 = string.splitToNumber(var_8_0, "#")

	arg_8_0._listCount = #var_8_1

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		local var_8_2 = gohelper.cloneInPlace(arg_8_0._gotaskitem)
		local var_8_3 = MonoHelper.addLuaComOnceToGo(var_8_2, VersionActivity1_5DungeonMapTaskItem)

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
	arg_10_0._simagebg:UnLoadImage()
end

return var_0_0
