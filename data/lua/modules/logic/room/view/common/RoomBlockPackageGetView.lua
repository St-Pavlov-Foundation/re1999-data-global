module("modules.logic.room.view.common.RoomBlockPackageGetView", package.seeall)

slot0 = class("RoomBlockPackageGetView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._simagebgicon1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgicon1")
	slot0._simagebgicon2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgicon2")
	slot0._simageblockpackageicon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_blockpackageicon")
	slot0._simagetipshui = gohelper.findChildSingleImage(slot0.viewGO, "bg/simage_tipsmask/#simage_tips_hui")
	slot0._simagetipsbai = gohelper.findChildSingleImage(slot0.viewGO, "bg/simage_tipsmask/#simage_tips_bai")
	slot0._gocobrand = gohelper.findChild(slot0.viewGO, "bg/#go_cobrand")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	if not slot0._canClick then
		return
	end

	slot0:_next()
end

function slot0._editableInitView(slot0)
	slot0._simagebgicon1:LoadImage(ResUrl.getRoomGetIcon("xw_texiao1"))
	slot0._simagebgicon2:LoadImage(ResUrl.getRoomGetIcon("xw_texiao2"))

	slot0._txtname1 = gohelper.findChildText(slot0.viewGO, "bg/simage_tipsmask/#simage_tips_hui/#txt_name")
	slot0._txtname2 = gohelper.findChildText(slot0.viewGO, "bg/simage_tipsmask/#simage_tips_bai/#txt_name")

	gohelper.removeUIClickAudio(slot0._btnclose.gameObject)

	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gocobrand, RoomSourcesCobrandLogoItem, slot0)
	slot0.cobrandLogoItem.__view = slot0
end

function slot0._refreshUI(slot0)
	slot3 = slot0._item.itemType == MaterialEnum.MaterialType.BlockPackage
	slot4 = slot1 == MaterialEnum.MaterialType.Building
	slot5 = slot1 == MaterialEnum.MaterialType.RoomTheme

	gohelper.setActive(slot0._txtname1.gameObject, slot3 or slot4 or slot5)
	gohelper.setActive(slot0._txtname2.gameObject, slot3 or slot4 or slot5)
	gohelper.setActive(slot0._simageblockpackageicon.gameObject, slot3 or slot4 or slot5)

	slot6 = nil

	if slot3 then
		slot6 = RoomConfig.instance:getBlockPackageConfig(slot0._item.itemId)
		slot0._txtname1.text = slot6.name
		slot0._txtname2.text = slot6.name

		slot0._simageblockpackageicon:LoadImage(ResUrl.getRoomBlockPackageRewardIcon(slot6.rewardIcon))
		slot0._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_1"))
		slot0._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_1"))
	elseif slot4 then
		slot7 = nil

		if slot0._item.roomBuildingLevel and slot8 > 0 then
			slot7 = RoomConfig.instance:getLevelGroupConfig(slot2, slot8) and slot9.rewardIcon
		end

		slot6 = RoomConfig.instance:getBuildingConfig(slot2)

		if string.nilorempty(slot7) then
			slot7 = slot6.rewardIcon
		end

		slot0._txtname1.text = slot6.name
		slot0._txtname2.text = slot6.name

		slot0._simageblockpackageicon:LoadImage(ResUrl.getRoomBuildingRewardIcon(slot7))
		slot0._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode"))
		slot0._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode"))
	elseif slot5 then
		slot6 = RoomConfig.instance:getThemeConfig(slot2)
		slot0._txtname1.text = slot6.name
		slot0._txtname2.text = slot6.name

		slot0._simageblockpackageicon:LoadImage(ResUrl.getRoomThemeRewardIcon(slot6.rewardIcon))
		slot0._simagetipshui:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_2"))
		slot0._simagetipsbai:LoadImage(ResUrl.getRoomIconLangPath("xw_huode_2"))
	else
		logError("不支持的物品类型, itemType: " .. tostring(slot1))
	end

	slot0.cobrandLogoItem:setSourcesTypeStr(slot6 and slot6.sourcesType)
end

function slot0._onEscape(slot0)
	slot0:_btncloseOnClick()
end

function slot0._next(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._refreshUI, slot0)

	slot0._itemIndex = slot0._itemIndex + 1
	slot0._item = slot0.viewParam and slot0.viewParam.itemList and slot0.viewParam.itemList[slot0._itemIndex]

	if not slot0._item then
		slot0:closeThis()

		return
	end

	if slot0._itemIndex > 1 then
		TaskDispatcher.runDelay(slot0._animDone, slot0, 5)

		slot0._canClick = false

		slot0._animatorPlayer:Play("all", slot0._animDone, slot0)
		TaskDispatcher.runDelay(slot0._refreshUI, slot0, 0.5)
	elseif slot1 then
		TaskDispatcher.runDelay(slot0._animDone, slot0, 5)

		slot0._canClick = false

		slot0._animatorPlayer:Play(UIAnimationName.Open, slot0._animDone, slot0)
		slot0:_refreshUI()
	else
		slot0:_refreshUI()
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_open)
end

function slot0.onOpen(slot0)
	slot0._itemIndex = 0
	slot0._canClick = true

	slot0:_next()
	NavigateMgr.instance:addEscape(ViewName.RoomBlockPackageGetView, slot0._onEscape, slot0)
end

function slot0._animDone(slot0)
	TaskDispatcher.cancelTask(slot0._animDone, slot0)

	slot0._canClick = true
end

function slot0.onUpdateParam(slot0)
	slot0._itemIndex = 0
	slot0._canClick = true

	slot0:_next(true)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._animDone, slot0)
	TaskDispatcher.cancelTask(slot0._refreshUI, slot0)

	if slot0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._animDone, slot0)
	TaskDispatcher.cancelTask(slot0._refreshUI, slot0)
	slot0._simagebgicon1:UnLoadImage()
	slot0._simagebgicon2:UnLoadImage()
	slot0._simageblockpackageicon:UnLoadImage()
	slot0._simagetipshui:UnLoadImage()
	slot0._simagetipsbai:UnLoadImage()
	slot0.cobrandLogoItem:onDestroy()
end

return slot0
