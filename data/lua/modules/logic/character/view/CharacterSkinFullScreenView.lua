module("modules.logic.character.view.CharacterSkinFullScreenView", package.seeall)

slot0 = class("CharacterSkinFullScreenView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "#go_scroll")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.AxisChange, slot0._onAxisChange, slot0)
	end
end

function slot0.removeEvents(slot0)
	if GamepadController.instance:isOpen() then
		slot0:removeEventCb(GamepadController.instance, GamepadEvent.AxisChange, slot0._onAxisChange, slot0)
	end
end

slot0.retainRate = 0.2
slot0.live2dRetainRate = 0.4
slot0.RetainRate = {
	Live2DHeight = 0.2,
	Live2DWidth = 0.4,
	Normal = 0.2
}
slot0.DefaultLive2dOffsetY = -350
slot0.DefaultLive2dCameraSize = 14

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))

	slot0._image = gohelper.findChildImage(slot0.viewGO, "#go_scroll/#simage_pic")
	slot0._scrollRect = SLFramework.UGUI.ScrollRectWrap.Get(slot0._goscroll)
	slot0._scrollTransform = slot0._goscroll.transform
	slot0.goInteractArea = gohelper.findChild(slot0.viewGO, "#go_scroll/interactable_area")
	slot0.goDynamicContainer = gohelper.findChild(slot0.viewGO, "#go_scroll/dynamicContainer")
	slot0.goImageContainer = gohelper.findChild(slot0.viewGO, "#go_scroll/dynamicContainer/#go_imagecontainer")
	slot0.goSpineContainer = gohelper.findChild(slot0.viewGO, "#go_scroll/dynamicContainer/#go_spinecontainer")
	slot0._spineContainerTransform = slot0.goSpineContainer.transform
	slot0.simageSkin = gohelper.findChildSingleImage(slot0.viewGO, "#go_scroll/dynamicContainer/#go_imagecontainer/#simage_skin")
	slot0.goSpineSkin = gohelper.findChild(slot0.viewGO, "#go_scroll/dynamicContainer/#go_spinecontainer/#go_spine")
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0.goInteractArea)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)

	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0.goInteractArea)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetOnMultiDragCb(slot0.onScaleHandler, slot0)
	slot0._touchEventMgr:SetScrollWheelCb(slot0.onMouseScrollWheelChange, slot0)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if not slot0.loadDone then
		return
	end

	slot0._startDragPos = recthelper.screenPosToAnchorPos(slot2.position, slot0._scrollTransform)
	slot3, slot4 = recthelper.getAnchor(slot0.interactTr, 0, 0)
	slot0._startImagePos = Vector2(slot3, slot4)

	slot0:_showDragEffect(false)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if not slot0.loadDone then
		return
	end

	slot0._scale = false
	slot0._startDragPos = nil

	slot0:_showDragEffect(true)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0.loadDone then
		return
	end

	if slot0._scale or not slot0._startDragPos then
		return
	end

	slot4 = recthelper.screenPosToAnchorPos(slot2.position, slot0._scrollTransform) - slot0._startDragPos

	slot0:SetAnchor(slot0._startImagePos.x + slot4.x, slot0._startImagePos.y + slot4.y)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._showSkinConfig = slot0.viewParam.skinCo
	slot0._showEnum = slot0.viewParam.showEnum or CharacterEnum.ShowSkinEnum.Static
	slot0.isLive2D = not string.nilorempty(slot0._showSkinConfig.live2d)
	slot0.skinIndex = slot0._showSkinConfig.id - slot0._showSkinConfig.characterId * 100
	slot0._screenWidth = recthelper.getWidth(slot0.viewGO.transform)
	slot0._screenHeight = recthelper.getHeight(slot0.viewGO.transform)
	slot0.curScaleX = 1
	slot0.curScaleY = 1
	slot0._maxScale = 2
	slot0._minScale = 0.8
	slot0.initScaleX = 1
	slot0.initScaleY = 1
	slot0._deltaScale = 0.2
	slot0.interactTr = slot0.simageSkin.transform
	slot0.retainRateW = uv0.RetainRate.Normal
	slot0.retainRateH = uv0.RetainRate.Normal
	slot0.imageWidth = recthelper.getWidth(slot0.interactTr)
	slot0.imageHeight = recthelper.getHeight(slot0.interactTr)

	slot0:setContainerAnchor()
	slot0:refreshSkin()
end

function slot0.setContainerAnchor(slot0)
	slot1 = slot0.goDynamicContainer.transform

	if slot0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and not slot0.isLive2D then
		slot1.anchorMin = RectTransformDefine.Anchor.CenterBottom
		slot1.anchorMax = RectTransformDefine.Anchor.CenterBottom

		recthelper.setAnchorY(slot1, -700)
	else
		slot1.anchorMin = RectTransformDefine.Anchor.CenterMiddle
		slot1.anchorMax = RectTransformDefine.Anchor.CenterMiddle

		recthelper.setAnchorY(slot1, 0)
	end
end

function slot0.refreshSkin(slot0)
	gohelper.setActive(slot0.goImageContainer, slot0._showEnum == CharacterEnum.ShowSkinEnum.Static)
	gohelper.setActive(slot0.goSpineContainer, slot0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic)

	if slot0._showEnum == CharacterEnum.ShowSkinEnum.Static then
		slot0:refreshStaticVertical()
	elseif slot0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic then
		slot0:refreshDynamicVertical()
	end
end

function slot0.refreshStaticVertical(slot0)
	slot0.simageSkin:LoadImage(ResUrl.getHeadIconImg(slot0._showSkinConfig.drawing), slot0._onLoad, slot0)
end

function slot0._onLoad(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0.simageSkin.gameObject)

	slot0.interactTr = slot0.simageSkin.transform
	slot0.imageWidth = recthelper.getWidth(slot0.interactTr)
	slot0.imageHeight = recthelper.getHeight(slot0.interactTr)
	slot1 = SkinConfig.instance:getSkinOffset(slot0._showSkinConfig.skinViewImgOffset, {
		0,
		0,
		0.8
	})

	recthelper.setAnchor(slot0.interactTr, 0, slot1[2])
	transformhelper.setLocalScale(slot0.interactTr, slot1[3], slot1[3], slot1[3])

	slot0.initScaleX = slot1[3]
	slot0.initScaleY = slot1[3]
	slot0.retainRateW = uv0.RetainRate.Normal
	slot0.retainRateH = uv0.RetainRate.Normal

	slot0:calculateDragBorder()

	slot0.loadDone = true
end

function slot0.refreshDynamicVertical(slot0)
	slot0.interactTr = slot0.goSpineSkin.transform
	slot0.imageWidth = 800
	slot0.imageHeight = 1400
	slot0._uiSpine = GuiModelAgent.Create(slot0.goSpineSkin, true)

	if slot0.isLive2D then
		slot0._uiSpine:setLive2dCameraLoadedCallback(slot0.onLive2dCameraLoadedCallback, slot0)
	end

	if slot0._showSkinConfig.fullScreenCameraSize <= 0 then
		slot1 = uv0.DefaultLive2dCameraSize
	end

	slot0._uiSpine:setResPath(slot0._showSkinConfig, slot0._onUISpineLoaded, slot0, slot1)
end

function slot0._showDragEffect(slot0, slot1)
	if slot0._uiSpine then
		slot0._uiSpine:showDragEffect(slot1)
	end
end

function slot0._onUISpineLoaded(slot0)
	slot0._uiSpine:initSkinDragEffect(slot0._showSkinConfig.id)

	slot0.retainRateW = uv0.RetainRate.Live2DWidth
	slot0.retainRateH = uv0.RetainRate.Live2DHeight
	slot1 = nil

	if slot0.isLive2D then
		slot1 = slot0._showSkinConfig.fullScreenLive2dOffset
	end

	if string.nilorempty(slot1) then
		slot1 = slot0._showSkinConfig.characterViewOffset
	end

	slot2 = SkinConfig.instance:getSkinOffset(slot1)

	recthelper.setAnchor(slot0.goSpineSkin.transform, slot2[1], slot2[2])
	transformhelper.setLocalScale(slot0.goSpineSkin.transform, slot2[3], slot2[3], slot2[3])

	if not slot0.isLive2D then
		slot0.initScaleX = slot2[3]
		slot0.initScaleY = slot2[3]
	else
		slot0.initScaleX = 1
		slot0.initScaleY = 1
	end

	slot0:calculateDragBorder()

	slot0.loadDone = true
end

function slot0.onLive2dCameraLoadedCallback(slot0, slot1)
	slot0.retainRateW = uv0.RetainRate.Live2DWidth
	slot0.retainRateH = uv0.RetainRate.Live2DHeight
	slot0.interactTr = slot1._rawImageGo.transform
	slot0.imageWidth = slot1._rt.width
	slot0.imageHeight = slot1._rt.height

	gohelper.addChild(slot0.goDynamicContainer, slot1._rawImageGo)
	gohelper.setAsFirstSibling(slot1._rawImageGo)
	slot0:calculateDragBorder()
	slot0:SetAnchor(0, uv0.DefaultLive2dOffsetY)
end

function slot0.calculateDragBorder(slot0)
	slot0.maxX = slot0._screenWidth / 2 + slot0.imageWidth * slot0.curScaleX * (0.5 - slot0.retainRateW)
	slot0.minX = -slot0.maxX
	slot0.maxY = slot0._screenHeight / 2 + slot0.imageHeight * slot0.curScaleY * (0.5 - slot0.retainRateH)
	slot0.minY = -slot0.maxY
end

function slot0.onTouchDown(slot0)
	slot0.isFirstScaleHandle = true
end

function slot0.onTouchUp(slot0)
	slot0.isFirstScaleHandle = true
end

function slot0.onScaleHandler(slot0, slot1, slot2)
	if not slot0.loadDone then
		return
	end

	if slot0.isFirstScaleHandle then
		slot0.isFirstScaleHandle = false

		return
	end

	slot0._scale = true
	slot0._clickDown = false
	slot3 = slot2 * 0.01
	slot0.curScaleX = slot0.curScaleX + slot3
	slot0.curScaleY = slot0.curScaleY + slot3

	slot0:setLocalScale()
end

function slot0._onAxisChange(slot0, slot1, slot2)
	if slot1 == GamepadEnum.KeyCode.RightStickHorizontal then
		slot0:onMouseScrollWheelChange(slot2 * 0.1)
	elseif slot1 == GamepadEnum.KeyCode.RightStickVertical then
		slot0:onMouseScrollWheelChange(slot2 * 0.1)
	end
end

function slot0.onMouseScrollWheelChange(slot0, slot1)
	if not slot0.loadDone then
		return
	end

	slot0.curScaleX = slot0.curScaleX + slot1
	slot0.curScaleY = slot0.curScaleY + slot1

	slot0:setLocalScale()
end

function slot0.setLocalScale(slot0)
	slot0.curScaleX = math.min(slot0.curScaleX, slot0._maxScale)
	slot0.curScaleY = math.min(slot0.curScaleY, slot0._maxScale)
	slot0.curScaleX = math.max(slot0.curScaleX, slot0._minScale)
	slot0.curScaleY = math.max(slot0.curScaleY, slot0._minScale)

	if slot0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and slot0.isLive2D then
		transformhelper.setLocalScale(slot0._spineContainerTransform, slot0.curScaleX * slot0.initScaleX, slot0.curScaleY * slot0.initScaleY, 1)
	else
		transformhelper.setLocalScale(slot0.interactTr, slot1, slot2, 1)
	end

	slot0:calculateDragBorder()
	slot0:SetAnchor(recthelper.getAnchorX(slot0.interactTr), recthelper.getAnchorY(slot0.interactTr))
end

function slot0.SetAnchor(slot0, slot1, slot2)
	recthelper.setAnchor(slot0.interactTr, math.max(math.min(slot1, slot0.maxX), slot0.minX), math.max(math.min(slot2, slot0.maxY), slot0.minY))

	if slot0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and slot0.isLive2D then
		recthelper.setAnchor(slot0._spineContainerTransform, slot1, slot2)
	end
end

function slot0.onClose(slot0)
	gohelper.setActive(slot0.goSpineSkin, false)
end

function slot0.onDestroyView(slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()

	if slot0._touchEventMgr then
		TouchEventMgrHepler.remove(slot0._touchEventMgr)

		slot0._touchEventMgr = nil
	end

	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end

	slot0.simageSkin:UnLoadImage()
	slot0._simagebg:UnLoadImage()
end

return slot0
