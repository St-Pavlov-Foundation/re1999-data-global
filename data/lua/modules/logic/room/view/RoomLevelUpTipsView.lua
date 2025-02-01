module("modules.logic.room.view.RoomLevelUpTipsView", package.seeall)

slot0 = class("RoomLevelUpTipsView", BaseView)
slot1 = 43

function slot0.onInitView(slot0)
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_maskbg")
	slot0._txttype = gohelper.findChildText(slot0.viewGO, "title/#txt_type")
	slot0._gopreviouslevel = gohelper.findChild(slot0.viewGO, "levelup/previous/node/#go_previouslevel")
	slot0._txtpreviouslv = gohelper.findChildText(slot0.viewGO, "levelup/previous/#txt_previouslv")
	slot0._gocurrentlevel = gohelper.findChild(slot0.viewGO, "levelup/current/node/#go_currentlevel")
	slot0._txtcurrentlv = gohelper.findChildText(slot0.viewGO, "levelup/current/#txt_currentlv")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "levelupInfo/#go_info")

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
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(slot0._gopreviouslevel, false)
	gohelper.setActive(slot0._gocurrentlevel, false)
	gohelper.setActive(slot0._goinfo, false)

	slot0._previousLevelItemList = {}
	slot0._currentLevelItemList = {}
	slot0._infoItemList = {}
	slot0._btnclose = gohelper.findChildClickWithAudio(slot0.viewGO, "bg")
end

function slot0._refreshLevel(slot0, slot1, slot2, slot3, slot4)
	for slot8 = 1, slot4 do
		if not slot1[slot8] then
			slot9 = slot0:getUserDataTb_()
			slot9.go = gohelper.cloneInPlace(slot2, "item" .. slot8)
			slot9.golight = gohelper.findChild(slot9.go, "active")

			table.insert(slot1, slot9)
		end

		gohelper.setActive(slot9.golight, slot8 <= slot3)
		gohelper.setActive(slot9.go, true)
	end

	for slot8 = slot4 + 1, #slot1 do
		gohelper.setActive(slot1[slot8].go, false)
	end
end

function slot0._playLevelAnimation(slot0, slot1, slot2)
	if not slot1 or #slot1 <= 0 then
		return
	end

	for slot6 = 1, slot2 do
		gohelper.setActive(slot1[slot6].golight, false)
	end

	slot5 = 0.6 + (slot2 - 1) * 0.06

	if slot0._scene and slot0._scene.tween then
		slot0._levelTweenId = slot0._scene.tween:tweenFloat(0, slot5, slot5, slot0._levelAnimationFrame, slot0._levelAnimationFinish, slot0, {
			delay = slot3,
			interval = slot4,
			level = slot2,
			duration = slot5,
			itemList = slot1
		})
	else
		slot0._levelTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot5, slot5, slot0._levelAnimationFrame, slot0._levelAnimationFinish, slot0, {
			delay = slot3,
			interval = slot4,
			level = slot2,
			duration = slot5,
			itemList = slot1
		})
	end
end

function slot0._levelAnimationFrame(slot0, slot1, slot2)
	for slot6 = 1, slot2.level do
		gohelper.setActive(slot2.itemList[slot6].golight, slot1 >= slot2.delay + (slot6 - 1) * slot2.interval)
	end
end

function slot0._levelAnimationFinish(slot0, slot1)
	slot0:_levelAnimationFrame(slot1.duration + 0.001, slot1)
end

function slot0.onOpen(slot0)
	if slot0.viewParam.level then
		slot0:_updateLevelInfo(slot0.viewParam.level)
	elseif slot0.viewParam.buildingUid then
		slot0:_updateBuildingLevelInfo(slot0.viewParam.buildingUid)
	else
		slot0:_updateProductLineLevelInfo(slot0.viewParam.productLineMO)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function slot0._updateLevelInfo(slot0, slot1)
	slot0._txttype.text = luaLang("room_level_up")
	slot0._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", slot1 - 1)
	slot0._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", slot1)
	slot2 = RoomConfig.instance:getMaxRoomLevel()

	slot0:_refreshLevel(slot0._previousLevelItemList, slot0._gopreviouslevel, slot1 - 1, slot2)
	slot0:_refreshLevel(slot0._currentLevelItemList, slot0._gocurrentlevel, slot1, slot2)
	slot0:_playLevelAnimation(slot0._currentLevelItemList, slot1)
	slot0:_refreshDescTips(RoomProductionHelper.getRoomLevelUpParams(slot1 - 1, slot1, true))
end

function slot0._updateBuildingLevelInfo(slot0, slot1)
	slot0._txttype.text = luaLang("room_building_level_up")
	slot3 = 0
	slot4 = 0
	slot5 = 0

	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) then
		slot4 = Mathf.Max(0, slot2:getLevel() - 1)
	end

	slot0._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", slot4)
	slot0._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", slot5)

	slot0:_refreshLevel(slot0._previousLevelItemList, slot0._gopreviouslevel, slot4, slot3)
	slot0:_refreshLevel(slot0._currentLevelItemList, slot0._gocurrentlevel, slot5, slot3)
	slot0:_playLevelAnimation(slot0._currentLevelItemList, slot5)
	slot0:_refreshDescTips(RoomHelper.getBuildingLevelUpTipsParam(slot1))
end

function slot0._updateProductLineLevelInfo(slot0, slot1)
	slot0._txttype.text = luaLang("room_production_line_level_up")
	slot0._txtpreviouslv.text = string.format("Lv.<size=56>%d</size>", slot1.level - 1)
	slot0._txtcurrentlv.text = string.format("Lv.<size=56>%d</size>", slot1.level)

	slot0:_refreshLevel(slot0._previousLevelItemList, slot0._gopreviouslevel, slot1.level - 1, slot1.maxLevel)
	slot0:_refreshLevel(slot0._currentLevelItemList, slot0._gocurrentlevel, slot1.level, slot1.maxLevel)
	slot0:_playLevelAnimation(slot0._currentLevelItemList, slot1.level)
	slot0:_refreshDescTips(RoomProductionHelper.getProductLineLevelUpParams(slot1.id, slot1.level - 1, slot1.level, true))
end

function slot0._refreshDescTips(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not slot0._infoItemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._goinfo, "item" .. slot5)
			slot7.trans = slot7.go.transform
			slot7.gonormal = gohelper.findChild(slot7.go, "#go_normal")
			slot7.txtinfo = gohelper.findChildText(slot7.go, "#go_normal/txt_info")
			slot7.gohasNewItem = gohelper.findChild(slot7.go, "#go_hasNewItem")
			slot7.txtnewItemInfo = gohelper.findChildText(slot7.go, "#go_hasNewItem/txt_newItemInfo")
			slot7.goNewItemLayout = gohelper.findChild(slot7.go, "#go_hasNewItem/#go_newItemLayout")
			slot7.goNewItem = gohelper.findChild(slot7.go, "#go_hasNewItem/#go_newItemLayout/#go_newItem")

			table.insert(slot0._infoItemList, slot7)
		end

		slot9 = recthelper.getHeight(slot7.trans)

		if slot6.newItemInfoList and true or false then
			slot9 = recthelper.getHeight(slot7.goNewItemLayout.transform)
			slot7.txtnewItemInfo.text = slot6.desc

			gohelper.CreateObjList(slot0, slot0._onSetNewItem, slot6.newItemInfoList, slot7.goNewItemLayout, slot7.goNewItem)
		else
			slot7.txtinfo.text = slot6.desc
		end

		recthelper.setHeight(slot7.trans, slot9)
		gohelper.setActive(slot7.gonormal, not slot8)
		gohelper.setActive(slot7.gohasNewItem, slot8)
		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._infoItemList do
		gohelper.setActive(slot0._infoItemList[slot5].go, false)
	end
end

function slot0._onSetNewItem(slot0, slot1, slot2, slot3)
	slot6 = slot2.quantity or 0
	slot7 = IconMgr.instance:getCommonItemIcon(slot1)

	slot7:setCountFontSize(uv0)
	slot7:setMOValue(slot2.type, slot2.id, slot6)
	slot7:isShowCount(slot6 ~= 0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._levelTweenId then
		if slot0._scene and slot0._scene.tween then
			slot0._scene.tween:killById(slot0._levelTweenId)
		else
			ZProj.TweenHelper.KillById(slot0._levelTweenId)
		end

		slot0._levelTweenId = nil
	end
end

return slot0
