module("modules.logic.character.view.CharacterSkinFullScreenView", package.seeall)

local var_0_0 = class("CharacterSkinFullScreenView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "#go_scroll")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if GamepadController.instance:isOpen() then
		arg_2_0:addEventCb(GamepadController.instance, GamepadEvent.AxisChange, arg_2_0._onAxisChange, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	if GamepadController.instance:isOpen() then
		arg_3_0:removeEventCb(GamepadController.instance, GamepadEvent.AxisChange, arg_3_0._onAxisChange, arg_3_0)
	end
end

var_0_0.retainRate = 0.2
var_0_0.live2dRetainRate = 0.4
var_0_0.RetainRate = {
	Live2DHeight = 0.2,
	Live2DWidth = 0.4,
	Normal = 0.2
}
var_0_0.DefaultLive2dOffsetY = -350
var_0_0.DefaultLive2dCameraSize = 14

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))

	arg_5_0._image = gohelper.findChildImage(arg_5_0.viewGO, "#go_scroll/#simage_pic")
	arg_5_0._scrollRect = SLFramework.UGUI.ScrollRectWrap.Get(arg_5_0._goscroll)
	arg_5_0._scrollTransform = arg_5_0._goscroll.transform
	arg_5_0.goInteractArea = gohelper.findChild(arg_5_0.viewGO, "#go_scroll/interactable_area")
	arg_5_0.goDynamicContainer = gohelper.findChild(arg_5_0.viewGO, "#go_scroll/dynamicContainer")
	arg_5_0.goImageContainer = gohelper.findChild(arg_5_0.viewGO, "#go_scroll/dynamicContainer/#go_imagecontainer")
	arg_5_0.goSpineContainer = gohelper.findChild(arg_5_0.viewGO, "#go_scroll/dynamicContainer/#go_spinecontainer")
	arg_5_0._spineContainerTransform = arg_5_0.goSpineContainer.transform
	arg_5_0.simageSkin = gohelper.findChildSingleImage(arg_5_0.viewGO, "#go_scroll/dynamicContainer/#go_imagecontainer/#simage_skin")
	arg_5_0.goSpineSkin = gohelper.findChild(arg_5_0.viewGO, "#go_scroll/dynamicContainer/#go_spinecontainer/#go_spine")
	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_5_0.goInteractArea)

	arg_5_0._drag:AddDragBeginListener(arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0._onDragEnd, arg_5_0)
	arg_5_0._drag:AddDragListener(arg_5_0._onDrag, arg_5_0)

	arg_5_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_5_0.goInteractArea)

	arg_5_0._touchEventMgr:SetIgnoreUI(true)
	arg_5_0._touchEventMgr:SetOnMultiDragCb(arg_5_0.onScaleHandler, arg_5_0)
	arg_5_0._touchEventMgr:SetScrollWheelCb(arg_5_0.onMouseScrollWheelChange, arg_5_0)
end

function var_0_0._onDragBegin(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0.loadDone then
		return
	end

	arg_6_0._startDragPos = recthelper.screenPosToAnchorPos(arg_6_2.position, arg_6_0._scrollTransform)

	local var_6_0, var_6_1 = recthelper.getAnchor(arg_6_0.interactTr, 0, 0)

	arg_6_0._startImagePos = Vector2(var_6_0, var_6_1)

	arg_6_0:_showDragEffect(false)
end

function var_0_0._onDragEnd(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.loadDone then
		return
	end

	arg_7_0._scale = false
	arg_7_0._startDragPos = nil

	arg_7_0:_showDragEffect(true)
end

function var_0_0._onDrag(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.loadDone then
		return
	end

	if arg_8_0._scale or not arg_8_0._startDragPos then
		return
	end

	local var_8_0 = recthelper.screenPosToAnchorPos(arg_8_2.position, arg_8_0._scrollTransform) - arg_8_0._startDragPos
	local var_8_1 = arg_8_0._startImagePos.x + var_8_0.x
	local var_8_2 = arg_8_0._startImagePos.y + var_8_0.y

	arg_8_0:SetAnchor(var_8_1, var_8_2)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._showSkinConfig = arg_10_0.viewParam.skinCo
	arg_10_0._showEnum = arg_10_0.viewParam.showEnum or CharacterEnum.ShowSkinEnum.Static
	arg_10_0.isLive2D = not string.nilorempty(arg_10_0._showSkinConfig.live2d)
	arg_10_0.skinIndex = arg_10_0._showSkinConfig.id - arg_10_0._showSkinConfig.characterId * 100
	arg_10_0._screenWidth = recthelper.getWidth(arg_10_0.viewGO.transform)
	arg_10_0._screenHeight = recthelper.getHeight(arg_10_0.viewGO.transform)
	arg_10_0.curScaleX = 1
	arg_10_0.curScaleY = 1
	arg_10_0._maxScale = 2
	arg_10_0._minScale = 0.8
	arg_10_0.initScaleX = 1
	arg_10_0.initScaleY = 1
	arg_10_0._deltaScale = 0.2
	arg_10_0.interactTr = arg_10_0.simageSkin.transform
	arg_10_0.retainRateW = var_0_0.RetainRate.Normal
	arg_10_0.retainRateH = var_0_0.RetainRate.Normal
	arg_10_0.imageWidth = recthelper.getWidth(arg_10_0.interactTr)
	arg_10_0.imageHeight = recthelper.getHeight(arg_10_0.interactTr)

	arg_10_0:setContainerAnchor()
	arg_10_0:refreshSkin()
end

function var_0_0.setContainerAnchor(arg_11_0)
	local var_11_0 = arg_11_0.goDynamicContainer.transform

	if arg_11_0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and not arg_11_0.isLive2D then
		var_11_0.anchorMin = RectTransformDefine.Anchor.CenterBottom
		var_11_0.anchorMax = RectTransformDefine.Anchor.CenterBottom

		recthelper.setAnchorY(var_11_0, -700)
	else
		var_11_0.anchorMin = RectTransformDefine.Anchor.CenterMiddle
		var_11_0.anchorMax = RectTransformDefine.Anchor.CenterMiddle

		recthelper.setAnchorY(var_11_0, 0)
	end
end

function var_0_0.refreshSkin(arg_12_0)
	gohelper.setActive(arg_12_0.goImageContainer, arg_12_0._showEnum == CharacterEnum.ShowSkinEnum.Static)
	gohelper.setActive(arg_12_0.goSpineContainer, arg_12_0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic)

	if arg_12_0._showEnum == CharacterEnum.ShowSkinEnum.Static then
		arg_12_0:refreshStaticVertical()
	elseif arg_12_0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic then
		arg_12_0:refreshDynamicVertical()
	end
end

function var_0_0.refreshStaticVertical(arg_13_0)
	arg_13_0.simageSkin:LoadImage(ResUrl.getHeadIconImg(arg_13_0._showSkinConfig.drawing), arg_13_0._onLoad, arg_13_0)
end

function var_0_0._onLoad(arg_14_0)
	ZProj.UGUIHelper.SetImageSize(arg_14_0.simageSkin.gameObject)

	arg_14_0.interactTr = arg_14_0.simageSkin.transform
	arg_14_0.imageWidth = recthelper.getWidth(arg_14_0.interactTr)
	arg_14_0.imageHeight = recthelper.getHeight(arg_14_0.interactTr)

	local var_14_0 = SkinConfig.instance:getSkinOffset(arg_14_0._showSkinConfig.skinViewImgOffset, {
		0,
		0,
		0.8
	})

	recthelper.setAnchor(arg_14_0.interactTr, 0, var_14_0[2])
	transformhelper.setLocalScale(arg_14_0.interactTr, var_14_0[3], var_14_0[3], var_14_0[3])

	arg_14_0.initScaleX = var_14_0[3]
	arg_14_0.initScaleY = var_14_0[3]
	arg_14_0.retainRateW = var_0_0.RetainRate.Normal
	arg_14_0.retainRateH = var_0_0.RetainRate.Normal

	arg_14_0:calculateDragBorder()

	arg_14_0.loadDone = true
end

function var_0_0.refreshDynamicVertical(arg_15_0)
	arg_15_0.interactTr = arg_15_0.goSpineSkin.transform
	arg_15_0.imageWidth = 800
	arg_15_0.imageHeight = 1400
	arg_15_0._uiSpine = GuiModelAgent.Create(arg_15_0.goSpineSkin, true)

	arg_15_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.FullScreen)

	if arg_15_0.isLive2D then
		arg_15_0._uiSpine:setLive2dCameraLoadedCallback(arg_15_0.onLive2dCameraLoadedCallback, arg_15_0)
	end

	local var_15_0 = arg_15_0._showSkinConfig.fullScreenCameraSize

	if var_15_0 <= 0 then
		var_15_0 = var_0_0.DefaultLive2dCameraSize
	end

	arg_15_0._uiSpine:setResPath(arg_15_0._showSkinConfig, arg_15_0._onUISpineLoaded, arg_15_0, var_15_0)
end

function var_0_0._showDragEffect(arg_16_0, arg_16_1)
	if arg_16_0._uiSpine then
		arg_16_0._uiSpine:showDragEffect(arg_16_1)
	end
end

function var_0_0._onUISpineLoaded(arg_17_0)
	arg_17_0._uiSpine:initSkinDragEffect(arg_17_0._showSkinConfig.id)

	arg_17_0.retainRateW = var_0_0.RetainRate.Live2DWidth
	arg_17_0.retainRateH = var_0_0.RetainRate.Live2DHeight

	local var_17_0

	if arg_17_0.isLive2D then
		var_17_0 = arg_17_0._showSkinConfig.fullScreenLive2dOffset
	end

	if string.nilorempty(var_17_0) then
		var_17_0 = arg_17_0._showSkinConfig.characterViewOffset
	end

	local var_17_1 = SkinConfig.instance:getSkinOffset(var_17_0)

	recthelper.setAnchor(arg_17_0.goSpineSkin.transform, var_17_1[1], var_17_1[2])
	transformhelper.setLocalScale(arg_17_0.goSpineSkin.transform, var_17_1[3], var_17_1[3], var_17_1[3])

	if not arg_17_0.isLive2D then
		arg_17_0.initScaleX = var_17_1[3]
		arg_17_0.initScaleY = var_17_1[3]
	else
		arg_17_0.initScaleX = 1
		arg_17_0.initScaleY = 1
	end

	arg_17_0:calculateDragBorder()

	arg_17_0.loadDone = true
end

function var_0_0.onLive2dCameraLoadedCallback(arg_18_0, arg_18_1)
	arg_18_0.retainRateW = var_0_0.RetainRate.Live2DWidth
	arg_18_0.retainRateH = var_0_0.RetainRate.Live2DHeight
	arg_18_0.interactTr = arg_18_1._rawImageGo.transform
	arg_18_0.imageWidth = arg_18_1._rt.width
	arg_18_0.imageHeight = arg_18_1._rt.height

	gohelper.addChild(arg_18_0.goDynamicContainer, arg_18_1._rawImageGo)
	gohelper.setAsFirstSibling(arg_18_1._rawImageGo)
	arg_18_0:calculateDragBorder()
	arg_18_0:SetAnchor(0, var_0_0.DefaultLive2dOffsetY)
end

function var_0_0.calculateDragBorder(arg_19_0)
	local var_19_0 = arg_19_0.imageWidth * arg_19_0.curScaleX
	local var_19_1 = arg_19_0.imageHeight * arg_19_0.curScaleY

	arg_19_0.maxX = arg_19_0._screenWidth / 2 + var_19_0 * (0.5 - arg_19_0.retainRateW)
	arg_19_0.minX = -arg_19_0.maxX
	arg_19_0.maxY = arg_19_0._screenHeight / 2 + var_19_1 * (0.5 - arg_19_0.retainRateH)
	arg_19_0.minY = -arg_19_0.maxY
end

function var_0_0.onTouchDown(arg_20_0)
	arg_20_0.isFirstScaleHandle = true
end

function var_0_0.onTouchUp(arg_21_0)
	arg_21_0.isFirstScaleHandle = true
end

function var_0_0.onScaleHandler(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_0.loadDone then
		return
	end

	if arg_22_0.isFirstScaleHandle then
		arg_22_0.isFirstScaleHandle = false

		return
	end

	arg_22_0._scale = true
	arg_22_0._clickDown = false

	local var_22_0 = arg_22_2 * 0.01

	arg_22_0.curScaleX = arg_22_0.curScaleX + var_22_0
	arg_22_0.curScaleY = arg_22_0.curScaleY + var_22_0

	arg_22_0:setLocalScale()
end

function var_0_0._onAxisChange(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == GamepadEnum.KeyCode.RightStickHorizontal then
		arg_23_0:onMouseScrollWheelChange(arg_23_2 * 0.1)
	elseif arg_23_1 == GamepadEnum.KeyCode.RightStickVertical then
		arg_23_0:onMouseScrollWheelChange(arg_23_2 * 0.1)
	end
end

function var_0_0.onMouseScrollWheelChange(arg_24_0, arg_24_1)
	if not arg_24_0.loadDone then
		return
	end

	arg_24_0.curScaleX = arg_24_0.curScaleX + arg_24_1
	arg_24_0.curScaleY = arg_24_0.curScaleY + arg_24_1

	arg_24_0:setLocalScale()
end

function var_0_0.setLocalScale(arg_25_0)
	arg_25_0.curScaleX = math.min(arg_25_0.curScaleX, arg_25_0._maxScale)
	arg_25_0.curScaleY = math.min(arg_25_0.curScaleY, arg_25_0._maxScale)
	arg_25_0.curScaleX = math.max(arg_25_0.curScaleX, arg_25_0._minScale)
	arg_25_0.curScaleY = math.max(arg_25_0.curScaleY, arg_25_0._minScale)

	local var_25_0 = arg_25_0.curScaleX * arg_25_0.initScaleX
	local var_25_1 = arg_25_0.curScaleY * arg_25_0.initScaleY

	if arg_25_0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and arg_25_0.isLive2D then
		transformhelper.setLocalScale(arg_25_0._spineContainerTransform, var_25_0, var_25_1, 1)
	else
		transformhelper.setLocalScale(arg_25_0.interactTr, var_25_0, var_25_1, 1)
	end

	arg_25_0:calculateDragBorder()
	arg_25_0:SetAnchor(recthelper.getAnchorX(arg_25_0.interactTr), recthelper.getAnchorY(arg_25_0.interactTr))
end

function var_0_0.SetAnchor(arg_26_0, arg_26_1, arg_26_2)
	arg_26_1 = math.min(arg_26_1, arg_26_0.maxX)
	arg_26_1 = math.max(arg_26_1, arg_26_0.minX)
	arg_26_2 = math.min(arg_26_2, arg_26_0.maxY)
	arg_26_2 = math.max(arg_26_2, arg_26_0.minY)

	recthelper.setAnchor(arg_26_0.interactTr, arg_26_1, arg_26_2)

	if arg_26_0._showEnum == CharacterEnum.ShowSkinEnum.Dynamic and arg_26_0.isLive2D then
		recthelper.setAnchor(arg_26_0._spineContainerTransform, arg_26_1, arg_26_2)
	end
end

function var_0_0.onClose(arg_27_0)
	gohelper.setActive(arg_27_0.goSpineSkin, false)
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._drag:RemoveDragBeginListener()
	arg_28_0._drag:RemoveDragListener()
	arg_28_0._drag:RemoveDragEndListener()

	if arg_28_0._touchEventMgr then
		TouchEventMgrHepler.remove(arg_28_0._touchEventMgr)

		arg_28_0._touchEventMgr = nil
	end

	if arg_28_0._uiSpine then
		arg_28_0._uiSpine:onDestroy()

		arg_28_0._uiSpine = nil
	end

	arg_28_0.simageSkin:UnLoadImage()
	arg_28_0._simagebg:UnLoadImage()
end

return var_0_0
