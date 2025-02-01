module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenSlot", package.seeall)

slot0 = class("EliminateSelectChessMenSlot", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goadd = gohelper.findChild(slot0.viewGO, "#go_add")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "#go_detail")
	slot0._imageQuality = gohelper.findChildImage(slot0.viewGO, "#go_detail/#image_Quality")
	slot0._imageChess = gohelper.findChildImage(slot0.viewGO, "#go_detail/ChessMask/#image_Chess")
	slot0._txtFireNum = gohelper.findChildText(slot0.viewGO, "#go_detail/image_Fire/#txt_FireNum")
	slot0._goResources = gohelper.findChild(slot0.viewGO, "#go_detail/#go_Resources")
	slot0._goResourceItem = gohelper.findChild(slot0.viewGO, "#go_detail/#go_Resources/#go_ResourceItem")
	slot0._imageResourceQuality = gohelper.findChildImage(slot0.viewGO, "#go_detail/#go_Resources/#go_ResourceItem/#image_ResourceQuality")
	slot0._txtResourceNum = gohelper.findChildText(slot0.viewGO, "#go_detail/#go_Resources/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	slot0._goAssist = gohelper.findChild(slot0.viewGO, "#go_Assist")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)

	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.SelectChessMen, slot0._onSelectChessMen, slot0)

	slot0._isPreset = EliminateTeamSelectionModel.instance:isPreset()

	gohelper.setActive(slot0._goAssist, false)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onItemClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if slot0._isUnlocked and slot0._mo then
		EliminateSelectChessMenListModel.instance:setSelectedChessMen(slot0._mo)

		if EliminateSelectChessMenListModel.instance:getQuickEdit() then
			EliminateMapController.instance:dispatchEvent(EliminateMapEvent.QuickSelectChessMen)
		end
	end
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
	slot0._isUnlocked = slot1 <= EliminateSelectChessMenListModel.instance:getAddMaxCount()
end

function slot0._onSelectChessMen(slot0)
	slot0._isSelected = slot0._mo == EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(slot0._goSelected, slot0._isSelected)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0._goLocked, not slot0._isUnlocked)
	gohelper.setActive(slot0._goadd, slot0._isUnlocked and not slot0._mo)
	gohelper.setActive(slot0._godetail, slot0._isUnlocked and slot0._mo)
	gohelper.setActive(slot0._goAssist, false)

	if not slot0._mo then
		return
	end

	slot0._config = slot1.config
	slot0._txtFireNum.text = tostring(slot0._config.defaultPower)

	slot0:_onSelectChessMen()
	UISpriteSetMgr.instance:setV2a2ChessSprite(slot0._imageChess, slot0._config.resPic, false)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageQuality, "v2a2_eliminate_builditem_quality_0" .. slot0._config.level, false)
	gohelper.setActive(slot0._goAssist, slot0._isPreset)
	gohelper.CreateObjList(slot0, slot0._onItemShow, slot0._mo.costList, slot0._goResources, slot0._goResourceItem)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(gohelper.findChildImage(slot1, "#image_ResourceQuality"), EliminateTeamChessEnum.ResourceTypeToImagePath[slot2[1]], false)

	gohelper.findChildText(slot1, "#image_ResourceQuality/#txt_ResourceNum").text = slot2[2]
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
