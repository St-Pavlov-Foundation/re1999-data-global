module("modules.versionactivitybase.fixed.VersionActivityFixedHelper", package.seeall)

local var_0_0 = class("VersionActivityFixedHelper")
local var_0_1 = {
	big = 2,
	small = 9
}
local var_0_2
local var_0_3 = "%s_%s"
local var_0_4 = "V%sa%s"
local var_0_5 = "v%sa%s"

local function var_0_6(arg_1_0, arg_1_1)
	return arg_1_0 or var_0_1.big, arg_1_1 or var_0_1.small
end

local function var_0_7(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_2, arg_2_3 = var_0_6(arg_2_2, arg_2_3)

	local var_2_0 = string.format(arg_2_1, arg_2_2, arg_2_3)

	return string.format(arg_2_0, var_2_0)
end

local function var_0_8(arg_3_0, arg_3_1)
	arg_3_0, arg_3_1 = var_0_6(arg_3_0, arg_3_1)

	if not var_0_2 then
		var_0_2 = {}
	end

	if not var_0_2[arg_3_0] then
		var_0_2[arg_3_0] = {}
	end

	if not var_0_2[arg_3_0][arg_3_1] then
		var_0_2[arg_3_0][arg_3_1] = {}
	end

	return var_0_2[arg_3_0][arg_3_1]
end

function var_0_0.setMainActivitySprite(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_3, arg_4_4 = var_0_6(arg_4_3, arg_4_4)

	local var_4_0 = var_0_8(arg_4_3, arg_4_4)._MainActivitySpriteFunc

	if not var_4_0 then
		var_4_0 = var_0_7("set%sMainActivitySprite", var_0_4, arg_4_3, arg_4_4)
		var_0_2[arg_4_3][arg_4_4]._MainActivitySpriteFunc = var_4_0
	end

	UISpriteSetMgr.instance[var_4_0](UISpriteSetMgr.instance, arg_4_0, arg_4_1, arg_4_2)
end

function var_0_0.setDungeonSprite(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_3, arg_5_4 = var_0_6(arg_5_3, arg_5_4)

	local var_5_0 = var_0_8(arg_5_3, arg_5_4)._DungeonSpriteFunc

	if not var_5_0 then
		var_5_0 = var_0_7("set%sDungeonSprite", var_0_4, arg_5_3, arg_5_4)
		var_0_2[arg_5_3][arg_5_4]._DungeonSpriteFunc = var_5_0
	end

	UISpriteSetMgr.instance[var_5_0](UISpriteSetMgr.instance, arg_5_0, arg_5_1, arg_5_2)
end

function var_0_0.getVersionActivityEnum(arg_6_0, arg_6_1)
	arg_6_0, arg_6_1 = var_0_6(arg_6_0, arg_6_1)

	local var_6_0 = var_0_8(arg_6_0, arg_6_1)._Enum

	if not var_6_0 then
		local var_6_1 = var_0_7("VersionActivity%sEnum", var_0_3, arg_6_0, arg_6_1)

		var_6_0 = _G[var_6_1]
		var_0_2[arg_6_0][arg_6_1]._Enum = var_6_0
	end

	return var_6_0
end

function var_0_0.getVersionActivityEnterViewName(arg_7_0, arg_7_1)
	arg_7_0, arg_7_1 = var_0_6(arg_7_0, arg_7_1)

	local var_7_0 = var_0_8(arg_7_0, arg_7_1)._EnterViewName

	if not var_7_0 then
		local var_7_1 = var_0_7("VersionActivity%sEnterView", var_0_3, arg_7_0, arg_7_1)

		var_7_0 = ViewName[var_7_1]
		var_0_2[arg_7_0][arg_7_1]._EnterViewName = var_7_0
	end

	return var_7_0
end

function var_0_0.getVersionActivityStoreViewName(arg_8_0, arg_8_1)
	arg_8_0, arg_8_1 = var_0_6(arg_8_0, arg_8_1)

	local var_8_0 = var_0_8(arg_8_0, arg_8_1)._StoreViewName

	if not var_8_0 then
		local var_8_1 = var_0_7("VersionActivity%sStoreView", var_0_3, arg_8_0, arg_8_1)

		var_8_0 = ViewName[var_8_1]
		var_0_2[arg_8_0][arg_8_1]._StoreViewName = var_8_0
	end

	return var_8_0
end

function var_0_0.getVersionActivityTaskViewName(arg_9_0, arg_9_1)
	arg_9_0, arg_9_1 = var_0_6(arg_9_0, arg_9_1)

	local var_9_0 = var_0_8(arg_9_0, arg_9_1)._TaskViewName

	if not var_9_0 then
		local var_9_1 = var_0_7("VersionActivity%sTaskView", var_0_3, arg_9_0, arg_9_1)

		var_9_0 = ViewName[var_9_1]
		var_0_2[arg_9_0][arg_9_1]._TaskViewName = var_9_0
	end

	return var_9_0
end

function var_0_0.getVersionActivityDungeonEnum(arg_10_0, arg_10_1)
	arg_10_0, arg_10_1 = var_0_6(arg_10_0, arg_10_1)

	local var_10_0 = var_0_8(arg_10_0, arg_10_1)._DungeonEnum

	if not var_10_0 then
		local var_10_1 = var_0_7("VersionActivity%sDungeonEnum", var_0_3, arg_10_0, arg_10_1)

		var_10_0 = _G[var_10_1]
		var_0_2[arg_10_0][arg_10_1]._DungeonEnum = var_10_0
	end

	return var_10_0
end

function var_0_0.getVersionActivityDungeonMapViewName(arg_11_0, arg_11_1)
	arg_11_0, arg_11_1 = var_0_6(arg_11_0, arg_11_1)

	local var_11_0 = var_0_8(arg_11_0, arg_11_1)._DungeonMapViewName

	if not var_11_0 then
		local var_11_1 = var_0_7("VersionActivity%sDungeonMapView", var_0_3, arg_11_0, arg_11_1)

		var_11_0 = ViewName[var_11_1]
		var_0_2[arg_11_0][arg_11_1]._DungeonMapViewName = var_11_0
	end

	return var_11_0
end

function var_0_0.getVersionActivityDungeonMapLevelViewName(arg_12_0, arg_12_1)
	arg_12_0, arg_12_1 = var_0_6(arg_12_0, arg_12_1)

	local var_12_0 = var_0_8(arg_12_0, arg_12_1)._DungeonMapLevelView

	if not var_12_0 then
		local var_12_1 = var_0_7("VersionActivity%sDungeonMapLevelView", var_0_3, arg_12_0, arg_12_1)

		var_12_0 = ViewName[var_12_1]
		var_0_2[arg_12_0][arg_12_1]._DungeonMapLevelView = var_12_0
	end

	return var_12_0
end

function var_0_0.getVersionActivityDungeonEnterReddotId(arg_13_0, arg_13_1)
	arg_13_0, arg_13_1 = var_0_6(arg_13_0, arg_13_1)

	local var_13_0 = var_0_8(arg_13_0, arg_13_1)._DungeonEnter

	if not var_13_0 then
		local var_13_1 = var_0_7("%sDungeonEnter", var_0_4, arg_13_0, arg_13_1)

		var_13_0 = RedDotEnum.DotNode[var_13_1]
		var_0_2[arg_13_0][arg_13_1]._DungeonEnter = var_13_0
	end

	return var_13_0
end

function var_0_0.getVersionActivityDungeonTaskReddotId(arg_14_0, arg_14_1)
	arg_14_0, arg_14_1 = var_0_6(arg_14_0, arg_14_1)

	local var_14_0 = var_0_8(arg_14_0, arg_14_1)._DungeonEnter

	if not var_14_0 then
		local var_14_1 = var_0_7("%sDungeonTask", var_0_4, arg_14_0, arg_14_1)

		var_14_0 = RedDotEnum.DotNode[var_14_1]
		var_0_2[arg_14_0][arg_14_1]._DungeonEnter = var_14_0
	end

	return var_14_0
end

function var_0_0.getVersionActivityCurrencyType(arg_15_0, arg_15_1)
	arg_15_0, arg_15_1 = var_0_6(arg_15_0, arg_15_1)

	local var_15_0 = var_0_8(arg_15_0, arg_15_1)._CurrencyType

	if not var_15_0 then
		local var_15_1 = var_0_7("%sDungeon", var_0_4, arg_15_0, arg_15_1)

		var_15_0 = CurrencyEnum.CurrencyType[var_15_1]
		var_0_2[arg_15_0][arg_15_1]._CurrencyType = var_15_0
	end

	return var_15_0
end

function var_0_0.getVersionActivityAudioBgmLayer(arg_16_0, arg_16_1)
	arg_16_0, arg_16_1 = var_0_6(arg_16_0, arg_16_1)

	local var_16_0 = var_0_8(arg_16_0, arg_16_1)._AudioBgmLayer

	if not var_16_0 then
		local var_16_1 = var_0_7("VersionActivity%sMain", var_0_3, arg_16_0, arg_16_1)

		var_16_0 = AudioBgmEnum.Layer[var_16_1]
		var_0_2[arg_16_0][arg_16_1]._AudioBgmLayer = var_16_0
	end

	return var_16_0
end

function var_0_0.getVersionActivityStoreRareIcon(arg_17_0, arg_17_1)
	arg_17_0, arg_17_1 = var_0_6(arg_17_0, arg_17_1)

	local var_17_0 = var_0_8(arg_17_0, arg_17_1)._StoreRareIcon

	if not var_17_0 then
		var_17_0 = var_0_7("%s_store_quality_", var_0_5, arg_17_0, arg_17_1)
		var_0_2[arg_17_0][arg_17_1]._StoreRareIcon = var_17_0
	end

	return var_17_0
end

function var_0_0._getFixed(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0, arg_18_1 = var_0_6(arg_18_0, arg_18_1)

	local var_18_0 = var_0_8(arg_18_0, arg_18_1)[arg_18_2]

	if not var_18_0 then
		local var_18_1 = "VersionActivity%s" .. arg_18_2
		local var_18_2 = var_0_7(var_18_1, var_0_3, arg_18_0, arg_18_1)
		local var_18_3 = string.format(var_18_1, "Fixed")

		var_18_0 = _G[var_18_2] or _G[var_18_3]
		var_0_2[arg_18_0][arg_18_1][arg_18_2] = var_18_0
	end

	return var_18_0
end

function var_0_0.getVersionActivityEnterController(arg_19_0, arg_19_1)
	return var_0_0._getFixed(arg_19_0, arg_19_1, "EnterController")
end

function var_0_0.getVersionActivityDungeonController(arg_20_0, arg_20_1)
	return var_0_0._getFixed(arg_20_0, arg_20_1, "DungeonController")
end

function var_0_0.getVersionActivityDungeonMapElement(arg_21_0, arg_21_1)
	return var_0_0._getFixed(arg_21_0, arg_21_1, "DungeonMapElement")
end

function var_0_0.getVersionActivityDungeonMapHoleView(arg_22_0, arg_22_1)
	return var_0_0._getFixed(arg_22_0, arg_22_1, "DungeonMapHoleView")
end

function var_0_0.getVersionActivityDungeonMapScene(arg_23_0, arg_23_1)
	return var_0_0._getFixed(arg_23_0, arg_23_1, "DungeonMapScene")
end

function var_0_0.getVersionActivityDungeonMapSceneElements(arg_24_0, arg_24_1)
	return var_0_0._getFixed(arg_24_0, arg_24_1, "DungeonMapSceneElements")
end

function var_0_0.getVersionActivityDungeonMapChapterLayout(arg_25_0, arg_25_1)
	return var_0_0._getFixed(arg_25_0, arg_25_1, "DungeonMapChapterLayout")
end

function var_0_0.getVersionActivityDungeonMapEpisodeItem(arg_26_0, arg_26_1)
	return var_0_0._getFixed(arg_26_0, arg_26_1, "DungeonMapEpisodeItem")
end

function var_0_0.getVersionActivityDungeonMapEpisodeView(arg_27_0, arg_27_1)
	return var_0_0._getFixed(arg_27_0, arg_27_1, "DungeonMapEpisodeView")
end

function var_0_0.getVersionActivityDungeonMapFinishElement(arg_28_0, arg_28_1)
	return var_0_0._getFixed(arg_28_0, arg_28_1, "DungeonMapFinishElement")
end

function var_0_0.getVersionActivityDungeonMapInteractView(arg_29_0, arg_29_1)
	return var_0_0._getFixed(arg_29_0, arg_29_1, "DungeonMapInteractView")
end

function var_0_0.getVersionActivityDungeonMapView(arg_30_0, arg_30_1)
	return var_0_0._getFixed(arg_30_0, arg_30_1, "DungeonMapView")
end

function var_0_0.getVersionActivityDungeonMapLevelView(arg_31_0, arg_31_1)
	return var_0_0._getFixed(arg_31_0, arg_31_1, "DungeonMapLevelView")
end

function var_0_0.getVersionActivityStoreGoodsItem(arg_32_0, arg_32_1)
	return var_0_0._getFixed(arg_32_0, arg_32_1, "StoreGoodsItem")
end

function var_0_0.getVersionActivityStoreItem(arg_33_0, arg_33_1)
	return var_0_0._getFixed(arg_33_0, arg_33_1, "StoreItem")
end

function var_0_0.getVersionActivityStoreView(arg_34_0, arg_34_1)
	return var_0_0._getFixed(arg_34_0, arg_34_1, "StoreView")
end

function var_0_0.getVersionActivityTaskItem(arg_35_0, arg_35_1)
	return var_0_0._getFixed(arg_35_0, arg_35_1, "TaskItem")
end

function var_0_0.getVersionActivityTaskView(arg_36_0, arg_36_1)
	return var_0_0._getFixed(arg_36_0, arg_36_1, "TaskView")
end

function var_0_0.getVersionActivityDungeonEnterView(arg_37_0, arg_37_1)
	return var_0_0._getFixed(arg_37_0, arg_37_1, "DungeonEnterView")
end

function var_0_0.getVersionActivitySubAnimatorComp(arg_38_0, arg_38_1)
	return var_0_0._getFixed(arg_38_0, arg_38_1, "SubAnimatorComp")
end

function var_0_0.getVersionActivityEnterBgmView(arg_39_0, arg_39_1)
	return var_0_0._getFixed(arg_39_0, arg_39_1, "EnterBgmView")
end

function var_0_0.getVersionActivityEnterView(arg_40_0, arg_40_1)
	return var_0_0._getFixed(arg_40_0, arg_40_1, "EnterView")
end

function var_0_0.getVersionActivityEnterViewTabItem1(arg_41_0, arg_41_1)
	return var_0_0._getFixed(arg_41_0, arg_41_1, "EnterViewTabItem1")
end

function var_0_0.getVersionActivityEnterViewTabItem2(arg_42_0, arg_42_1)
	return var_0_0._getFixed(arg_42_0, arg_42_1, "EnterViewTabItem2")
end

function var_0_0.isTargetVersion(arg_43_0, arg_43_1)
	return var_0_1.big == arg_43_0 and var_0_1.small == arg_43_1
end

return var_0_0
