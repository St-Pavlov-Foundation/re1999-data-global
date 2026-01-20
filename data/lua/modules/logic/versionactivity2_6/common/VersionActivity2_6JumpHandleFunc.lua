-- chunkname: @modules/logic/versionactivity2_6/common/VersionActivity2_6JumpHandleFunc.lua

module("modules.logic.versionactivity2_6.common.VersionActivity2_6JumpHandleFunc", package.seeall)

local VersionActivity2_6JumpHandleFunc = class("VersionActivity2_6JumpHandleFunc")

function VersionActivity2_6JumpHandleFunc:jumpTo11815(paramsList)
	local isOpenFactoryBlueprint = paramsList and paramsList[3] == 2

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_6EnterView)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_8DungeonMapView)
	table.insert(self.waitOpenViewNames, ViewName.VersionActivity1_8FactoryMapView)

	if not isOpenFactoryBlueprint then
		table.insert(self.closeViewNames, ViewName.VersionActivity1_8FactoryBlueprintView)
	end

	local function openFactoryFunc()
		Activity157Controller.instance:openFactoryMapView(isOpenFactoryBlueprint)
	end

	local function openDungeonMapFunc()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8DungeonMapView) then
			openFactoryFunc()
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, openFactoryFunc)
		end
	end

	VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(openDungeonMapFunc, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo11804(paramsList)
	local actId = paramsList[2]
	local episodeId = paramsList[3]

	table.insert(self.waitOpenViewNames, ViewName.VersionActivity2_6EnterView)
	table.insert(self.closeViewNames, ViewName.VersionActivity1_8DungeonMapLevelView)

	if episodeId then
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, episodeId, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					isJump = true,
					episodeId = episodeId
				})
			end)
		end, nil, actId, true)
	else
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openVersionActivityDungeonMapView, VersionActivity1_8DungeonController.instance, actId, true)
	end

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12601()
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12602(paramsList)
	local actId = paramsList[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12605(paramsList)
	local actId = paramsList[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12603(paramsList)
	VersionActivity2_6DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12606(paramsList)
	local actId = paramsList[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

function VersionActivity2_6JumpHandleFunc:jumpTo12618(paramsList)
	local actId = paramsList[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, actId)

	return JumpEnum.JumpResult.Success
end

return VersionActivity2_6JumpHandleFunc
