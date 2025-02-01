module("modules.logic.room.view.RoomBlockPackageView", package.seeall)

slot0 = class("RoomBlockPackageView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._godetailedItem = gohelper.findChild(slot0.viewGO, "middle/cloneItem/#go_detailedItem")
	slot0._gosimpleItem = gohelper.findChild(slot0.viewGO, "middle/cloneItem/#go_simpleItem")
	slot0._scrolldetailed = gohelper.findChildScrollRect(slot0.viewGO, "middle/#scroll_detailed")
	slot0._scrollsimple = gohelper.findChildScrollRect(slot0.viewGO, "middle/#scroll_simple")
	slot0._btnnumber = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/left/#btn_number")
	slot0._btnrare = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/left/#btn_rare")
	slot0._btntheme = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/left/#btn_theme")
	slot0._btndetailed = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#btn_detailed")
	slot0._btnsimple = gohelper.findChildButtonWithAudio(slot0.viewGO, "top/#btn_simple")
	slot0._gonavigatebuttonscontainer = gohelper.findChild(slot0.viewGO, "#go_navigatebuttonscontainer")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnnumber:AddClickListener(slot0._btnnumberOnClick, slot0)
	slot0._btnrare:AddClickListener(slot0._btnrareOnClick, slot0)
	slot0._btndetailed:AddClickListener(slot0._btndetailedOnClick, slot0)
	slot0._btnsimple:AddClickListener(slot0._btnsimpleOnClick, slot0)
	slot0._btntheme:AddClickListener(slot0._btnthemeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnnumber:RemoveClickListener()
	slot0._btnrare:RemoveClickListener()
	slot0._btndetailed:RemoveClickListener()
	slot0._btnsimple:RemoveClickListener()
	slot0._btntheme:RemoveClickListener()
end

function slot0._btnthemeOnClick(slot0)
	RoomController.instance:openThemeFilterView(false)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnrareOnClick(slot0)
	slot0:_setSortRate(true)
end

function slot0._btnnumberOnClick(slot0)
	slot0:_setSortRate(false)
end

function slot0._btndetailedOnClick(slot0)
	if slot0._isDetailed ~= true then
		slot0:_toFirsePage(true)
	end
end

function slot0._btnsimpleOnClick(slot0)
	if slot0._isDetailed ~= false then
		slot0:_toFirsePage(false)
	end
end

function slot0._editableInitView(slot0)
	slot0._selectPackageId = nil
	slot0._isDetailed = true
	slot0._stateInfoGos = {}

	for slot5 = 1, #{
		slot0._btnrare.gameObject,
		slot0._btnnumber.gameObject
	} do
		slot6 = slot1[slot5]

		table.insert(slot0._stateInfoGos, {
			normalGO = gohelper.findChild(slot6, "go_normal"),
			selectGO = gohelper.findChild(slot6, "go_select"),
			arrowGO = gohelper.findChild(slot6, "go_select/txt/go_arrow")
		})
	end

	slot0._gothemeSelect = gohelper.findChild(slot0.viewGO, "top/left/#btn_theme/go_select")
	slot0._gothemeUnSelect = gohelper.findChild(slot0.viewGO, "top/left/#btn_theme/go_unselect")

	gohelper.setActive(slot0._gosimpleItem, false)
	gohelper.setActive(slot0._godetailedItem, false)
	gohelper.setActive(slot0._gopageItem, false)
	slot0:_setDetailed(true)
	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.UI.UI_Team_close)
end

function slot0._setSortRate(slot0, slot1)
	if slot0._isSortOrder ~= nil and slot0._isSortRate == slot1 then
		slot0._isSortOrder = slot0._isSortOrder == false
	else
		slot0._isSortOrder = false
	end

	slot0._isSortRate = slot1

	for slot6 = 1, #slot0._stateInfoGos do
		slot7 = slot6 == (slot0._isSortRate and 1 or 2)

		gohelper.setActive(slot0._stateInfoGos[slot6].selectGO, slot7 == true)
		gohelper.setActive(slot8.normalGO, slot7 == false)

		if slot7 then
			transformhelper.setLocalScale(slot8.arrowGO.transform, 1, slot0._isSortOrder and -1 or 1, 1)
		end
	end

	slot0:_sortPackageIds()
	slot0:_toFirsePage()
end

function slot0._setDetailed(slot0, slot1)
	slot0._isDetailed = slot1 and true or false

	gohelper.setActive(slot0._scrollsimple.gameObject, slot0._isDetailed == false)
	gohelper.setActive(slot0._btndetailed.gameObject, slot0._isDetailed == false)
	gohelper.setActive(slot0._scrolldetailed.gameObject, slot0._isDetailed == true)
	gohelper.setActive(slot0._btnsimple.gameObject, slot0._isDetailed == true)
end

function slot0._toFirsePage(slot0, slot1)
	if slot1 ~= nil then
		slot0:_setDetailed(slot1)
	end

	if slot0._isDetailed then
		slot0._scrolldetailed.horizontalNormalizedPosition = 0
	else
		slot0._scrollsimple.verticalNormalizedPosition = 1
	end
end

function slot0._sortPackageIds(slot0)
	RoomShowBlockPackageListModel.instance:setSortParam(slot0._isSortRate, slot0._isSortOrder)
end

function slot0._refreshItemListUI(slot0)
end

function slot0._onSelectBlockPackage(slot0, slot1)
	slot0._selectPackageId = slot1

	RoomShowBlockPackageListModel.instance:setSelect(slot0._selectPackageId)

	if slot0._selectPackageId and slot0._selectPackageId ~= slot0:_getCurUsePacageId() then
		RoomInventoryBlockModel.instance:setSelectBlockPackageIds({
			slot0._selectPackageId
		})
		RoomMapController.instance:dispatchEvent(RoomEvent.ConfirmSelectBlockPackage)
	end
end

function slot0._onThemeFilterChanged(slot0)
	RoomShowBlockPackageListModel.instance:setShowBlockList()
	RoomShowBlockPackageListModel.instance:setSelect(slot0._selectPackageId)
	slot0:_refreshFilterState()
end

function slot0._refreshFilterState(slot0)
	if slot0._isLastThemeOpen ~= (RoomThemeFilterListModel.instance:getSelectCount() > 0) then
		slot0._isLastThemeOpen = slot1

		gohelper.setActive(slot0._gothemeUnSelect, not slot1)
		gohelper.setActive(slot0._gothemeSelect, slot1)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.SelectBlockPackage, slot0._onSelectBlockPackage, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, slot0._onThemeFilterChanged, slot0)

	slot0._selectPackageId = slot0:_getCurUsePacageId()

	RoomShowBlockPackageListModel.instance:initShow(slot0._selectPackageId)
	RoomShowBlockPackageListModel.instance:setSelect(slot0._selectPackageId)
	slot0:_setSortRate(true)
	slot0:_refreshFilterState()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._getCurUsePacageId(slot0)
	return RoomInventoryBlockModel.instance:getCurPackageMO() and slot1.id or nil
end

return slot0
