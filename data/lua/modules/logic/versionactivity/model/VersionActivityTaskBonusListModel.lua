module("modules.logic.versionactivity.model.VersionActivityTaskBonusListModel", package.seeall)

slot0 = class("VersionActivityTaskBonusListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0.taskActivityMo = nil
end

function slot0.initTaskBonusList(slot0)
end

function slot0.refreshList(slot0)
	slot0:setList(TaskConfig.instance:getTaskActivityBonusConfig(TaskEnum.TaskType.ActivityDungeon))
end

function slot0.getTaskActivityMo(slot0)
	if not slot0.taskActivityMo then
		slot0.taskActivityMo = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon)
	end

	return slot0.taskActivityMo
end

function slot0.recordPrefixActivityPointCount(slot0)
	slot0.prefixActivityPointCount = slot0:getTaskActivityMo().value
end

function slot0.checkActivityPointCountHasChange(slot0)
	return slot0.prefixActivityPointCount ~= slot0:getTaskActivityMo().value
end

function slot0.checkNeedPlayEffect(slot0, slot1, slot2)
	return slot0.prefixActivityPointCount < TaskConfig.instance:getTaskBonusValue(TaskEnum.TaskType.ActivityDungeon, slot1, slot2) and slot3 <= slot0:getTaskActivityMo().value
end

slot0.instance = slot0.New()

return slot0
