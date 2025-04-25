module("modules.logic.room.view.critter.summon.RoomCritterSummonResultItem", package.seeall)

slot0 = class("RoomCritterSummonResultItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goegg = gohelper.findChild(slot0.viewGO, "#go_egg")
	slot0._gocritter = gohelper.findChild(slot0.viewGO, "#go_critter")
	slot0._imagequality = gohelper.findChildImage(slot0.viewGO, "#go_critter/#image_quality")
	slot0._imagequalitylight = gohelper.findChildImage(slot0.viewGO, "#go_critter/#image_qualitylight")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_critter/#simage_icon")
	slot0._simagecard = gohelper.findChildSingleImage(slot0.viewGO, "#go_critter/#simage_card")
	slot0._btnopenEgg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_openEgg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnopenEgg:AddClickListener(slot0._btnopenEggOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnopenEgg:RemoveClickListener()
end

function slot0._btnopenEggOnClick(slot0)
	if not slot0.critterMO or slot0:_isLockOp() then
		return
	end

	slot0:_setLockTime(0.5)

	if slot0._isOpenEgg then
		CritterController.instance:openRoomCritterDetailView(not slot0.critterMO:isMaturity(), slot0.critterMO)

		return
	end

	CritterSummonController.instance:openSummonGetCritterView({
		mode = RoomSummonEnum.SummonType.Summon,
		critterMo = slot0.critterMO
	}, true)
	slot0:setOpenEgg(true)
end

function slot0._isLockOp(slot0)
	if slot0._nextLockTime and Time.time < slot0._nextLockTime then
		return true
	end

	return false
end

function slot0._setLockTime(slot0, slot1)
	slot0._nextLockTime = Time.time + tonumber(slot1)
end

function slot0._editableInitView(slot0)
	slot0._iconRareScaleMap = {
		1.3,
		1.3,
		1.3,
		1.8,
		1.8
	}
	slot0._isOpenEgg = false
	slot0._eggDict = {}
	slot0._simageiconTrs = slot0._simageicon.transform
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)

	slot0:setOpenEgg(slot0._isOpenEgg)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.critterMO = slot1

	gohelper.setActive(slot0.viewGO, slot1)
	slot0:_refreshUI()
end

function slot0.setOpenEgg(slot0, slot1)
	slot2 = false

	if slot1 == true then
		slot2 = true
	end

	slot0._isOpenEgg = slot2

	gohelper.setActive(slot0._gocritter, slot0._isOpenEgg and slot0._isLaseOpenEgg)
end

function slot0.playAnim(slot0, slot1)
	slot2 = false

	if slot1 == true then
		slot2 = true
	end

	if slot0._isLaseOpenEgg == slot2 then
		return false
	end

	slot0._isLaseOpenEgg = slot2

	if slot0._eggDict[slot0._lastRate] then
		if slot0._isLaseOpenEgg then
			slot3:playOpenAnim()
		else
			slot3:playIdleAnim()
		end
	end

	gohelper.setActive(slot0._gocritter, slot0._isLaseOpenEgg)
	slot0._animatorPlayer:Play(slot0._isLaseOpenEgg and "open" or "close", nil, )
	slot0:_setLockTime(0.5)

	return true
end

function slot0.isOpenEgg(slot0)
	return slot0._isOpenEgg
end

function slot0.onSelect(slot0, slot1)
end

slot0._EGG_NAME_DICT = {
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg1.prefab",
	"roomcrittersummonresult_egg2.prefab",
	"roomcrittersummonresult_egg3.prefab"
}

function slot0._setShowCompByRare(slot0, slot1)
	if slot0._lastRate == slot1 then
		return
	end

	slot0._lastRate = slot1

	if not slot0._eggDict[slot1] and CritterEnum.QualityEggSummomResNameMap[slot1] then
		slot4 = slot0._view:getResInst(ResUrl.getRoomCritterEggPrefab(slot2), slot0._goegg)

		transformhelper.setLocalScale(slot4.transform, 0.55, 0.55, 0.55)

		slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, RoomGetCritterEgg)
		slot5.eggRare = slot1
		slot0._eggDict[slot1] = slot5

		if slot0._isLaseOpenEgg then
			slot5:playOpenAnim()
		else
			slot5:playIdleAnim()
		end
	end

	for slot5, slot6 in pairs(slot0._eggDict) do
		gohelper.setActive(slot6.go, slot5 == slot1)
	end
end

function slot0.openEggAnim(slot0)
end

function slot0._refreshUI(slot0)
	if not slot0.critterMO then
		return
	end

	if CritterConfig.instance:getCritterRare(slot0.critterMO.defineId) then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imagequality, CritterEnum.QualityEggImageNameMap[slot1])
		UISpriteSetMgr.instance:setCritterSprite(slot0._imagequalitylight, CritterEnum.QualityEggLightImageNameMap[slot1])

		slot2 = slot0._iconRareScaleMap[slot1] or 1

		transformhelper.setLocalScale(slot0._simageiconTrs, slot2, slot2, slot2)
		slot0:_setShowCompByRare(slot1)
	end

	if not string.nilorempty(CritterConfig.instance:getCritterHeadIcon(slot0.critterMO:getSkinId())) then
		slot0._simageicon:LoadImage(ResUrl.getCritterLargeIcon(slot2))
	end

	if CritterConfig.instance:getCritterRareCfg(slot1) then
		slot0._simagecard:LoadImage(ResUrl.getRoomCritterIcon(slot3.cardRes))
	end
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
	slot0._simagecard:UnLoadImage()

	for slot4, slot5 in pairs(slot0._eggDict) do
		slot5:onDestroy()
	end
end

return slot0
