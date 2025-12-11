module("modules.logic.store.view.ClothesStorePreviewSkinComp", package.seeall)

local var_0_0 = class("ClothesStorePreviewSkinComp", LuaCompBase)
local var_0_1 = {
	500,
	780
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0._goskincontainer = gohelper.findChild(arg_1_0.viewGO, "bg/characterSpine/#go_skincontainer")
	arg_1_0._gol2dRoot = gohelper.findChild(arg_1_0.viewGO, "bg/characterSpine/#go_skincontainer/#go_l2d")
	arg_1_0._simagel2d = gohelper.findChildSingleImage(arg_1_0._gol2dRoot, "#simage_l2d")
	arg_1_0._gobigspine = gohelper.findChild(arg_1_0._gol2dRoot, "#go_spinecontainer/#go_spine")
	arg_1_0._gospinecontainer = gohelper.findChild(arg_1_0._gol2dRoot, "#go_spinecontainer")
	arg_1_0._go2dRoot = gohelper.findChild(arg_1_0.viewGO, "bg/characterSpine/#go_skincontainer/#go_2d")
	arg_1_0._simage2d = gohelper.findChildSingleImage(arg_1_0._go2dRoot, "#simage_skin")
	arg_1_0._go2dspine = gohelper.findChild(arg_1_0._go2dRoot, "#go_spinecontainer/#go_spine")
	arg_1_0._go2dspinecontainer = gohelper.findChild(arg_1_0._go2dRoot, "#go_spinecontainer")
	arg_1_0._txtcharacterName = gohelper.findChildText(arg_1_0.viewGO, "#txt_characterName")
	arg_1_0._txtskinName = gohelper.findChildText(arg_1_0.viewGO, "#txt_skinName")
	arg_1_0._txtskinNameEn = gohelper.findChildText(arg_1_0.viewGO, "#txt_skinNameEn")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.OnPlaySkinVideo, arg_2_0._onPlaySkinVideo, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_2_0._onOpenFullView, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.OnPlaySkinVideo, arg_3_0._onPlaySkinVideo, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_3_0._onOpenFullView, arg_3_0)
end

function var_0_0._onOpenFullView(arg_4_0)
	arg_4_0:stopVoice()
end

function var_0_0._onPlaySkinVideo(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_0:stopVoice()
end

function var_0_0.setSmallSpineGO(arg_6_0, arg_6_1)
	arg_6_0._gosmallspine = arg_6_1
end

function var_0_0.setGoods(arg_7_0, arg_7_1)
	arg_7_0.goodsMO = arg_7_1
	arg_7_0.showLive2d = StoreClothesGoodsItemListModel.instance:getIsLive2d()

	arg_7_0:refreshView()
end

function var_0_0.refreshView(arg_8_0)
	if not arg_8_0.goodsMO then
		return
	end

	local var_8_0 = arg_8_0.goodsMO.config.product
	local var_8_1 = string.splitToNumber(var_8_0, "#")[2]

	arg_8_0.skinCo = SkinConfig.instance:getSkinCo(var_8_1)

	arg_8_0:refreshBg(arg_8_0.showLive2d)
	arg_8_0:refreshSmallSpine()
	arg_8_0:refreshInfo()
end

function var_0_0.refreshBg(arg_9_0, arg_9_1)
	arg_9_0:clearSkin()
	arg_9_0:setGOActive(arg_9_0._gol2dRoot, arg_9_1)
	gohelper.setActive(arg_9_0._go2dRoot, not arg_9_1)
	recthelper.setAnchor(arg_9_0._goskincontainer.transform, 0, 0)

	if arg_9_1 then
		arg_9_0:refreshLive2d()
	else
		arg_9_0:refresh2d()
	end
end

function var_0_0.setGOActive(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	gohelper.setActive(arg_10_1, true)

	if arg_10_2 then
		transformhelper.setLocalPos(arg_10_1.transform, 0, 0, 0)
	else
		transformhelper.setLocalPos(arg_10_1.transform, 99999, 99999, 0)
	end
end

function var_0_0.refreshInfo(arg_11_0)
	local var_11_0 = HeroConfig.instance:getHeroCO(arg_11_0.skinCo.characterId)

	arg_11_0._txtcharacterName.text = var_11_0.name

	gohelper.setActive(arg_11_0._txtskinName.gameObject, true)
	gohelper.setActive(arg_11_0._txtskinNameEn.gameObject, true)

	arg_11_0._txtskinName.text = "— " .. arg_11_0.skinCo.characterSkin

	if LangSettings.instance:isEn() then
		arg_11_0._txtskinNameEn.text = ""
	else
		arg_11_0._txtskinNameEn.text = arg_11_0.skinCo.characterSkinNameEng
	end
end

function var_0_0.refreshLive2d(arg_12_0)
	local var_12_0 = arg_12_0.skinCo.live2dbg

	arg_12_0._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(var_12_0))

	if arg_12_0._uiSpine == nil then
		arg_12_0._uiSpine = GuiModelAgent.Create(arg_12_0._gobigspine, true)

		arg_12_0._uiSpine:setResPath(arg_12_0.skinCo, arg_12_0._onUISpineLoaded, arg_12_0, CharacterVoiceEnum.NormalFullScreenEffectCameraSize)
	else
		arg_12_0:_onUISpineLoaded()
	end
end

function var_0_0._onUISpineLoaded(arg_13_0)
	local var_13_0 = arg_13_0.skinCo.skinViewLive2dOffset

	if string.nilorempty(var_13_0) then
		var_13_0 = arg_13_0.skinCo.characterViewOffset
	end

	local var_13_1 = SkinConfig.instance:getSkinOffset(var_13_0)

	recthelper.setAnchor(arg_13_0._gobigspine.transform, tonumber(var_13_1[1]), tonumber(var_13_1[2]))

	local var_13_2 = tonumber(var_13_1[3]) * 1

	transformhelper.setLocalScale(arg_13_0._gobigspine.transform, var_13_2, var_13_2, var_13_2)
	TaskDispatcher.cancelTask(arg_13_0._tryPlayVoice, arg_13_0)
	TaskDispatcher.runDelay(arg_13_0._tryPlayVoice, arg_13_0, 0.3)
end

function var_0_0._tryPlayVoice(arg_14_0)
	local var_14_0 = HeroModel.instance:getHeroAllVoice(arg_14_0.skinCo.characterId, arg_14_0.skinCo.id)

	if not var_14_0 or next(var_14_0) == nil then
		return
	end

	local var_14_1 = {
		[CharacterEnum.VoiceType.MainViewSpecialInteraction] = 1,
		[CharacterEnum.VoiceType.MainViewSpecialRespond] = 1,
		[CharacterEnum.VoiceType.MainViewDragSpecialRespond] = 1
	}
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in pairs(var_14_0) do
		if not var_14_1[iter_14_1.type] then
			table.insert(var_14_2, iter_14_0)
		end
	end

	local var_14_3 = var_14_0[var_14_2[math.random(1, #var_14_2)]]

	arg_14_0._uiSpine:playVoice(var_14_3, function()
		arg_14_0:stopVoice()
	end)
end

function var_0_0.stopVoice(arg_16_0)
	if not arg_16_0._uiSpine then
		return
	end

	arg_16_0._uiSpine:stopVoice()
end

function var_0_0.refresh2d(arg_17_0)
	if arg_17_0:isUniqueSkin() and not string.nilorempty(arg_17_0.skinCo.skin2dParams) then
		arg_17_0._simage2d:LoadImage(ResUrl.getSkin2dBg(arg_17_0.skinCo.id), arg_17_0._loadedImage, arg_17_0)
	else
		arg_17_0._simage2d:LoadImage(ResUrl.getHeadIconImg(arg_17_0.skinCo.id), arg_17_0._loadedImage, arg_17_0)
	end

	arg_17_0:load2dSkinSpine(arg_17_0.skinCo.skin2dParams)
end

function var_0_0.load2dSkinSpine(arg_18_0, arg_18_1)
	if string.nilorempty(arg_18_1) then
		gohelper.setActive(arg_18_0._go2dspine, false)

		return
	end

	gohelper.setActive(arg_18_0._go2dspine, true)

	local var_18_0 = arg_18_0:filterSpineParams(arg_18_1)

	if var_18_0.spinePath == arg_18_0._cur2dSpinePath then
		return
	end

	arg_18_0._cur2dSpinePath = var_18_0.spinePath

	if not arg_18_0.skin2dSpine then
		arg_18_0.skin2dSpine = GuiSpine.Create(arg_18_0._go2dspine, false)
	end

	local var_18_1 = arg_18_0._go2dspine.transform

	recthelper.setWidth(var_18_1, var_0_1[1])
	transformhelper.setLocalPos(var_18_1, var_18_0.spinePos[1], var_18_0.spinePos[2], 0)
	transformhelper.setLocalScale(var_18_1, var_18_0.spineScale, var_18_0.spineScale, var_18_0.spineScale)
	arg_18_0.skin2dSpine:setResPath(arg_18_0._cur2dSpinePath, arg_18_0._onSkinSpineLoaded, arg_18_0, true)
end

function var_0_0._onSkinSpineLoaded(arg_19_0)
	local var_19_0 = arg_19_0.skin2dSpine:getSpineTr()
	local var_19_1 = var_19_0.parent

	recthelper.setWidth(var_19_0, recthelper.getWidth(var_19_1))
	recthelper.setHeight(var_19_0, recthelper.getHeight(var_19_1))
end

function var_0_0.filterSpineParams(arg_20_0, arg_20_1)
	local var_20_0 = {}
	local var_20_1 = string.split(arg_20_1, "#")

	var_20_0.spinePath = var_20_1[1]
	var_20_0.spinePos = var_20_1[2] and string.splitToNumber(var_20_1[2], ",") or {
		0,
		0
	}
	var_20_0.spineScale = var_20_1[3] and tonumber(var_20_1[3]) or 1

	return var_20_0
end

function var_0_0.refreshSmallSpine(arg_21_0)
	if not arg_21_0._goSpine then
		arg_21_0._goSpine = GuiSpine.Create(arg_21_0._gosmallspine, false)
	end

	arg_21_0._goSpine:stopVoice()
	arg_21_0._goSpine:setResPath(ResUrl.getSpineUIPrefab(arg_21_0.skinCo.spine), arg_21_0._onSpineLoaded, arg_21_0, true)

	local var_21_0 = SkinConfig.instance:getSkinOffset(arg_21_0.skinCo.skinSpineOffset)

	recthelper.setAnchor(arg_21_0._gosmallspine.transform, tonumber(var_21_0[1]), tonumber(var_21_0[2]))
	transformhelper.setLocalScale(arg_21_0._gosmallspine.transform, tonumber(var_21_0[3]), tonumber(var_21_0[3]), tonumber(var_21_0[3]))
end

function var_0_0._loadedImage(arg_22_0)
	ZProj.UGUIHelper.SetImageSize(arg_22_0._simage2d.gameObject)

	local var_22_0 = arg_22_0.skinCo.skinViewImgOffset

	if not string.nilorempty(var_22_0) then
		local var_22_1 = string.splitToNumber(var_22_0, "#")

		recthelper.setAnchor(arg_22_0._simage2d.transform, tonumber(var_22_1[1]), tonumber(var_22_1[2]))
		transformhelper.setLocalScale(arg_22_0._simage2d.transform, tonumber(var_22_1[3]), tonumber(var_22_1[3]), tonumber(var_22_1[3]))
	else
		recthelper.setAnchor(arg_22_0._simage2d.transform, -150, -150)
		transformhelper.setLocalScale(arg_22_0._simage2d.transform, 0.6, 0.6, 0.6)
	end
end

function var_0_0.clearSkin(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._tryPlayVoice, arg_23_0)
	arg_23_0:stopVoice()
	arg_23_0._simagel2d:UnLoadImage()
	arg_23_0._simage2d:UnLoadImage()

	if arg_23_0._goSpine then
		arg_23_0._goSpine:stopVoice()

		arg_23_0._goSpine = nil
	end

	if arg_23_0._uiSpine then
		arg_23_0._uiSpine:onDestroy()

		arg_23_0._uiSpine = nil
	end
end

function var_0_0.isUniqueSkin(arg_24_0)
	return arg_24_0.goodsMO.config.skinLevel == 2
end

function var_0_0.onDestroy(arg_25_0)
	arg_25_0:clearSkin()
end

return var_0_0
