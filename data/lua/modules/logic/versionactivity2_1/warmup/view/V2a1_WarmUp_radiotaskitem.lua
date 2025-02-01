module("modules.logic.versionactivity2_1.warmup.view.V2a1_WarmUp_radiotaskitem", package.seeall)

slot0 = class("V2a1_WarmUp_radiotaskitem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._txtDateUnSelected = gohelper.findChildText(slot0.viewGO, "txt_DateUnSelected")
	slot0._goDateSelected = gohelper.findChild(slot0.viewGO, "image_Selected")
	slot0._txtDateSelected = gohelper.findChildText(slot0.viewGO, "image_Selected/txt_DateSelected")
	slot0._finishEffectGo = gohelper.findChild(slot0.viewGO, "image_Selected/Wave_effect2")
	slot0._imagewave = gohelper.findChildImage(slot0.viewGO, "image_Selected/image_wave")
	slot0._goDateLocked = gohelper.findChild(slot0.viewGO, "image_Locked")
	slot0._goRed = gohelper.findChild(slot0.viewGO, "#go_reddot")
	slot0._click = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_click")
	slot0._txtDateUnSelectedGo = slot0._txtDateUnSelected.gameObject
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goDateSelected, slot1)
	gohelper.setActive(slot0._txtDateUnSelectedGo, not slot1)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0._getEpisodeConfig(slot0, slot1)
	return slot0:_assetGetViewContainer():getEpisodeConfig(slot1)
end

function slot0._getRLOC(slot0, slot1)
	return slot0:_assetGetViewContainer():getRLOC(slot1)
end

function slot0._isEpisodeDayOpen(slot0, slot1)
	return slot0:_assetGetViewContainer():isEpisodeDayOpen(slot1)
end

function slot0._isEpisodeUnLock(slot0, slot1)
	return slot0:_assetGetViewContainer():isEpisodeUnLock(slot1)
end

function slot0._isEpisodeReallyOpen(slot0, slot1)
	return slot0:_assetGetViewContainer():isEpisodeReallyOpen(slot1)
end

function slot0.setData(slot0, slot1)
	slot0._mo = slot1
	slot2 = slot1
	slot8 = "Day." .. tostring(slot0:_getEpisodeConfig(slot2).openDay)
	slot0._txtDateUnSelected.text = slot8
	slot0._txtDateSelected.text = slot8

	gohelper.setActive(slot0._goDateLocked, slot5)
	gohelper.setActive(slot0._goRed, not not slot0:_isEpisodeReallyOpen(slot2) and not slot0:_getRLOC(slot2))
end

function slot0._onClick(slot0)
	slot1 = slot0:_assetGetParent()

	if not slot0:_checkIfOpenAndToast() then
		return
	end

	slot1:onClickTab(slot0._mo)
end

function slot0._checkIfOpenAndToast(slot0)
	slot3, slot4 = slot0:_isEpisodeDayOpen(slot0._mo)

	if not slot3 then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeNotOpen, slot4)

		return false
	end

	if not slot0:_isEpisodeUnLock(slot2) then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeLock)

		return false
	end

	return true
end

return slot0
