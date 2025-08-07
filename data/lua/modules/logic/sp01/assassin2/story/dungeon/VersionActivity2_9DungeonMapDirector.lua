module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapDirector", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapDirector", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0:initWorkMap()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_9DungeonController.instance, VersionActivity2_9Event.OnOneWorkLoadDone, arg_2_0._onOneWorkLoadDone, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_2_0._onChangeMap, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_2_0._onDisposeScene, arg_2_0)
end

function var_0_0.initWorkMap(arg_3_0)
	arg_3_0.statusMap = {}

	for iter_3_0, iter_3_1 in pairs(VersionActivity2_9DungeonEnum.LoadWorkType) do
		arg_3_0.statusMap[iter_3_1] = false
	end
end

function var_0_0._onChangeMap(arg_4_0)
	arg_4_0.statusMap[VersionActivity2_9DungeonEnum.LoadWorkType.Scene] = false
end

function var_0_0._onDisposeScene(arg_5_0)
	arg_5_0.statusMap[VersionActivity2_9DungeonEnum.LoadWorkType.Scene] = false
end

function var_0_0._onOneWorkLoadDone(arg_6_0, arg_6_1)
	arg_6_0.statusMap[arg_6_1] = true

	arg_6_0:checkIsAllWorkLoadDone()
end

function var_0_0.checkIsAllWorkLoadDone(arg_7_0)
	if not arg_7_0:isAllWorkLoadDone() then
		return
	end

	arg_7_0:onAllWorkLoadDone()
end

function var_0_0.onAllWorkLoadDone(arg_8_0)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnAllWorkLoadDone)
end

function var_0_0.isAllWorkLoadDone(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.statusMap) do
		if not iter_9_1 then
			return
		end
	end

	return true
end

return var_0_0
