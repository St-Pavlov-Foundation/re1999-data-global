module("modules.logic.character.view.CharacterDataTitleView", package.seeall)

local var_0_0 = class("CharacterDataTitleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simagebg/#simage_bg_uicanvas")
	arg_1_0._simagecentericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simagebg/#simage_centericon")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simagebg/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simagebg/#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simagebg/#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/simagebg/#simage_mask")
	arg_1_0._btnuttuicon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_uttuicon")
	arg_1_0._btnskinswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "content/intro/#btn_skinswitch")
	arg_1_0._simagesignature = gohelper.findChildSingleImage(arg_1_0.viewGO, "content/intro/#simage_signature")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "content/character/charactericoncontainer/#go_spine")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "content/intro/container/#txt_name")
	arg_1_0._gohandbook = gohelper.findChild(arg_1_0.viewGO, "content/intro/#go_handbook")
	arg_1_0._careericon = gohelper.findChildImage(arg_1_0.viewGO, "content/intro/container/#txt_name/#image_career")
	arg_1_0._gostarlist = gohelper.findChild(arg_1_0.viewGO, "content/intro/#go_handbook/#go_starList")
	arg_1_0._goCharacterStaticContainer = gohelper.findChild(arg_1_0.viewGO, "content/character/#simage_characterstaticskin")
	arg_1_0._goCharacterDynamicContainer = gohelper.findChild(arg_1_0.viewGO, "content/character/charactericoncontainer")
	arg_1_0._txtintroduce = gohelper.findChildText(arg_1_0.viewGO, "content/intro/#txt_introduce")
	arg_1_0._txtmedium = gohelper.findChildText(arg_1_0.viewGO, "content/intro/introduce2/InfoLayoutGroup/#txt_medium")
	arg_1_0._txtinspiration = gohelper.findChildText(arg_1_0.viewGO, "content/intro/introduce2/InfoLayoutGroup/#txt_inspiration")
	arg_1_0._txtaroma = gohelper.findChildText(arg_1_0.viewGO, "content/intro/introduce2/InfoLayoutGroup/#txt_aroma")
	arg_1_0._txtsize = gohelper.findChildText(arg_1_0.viewGO, "content/intro/introduce2/InfoLayoutGroup/#txt_size")
	arg_1_0._imagefetter = gohelper.findChildImage(arg_1_0.viewGO, "content/intro/#txt_introduce/fetter/#image_fetter")
	arg_1_0._txtfetter = gohelper.findChildText(arg_1_0.viewGO, "content/intro/#txt_introduce/fetter/txt/#txt_fetter")
	arg_1_0._gohasskin = gohelper.findChild(arg_1_0.viewGO, "content/#pifu")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnuttuicon:AddClickListener(arg_2_0._onUttuBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnuttuicon:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._animbtnskinswitch = arg_4_0._btnskinswitch:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_4_0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	arg_4_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_4_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_4_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_4_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))

	arg_4_0._uiSpine = GuiModelAgent.Create(arg_4_0._gospine, true)

	arg_4_0._uiSpine:openBloomView(CharacterVoiceEnum.UIBloomView.CharacterDataView)

	arg_4_0.showStatusDraw = false

	gohelper.setActive(arg_4_0._gohasskin, false)
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:_refreshUI()
	arg_5_0:_setFaithValue()
end

function var_0_0._disableClipAlpha(arg_6_0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function var_0_0.onOpen(arg_7_0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	gohelper.setActive(arg_7_0.viewGO, true)
	arg_7_0:_refreshUI()
	TaskDispatcher.runDelay(arg_7_0._playPercentAni, arg_7_0, 0.5)

	if not arg_7_0._uiSpine then
		return
	end

	arg_7_0._uiSpine:setModelVisible(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_cover_open_1)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_7_0._onOpenViewFinish, arg_7_0, LuaEventSystem.Low)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0, LuaEventSystem.Low)
end

function var_0_0._onOpenViewFinish(arg_8_0, arg_8_1)
	arg_8_0:_setModelVisible(ViewHelper.instance:checkViewOnTheTop(ViewName.CharacterDataView))
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	arg_9_0:_setModelVisible(ViewHelper.instance:checkViewOnTheTop(ViewName.CharacterDataView))
end

function var_0_0._setModelVisible(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0._uiSpine:showModelEffect()
	else
		arg_10_0._uiSpine:hideModelEffect()
	end
end

function var_0_0._refreshUI(arg_11_0)
	if arg_11_0._heroId and arg_11_0._heroId == CharacterDataModel.instance:getCurHeroId() then
		return
	end

	arg_11_0._heroId = CharacterDataModel.instance:getCurHeroId()

	if type(arg_11_0.viewParam) == "table" then
		arg_11_0.fromHandbookView = arg_11_0.viewParam.fromHandbookView
		arg_11_0.adjustStaticOffset = arg_11_0.viewParam.adjustStaticOffset
	else
		arg_11_0.fromHandbookView = false
		arg_11_0.adjustStaticOffset = false
	end

	arg_11_0.heroInfo = HeroModel.instance:getByHeroId(arg_11_0._heroId)

	arg_11_0:_initHandbookInfo()
	arg_11_0:_initInfo()
	arg_11_0:_initAdjustStaticOffsetInfo()
end

function var_0_0._initInfo(arg_12_0)
	local var_12_0 = arg_12_0.heroInfo

	arg_12_0._simagesignature:LoadImage(ResUrl.getSignature(var_12_0.config.signature), arg_12_0._onSignatureImageLoad, arg_12_0)

	arg_12_0._txtname.text = arg_12_0:_getFormatStr(var_12_0.config.name)

	local var_12_1 = CharacterDataConfig.instance:getCharacterDataCO(arg_12_0._heroId, var_12_0.skin, CharacterEnum.CharacterDataItemType.Title, 1).text
	local var_12_2 = not string.nilorempty(var_12_1) and string.split(var_12_1, "\\&") or {}

	arg_12_0._txtintroduce.text = var_12_2[1] and var_12_2[1] or ""
	arg_12_0._txtmedium.text = arg_12_0:_getTitleStr(var_12_2[3])
	arg_12_0._txtinspiration.text = arg_12_0:_getTitleStr(var_12_2[5])
	arg_12_0._txtaroma.text = arg_12_0:_getTitleStr(var_12_2[4])
	arg_12_0._txtsize.text = arg_12_0:_getTitleStr(var_12_2[2])

	arg_12_0:_setFaithPercent(0)
	arg_12_0:loadSpine()
end

function var_0_0._initHandbookInfo(arg_13_0)
	gohelper.setActive(arg_13_0._btnskinswitch.gameObject, arg_13_0.fromHandbookView)
	gohelper.setActive(arg_13_0._careericon.gameObject, arg_13_0.fromHandbookView)
	gohelper.setActive(arg_13_0._gohandbook, arg_13_0.fromHandbookView)
	gohelper.setActive(arg_13_0._goCharacterStaticContainer, arg_13_0.showStatusDraw)
	gohelper.setActive(arg_13_0._goCharacterDynamicContainer, not arg_13_0.showStatusDraw)

	if arg_13_0.fromHandbookView then
		arg_13_0.simageStaticDraw = gohelper.getSingleImage(arg_13_0._goCharacterStaticContainer)
		arg_13_0._signatureClick = gohelper.getClickWithAudio(arg_13_0._simagesignature.gameObject, AudioEnum.UI.play_ui_moor_open)

		arg_13_0._signatureClick:AddClickListener(arg_13_0.onSignatureOnClick, arg_13_0)
		arg_13_0._btnskinswitch:AddClickListener(arg_13_0.onSkinSwitchBtnOnClick, arg_13_0)
		gohelper.addUIClickAudio(arg_13_0._btnskinswitch.gameObject, AudioEnum.UI.Play_UI_General_shutdown)

		arg_13_0.starList = {}

		for iter_13_0 = 1, 6 do
			local var_13_0 = gohelper.findChild(arg_13_0._gostarlist, "star" .. iter_13_0)

			table.insert(arg_13_0.starList, var_13_0)
		end

		UISpriteSetMgr.instance:setCharactergetSprite(arg_13_0._careericon, "charactercareer" .. arg_13_0.heroInfo.config.career)

		for iter_13_1 = 1, 6 do
			gohelper.setActive(arg_13_0.starList[iter_13_1], iter_13_1 <= arg_13_0.heroInfo.config.rare + 1)
		end

		arg_13_0.haveSkinList = {}
		arg_13_0.haveSkinDict = {}

		local var_13_1 = SkinInfoMO.New()

		var_13_1:init({
			expireSec = 0,
			skin = arg_13_0.heroInfo.config.skinId
		})
		table.insert(arg_13_0.haveSkinList, var_13_1)

		arg_13_0.haveSkinDict[arg_13_0.heroInfo.config.skinId] = true

		for iter_13_2, iter_13_3 in ipairs(arg_13_0.heroInfo.skinInfoList) do
			if not arg_13_0.haveSkinDict[iter_13_3.skin] then
				table.insert(arg_13_0.haveSkinList, iter_13_3)

				arg_13_0.haveSkinDict[iter_13_3.skin] = true
			end
		end

		arg_13_0.currentShowSkinIndex = 0

		for iter_13_4 = 1, #arg_13_0.haveSkinList do
			if arg_13_0.haveSkinList[iter_13_4].skin == arg_13_0.heroInfo.skin then
				arg_13_0.currentShowSkinIndex = iter_13_4
			end
		end

		gohelper.setActive(arg_13_0._gohasskin, arg_13_0.currentShowSkinIndex ~= 1)
	end
end

function var_0_0._initAdjustStaticOffsetInfo(arg_14_0)
	if arg_14_0.adjustStaticOffset then
		gohelper.setActive(arg_14_0._goCharacterStaticContainer, true)
		gohelper.setActive(arg_14_0._goCharacterDynamicContainer, false)
		arg_14_0:loadStaticDraw()
	end
end

function var_0_0.loadSpine(arg_15_0)
	local var_15_0 = arg_15_0.haveSkinList and arg_15_0.haveSkinList[arg_15_0.currentShowSkinIndex].skin or arg_15_0.heroInfo.skin
	local var_15_1 = SkinConfig.instance:getSkinCo(var_15_0)

	arg_15_0._uiSpine:setResPath(var_15_1, arg_15_0._onSpineLoaded, arg_15_0)

	local var_15_2 = var_15_1.characterDataTitleViewOffset
	local var_15_3

	if string.nilorempty(var_15_2) then
		var_15_3 = SkinConfig.instance:getSkinOffset(var_15_1.characterViewOffset)
		var_15_3 = SkinConfig.instance:getAfterRelativeOffset(501, var_15_3)
	else
		var_15_3 = SkinConfig.instance:getSkinOffset(var_15_2)
	end

	recthelper.setAnchor(arg_15_0._gospine.transform, var_15_3[1], var_15_3[2])
	transformhelper.setLocalScale(arg_15_0._gospine.transform, var_15_3[3], var_15_3[3], var_15_3[3])
	arg_15_0._uiSpine:setModelVisible(not arg_15_0.showStatusDraw)
end

function var_0_0.loadStaticDraw(arg_16_0)
	local var_16_0 = arg_16_0.haveSkinList and arg_16_0.haveSkinList[arg_16_0.currentShowSkinIndex].skin or arg_16_0.heroInfo.skin
	local var_16_1 = SkinConfig.instance:getSkinCo(var_16_0)

	arg_16_0.simageStaticDraw:LoadImage(ResUrl.getHeadIconImg(var_16_1.drawing), function()
		ZProj.UGUIHelper.SetImageSize(arg_16_0._goCharacterStaticContainer)

		local var_17_0 = arg_16_0._goCharacterStaticContainer.transform
		local var_17_1

		if string.nilorempty(var_16_1.characterTitleViewStaticOffset) then
			var_17_1 = {
				-400,
				500,
				0.68
			}
		else
			var_17_1 = string.splitToNumber(var_16_1.characterTitleViewStaticOffset, "#")
		end

		recthelper.setAnchor(var_17_0, var_17_1[1], var_17_1[2])

		var_17_0.localScale = Vector3.one * var_17_1[3]
	end)
end

function var_0_0._playPercentAni(arg_18_0)
	local var_18_0 = HeroModel.instance:getByHeroId(arg_18_0._heroId)
	local var_18_1 = HeroConfig.instance:getFaithPercent(var_18_0.faith)[1]

	if var_18_1 > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_cover_open_2)
	end

	arg_18_0._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, var_18_1, 0.34, arg_18_0._setFaithPercent, arg_18_0._setFaithValue, arg_18_0, nil, EaseType.Linear)

	arg_18_0:_disableClipAlpha()
end

function var_0_0._setFaithPercent(arg_19_0, arg_19_1)
	arg_19_0._txtfetter.text = arg_19_1 > math.floor(arg_19_1) and string.format("%0.1f", arg_19_1 * 100) .. "%" or arg_19_1 * 100 .. "%"
	arg_19_0._imagefetter.fillAmount = arg_19_1
end

function var_0_0._setFaithValue(arg_20_0)
	local var_20_0 = HeroModel.instance:getByHeroId(arg_20_0._heroId)
	local var_20_1 = HeroConfig.instance:getFaithPercent(var_20_0.faith)[1]

	arg_20_0:_setFaithPercent(var_20_1)

	if arg_20_0._faithTweenId then
		ZProj.TweenHelper.KillById(arg_20_0._faithTweenId)

		arg_20_0._faithTweenId = nil
	end
end

function var_0_0._onUttuBtnClick(arg_21_0)
	ViewMgr.instance:openView(ViewName.CharacterDataUttuView)
end

function var_0_0._onSpineLoaded(arg_22_0)
	return
end

function var_0_0._getTitleStr(arg_23_0, arg_23_1)
	if string.nilorempty(arg_23_1) then
		return ""
	end

	if GameConfig:GetCurLangType() ~= LangSettings.kr then
		arg_23_1 = string.gsub(arg_23_1, "\n", "")
	end

	local var_23_0 = string.find(arg_23_1, "：") and "：" or ": "
	local var_23_1 = string.split(arg_23_1, var_23_0)

	if #var_23_1 > 1 then
		return var_23_1[2]
	else
		return arg_23_1
	end
end

function var_0_0._getFormatStr(arg_24_0, arg_24_1)
	if string.nilorempty(arg_24_1) then
		return ""
	end

	local var_24_0 = GameUtil.utf8sub(arg_24_1, 1, 1)
	local var_24_1 = ""

	if GameUtil.utf8len(arg_24_1) >= 2 then
		var_24_1 = GameUtil.utf8sub(arg_24_1, 2, GameUtil.utf8len(arg_24_1) - 1)
	end

	return string.format("<size=90>%s</size>%s", var_24_0, var_24_1)
end

function var_0_0._onSignatureImageLoad(arg_25_0)
	ZProj.UGUIHelper.SetImageSize(arg_25_0._simagesignature.gameObject)
end

function var_0_0.onSkinSwitchBtnOnClick(arg_26_0)
	if arg_26_0.fromHandbookView then
		if #arg_26_0.haveSkinList == 1 then
			GameFacade.showToast(ToastEnum.CharacterDataTitle)

			return
		end

		arg_26_0.currentShowSkinIndex = arg_26_0.currentShowSkinIndex + 1

		if arg_26_0.currentShowSkinIndex > #arg_26_0.haveSkinList then
			arg_26_0.currentShowSkinIndex = 1
		end

		local var_26_0 = arg_26_0.haveSkinList and arg_26_0.haveSkinList[arg_26_0.currentShowSkinIndex].skin or arg_26_0.heroInfo.skin

		if SkinConfig.instance:getSkinCo(var_26_0).showDrawingSwitch == 0 then
			arg_26_0.showStatusDraw = false

			gohelper.setActive(arg_26_0._goCharacterStaticContainer, arg_26_0.showStatusDraw)
			gohelper.setActive(arg_26_0._goCharacterDynamicContainer, not arg_26_0.showStatusDraw)
		end

		if arg_26_0.showStatusDraw then
			arg_26_0:loadStaticDraw()
		else
			arg_26_0:loadSpine()
		end

		arg_26_0._animbtnskinswitch:Play("skinswitch_click", 0, 0)
		gohelper.setActive(arg_26_0._gohasskin, arg_26_0.currentShowSkinIndex ~= 1)
	end
end

function var_0_0.onSignatureOnClick(arg_27_0)
	if arg_27_0.fromHandbookView then
		local var_27_0 = arg_27_0.haveSkinList and arg_27_0.haveSkinList[arg_27_0.currentShowSkinIndex].skin or arg_27_0.heroInfo.skin

		if SkinConfig.instance:getSkinCo(var_27_0).showDrawingSwitch == 0 then
			return
		end

		arg_27_0.showStatusDraw = not arg_27_0.showStatusDraw

		gohelper.setActive(arg_27_0._goCharacterStaticContainer, arg_27_0.showStatusDraw)
		gohelper.setActive(arg_27_0._goCharacterDynamicContainer, not arg_27_0.showStatusDraw)

		if arg_27_0.showStatusDraw then
			arg_27_0:loadStaticDraw()
		else
			arg_27_0:loadSpine()
		end
	end
end

function var_0_0.onClose(arg_28_0)
	arg_28_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_28_0._onOpenViewFinish, arg_28_0)
	arg_28_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_28_0._onCloseViewFinish, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._playPercentAni, arg_28_0)

	if arg_28_0._faithTweenId then
		ZProj.TweenHelper.KillById(arg_28_0._faithTweenId)

		arg_28_0._faithTweenId = nil
	end

	gohelper.setActive(arg_28_0.viewGO, false)

	if not arg_28_0._uiSpine then
		return
	end

	arg_28_0._uiSpine:setModelVisible(false)
	arg_28_0:_disableClipAlpha()
end

function var_0_0.onDestroyView(arg_29_0)
	arg_29_0._simagebg:UnLoadImage()
	arg_29_0._simagecentericon:UnLoadImage()
	arg_29_0._simagelefticon:UnLoadImage()
	arg_29_0._simagerighticon:UnLoadImage()
	arg_29_0._simagerighticon2:UnLoadImage()
	arg_29_0._simagemask:UnLoadImage()
	arg_29_0._simagesignature:UnLoadImage()

	if arg_29_0._uiSpine then
		arg_29_0._uiSpine = nil
	end

	if arg_29_0.fromHandbookView then
		arg_29_0._btnskinswitch:RemoveClickListener()
	end

	if arg_29_0._signatureClick then
		arg_29_0._signatureClick:RemoveClickListener()
	end
end

return var_0_0
