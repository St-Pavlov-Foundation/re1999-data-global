module("modules.logic.dungeon.view.chapter.DungeonChapterUnlockItem", package.seeall)

local var_0_0 = class("DungeonChapterUnlockItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._gotemplate = gohelper.findChild(arg_1_0.viewGO, "#go_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	arg_4_0._config = arg_4_1
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:_showUnlockContent()
	arg_5_0:_showBeUnlockEpisode()
	gohelper.setActive(arg_5_0.viewGO, false)
	TaskDispatcher.runDelay(arg_5_0._delayShow, arg_5_0, 0.7)
end

function var_0_0._delayShow(arg_6_0)
	gohelper.setActive(arg_6_0.viewGO, true)
end

function var_0_0._showUnlockContent(arg_7_0)
	local var_7_0 = var_0_0.getUnlockContentList(arg_7_0._config.id)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = gohelper.clone(arg_7_0._gotemplate, arg_7_0._gocontainer)

		gohelper.setActive(var_7_1, true)

		local var_7_2 = gohelper.findChildTextMesh(var_7_1, "#txt_condition")
		local var_7_3 = gohelper.findChildImage(var_7_1, "#image_icon")

		UISpriteSetMgr.instance:setUiFBSprite(var_7_3, "jiesuo", true)

		var_7_2.text = iter_7_1
	end
end

function var_0_0.getUnlockContentList(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if DungeonModel.instance:isReactivityEpisode(arg_8_0) then
		return var_8_0
	end

	local var_8_1 = OpenConfig.instance:getOpenShowInEpisode(arg_8_0)

	if var_8_1 then
		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			local var_8_2 = lua_open.configDict[iter_8_1]
			local var_8_3

			if arg_8_1 and var_8_2 and var_8_2.bindActivityId ~= 0 then
				local var_8_4 = var_8_2.bindActivityId

				if ActivityHelper.getActivityStatus(var_8_4) == ActivityEnum.ActivityStatus.Normal then
					var_8_3 = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.ActivityOpen, iter_8_1)
				end
			else
				var_8_3 = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.Open, iter_8_1)
			end

			if var_8_3 then
				table.insert(var_8_0, var_8_3)
			end
		end
	end

	local var_8_5 = DungeonConfig.instance:getUnlockEpisodeList(arg_8_0)

	if var_8_5 then
		for iter_8_2, iter_8_3 in ipairs(var_8_5) do
			local var_8_6 = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.Episode, iter_8_3)

			if var_8_6 then
				table.insert(var_8_0, var_8_6)
			end
		end
	end

	local var_8_7 = OpenConfig.instance:getOpenGroupShowInEpisode(arg_8_0)

	if var_8_7 then
		for iter_8_4, iter_8_5 in ipairs(var_8_7) do
			local var_8_8 = DungeonModel.instance:getUnlockContent(DungeonEnum.UnlockContentType.OpenGroup, iter_8_5)

			if var_8_8 then
				table.insert(var_8_0, var_8_8)
			end
		end
	end

	return var_8_0
end

function var_0_0._showBeUnlockEpisode(arg_9_0)
	if arg_9_0._config.unlockEpisode <= 0 or DungeonModel.instance:hasPassLevelAndStory(arg_9_0._config.id) then
		return
	end

	local var_9_0 = gohelper.clone(arg_9_0._gotemplate, arg_9_0._gocontainer)

	gohelper.setActive(var_9_0, true)

	local var_9_1 = gohelper.findChildTextMesh(var_9_0, "#txt_condition")
	local var_9_2 = gohelper.findChildImage(var_9_0, "#image_icon")

	UISpriteSetMgr.instance:setUiFBSprite(var_9_2, "suo1", true)

	local var_9_3 = DungeonConfig.instance:getEpisodeCO(arg_9_0._config.unlockEpisode)

	var_9_1.text = formatLuaLang("dungeon_unlock_episode", string.format("%s %s", DungeonController.getEpisodeName(var_9_3), var_9_3.name))
end

function var_0_0._editableAddEvents(arg_10_0)
	return
end

function var_0_0._editableRemoveEvents(arg_11_0)
	return
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	return
end

function var_0_0.onSelect(arg_13_0, arg_13_1)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayShow, arg_14_0)
end

return var_0_0
