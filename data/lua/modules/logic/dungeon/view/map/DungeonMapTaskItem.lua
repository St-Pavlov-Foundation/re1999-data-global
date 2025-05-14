module("modules.logic.dungeon.view.map.DungeonMapTaskItem", package.seeall)

local var_0_0 = class("DungeonMapTaskItem", DungeonMapTaskInfoItem)

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

	if arg_1_0:_showIcon(var_1_0) then
		DungeonMapTaskInfoItem.setIcon(arg_1_0._icon, arg_1_0._elementId, "zhuxianditu_renwuicon_")
		gohelper.setActive(arg_1_0._icon, true)
	else
		gohelper.setActive(arg_1_0._icon, false)
	end

	arg_1_0:refreshStatus()
end

function var_0_0._showIcon(arg_2_0, arg_2_1)
	if arg_2_1.type == DungeonEnum.ElementType.Investigate then
		return false
	end

	return true
end

function var_0_0.refreshStatus(arg_3_0)
	if DungeonMapModel.instance:elementIsFinished(arg_3_0._elementId) then
		local var_3_0 = GameUtil.parseColor("#272525b2")

		arg_3_0._txtinfo.color = var_3_0
		arg_3_0._txtprogress.color = var_3_0
		arg_3_0._icon.color = GameUtil.parseColor("#b2562b")
		arg_3_0._txtprogress.text = "1/1"
	else
		local var_3_1 = GameUtil.parseColor("#272525")

		arg_3_0._txtinfo.color = var_3_1
		arg_3_0._txtprogress.color = var_3_1
		arg_3_0._icon.color = GameUtil.parseColor("#81807f")
		arg_3_0._txtprogress.text = "0/1"
	end
end

function var_0_0.init(arg_4_0, arg_4_1)
	var_0_0.super.init(arg_4_0, arg_4_1)

	arg_4_0._txtprogress = gohelper.findChildText(arg_4_0.viewGO, "progress")
end

function var_0_0.addEventListeners(arg_5_0)
	return
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0.onStart(arg_7_0)
	return
end

function var_0_0.onDestroy(arg_8_0)
	return
end

return var_0_0
