module("modules.logic.dungeon.view.map.DungeonMapTaskInfoItem", package.seeall)

local var_0_0 = class("DungeonMapTaskInfoItem", LuaCompBase)

function var_0_0.setParam(arg_1_0, arg_1_1)
	if arg_1_0._anim and (not arg_1_0.viewGO.activeInHierarchy or arg_1_0._elementId ~= arg_1_1[2]) then
		arg_1_0._anim:Play("taskitem_in", 0, 0)
	end

	arg_1_0._index = arg_1_1[1]
	arg_1_0._elementId = arg_1_1[2]

	local var_1_0 = lua_chapter_map_element.configDict[arg_1_0._elementId]

	if not var_1_0 then
		logError("元件表找不到元件id:" .. arg_1_0._elementId)
	end

	arg_1_0._txtinfo.text = var_1_0.title

	var_0_0.setIcon(arg_1_0._icon, arg_1_0._elementId, "zhuxianditu_renwuicon_")
	arg_1_0:refreshStatus()
end

function var_0_0.setIcon(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = lua_chapter_map_element.configDict[arg_2_1]
	local var_2_1 = DungeonMapModel.instance:elementIsFinished(arg_2_1)
	local var_2_2 = DungeonEnum.ElementTypeUIResIdMap[var_2_0.type] or var_2_0.type

	UISpriteSetMgr.instance:setUiFBSprite(arg_2_0, arg_2_2 .. var_2_2 .. (var_2_1 and 1 or 0))
end

function var_0_0.refreshStatus(arg_3_0)
	if DungeonMapModel.instance:elementIsFinished(arg_3_0._elementId) then
		local var_3_0 = GameUtil.parseColor("#c66030")

		arg_3_0._txtinfo.color = var_3_0
		arg_3_0._icon.color = var_3_0
	else
		arg_3_0._txtinfo.color = GameUtil.parseColor("#ded9d4")
		arg_3_0._icon.color = GameUtil.parseColor("#a1a3a6")
	end
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.viewGO = arg_4_1
	arg_4_0._txtinfo = gohelper.findChildText(arg_4_0.viewGO, "info")
	arg_4_0._icon = gohelper.findChildImage(arg_4_1, "icon")
	arg_4_0._anim = arg_4_1:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.playTaskOutAnim(arg_5_0)
	if arg_5_0.viewGO.activeInHierarchy then
		arg_5_0._anim:Play("taskitem_out")
		TaskDispatcher.cancelTask(arg_5_0._hideGo, arg_5_0)
		TaskDispatcher.runDelay(arg_5_0._hideGo, arg_5_0, 0.24)
	end
end

function var_0_0._hideGo(arg_6_0)
	gohelper.setActive(arg_6_0.viewGO, false)
end

function var_0_0.addEventListeners(arg_7_0)
	arg_7_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_7_0._setEpisodeListVisible, arg_7_0)
end

function var_0_0.removeEventListeners(arg_8_0)
	return
end

function var_0_0._setEpisodeListVisible(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0._anim:Play("taskitem_in", 0, 0)
	else
		arg_9_0._anim:Play("taskitem_out", 0, 0)
	end
end

function var_0_0.onStart(arg_10_0)
	return
end

function var_0_0.onDestroy(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._hideGo, arg_11_0)
end

function var_0_0._playEnterAnim(arg_12_0, arg_12_1)
	if arg_12_1 == ViewName.DungeonMapTaskView then
		arg_12_0._anim:Play("taskitem_in", 0, 0)
	end
end

function var_0_0._playOutAnim(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.DungeonMapTaskView then
		arg_13_0._anim:Play("taskitem_out", 0, 0)
	end
end

return var_0_0
