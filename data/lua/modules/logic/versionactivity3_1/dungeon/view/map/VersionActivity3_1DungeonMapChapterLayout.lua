module("modules.logic.versionactivity3_1.dungeon.view.map.VersionActivity3_1DungeonMapChapterLayout", package.seeall)

local var_0_0 = class("VersionActivity3_1DungeonMapChapterLayout", VersionActivityFixedDungeonMapChapterLayout)
local var_0_1 = "default"
local var_0_2 = 600
local var_0_3 = 100
local var_0_4 = 0.26

function var_0_0._editableInitView(arg_1_0)
	arg_1_0._focusIndex = 0
	arg_1_0._episodeItemDict = arg_1_0:getUserDataTb_()
	arg_1_0._episodeContainerItemList = arg_1_0:getUserDataTb_()
	arg_1_0.episodeItemPath = arg_1_0.viewContainer:getSetting().otherRes[1]

	local var_1_0 = Vector2(0, 1)

	arg_1_0.rectTransform.pivot = var_1_0
	arg_1_0.rectTransform.anchorMin = var_1_0
	arg_1_0.rectTransform.anchorMax = var_1_0
	arg_1_0.defaultY = arg_1_0.activityDungeonMo:getLayoutOffsetY()

	recthelper.setAnchorY(arg_1_0.rectTransform, arg_1_0.defaultY)

	arg_1_0._rawWidth = recthelper.getWidth(arg_1_0.rectTransform)
	arg_1_0._rawHeight = 500

	recthelper.setSize(arg_1_0.contentTransform, arg_1_0._rawWidth, arg_1_0._rawHeight)
	recthelper.setAnchorY(arg_1_0.contentTransform, 300)

	local var_1_1 = ViewMgr.instance:getUIRoot().transform
	local var_1_2 = recthelper.getWidth(var_1_1)

	arg_1_0._offsetX = (var_1_2 - var_0_2) / 2 + var_0_2
	arg_1_0._constDungeonNormalPosX = var_1_2 - arg_1_0._offsetX
	arg_1_0._constDungeonNormalPosY = CommonConfig.instance:getConstNum(ConstEnum.DungeonNormalPosY)
	arg_1_0._constDungeonNormalDeltaX = var_0_3
	arg_1_0._bigVersion, arg_1_0._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	if ViewMgr.instance:isOpening(VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(arg_1_0._bigVersion, arg_1_0._smallVersion)) then
		arg_1_0._timelineAnimation:Play("timeline_mask")
	end
end

return var_0_0
