module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapChapterLayout", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapChapterLayout", VersionActivityFixedDungeonMapChapterLayout)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._gotimeline = gohelper.findChild(arg_1_0.viewGO, "timeline")

	gohelper.setActive(arg_1_0._gotimeline, false)

	arg_1_0._nodeVectorList = {}
	arg_1_0._nodeScreenPosList = {}
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnAllWorkLoadDone, arg_2_0._onAllWorkLoadDone, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnUpdateEpisodeNodePos, arg_2_0._onUpdateEpisodeNodePos, arg_2_0)
end

function var_0_0._onUpdateEpisodeNodePos(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0:_saveEpisodeNodePos(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0:_setEpisodeItemAnchorX(arg_3_1)
end

function var_0_0._saveEpisodeNodePos(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = arg_4_0._nodeVectorList[arg_4_1]

	if not var_4_0 then
		var_4_0 = Vector2()

		table.insert(arg_4_0._nodeVectorList, var_4_0)
	end

	local var_4_1, var_4_2 = recthelper.worldPosToAnchorPosXYZ(arg_4_2, arg_4_3, arg_4_4, arg_4_0.contentTransform)

	var_4_0:Set(var_4_1, var_4_2)
end

function var_0_0._onAllWorkLoadDone(arg_5_0)
	if arg_5_0._isInited then
		return
	end

	arg_5_0:refreshEpisodeNodes()

	arg_5_0._isInited = true
end

function var_0_0._setEpisodeItemAnchorX(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._episodeContainerItemList and arg_6_0._episodeContainerItemList[arg_6_1]
	local var_6_1 = arg_6_0._nodeVectorList and arg_6_0._nodeVectorList[arg_6_1]

	if not var_6_0 or not var_6_1 then
		return
	end

	recthelper.setAnchor(var_6_0.containerTr, var_6_1.x, var_6_1.y)
end

function var_0_0.refreshEpisodeNodes(arg_7_0)
	var_0_0.super.refreshEpisodeNodes(arg_7_0)

	arg_7_0._lastEpisodeIndex = arg_7_0._episodeContainerItemList and #arg_7_0._episodeContainerItemList or 0
	arg_7_0._contentWidth = 100000

	recthelper.setSize(arg_7_0.contentTransform, arg_7_0._contentWidth, arg_7_0._rawHeight)
end

function var_0_0.setFocusItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 then
		return
	end

	local var_8_0 = arg_8_0:_getEpisodeItemIndex(arg_8_1)

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.FocusEpisodeNode, var_8_0, arg_8_2)
end

function var_0_0._getEpisodeItemIndex(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._episodeContainerItemList) do
		if iter_9_1.episodeItem.viewGO == arg_9_1 then
			return iter_9_0
		end
	end
end

function var_0_0.tryClickDNA(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._episodeContainerItemList) do
		if iter_10_1.episodeItem:isScreenPosInDNAClickArea(arg_10_1) then
			iter_10_1.episodeItem:onClick()

			return true
		end
	end
end

return var_0_0
