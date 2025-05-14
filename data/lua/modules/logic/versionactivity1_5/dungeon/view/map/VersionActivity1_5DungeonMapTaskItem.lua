module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapTaskItem", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapTaskItem", DungeonMapTaskItem)

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

	local var_1_1 = VersionActivity1_5DungeonConfig.instance:getSubHeroTaskCoByElementId(arg_1_0._elementId)

	if var_1_1 then
		arg_1_0._txtinfo.text = var_1_1.title
	else
		arg_1_0._txtinfo.text = var_1_0.title
	end

	DungeonMapTaskInfoItem.setIcon(arg_1_0._icon, arg_1_0._elementId, "zhuxianditu_renwuicon_")
	arg_1_0:refreshStatus()
end

return var_0_0
