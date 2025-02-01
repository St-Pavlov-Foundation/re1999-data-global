module("modules.logic.characterskin.view.CharacterSkinTipView", package.seeall)

slot0 = class("CharacterSkinTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gosmallspine = gohelper.findChild(slot0.viewGO, "smalldynamiccontainer/#go_smallspine")
	slot0._goskincontainer = gohelper.findChild(slot0.viewGO, "characterSpine/#go_skincontainer")
	slot0._simageskin = gohelper.findChildSingleImage(slot0.viewGO, "characterSpine/#go_skincontainer/#simage_skin")
	slot0._simagebgmask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgmask")
	slot0._gogetIcon = gohelper.findChild(slot0.viewGO, "desc/#go_getIcon")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "desc/#simage_signature")
	slot0._simagesignatureicon = gohelper.findChildSingleImage(slot0.viewGO, "desc/#simage_signatureicon")
	slot0._txtcharacterName = gohelper.findChildText(slot0.viewGO, "desc/#txt_characterName")
	slot0._btnshowDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "desc/#txt_characterName/#btn_showDetail")
	slot0._txtskinName = gohelper.findChildText(slot0.viewGO, "desc/#txt_skinName")
	slot0._txtskinNameEn = gohelper.findChildText(slot0.viewGO, "desc/#txt_skinName/#txt_skinNameEn")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "desc/#txt_desc")
	slot0._simageskinSwitchBg = gohelper.findChildSingleImage(slot0.viewGO, "container/#simage_skinSwitchBg")
	slot0._simageskinicon = gohelper.findChildSingleImage(slot0.viewGO, "container/skinSwitch/skinmask/skinicon")
	slot0._gobtntopleft = gohelper.findChild(slot0.viewGO, "#go_btntopleft")
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnshowDetail:AddClickListener(slot0._btnshowDetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnshowDetail:RemoveClickListener()
end

function slot0._btnshowDetailOnClick(slot0)
	CharacterController.instance:openCharacterSkinFullScreenView(slot0._skinCo)
end

function slot0._editableInitView(slot0)
	slot0._preDragAnchorPositionX = 0
	slot0._currentSelectSkinIndex = 0
	slot0._preSelectSkinIndex = 0
	slot0._minAnchorPositionX = 0
	slot0._minChangeAnchorPositionX = 10
end

function slot0.onUpdateParam(slot0)
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0._goSpine = GuiSpine.Create(slot0._gosmallspine, false)

	slot0._simagebg:LoadImage(ResUrl.getCharacterSkinIcon("full/pifubeijing_012"))
	slot0._simagebgmask:LoadImage(ResUrl.getCharacterSkinIcon("mask"))
	slot0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
	slot0:refreshView()
end

function slot0.onOpenFinish(slot0)
	slot0._viewAnim.enabled = true
end

function slot0.refreshView(slot0)
	slot0._skinCo = SkinConfig.instance:getSkinCo(slot0.viewParam)
	slot0._heroCo = HeroConfig.instance:getHeroCO(slot0._skinCo.characterId)

	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot0._heroCo.signature, "characterget"))
	slot0._simagesignatureicon:LoadImage(ResUrl.getSignature("3011_2", "characterget"))
	slot0._simageskinicon:LoadImage(ResUrl.getHeadSkinSmall(slot0.viewParam))
	slot0._simageskin:LoadImage(ResUrl.getHeadIconImg(slot0.viewParam), slot0._loadedImage, slot0)

	slot0._txtcharacterName.text = slot0._heroCo.name
	slot0._txtskinName.text = slot0.skinCo.characterSkin
	slot0._txtskinNameEn.text = slot0._skinCo.characterSkinNameEng
	slot0._txtdesc.text = slot0._skinCo.skinDescription

	slot0._goSpine:stopVoice()
	slot0._goSpine:setResPath(ResUrl.getSpineUIPrefab(slot0._skinCo.spine), slot0._onSpineLoaded, slot0, true)

	slot1 = SkinConfig.instance:getSkinOffset(slot0._skinCo.skinSpineOffset)

	recthelper.setAnchor(slot0._gosmallspine.transform, tonumber(slot1[1]), tonumber(slot1[2]))
	transformhelper.setLocalScale(slot0._gosmallspine.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
	gohelper.setActive(slot0._simagesignatureicon.gameObject, slot0._heroCo.signature == "3011")
end

function slot0._loadedImage(slot0)
	gohelper.onceAddComponent(slot0._simageskin.gameObject, gohelper.Type_Image):SetNativeSize()

	if not string.nilorempty(slot0._skinCo.skinViewImgOffset) then
		slot2 = string.splitToNumber(slot1, "#")

		recthelper.setAnchor(slot0._goskincontainer.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._goskincontainer.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	else
		recthelper.setAnchor(slot0._goskincontainer.transform, -150, -150)
		transformhelper.setLocalScale(slot0._goskincontainer.transform, 0.6, 0.6, 0.6)
	end
end

function slot0._onSpineLoaded(slot0)
end

function slot0.onClose(slot0)
	slot0._simageskin:UnLoadImage()
	slot0._simagesignature:UnLoadImage()
	slot0._simagesignatureicon:UnLoadImage()
end

function slot0.onDestroyView(slot0)
	if slot0._goSpine then
		slot0._goSpine:stopVoice()

		slot0._goSpine = nil
	end

	slot0._simagebg:UnLoadImage()
	slot0._simageskinSwitchBg:UnLoadImage()
end

return slot0
