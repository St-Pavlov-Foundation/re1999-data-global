module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapNodeItem", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapNodeItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._index = arg_1_1 and arg_1_1.index
	arg_1_0._gomesh = arg_1_1 and arg_1_1.meshGO
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._goselectnode = gohelper.findChild(arg_2_0.go, "select")
	arg_2_0._gounselectnode = gohelper.findChild(arg_2_0.go, "unselect")
	arg_2_0._gonode = gohelper.cloneInPlace(arg_2_0._gounselectnode, "current")
	arg_2_0._trannode = arg_2_0._gonode.transform
	arg_2_0._transelectnode = arg_2_0._goselectnode.transform
	arg_2_0._tranunselectnode = arg_2_0._gounselectnode.transform
	arg_2_0._animator = gohelper.onceAddComponent(arg_2_0._gomesh, gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_3_0)
	return
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.brocastPosition(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = arg_5_0:getNodeWorldPos()

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnUpdateEpisodeNodePos, arg_5_0._index, var_5_0, var_5_1, var_5_2)
end

function var_0_0.getNodeLocalPos(arg_6_0)
	return transformhelper.getLocalPos(arg_6_0._trannode)
end

function var_0_0.getNodeWorldPos(arg_7_0)
	return transformhelper.getPos(arg_7_0._trannode)
end

function var_0_0.onSelect(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 and "selection_open" or "selection_close"

	arg_8_0._animator:Play(var_8_0, 0, 0)
	arg_8_0:tweenMoveNodePos(arg_8_1)

	if arg_8_1 then
		AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_selectEpisode)
	end
end

function var_0_0.tweenMoveNodePos(arg_9_0, arg_9_1)
	arg_9_0:_killNodeMoveTween()

	local var_9_0, var_9_1, var_9_2 = arg_9_0:getNodeLocalPos()
	local var_9_3 = arg_9_1 and arg_9_0._transelectnode or arg_9_0._tranunselectnode
	local var_9_4, var_9_5, var_9_6 = transformhelper.getLocalPos(var_9_3)
	local var_9_7 = VersionActivity2_9DungeonEnum.EpisodeSelectDuration

	arg_9_0._tweenId_x = ZProj.TweenHelper.DOTweenFloat(var_9_0, var_9_4, var_9_7, arg_9_0._tweenMoveNodePosXFrameCb, arg_9_0._tweenMoveNodePosDone, arg_9_0)
	arg_9_0._tweenId_y = ZProj.TweenHelper.DOTweenFloat(var_9_1, var_9_5, var_9_7, arg_9_0._tweenMoveNodePosYFrameCb, arg_9_0._tweenMoveNodePosDone, arg_9_0)
	arg_9_0._tweenId_z = ZProj.TweenHelper.DOTweenFloat(var_9_2, var_9_6, var_9_7, arg_9_0._tweenMoveNodePosZFrameCb, arg_9_0._tweenMoveNodePosDone, arg_9_0)
end

function var_0_0._tweenMoveNodePosXFrameCb(arg_10_0, arg_10_1)
	local var_10_0, var_10_1, var_10_2 = arg_10_0:getNodeLocalPos()

	transformhelper.setLocalPos(arg_10_0._trannode, arg_10_1, var_10_1, var_10_2)
	arg_10_0:brocastPosition()
end

function var_0_0._tweenMoveNodePosYFrameCb(arg_11_0, arg_11_1)
	local var_11_0, var_11_1, var_11_2 = arg_11_0:getNodeLocalPos()

	transformhelper.setLocalPos(arg_11_0._trannode, var_11_0, arg_11_1, var_11_2)
	arg_11_0:brocastPosition()
end

function var_0_0._tweenMoveNodePosZFrameCb(arg_12_0, arg_12_1)
	local var_12_0, var_12_1 = arg_12_0:getNodeLocalPos()

	transformhelper.setLocalPos(arg_12_0._trannode, var_12_0, var_12_1, arg_12_1)
	arg_12_0:brocastPosition()
end

function var_0_0._tweenMoveNodePosDone(arg_13_0)
	return
end

function var_0_0._killNodeMoveTween(arg_14_0)
	if arg_14_0._tweenId_x then
		ZProj.TweenHelper.KillById(arg_14_0._tweenId_x)

		arg_14_0._tweenId_x = nil
	end

	if arg_14_0._tweenId_y then
		ZProj.TweenHelper.KillById(arg_14_0._tweenId_y)

		arg_14_0._tweenId_y = nil
	end

	if arg_14_0._tweenId_z then
		ZProj.TweenHelper.KillById(arg_14_0._tweenId_z)

		arg_14_0._tweenId_z = nil
	end
end

function var_0_0.onDestroy(arg_15_0)
	arg_15_0:_killNodeMoveTween()

	arg_15_0._gomesh = nil
end

return var_0_0
