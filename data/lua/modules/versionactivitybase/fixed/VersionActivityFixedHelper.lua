-- chunkname: @modules/versionactivitybase/fixed/VersionActivityFixedHelper.lua

module("modules.versionactivitybase.fixed.VersionActivityFixedHelper", package.seeall)

local VersionActivityFixedHelper = class("VersionActivityFixedHelper")
local _version = {
	big = 3,
	small = 4
}
local _versionTable
local foramt1 = "%s_%s"
local foramt2 = "V%sa%s"
local foramt3 = "v%sa%s"

local function _getVersion(big, small)
	return big or _version.big, small or _version.small
end

local function _getVersionFuncForamt(funcName, foramt, big, small)
	big, small = _getVersion(big, small)

	local _format = string.format(foramt, big, small)

	return string.format(funcName, _format)
end

local function _getVersionTable(big, small)
	big, small = _getVersion(big, small)

	if not _versionTable then
		_versionTable = {}
	end

	if not _versionTable[big] then
		_versionTable[big] = {}
	end

	if not _versionTable[big][small] then
		_versionTable[big][small] = {}
	end

	return _versionTable[big][small]
end

function VersionActivityFixedHelper.setMainActivitySprite(image, name, setNativeSize, big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._MainActivitySpriteFunc

	if not func then
		func = _getVersionFuncForamt("set%sMainActivitySprite", foramt2, big, small)
		_versionTable[big][small]._MainActivitySpriteFunc = func
	end

	UISpriteSetMgr.instance[func](UISpriteSetMgr.instance, image, name, setNativeSize)
end

function VersionActivityFixedHelper.setDungeonSprite(image, name, setNativeSize, big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonSpriteFunc

	if not func then
		func = _getVersionFuncForamt("set%sDungeonSprite", foramt2, big, small)
		_versionTable[big][small]._DungeonSpriteFunc = func
	end

	UISpriteSetMgr.instance[func](UISpriteSetMgr.instance, image, name, setNativeSize)
end

function VersionActivityFixedHelper.setCustomDungeonStore(id)
	VersionActivityFixedHelper._customDungeonStore = id
end

function VersionActivityFixedHelper.getVersionActivityDungeonStore(big, small)
	if VersionActivityFixedHelper._customDungeonStore then
		return VersionActivityFixedHelper._customDungeonStore
	end

	return VersionActivityFixedHelper.getVersionActivityEnum(big, small).ActivityId.DungeonStore
end

function VersionActivityFixedHelper.getVersionActivityEnum(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._Enum

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sEnum", foramt1, big, small)

		func = _G[title]
		_versionTable[big][small]._Enum = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityEnterViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._EnterViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sEnterView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._EnterViewName = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityStoreViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._StoreViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sStoreView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._StoreViewName = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityTaskViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._TaskViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sTaskView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._TaskViewName = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonEnum(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonEnum

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonEnum", foramt1, big, small)

		func = _G[title]
		_versionTable[big][small]._DungeonEnum = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonMapViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonMapView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._DungeonMapViewName = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonMapLevelView

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonMapLevelView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._DungeonMapLevelView = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonEnterReddotId(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonEnter

	if not func then
		local title = _getVersionFuncForamt("%sDungeonEnter", foramt2, big, small)

		func = RedDotEnum.DotNode[title]
		_versionTable[big][small]._DungeonEnter = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonTaskReddotId(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonTask

	if not func then
		local title = _getVersionFuncForamt("%sDungeonTask", foramt2, big, small)

		func = RedDotEnum.DotNode[title]
		_versionTable[big][small]._DungeonTask = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityCurrencyType(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._CurrencyType

	if not func then
		local title = _getVersionFuncForamt("%sDungeon", foramt2, big, small)

		func = CurrencyEnum.CurrencyType[title]
		_versionTable[big][small]._CurrencyType = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._AudioBgmLayer

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sMain", foramt1, big, small)

		func = AudioBgmEnum.Layer[title]
		_versionTable[big][small]._AudioBgmLayer = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityStoreRareIcon(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._StoreRareIcon

	if not func then
		func = _getVersionFuncForamt("%s_store_quality_", foramt3, big, small)
		_versionTable[big][small]._StoreRareIcon = func
	end

	return func
end

function VersionActivityFixedHelper._getFixed(big, small, name)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table[name]

	if not func then
		local _format = "VersionActivity%s" .. name
		local title = _getVersionFuncForamt(_format, foramt1, big, small)
		local fixedTitle = string.format(_format, "Fixed")

		func = _G[title] or _G[fixedTitle]
		_versionTable[big][small][name] = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityEnterController(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterController")
end

function VersionActivityFixedHelper.getVersionActivityDungeonController(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonController")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapElement(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapElement")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapHoleView")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapScene(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapScene")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapSceneElements")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapChapterLayout(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapChapterLayout")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeItem(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapEpisodeItem")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapEpisodeView")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapFinishElement(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapFinishElement")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapInteractView")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapView")
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapLevelView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapLevelView")
end

function VersionActivityFixedHelper.getVersionActivityStoreGoodsItem(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "StoreGoodsItem")
end

function VersionActivityFixedHelper.getVersionActivityStoreItem(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "StoreItem")
end

function VersionActivityFixedHelper.getVersionActivityStoreView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "StoreView")
end

function VersionActivityFixedHelper.getVersionActivityTaskItem(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "TaskItem")
end

function VersionActivityFixedHelper.getVersionActivityTaskView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "TaskView")
end

function VersionActivityFixedHelper.getVersionActivityDungeonEnterView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonEnterView")
end

function VersionActivityFixedHelper.getVersionActivitySubAnimatorComp(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "SubAnimatorComp")
end

function VersionActivityFixedHelper.getVersionActivityEnterBgmView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterBgmView")
end

function VersionActivityFixedHelper.getVersionActivityEnterView(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterView")
end

function VersionActivityFixedHelper.getVersionActivityEnterViewTabItem1(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterViewTabItem1")
end

function VersionActivityFixedHelper.getVersionActivityEnterViewTabItem2(big, small)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterViewTabItem2")
end

function VersionActivityFixedHelper.isTargetVersion(big, small)
	return _version.big == big and _version.small == small
end

return VersionActivityFixedHelper
