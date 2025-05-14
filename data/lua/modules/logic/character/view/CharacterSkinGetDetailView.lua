module("modules.logic.character.view.CharacterSkinGetDetailView", package.seeall)

local var_0_0 = class("CharacterSkinGetDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goContainer = gohelper.findChild(arg_1_0.viewGO, "characterskingetdetailview")
	arg_1_0._goclose = gohelper.findChild(arg_1_0._goContainer, "#go_close")
	arg_1_0._txtcharacterNameEn = gohelper.findChildText(arg_1_0._goContainer, "#txt_characterNameEn")
	arg_1_0._imagesingleItemBg = gohelper.findChildImage(arg_1_0._goContainer, "characterSingleItem/#image_singleItemBg")
	arg_1_0._simagesingleItemIcon = gohelper.findChildSingleImage(arg_1_0._goContainer, "characterSingleItem/#simage_singleItemIcon")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0._goContainer, "#btn_back")
	arg_1_0._simageskinbg = gohelper.findChildSingleImage(arg_1_0._goContainer, "FullScreenGameObject/skinDetail/#simage_skinbg")
	arg_1_0._simageskin = gohelper.findChildSingleImage(arg_1_0._goContainer, "FullScreenGameObject/skinDetail/#simage_skin")
	arg_1_0._txtskinName = gohelper.findChildText(arg_1_0._goContainer, "FullScreenGameObject/skinDetail/#txt_skinName")
	arg_1_0._txtskinNameEn = gohelper.findChildText(arg_1_0._goContainer, "FullScreenGameObject/skinDetail/#txt_skinNameEn")
	arg_1_0._txtskinDesc = gohelper.findChildText(arg_1_0._goContainer, "FullScreenGameObject/skinDetail/#txt_skinDesc")
	arg_1_0._simagecircle = gohelper.findChildSingleImage(arg_1_0._goContainer, "circlebg/circlewai/#simage_circle")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnback:RemoveClickListener()
end

function var_0_0._btnbackOnClick(arg_4_0)
	arg_4_0.viewParam.isReplay = true

	ViewMgr.instance:openView(arg_4_0.viewName, arg_4_0.viewParam)
end

function var_0_0._onBgClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagecircle:LoadImage(ResUrl.getCharacterGetIcon("bg_yuanchuan"))
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterNewSkin, arg_8_0.reallyOpenView, arg_8_0)
end

function var_0_0.reallyOpenView(arg_9_0)
	if HeroModel.instance:getCurrentSkinId(arg_9_0.viewParam.heroId) == 304902 then
		AudioMgr.instance:trigger(AudioEnum.UI.kacakaca_audio)
	end

	gohelper.setActive(arg_9_0._goContainer, true)

	arg_9_0._bgClick = gohelper.getClickWithAudio(arg_9_0._goclose)

	arg_9_0._bgClick:AddClickListener(arg_9_0._onBgClick, arg_9_0)
	arg_9_0:_setImage()
	arg_9_0:_setText()
	arg_9_0:_playOpenAnim()
	NavigateMgr.instance:addEscape(ViewName.CharacterGetView, arg_9_0._onBgClick, arg_9_0)
end

function var_0_0._playOpenAnim(arg_10_0)
	arg_10_0._animator = arg_10_0._goContainer:GetComponent(typeof(UnityEngine.Animator))

	arg_10_0._animator:Play("characterget_skin2")
end

function var_0_0._setImage(arg_11_0)
	local var_11_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_11_0.viewParam.heroId, HeroModel.instance:getCurrentSkinId(arg_11_0.viewParam.heroId), CharacterEnum.CharacterDataItemType.Item, 1).icon
	local var_11_1 = HeroModel.instance:getCurrentSkinConfig(arg_11_0.viewParam.heroId)

	if var_11_0 and var_11_0 ~= "" then
		arg_11_0._simagesingleItemIcon:LoadImage(ResUrl.getCharacterDataPic(var_11_0), function(arg_12_0)
			local var_12_0 = SkinConfig.instance:getSkinOffset(var_11_1.skinGetDetailViewIconOffset)

			recthelper.setAnchor(arg_12_0._simagesingleItemIcon.transform, tonumber(var_12_0[1]), tonumber(var_12_0[2]))
			transformhelper.setLocalScale(arg_12_0._simagesingleItemIcon.transform, tonumber(var_12_0[3]), tonumber(var_12_0[3]), tonumber(var_12_0[3]))
		end, arg_11_0)

		local var_11_2 = var_11_1.skinGetColorbg or "#000000"

		SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._imagesingleItemBg, var_11_2)
	end

	if var_11_1.skinGetBackIcon and var_11_1.skinGetBackIcon ~= "" then
		arg_11_0._simageskinbg:LoadImage(ResUrl.getHeadSkinIconLarge(var_11_1.skinGetBackIcon))
	end

	if var_11_1.skinGetIcon and var_11_1.skinGetIcon ~= "" then
		arg_11_0._simageskin:LoadImage(ResUrl.getHeadSkinIconMiddle(var_11_1.skinGetIcon))
	end
end

function var_0_0._setText(arg_13_0)
	local var_13_0 = HeroModel.instance:getCurrentSkinConfig(arg_13_0.viewParam.heroId)

	arg_13_0._txtskinName.text = var_13_0.characterSkin
	arg_13_0._txtskinNameEn.text = var_13_0.characterSkinNameEng
	arg_13_0._txtskinDesc.text = var_13_0.skinDescription
	arg_13_0._txtcharacterNameEn.text = var_13_0.nameEng
end

function var_0_0._onSpineLoaded(arg_14_0)
	return
end

function var_0_0.onClose(arg_15_0)
	if arg_15_0._bgClick then
		arg_15_0._bgClick:RemoveClickListener()
	end

	arg_15_0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterNewSkin, arg_15_0.reallyOpenView, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagesingleItemIcon:UnLoadImage()
	arg_16_0._simageskinbg:UnLoadImage()
	arg_16_0._simageskin:UnLoadImage()
	arg_16_0._simagecircle:UnLoadImage()
end

return var_0_0
