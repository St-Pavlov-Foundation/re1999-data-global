module("modules.logic.character.view.CharacterSkinGetDetailView", package.seeall)

slot0 = class("CharacterSkinGetDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._goContainer = gohelper.findChild(slot0.viewGO, "characterskingetdetailview")
	slot0._goclose = gohelper.findChild(slot0._goContainer, "#go_close")
	slot0._txtcharacterNameEn = gohelper.findChildText(slot0._goContainer, "#txt_characterNameEn")
	slot0._imagesingleItemBg = gohelper.findChildImage(slot0._goContainer, "characterSingleItem/#image_singleItemBg")
	slot0._simagesingleItemIcon = gohelper.findChildSingleImage(slot0._goContainer, "characterSingleItem/#simage_singleItemIcon")
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0._goContainer, "#btn_back")
	slot0._simageskinbg = gohelper.findChildSingleImage(slot0._goContainer, "FullScreenGameObject/skinDetail/#simage_skinbg")
	slot0._simageskin = gohelper.findChildSingleImage(slot0._goContainer, "FullScreenGameObject/skinDetail/#simage_skin")
	slot0._txtskinName = gohelper.findChildText(slot0._goContainer, "FullScreenGameObject/skinDetail/#txt_skinName")
	slot0._txtskinNameEn = gohelper.findChildText(slot0._goContainer, "FullScreenGameObject/skinDetail/#txt_skinNameEn")
	slot0._txtskinDesc = gohelper.findChildText(slot0._goContainer, "FullScreenGameObject/skinDetail/#txt_skinDesc")
	slot0._simagecircle = gohelper.findChildSingleImage(slot0._goContainer, "circlebg/circlewai/#simage_circle")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnback:RemoveClickListener()
end

function slot0._btnbackOnClick(slot0)
	slot0.viewParam.isReplay = true

	ViewMgr.instance:openView(slot0.viewName, slot0.viewParam)
end

function slot0._onBgClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterNewSkin, slot0.reallyOpenView, slot0)
end

function slot0.reallyOpenView(slot0)
	if HeroModel.instance:getCurrentSkinId(slot0.viewParam.heroId) == 304902 then
		AudioMgr.instance:trigger(AudioEnum.UI.kacakaca_audio)
	end

	gohelper.setActive(slot0._goContainer, true)

	slot0._bgClick = gohelper.getClickWithAudio(slot0._goclose)

	slot0._bgClick:AddClickListener(slot0._onBgClick, slot0)
	slot0:_setImage()
	slot0:_setText()
	slot0:_playOpenAnim()
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, slot0._onBgClick, slot0)
end

function slot0._playOpenAnim(slot0)
	slot0._animator = slot0._goContainer:GetComponent(typeof(UnityEngine.Animator))

	slot0._animator:Play("characterget_skin2")
end

function slot0._setImage(slot0)
	slot2 = HeroModel.instance:getCurrentSkinConfig(slot0.viewParam.heroId)

	if CharacterDataConfig.instance:getCharacterDataCO(slot0.viewParam.heroId, HeroModel.instance:getCurrentSkinId(slot0.viewParam.heroId), CharacterEnum.CharacterDataItemType.Item, 1).icon and slot1 ~= "" then
		slot0._simagesingleItemIcon:LoadImage(ResUrl.getCharacterDataPic(slot1), function (slot0)
			slot1 = SkinConfig.instance:getSkinOffset(uv0.skinGetDetailViewIconOffset)

			recthelper.setAnchor(slot0._simagesingleItemIcon.transform, tonumber(slot1[1]), tonumber(slot1[2]))
			transformhelper.setLocalScale(slot0._simagesingleItemIcon.transform, tonumber(slot1[3]), tonumber(slot1[3]), tonumber(slot1[3]))
		end, slot0)
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imagesingleItemBg, slot2.skinGetColorbg or "#000000")
	end

	if slot2.skinGetBackIcon and slot2.skinGetBackIcon ~= "" then
		slot0._simageskinbg:LoadImage(ResUrl.getHeadSkinIconLarge(slot2.skinGetBackIcon))
	end

	if slot2.skinGetIcon and slot2.skinGetIcon ~= "" then
		slot0._simageskin:LoadImage(ResUrl.getHeadSkinIconMiddle(slot2.skinGetIcon))
	end
end

function slot0._setText(slot0)
	slot1 = HeroModel.instance:getCurrentSkinConfig(slot0.viewParam.heroId)
	slot0._txtskinName.text = slot1.characterSkin
	slot0._txtskinNameEn.text = slot1.characterSkinNameEng
	slot0._txtskinDesc.text = slot1.skinDescription
	slot0._txtcharacterNameEn.text = slot1.nameEng
end

function slot0._onSpineLoaded(slot0)
end

function slot0.onClose(slot0)
	if slot0._bgClick then
		slot0._bgClick:RemoveClickListener()
	end

	slot0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterNewSkin, slot0.reallyOpenView, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagesingleItemIcon:UnLoadImage()
	slot0._simageskinbg:UnLoadImage()
	slot0._simageskin:UnLoadImage()
	slot0._simagecircle:UnLoadImage()
end

return slot0
