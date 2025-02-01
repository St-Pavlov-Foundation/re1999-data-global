module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenItem", package.seeall)

slot0 = class("EliminateSelectChessMenItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goChessSelected = gohelper.findChild(slot0.viewGO, "#go_ChessSelected")
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._goUnLocked = gohelper.findChild(slot0.viewGO, "#go_UnLocked")
	slot0._imageChessQuality = gohelper.findChildImage(slot0.viewGO, "#go_UnLocked/#image_ChessQuality")
	slot0._imageChess = gohelper.findChildImage(slot0.viewGO, "#go_UnLocked/#image_Chess")
	slot0._goResource = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Resource")
	slot0._goResourceItem = gohelper.findChild(slot0.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem")
	slot0._imageResourceQuality = gohelper.findChildImage(slot0.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	slot0._txtResourceNum = gohelper.findChildText(slot0.viewGO, "#go_UnLocked/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	slot0._txtFireNum = gohelper.findChildText(slot0.viewGO, "#go_UnLocked/image_Fire/#txt_FireNum")

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
	slot0._animator = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0:addEventCb(EliminateMapController.instance, EliminateMapEvent.SelectChessMen, slot0._onSelectChessMen, slot0)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onItemClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not slot0._isUnlocked then
		GameFacade.showToast(ToastEnum.EliminateChessMenLocked)

		return
	end

	if not slot0._isSelected then
		EliminateSelectChessMenListModel.instance:setSelectedChessMen(slot0._mo)
	end

	if EliminateSelectChessMenListModel.instance:getQuickEdit() then
		EliminateMapController.instance:dispatchEvent(EliminateMapEvent.QuickSelectChessMen)
	end
end

function slot0._onSelectChessMen(slot0)
	slot0._isSelected = slot0._mo == EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(slot0._goChessSelected, slot0._isSelected)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._config = slot1.config
	slot0._isUnlocked = EliminateTeamSelectionModel.instance:hasChessPieceOrPreset(slot0._config.id)

	gohelper.setActive(slot0._goLocked, not slot0._isUnlocked)
	gohelper.setActive(slot0._goUnLocked, slot0._isUnlocked)
	slot0:_onSelectChessMen()

	if not slot0._isUnlocked then
		slot0._animator:Play("idle", slot0._idleDone, slot0)

		return
	end

	slot0._txtFireNum.text = tostring(slot0._config.defaultPower)

	gohelper.CreateObjList(slot0, slot0._onItemShow, slot0._mo.costList, slot0._goResource, slot0._goResourceItem)
	UISpriteSetMgr.instance:setV2a2ChessSprite(slot0._imageChess, slot0._config.resPic, false)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._imageChessQuality, "v2a2_eliminate_chessqualitybg_0" .. slot0._config.level, false)

	if not EliminateMapController.hasOnceActionKey(EliminateMapEnum.PrefsKey.ChessUnlock, slot0._config.id) then
		EliminateMapController.setOnceActionKey(EliminateMapEnum.PrefsKey.ChessUnlock, slot0._config.id)
		gohelper.setActive(slot0._goLocked, true)
		slot0._animator:Play("unlock", slot0._unlockDone, slot0)
	end
end

function slot0._unlockDone(slot0)
	slot0._animator:Play("idle", slot0._idleDone, slot0)
	gohelper.setActive(slot0._goLocked, false)
end

function slot0._idleDone(slot0)
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
