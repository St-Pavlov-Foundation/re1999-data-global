module("modules.logic.room.view.common.RoomBlockPackageGetView", package.seeall)

local var_0_0 = class("RoomBlockPackageGetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._simagebgicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgicon1")
	arg_1_0._simagebgicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgicon2")
	arg_1_0._simageblockpackageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_blockpackageicon")
	arg_1_0._simagetipshui = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simage_tipsmask/#simage_tips_hui")
	arg_1_0._simagetipsbai = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simage_tipsmask/#simage_tips_bai")
	arg_1_0._gocobrand = gohelper.findChild(arg_1_0.viewGO, "bg/#go_cobrand")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	if not arg_4_0._canClick then
		return
	end

	arg_4_0:_next()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebgicon1:LoadImage(ResUrl.getRoomGetIcon("xw_texiao1"))
	arg_5_0._simagebgicon2:LoadImage(ResUrl.getRoomGetIcon("xw_texiao2"))

	arg_5_0._txtname1 = gohelper.findChildText(arg_5_0.viewGO, "bg/simage_tipsmask/#simage_tips_hui/#txt_name")
	arg_5_0._txtname2 = gohelper.findChildText(arg_5_0.viewGO, "bg/simage_tipsmask/#simage_tips_bai/#txt_name")

	gohelper.removeUIClickAudio(arg_5_0._btnclose.gameObject)

	arg_5_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)
	arg_5_0.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._gocobrand, RoomSourcesCobrandLogoItem, arg_5_0)
	arg_5_0.cobrandLogoItem.__view = arg_5_0
end

function var_0_0._refreshUI(arg_6_0)
	local var_6_0 = arg_6_0._item.itemType
	local var_6_1 = arg_6_0._item.itemId
	local var_6_2 = var_6_0 == MaterialEnum.MaterialType.BlockPackage
	local var_6_3 = var_6_0 == MaterialEnum.MaterialType.Building
	local var_6_4 = var_6_0 == MaterialEnum.MaterialType.RoomTheme

	gohelper.setActive(arg_6_0._txtname1.gameObject, var_6_2 or var_6_3 or var_6_4)
	gohelper.setActive(arg_6_0._txtname2.gameObject, var_6_2 or var_6_3 or var_6_4)
	gohelper.setActive(arg_6_0._simageblockpackageicon.gameObject, var_6_2 or var_6_3 or var_6_4)

	local var_6_5

	if var_6_2 then
		var_6_5 = RoomConfig.instance:getBlockPackageConfig(var_6_1)
		arg_6_0._txtname1.text = var_6_5.name
		arg_6_0._txtname2.text = var_6_5.name

		arg_6_0._simageblockpackageicon:LoadImage(ResUrl.getRoomBlockPackageRewardIcon(var_6_5.rewardIcon))
		arg_6_0._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_1"))
		arg_6_0._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_1"))
	elseif var_6_3 then
		local var_6_6
		local var_6_7 = arg_6_0._item.roomBuildingLevel

		if var_6_7 and var_6_7 > 0 then
			local var_6_8 = RoomConfig.instance:getLevelGroupConfig(var_6_1, var_6_7)

			var_6_6 = var_6_8 and var_6_8.rewardIcon
		end

		var_6_5 = RoomConfig.instance:getBuildingConfig(var_6_1)

		if string.nilorempty(var_6_6) then
			var_6_6 = var_6_5.rewardIcon
		end

		arg_6_0._txtname1.text = var_6_5.name
		arg_6_0._txtname2.text = var_6_5.name

		arg_6_0._simageblockpackageicon:LoadImage(ResUrl.getRoomBuildingRewardIcon(var_6_6))
		arg_6_0._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode"))
		arg_6_0._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode"))
	elseif var_6_4 then
		var_6_5 = RoomConfig.instance:getThemeConfig(var_6_1)
		arg_6_0._txtname1.text = var_6_5.name
		arg_6_0._txtname2.text = var_6_5.name

		arg_6_0._simageblockpackageicon:LoadImage(ResUrl.getRoomThemeRewardIcon(var_6_5.rewardIcon))
		arg_6_0._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_2"))
		arg_6_0._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_2"))
	else
		logError("不支持的物品类型, itemType: " .. tostring(var_6_0))
	end

	arg_6_0.cobrandLogoItem:setSourcesTypeStr(var_6_5 and var_6_5.sourcesType)
end

function var_0_0._onEscape(arg_7_0)
	arg_7_0:_btncloseOnClick()
end

function var_0_0._next(arg_8_0, arg_8_1)
	TaskDispatcher.cancelTask(arg_8_0._refreshUI, arg_8_0)

	arg_8_0._itemIndex = arg_8_0._itemIndex + 1
	arg_8_0._item = arg_8_0.viewParam and arg_8_0.viewParam.itemList and arg_8_0.viewParam.itemList[arg_8_0._itemIndex]

	if not arg_8_0._item then
		arg_8_0:closeThis()

		return
	end

	if arg_8_0._itemIndex > 1 then
		TaskDispatcher.runDelay(arg_8_0._animDone, arg_8_0, 5)

		arg_8_0._canClick = false

		arg_8_0._animatorPlayer:Play("all", arg_8_0._animDone, arg_8_0)
		TaskDispatcher.runDelay(arg_8_0._refreshUI, arg_8_0, 0.5)
	elseif arg_8_1 then
		TaskDispatcher.runDelay(arg_8_0._animDone, arg_8_0, 5)

		arg_8_0._canClick = false

		arg_8_0._animatorPlayer:Play(UIAnimationName.Open, arg_8_0._animDone, arg_8_0)
		arg_8_0:_refreshUI()
	else
		arg_8_0:_refreshUI()
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open)
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._itemIndex = 0
	arg_9_0._canClick = true

	arg_9_0:_next()
	NavigateMgr.instance:addEscape(ViewName.RoomBlockPackageGetView, arg_9_0._onEscape, arg_9_0)
end

function var_0_0._animDone(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._animDone, arg_10_0)

	arg_10_0._canClick = true
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0._itemIndex = 0
	arg_11_0._canClick = true

	arg_11_0:_next(true)
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._animDone, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._refreshUI, arg_12_0)

	if arg_12_0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function var_0_0.onDestroyView(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._animDone, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._refreshUI, arg_13_0)
	arg_13_0._simagebgicon1:UnLoadImage()
	arg_13_0._simagebgicon2:UnLoadImage()
	arg_13_0._simageblockpackageicon:UnLoadImage()
	arg_13_0._simagetipshui:UnLoadImage()
	arg_13_0._simagetipsbai:UnLoadImage()
	arg_13_0.cobrandLogoItem:onDestroy()
end

return var_0_0
