module("modules.ugui.icon.common.CommonCritterIcon", package.seeall)

slot0 = class("CommonCritterIcon", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagequality = gohelper.findChildImage(slot0.viewGO, "#simage_quality")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._gomood = gohelper.findChild(slot0.viewGO, "#go_mood")
	slot0._gobuildingIcon = gohelper.findChild(slot0.viewGO, "#go_buildingIcon")
	slot0._imagebuildingIcon = gohelper.findChildImage(slot0.viewGO, "#go_buildingIcon/#simage_buildingIcon")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0._gomaturity = gohelper.findChild(slot0.viewGO, "#go_manufacture")
	slot0._goindex = gohelper.findChild(slot0.viewGO, "#go_index")
	slot0._txtindex = gohelper.findChildText(slot0.viewGO, "#go_index/#txt_index")
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_click")
	slot0._gouptips = gohelper.findChild(slot0.viewGO, "#go_uptips")
	slot0._gospecial = gohelper.findChild(slot0.viewGO, "#go_special")

	slot0:setSelectUIVisible()
	slot0:showIndex()

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if slot0.mo and slot0.mo.uid then
		SLFramework.SLLogger.Log("魔精uid:" .. slot0.mo.uid)
	end

	if slot0._customCallback then
		return slot0._customCallback(slot0._customCallbackObj, slot0._customClickParams)
	end
end

function slot0._editableInitView(slot0)
	slot0.trans = slot0.viewGO.transform

	slot0:hideMood()
end

function slot0.getCritterMo(slot0, slot1)
	if not slot0.mo and slot1 then
		logError(string.format("CommonCritterIcon:getCritterMo error, no critterMo, uid:%s", slot0.critterUid))
	end

	return slot0.mo
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0.critterUid = slot0.mo:getId()
	slot0.critterId = slot0.mo:getDefineId()

	slot0:refresh()
end

function slot0.setMOValue(slot0, slot1, slot2)
	slot0.critterUid = slot1
	slot0.critterId = slot2
	slot0.mo = CritterModel.instance:getCritterMOByUid(slot0.critterUid)

	if slot0.mo and not slot0.critterId then
		slot0.critterId = slot0.mo:getDefineId()
	end

	slot0:refresh()
end

function slot0.setSelectUIVisible(slot0, slot1)
	slot0._isShowSelectedUI = slot1

	slot0:onSelect()

	if slot0._isShowSelectedUI then
		CritterController.instance:dispatchEvent(CritterEvent.CheckCritterIconSelected, slot0.critterUid, slot0.critterId)
	end
end

function slot0.setIsShowBuildingIcon(slot0, slot1)
	slot0._isShowBuildingIcon = slot1

	slot0:refreshBuildingIcon()
end

function slot0.setCanClick(slot0, slot1)
	gohelper.setActive(slot0._btnclick.gameObject, slot1)
end

function slot0.setCustomClick(slot0, slot1, slot2, slot3)
	slot0._customCallback = slot1
	slot0._customCallbackObj = slot2
	slot0._customClickParams = slot3
end

function slot0.setLockIconShow(slot0, slot1)
	slot0._isShowLockIcon = slot1

	slot0:refreshLockIcon()
end

function slot0.setMaturityIconShow(slot0, slot1)
	slot0._isShowMaturityIcon = slot1

	slot0:refreshMaturityIcon()
end

function slot0.refresh(slot0)
	slot0:refreshIcon()
	slot0:refreshRare()
	slot0:refreshBuildingIcon()
	slot0:refreshLockIcon()
	slot0:refreshMaturityIcon()
end

function slot0.refreshIcon(slot0)
	slot1 = nil

	if not string.nilorempty(CritterConfig.instance:getCritterHeadIcon((not slot0:getCritterMo() or slot2:getSkinId()) and CritterConfig.instance:getCritterNormalSkin(slot0.critterId))) then
		slot0:_loadIcon(ResUrl.getCritterHedaIcon(slot3))
	end
end

function slot0._loadIcon(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._simageicon:LoadImage(slot1)
end

function slot0.refreshRare(slot0)
	if CritterConfig.instance:getCritterRare(slot0.critterId) then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imagequality, CritterEnum.QualityImageNameMap[slot1])
	end
end

function slot0.showMood(slot0)
	if not slot0._moodItem then
		slot0._moodItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gomood, CritterMoodItem)
	end

	slot0._moodItem:setCritterUid(slot0.critterUid)
	gohelper.setActive(slot0._gomood, true)
end

function slot0.hideMood(slot0)
	gohelper.setActive(slot0._gomood, false)
end

function slot0.showUpTip(slot0, slot1)
	gohelper.setActive(slot0._gouptips, slot1)
end

function slot0.showSpeical(slot0)
	gohelper.setActive(slot0._gospecial, slot0:getCritterMo():isMutate())
end

function slot0.refreshBuildingIcon(slot0)
	gohelper.setActive(slot0._gobuildingIcon, false)

	if not slot0._isShowBuildingIcon then
		return
	end

	slot1 = nil

	if RoomMapBuildingModel.instance:getBuildingMOById(ManufactureModel.instance:getCritterWorkingBuilding(slot0.critterUid) or ManufactureModel.instance:getCritterRestingBuilding(slot0.critterUid)) then
		slot1 = ManufactureConfig.instance:getManufactureBuildingIcon(slot3.buildingId)
	end

	if not slot1 and RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot0.critterUid) then
		slot1 = RoomTransportHelper.getVehicleCfgByBuildingId(slot4.buildingId, slot4.buildingSkinId) and slot7.buildIcon
	end

	if not slot1 and slot0.mo:isCultivating() then
		slot1 = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CultivatingIcon)
	end

	if slot1 then
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuildingIcon, slot1)
		gohelper.setActive(slot0._gobuildingIcon, true)
	end
end

function slot0.refreshLockIcon(slot0)
	slot1 = false

	if slot0._isShowLockIcon and slot0.mo then
		slot1 = slot0.mo:isLock()
	end

	gohelper.setActive(slot0._golocked, slot1)
end

function slot0.refreshMaturityIcon(slot0)
	slot1 = false

	if slot0._isShowMaturityIcon and slot0.mo then
		slot1 = slot0.mo:isMaturity()
	end

	gohelper.setActive(slot0._gomaturity, slot1)
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot0._isShowSelectedUI and slot1)
end

function slot0.showIndex(slot0, slot1)
	if slot1 then
		slot0._txtindex.text = slot1
	end

	gohelper.setActive(slot0._goindex, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._simageicon then
		slot0._simageicon:UnLoadImage()

		slot0._simageicon = nil
	end
end

return slot0
