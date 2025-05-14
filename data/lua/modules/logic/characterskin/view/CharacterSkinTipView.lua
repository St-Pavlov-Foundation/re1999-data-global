module("modules.logic.characterskin.view.CharacterSkinTipView", package.seeall)

local var_0_0 = class("CharacterSkinTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gosmallspine = gohelper.findChild(arg_1_0.viewGO, "smalldynamiccontainer/#go_smallspine")
	arg_1_0._goskincontainer = gohelper.findChild(arg_1_0.viewGO, "characterSpine/#go_skincontainer")
	arg_1_0._simageskin = gohelper.findChildSingleImage(arg_1_0.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	arg_1_0._simagebgmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bgmask")
	arg_1_0._gogetIcon = gohelper.findChild(arg_1_0.viewGO, "desc/#go_getIcon")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "desc/#simage_signature")
	arg_1_0._simagesignatureicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "desc/#simage_signatureicon")
	arg_1_0._txtcharacterName = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_characterName")
	arg_1_0._btnshowDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "desc/#txt_characterName/#btn_showDetail")
	arg_1_0._txtskinName = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_skinName")
	arg_1_0._txtskinNameEn = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "desc/#txt_desc")
	arg_1_0._simageskinSwitchBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/#simage_skinSwitchBg")
	arg_1_0._simageskinicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/skinSwitch/skinmask/skinicon")
	arg_1_0._gobtntopleft = gohelper.findChild(arg_1_0.viewGO, "#go_btntopleft")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnshowDetail:AddClickListener(arg_2_0._btnshowDetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnshowDetail:RemoveClickListener()
end

function var_0_0._btnshowDetailOnClick(arg_4_0)
	CharacterController.instance:openCharacterSkinFullScreenView(arg_4_0._skinCo)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._preDragAnchorPositionX = 0
	arg_5_0._currentSelectSkinIndex = 0
	arg_5_0._preSelectSkinIndex = 0
	arg_5_0._minAnchorPositionX = 0
	arg_5_0._minChangeAnchorPositionX = 10
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:refreshView()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._goSpine = GuiSpine.Create(arg_7_0._gosmallspine, false)

	arg_7_0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	arg_7_0._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	arg_7_0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
	arg_7_0:refreshView()
end

function var_0_0.onOpenFinish(arg_8_0)
	arg_8_0._viewAnim.enabled = true
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0._skinCo = SkinConfig.instance:getSkinCo(arg_9_0.viewParam)
	arg_9_0._heroCo = HeroConfig.instance:getHeroCO(arg_9_0._skinCo.characterId)

	arg_9_0._simagesignature:LoadImage(ResUrl.getSignature(arg_9_0._heroCo.signature, "characterget"))
	arg_9_0._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
	arg_9_0._simageskinicon:LoadImage(ResUrl.getHeadSkinSmall(arg_9_0.viewParam))
	arg_9_0._simageskin:LoadImage(ResUrl.getHeadIconImg(arg_9_0.viewParam), arg_9_0._loadedImage, arg_9_0)

	arg_9_0._txtcharacterName.text = arg_9_0._heroCo.name
	arg_9_0._txtskinName.text = arg_9_0.skinCo.characterSkin
	arg_9_0._txtskinNameEn.text = arg_9_0._skinCo.characterSkinNameEng
	arg_9_0._txtdesc.text = arg_9_0._skinCo.skinDescription

	arg_9_0._goSpine:stopVoice()
	arg_9_0._goSpine:setResPath(ResUrl.getSpineUIPrefab(arg_9_0._skinCo.spine), arg_9_0._onSpineLoaded, arg_9_0, true)

	local var_9_0 = SkinConfig.instance:getSkinOffset(arg_9_0._skinCo.skinSpineOffset)

	recthelper.setAnchor(arg_9_0._gosmallspine.transform, tonumber(var_9_0[1]), tonumber(var_9_0[2]))
	transformhelper.setLocalScale(arg_9_0._gosmallspine.transform, tonumber(var_9_0[3]), tonumber(var_9_0[3]), tonumber(var_9_0[3]))
	gohelper.setActive(arg_9_0._simagesignatureicon.gameObject, arg_9_0._heroCo.signature == "3011")
end

function var_0_0._loadedImage(arg_10_0)
	gohelper.onceAddComponent(arg_10_0._simageskin.gameObject, gohelper.Type_Image):SetNativeSize()

	local var_10_0 = arg_10_0._skinCo.skinViewImgOffset

	if not string.nilorempty(var_10_0) then
		local var_10_1 = string.splitToNumber(var_10_0, "#")

		recthelper.setAnchor(arg_10_0._goskincontainer.transform, tonumber(var_10_1[1]), tonumber(var_10_1[2]))
		transformhelper.setLocalScale(arg_10_0._goskincontainer.transform, tonumber(var_10_1[3]), tonumber(var_10_1[3]), tonumber(var_10_1[3]))
	else
		recthelper.setAnchor(arg_10_0._goskincontainer.transform, -150, -150)
		transformhelper.setLocalScale(arg_10_0._goskincontainer.transform, 0.6, 0.6, 0.6)
	end
end

function var_0_0._onSpineLoaded(arg_11_0)
	return
end

function var_0_0.onClose(arg_12_0)
	arg_12_0._simageskin:UnLoadImage()
	arg_12_0._simagesignature:UnLoadImage()
	arg_12_0._simagesignatureicon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._goSpine then
		arg_13_0._goSpine:stopVoice()

		arg_13_0._goSpine = nil
	end

	arg_13_0._simagebg:UnLoadImage()
	arg_13_0._simageskinSwitchBg:UnLoadImage()
end

return var_0_0
