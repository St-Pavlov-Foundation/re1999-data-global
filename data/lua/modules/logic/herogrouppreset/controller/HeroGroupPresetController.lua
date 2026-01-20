-- chunkname: @modules/logic/herogrouppreset/controller/HeroGroupPresetController.lua

module("modules.logic.herogrouppreset.controller.HeroGroupPresetController", package.seeall)

local HeroGroupPresetController = class("HeroGroupPresetController", BaseController)

function HeroGroupPresetController:onInit()
	return
end

function HeroGroupPresetController:onInitFinish()
	return
end

function HeroGroupPresetController:addConstEvents()
	return
end

function HeroGroupPresetController:reInit()
	return
end

function HeroGroupPresetController:updateFightHeroGroup()
	if self:isFightScene() then
		HeroGroupModel.instance:_setSingleGroup()
	end
end

function HeroGroupPresetController:isFightScene()
	return GameSceneMgr.instance:isFightScene()
end

function HeroGroupPresetController:isFightShowType()
	return self._showType == HeroGroupPresetEnum.ShowType.Fight
end

function HeroGroupPresetController:useTrial()
	return GameSceneMgr.instance:isFightScene()
end

function HeroGroupPresetController:getHeroGroupTypeList()
	return self._heroGroupTypeList
end

function HeroGroupPresetController:getSelectedSubId()
	return self._subId
end

function HeroGroupPresetController.snapshotUsePreset(snapshotType)
	if not snapshotType then
		return
	end

	for k, v in pairs(HeroGroupPresetEnum.HeroGroupType2SnapshotType) do
		if snapshotType == v then
			return HeroGroupPresetEnum.HeroGroupSnapshotTypeOpen[k]
		end
	end
end

function HeroGroupPresetController:openHeroGroupPresetTeamView(param, isImmediate)
	self._showType = param and param.showType or HeroGroupPresetEnum.ShowType.Normal
	self._heroGroupTypeList = param and param.heroGroupTypeList
	self._subId = param and param.subId

	if not self:isFightScene() then
		HeroGroupModel.instance.episodeId = nil

		HeroGroupModel.instance:initRestrictHeroData()
		HeroGroupTrialModel.instance:clear()
		TowerModel.instance:clearRecordFightParam()
		FightModel.instance:setFightParam(FightParam.New())
	end

	ViewMgr.instance:closeView(ViewName.HeroGroupPresetTeamView)
	HeroGroupPresetController.instance:closeHeroGroupPresetEditView()
	ViewMgr.instance:openView(ViewName.HeroGroupPresetTeamView, param, isImmediate)
end

function HeroGroupPresetController:closeHeroGroupPresetEditView()
	ViewMgr.instance:closeView(ViewName.HeroGroupPresetEditView)
end

function HeroGroupPresetController:openHeroGroupPresetEditView(param, isImmediate)
	HeroGroupPresetController.instance:closeHeroGroupPresetEditView()
	ViewMgr.instance:openView(ViewName.HeroGroupPresetEditView, param, isImmediate)
end

function HeroGroupPresetController:openHeroGroupPresetModifyNameView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.HeroGroupPresetModifyNameView, param, isImmediate)
end

function HeroGroupPresetController:initCopyHeroGroupList()
	if not self:isFightScene() then
		return
	end

	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not heroGroupType then
		return
	end

	self._copyList = {}

	local list = HeroGroupPresetHeroGroupChangeController.instance:getHeroGroupList(heroGroupType)

	if list then
		for _, v in pairs(list) do
			local heroGroupMO = HeroGroupMO.New()

			heroGroupMO:init(v)
			table.insert(self._copyList, heroGroupMO)
		end
	end
end

function HeroGroupPresetController:getHeroGroupCopyList(heroGroupType)
	if self:isFightScene() and HeroGroupModel.instance:getPresetHeroGroupType() == heroGroupType and self._copyList then
		local list = {}

		for _, v in pairs(self._copyList) do
			local heroGroupMO = HeroGroupMO.New()

			heroGroupMO:init(v)
			table.insert(list, heroGroupMO)
		end

		return list
	end
end

function HeroGroupPresetController:deleteHeroGroupCopy(snapshotId, snapshotSubId)
	if not self:isFightScene() then
		return
	end

	if not self._copyList then
		return
	end

	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not heroGroupType then
		return
	end

	local heroGroupSnapShotId = HeroGroupPresetEnum.HeroGroupType2SnapshotAllType[heroGroupType]

	if heroGroupSnapShotId ~= snapshotId then
		logError(string.format("HeroGroupPresetController:deleteHeroGroupCopy error heroGroupSnapShotId:%s,snapshotId:%s", heroGroupSnapShotId, snapshotId))

		return
	end

	for i, v in ipairs(self._copyList) do
		if v.groupId == snapshotSubId then
			table.remove(self._copyList, i)

			return
		end
	end

	logError(string.format("HeroGroupPresetController:deleteHeroGroupCopy error heroGroupSnapShotId:%s,snapshotSubId:%s", heroGroupSnapShotId, snapshotSubId))
end

function HeroGroupPresetController:addHeroGroupCopy(snapshotId, snapshotSubId, heroGroupMo)
	if not self:isFightScene() then
		return
	end

	if not self._copyList then
		return
	end

	local heroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not heroGroupType then
		return
	end

	local heroGroupSnapShotId = HeroGroupPresetEnum.HeroGroupType2SnapshotAllType[heroGroupType]

	if heroGroupSnapShotId ~= snapshotId then
		logError(string.format("HeroGroupPresetController:addHeroGroupCopy error heroGroupSnapShotId:%s,snapshotId:%s", heroGroupSnapShotId, snapshotId))

		return
	end

	for i, v in ipairs(self._copyList) do
		if v.groupId == snapshotSubId then
			table.remove(self._copyList, i)
			logError(string.format("HeroGroupPresetController:addHeroGroupCopy remove error heroGroupSnapShotId:%s,snapshotSubId:%s", heroGroupSnapShotId, snapshotSubId))

			break
		end
	end

	table.insert(self._copyList, heroGroupMo)
end

function HeroGroupPresetController:revertCurHeroGroup()
	if not self:isFightScene() then
		return
	end

	if not self._copyList then
		return
	end

	local presetHeroGroupType = HeroGroupModel.instance:getPresetHeroGroupType()

	if not presetHeroGroupType then
		return
	end

	local heroGroupType = HeroGroupModel.instance.heroGroupType

	if heroGroupType == ModuleEnum.HeroGroupType.Temp or heroGroupType == ModuleEnum.HeroGroupType.Trial then
		return
	end

	local curHeroGroup = HeroGroupModel.instance:getCurGroupMO()

	if not curHeroGroup or not curHeroGroup.groupId then
		return
	end

	local copyListStr = ""

	for i, v in ipairs(self._copyList) do
		copyListStr = string.format("%s#%s", copyListStr, v.groupId)

		if v.groupId == curHeroGroup.groupId then
			local name = curHeroGroup.name

			curHeroGroup:init(v)

			curHeroGroup.name = name

			return
		end
	end

	logError(string.format("HeroGroupPresetController:revertCurHeroGroup error presetHeroGroupType:%s,heroGroupType:%s,snapshotSubId:%s,copyList:%s", presetHeroGroupType, heroGroupType, curHeroGroup.groupId, copyListStr))
end

function HeroGroupPresetController:clearCopyList()
	self._copyList = nil
end

HeroGroupPresetController.instance = HeroGroupPresetController.New()

return HeroGroupPresetController
