module("modules.logic.season.view1_6.Season1_6CelebrityCardEquip", package.seeall)

slot0 = class("Season1_6CelebrityCardEquip", LuaCompBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0.viewGO = slot1
	slot0._gorare5 = gohelper.findChild(slot0.viewGO, "#go_rare5")
	slot0._gorare4 = gohelper.findChild(slot0.viewGO, "#go_rare4")
	slot0._gorare3 = gohelper.findChild(slot0.viewGO, "#go_rare3")
	slot0._gorare2 = gohelper.findChild(slot0.viewGO, "#go_rare2")
	slot0._gorare1 = gohelper.findChild(slot0.viewGO, "#go_rare1")
	slot0._gobtnclick = gohelper.findChild(slot0.viewGO, "btn_click")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "tag")
	slot0._gotype1 = gohelper.findChild(slot0.viewGO, "tag/#go_type1")
	slot0._imageType1 = gohelper.findChildImage(slot0.viewGO, "tag/#go_type1")
	slot0._gotype2 = gohelper.findChild(slot0.viewGO, "tag/#go_type2")
	slot0._gotype3 = gohelper.findChild(slot0.viewGO, "tag/#go_type3")
	slot0._gotype4 = gohelper.findChild(slot0.viewGO, "tag/#go_type4")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

slot0.MaxRare = 5

function slot0._editableInitView(slot0)
	slot0._rareGoMap = {}

	for slot4 = 1, uv0.MaxRare do
		slot0._rareGoMap[slot4] = slot0:createRareMap(slot0["_gorare" .. tostring(slot4)])
	end

	slot0._darkMaskColor = "#ffffff"
	slot0._showTag = false
	slot0._showProbability = false
	slot0._showNewFlag = false
	slot0._showNewFlag2 = false
end

function slot0.onDestroy(slot0)
	slot0:disposeUI()
end

function slot0.checkInitBtnClick(slot0)
	if not slot0._btnclick then
		slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn_click")

		slot0._btnclick:AddClickListener(slot0.onClickCall, slot0)
	end
end

function slot0.checkInitLongPress(slot0)
	if not slot0._btnClickLongPrees then
		slot0._btnClickLongPrees = SLFramework.UGUI.UILongPressListener.Get(slot0._gobtnclick)

		slot0._btnClickLongPrees:AddLongPressListener(slot0.onLongPressCall, slot0)
	end
end

function slot0.disposeUI(slot0)
	if not slot0._isDisposed then
		for slot4, slot5 in pairs(slot0._rareGoMap) do
			if not gohelper.isNil(slot5.simageIcon) then
				slot5.simageIcon:UnLoadImage()
			end

			if not gohelper.isNil(slot5.simageSignature) then
				slot5.simageSignature:UnLoadImage()
			end
		end

		if slot0._btnClickLongPrees then
			slot0._btnClickLongPrees:RemoveLongPressListener()

			slot0._btnClickLongPrees = nil
		end

		if slot0._btnclick then
			slot0._btnclick:RemoveClickListener()

			slot0._btnclick = nil
		end

		slot0._isDisposed = true
	end
end

function slot0.updateData(slot0, slot1)
	slot0.itemId = slot1

	slot0:refreshUI()
end

function slot0.createRareMap(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.goSelfChoice = gohelper.findChild(slot1, "#go_rare6")
	slot2.imageCareer = gohelper.findChildImage(slot1, "image_career")
	slot2.simageIcon = gohelper.findChildSingleImage(slot1, "mask/image_icon")
	slot2.simageSignature = gohelper.findChildSingleImage(slot1, "simage_signature")
	slot2.imageIcon = gohelper.findChildImage(slot1, "mask/image_icon")
	slot2.imageSignature = gohelper.findChildImage(slot1, "simage_signature")
	slot2.imageBg = gohelper.findChildImage(slot1, "bg")
	slot2.goSelfChoice = gohelper.findChild(slot1, "go_selfchoice")
	slot2.imageDecorate = gohelper.findChildImage(slot1, "icon")

	return slot2
end

function slot0.refreshUI(slot0)
	if not slot0.itemId then
		return
	end

	slot0._goCurSelected = nil
	slot0._cfg = SeasonConfig.instance:getSeasonEquipCo(slot0.itemId)

	if not slot0._cfg then
		return
	end

	for slot5, slot6 in ipairs(slot0._rareGoMap) do
		slot7 = slot1.rare == slot5

		gohelper.setActive(slot6.go, slot7)

		if slot7 then
			slot0._curSelectedItem = slot6
		end
	end

	slot0:refreshSelfChoice()
	slot0:refreshIcon()
	slot0:refreshFlag()
end

function slot0.refreshSelfChoice(slot0)
	if slot0._curSelectedItem then
		gohelper.setActive(slot0._curSelectedItem.goSelfChoice, SeasonConfig.instance:getEquipIsOptional(slot0.itemId))
	end
end

function slot0.refreshIcon(slot0)
	if slot0._curSelectedItem then
		gohelper.setActive(slot0._curSelectedItem.goSelfChoice, slot0._cfg.isOptional == 1)

		if not string.nilorempty(slot0._cfg.careerIcon) then
			gohelper.setActive(slot1.imageCareer, true)
			UISpriteSetMgr.instance:setCommonSprite(slot1.imageCareer, slot0._cfg.careerIcon)
			SLFramework.UGUI.GuiHelper.SetColor(slot1.imageCareer, slot0._darkMaskColor)
		else
			gohelper.setActive(slot1.imageCareer, false)
		end

		if not string.nilorempty(slot0._cfg.icon) and slot1.simageIcon then
			gohelper.setActive(slot1.simageIcon, true)
			slot1.simageIcon:LoadImage(ResUrl.getSeasonCelebrityCard(slot0._cfg.icon), slot0.handleIconLoaded, slot0)
			SLFramework.UGUI.GuiHelper.SetColor(slot1.imageIcon, slot0._darkMaskColor)
		else
			gohelper.setActive(slot1.simageIcon, false)
		end

		if not string.nilorempty(slot0._cfg.signIcon) and slot1.simageSignature then
			gohelper.setActive(slot1.simageSignature, true)
			slot1.simageSignature:LoadImage(ResUrl.getSignature(slot0._cfg.signIcon, "characterget"))
		elseif slot0._cfg.rare ~= Activity104Enum.MainRoleRare then
			gohelper.setActive(slot1.simageSignature, false)
		end

		if slot1.imageSignature then
			SLFramework.UGUI.GuiHelper.SetColor(slot1.imageSignature, slot0._darkMaskColor)
		end

		if slot1.imageDecorate then
			SLFramework.UGUI.GuiHelper.SetColor(slot1.imageDecorate, slot0._darkMaskColor)
		end

		SLFramework.UGUI.GuiHelper.SetColor(slot1.imageBg, slot0._darkMaskColor)
		SeasonEquipMetaUtils.applyIconOffset(slot0.itemId, slot1.imageIcon, slot1.imageSignature)
	end
end

function slot0.refreshFlag(slot0)
	if not slot0.itemId then
		return
	end

	slot1 = slot0._showProbability and slot0._cfg.isOptional ~= 1
	slot2 = slot0._showTag and slot0._cfg.isOptional == 1
	slot3 = slot0._showNewFlag2 and not slot2
	slot4 = slot0._showNewFlag and not slot2

	gohelper.setActive(slot0._gotag, slot1 or slot2 or slot3 or slot4)
	gohelper.setActive(slot0._gotype1, slot1)
	gohelper.setActive(slot0._gotype2, slot2)
	gohelper.setActive(slot0._gotype3, slot3)
	gohelper.setActive(slot0._gotype4, slot4)
end

function slot0.setFlagUIPos(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	recthelper.setAnchor(slot0._gotag.transform, slot1, slot2)
end

slot1 = 2.3

function slot0.setFlagUIScale(slot0, slot1)
	slot1 = slot1 or uv0

	transformhelper.setLocalScale(slot0._gotag.transform, slot1, slot1, slot1)
end

function slot0.handleIconLoaded(slot0)
	if not slot0._isDisposed and slot0._curSelectedItem then
		gohelper.setActive(slot1.simageIcon, false)
		gohelper.setActive(slot1.simageIcon, true)
	end
end

function slot0.setColorDark(slot0, slot1)
	slot0._darkMaskColor = slot1 and "#7b7b7b" or "#ffffff"

	slot0:refreshIcon()
end

function slot0.setShowTag(slot0, slot1)
	slot0._showTag = slot1

	slot0:refreshFlag()
end

function slot0.setShowProbability(slot0, slot1)
	slot0._showProbability = slot1

	slot0:refreshFlag()
end

function slot0.setShowNewFlag(slot0, slot1)
	slot0._showNewFlag = slot1

	slot0:refreshFlag()
end

function slot0.setShowNewFlag2(slot0, slot1)
	slot0._showNewFlag2 = slot1

	slot0:refreshFlag()
end

function slot0.setClickCall(slot0, slot1, slot2, slot3)
	slot0._clickCallback = slot1
	slot0._clickCallbackObj = slot2
	slot0._clickParam = slot3

	if slot1 then
		slot0:checkInitBtnClick()
	end
end

function slot0.setLongPressCall(slot0, slot1, slot2, slot3)
	slot0._longPressCallback = slot1
	slot0._longPressCallbackObj = slot2
	slot0._longPressParam = slot3

	if slot1 then
		slot0:checkInitLongPress()
	end
end

function slot0.onClickCall(slot0)
	if slot0._clickCallback then
		slot0._clickCallback(slot0._clickCallbackObj, slot0._clickParam)
	end
end

function slot0.onLongPressCall(slot0)
	if slot0._longPressCallback then
		slot0._longPressCallback(slot0._longPressCallbackObj, slot0._longPressParam)
	end
end

return slot0
