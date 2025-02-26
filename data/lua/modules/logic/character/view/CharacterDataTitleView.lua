module("modules.logic.character.view.CharacterDataTitleView", package.seeall)

slot0 = class("CharacterDataTitleView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/simagebg/#simage_bg_uicanvas")
	slot0._simagecentericon = gohelper.findChildSingleImage(slot0.viewGO, "bg/simagebg/#simage_centericon")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/simagebg/#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/simagebg/#simage_righticon")
	slot0._simagerighticon2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/simagebg/#simage_righticon2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "bg/simagebg/#simage_mask")
	slot0._btnuttuicon = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btn_uttuicon")
	slot0._btnskinswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "content/intro/#btn_skinswitch")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "content/intro/#simage_signature")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "content/character/charactericoncontainer/#go_spine")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "content/intro/container/#txt_name")
	slot0._gohandbook = gohelper.findChild(slot0.viewGO, "content/intro/#go_handbook")
	slot0._careericon = gohelper.findChildImage(slot0.viewGO, "content/intro/container/#txt_name/#image_career")
	slot0._gostarlist = gohelper.findChild(slot0.viewGO, "content/intro/#go_handbook/#go_starList")
	slot0._goCharacterStaticContainer = gohelper.findChild(slot0.viewGO, "content/character/#simage_characterstaticskin")
	slot0._goCharacterDynamicContainer = gohelper.findChild(slot0.viewGO, "content/character/charactericoncontainer")
	slot0._txtintroduce = gohelper.findChildText(slot0.viewGO, "content/intro/#txt_introduce")
	slot0._txtmedium = gohelper.findChildText(slot0.viewGO, "content/intro/introduce2/InfoLayoutGroup/#txt_medium")
	slot0._txtinspiration = gohelper.findChildText(slot0.viewGO, "content/intro/introduce2/InfoLayoutGroup/#txt_inspiration")
	slot0._txtaroma = gohelper.findChildText(slot0.viewGO, "content/intro/introduce2/InfoLayoutGroup/#txt_aroma")
	slot0._txtsize = gohelper.findChildText(slot0.viewGO, "content/intro/introduce2/InfoLayoutGroup/#txt_size")
	slot0._imagefetter = gohelper.findChildImage(slot0.viewGO, "content/intro/#txt_introduce/fetter/#image_fetter")
	slot0._txtfetter = gohelper.findChildText(slot0.viewGO, "content/intro/#txt_introduce/fetter/txt/#txt_fetter")
	slot0._gohasskin = gohelper.findChild(slot0.viewGO, "content/#pifu")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnuttuicon:AddClickListener(slot0._onUttuBtnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnuttuicon:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._animbtnskinswitch = slot0._btnskinswitch:GetComponent(typeof(UnityEngine.Animator))

	slot0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	slot0._simagecentericon:LoadImage(ResUrl.getCharacterDataIcon("bg_fm_circle.png"))
	slot0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	slot0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	slot0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))

	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)

	slot0._uiSpine:openBloomView(CharacterVoiceEnum.UIBloomView.CharacterDataView)

	slot0.showStatusDraw = false

	gohelper.setActive(slot0._gohasskin, false)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
	slot0:_setFaithValue()
end

function slot0._disableClipAlpha(slot0)
	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

function slot0.onOpen(slot0)
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	gohelper.setActive(slot0.viewGO, true)
	slot0:_refreshUI()
	TaskDispatcher.runDelay(slot0._playPercentAni, slot0, 0.5)

	if not slot0._uiSpine then
		return
	end

	slot0._uiSpine:setModelVisible(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_cover_open_1)
end

function slot0._refreshUI(slot0)
	if slot0._heroId and slot0._heroId == CharacterDataModel.instance:getCurHeroId() then
		return
	end

	slot0._heroId = CharacterDataModel.instance:getCurHeroId()

	if type(slot0.viewParam) == "table" then
		slot0.fromHandbookView = slot0.viewParam.fromHandbookView
		slot0.adjustStaticOffset = slot0.viewParam.adjustStaticOffset
	else
		slot0.fromHandbookView = false
		slot0.adjustStaticOffset = false
	end

	slot0.heroInfo = HeroModel.instance:getByHeroId(slot0._heroId)

	slot0:_initHandbookInfo()
	slot0:_initInfo()
	slot0:_initAdjustStaticOffsetInfo()
end

function slot0._initInfo(slot0)
	slot1 = slot0.heroInfo

	slot0._simagesignature:LoadImage(ResUrl.getSignature(slot1.config.signature), slot0._onSignatureImageLoad, slot0)

	slot0._txtname.text = slot0:_getFormatStr(slot1.config.name)
	slot3 = not string.nilorempty(CharacterDataConfig.instance:getCharacterDataCO(slot0._heroId, slot1.skin, CharacterEnum.CharacterDataItemType.Title, 1).text) and string.split(slot2, "\\&") or {}
	slot0._txtintroduce.text = slot3[1] and slot3[1] or ""
	slot0._txtmedium.text = slot0:_getTitleStr(slot3[3])
	slot0._txtinspiration.text = slot0:_getTitleStr(slot3[5])
	slot0._txtaroma.text = slot0:_getTitleStr(slot3[4])
	slot0._txtsize.text = slot0:_getTitleStr(slot3[2])

	slot0:_setFaithPercent(0)
	slot0:loadSpine()
end

function slot0._initHandbookInfo(slot0)
	gohelper.setActive(slot0._btnskinswitch.gameObject, slot0.fromHandbookView)
	gohelper.setActive(slot0._careericon.gameObject, slot0.fromHandbookView)
	gohelper.setActive(slot0._gohandbook, slot0.fromHandbookView)
	gohelper.setActive(slot0._goCharacterStaticContainer, slot0.showStatusDraw)
	gohelper.setActive(slot0._goCharacterDynamicContainer, not slot0.showStatusDraw)

	if slot0.fromHandbookView then
		slot0.simageStaticDraw = gohelper.getSingleImage(slot0._goCharacterStaticContainer)
		slot0._signatureClick = gohelper.getClickWithAudio(slot0._simagesignature.gameObject, AudioEnum.UI.play_ui_moor_open)

		slot0._signatureClick:AddClickListener(slot0.onSignatureOnClick, slot0)

		slot4 = slot0

		slot0._btnskinswitch:AddClickListener(slot0.onSkinSwitchBtnOnClick, slot4)
		gohelper.addUIClickAudio(slot0._btnskinswitch.gameObject, AudioEnum.UI.Play_UI_General_shutdown)

		slot0.starList = {}

		for slot4 = 1, 6 do
			table.insert(slot0.starList, gohelper.findChild(slot0._gostarlist, "star" .. slot4))
		end

		slot4 = "charactercareer" .. slot0.heroInfo.config.career

		UISpriteSetMgr.instance:setCharactergetSprite(slot0._careericon, slot4)

		for slot4 = 1, 6 do
			gohelper.setActive(slot0.starList[slot4], slot4 <= slot0.heroInfo.config.rare + 1)
		end

		slot0.haveSkinList = {}
		slot0.haveSkinDict = {}
		slot1 = SkinInfoMO.New()
		slot5 = slot0.heroInfo.config.skinId

		slot1:init({
			expireSec = 0,
			skin = slot5
		})
		table.insert(slot0.haveSkinList, slot1)

		slot0.haveSkinDict[slot0.heroInfo.config.skinId] = true

		for slot5, slot6 in ipairs(slot0.heroInfo.skinInfoList) do
			if not slot0.haveSkinDict[slot6.skin] then
				table.insert(slot0.haveSkinList, slot6)

				slot0.haveSkinDict[slot6.skin] = true
			end
		end

		slot0.currentShowSkinIndex = 0

		for slot5 = 1, #slot0.haveSkinList do
			if slot0.haveSkinList[slot5].skin == slot0.heroInfo.skin then
				slot0.currentShowSkinIndex = slot5
			end
		end

		gohelper.setActive(slot0._gohasskin, slot0.currentShowSkinIndex ~= 1)
	end
end

function slot0._initAdjustStaticOffsetInfo(slot0)
	if slot0.adjustStaticOffset then
		gohelper.setActive(slot0._goCharacterStaticContainer, true)
		gohelper.setActive(slot0._goCharacterDynamicContainer, false)
		slot0:loadStaticDraw()
	end
end

function slot0.loadSpine(slot0)
	slot2 = SkinConfig.instance:getSkinCo(slot0.haveSkinList and slot0.haveSkinList[slot0.currentShowSkinIndex].skin or slot0.heroInfo.skin)

	slot0._uiSpine:setResPath(slot2, slot0._onSpineLoaded, slot0)

	slot4 = nil
	slot4 = (not string.nilorempty(slot2.characterDataTitleViewOffset) or SkinConfig.instance:getAfterRelativeOffset(501, SkinConfig.instance:getSkinOffset(slot2.characterViewOffset))) and SkinConfig.instance:getSkinOffset(slot3)

	recthelper.setAnchor(slot0._gospine.transform, slot4[1], slot4[2])
	transformhelper.setLocalScale(slot0._gospine.transform, slot4[3], slot4[3], slot4[3])
	slot0._uiSpine:setModelVisible(not slot0.showStatusDraw)
end

function slot0.loadStaticDraw(slot0)
	slot0.simageStaticDraw:LoadImage(ResUrl.getHeadIconImg(SkinConfig.instance:getSkinCo(slot0.haveSkinList and slot0.haveSkinList[slot0.currentShowSkinIndex].skin or slot0.heroInfo.skin).drawing), function ()
		ZProj.UGUIHelper.SetImageSize(uv0._goCharacterStaticContainer)

		slot0 = uv0._goCharacterStaticContainer.transform
		slot1 = nil
		slot1 = (not string.nilorempty(uv1.characterTitleViewStaticOffset) or {
			-400,
			500,
			0.68
		}) and string.splitToNumber(uv1.characterTitleViewStaticOffset, "#")

		recthelper.setAnchor(slot0, slot1[1], slot1[2])

		slot0.localScale = Vector3.one * slot1[3]
	end)
end

function slot0._playPercentAni(slot0)
	if HeroConfig.instance:getFaithPercent(HeroModel.instance:getByHeroId(slot0._heroId).faith)[1] > 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_cover_open_2)
	end

	slot0._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot2, 0.34, slot0._setFaithPercent, slot0._setFaithValue, slot0, nil, EaseType.Linear)

	slot0:_disableClipAlpha()
end

function slot0._setFaithPercent(slot0, slot1)
	slot0._txtfetter.text = math.floor(slot1) < slot1 and string.format("%0.1f", slot1 * 100) .. "%" or slot1 * 100 .. "%"
	slot0._imagefetter.fillAmount = slot1
end

function slot0._setFaithValue(slot0)
	slot0:_setFaithPercent(HeroConfig.instance:getFaithPercent(HeroModel.instance:getByHeroId(slot0._heroId).faith)[1])

	if slot0._faithTweenId then
		ZProj.TweenHelper.KillById(slot0._faithTweenId)

		slot0._faithTweenId = nil
	end
end

function slot0._onUttuBtnClick(slot0)
	ViewMgr.instance:openView(ViewName.CharacterDataUttuView)
end

function slot0._onSpineLoaded(slot0)
end

function slot0._getTitleStr(slot0, slot1)
	if string.nilorempty(slot1) then
		return ""
	end

	if GameConfig:GetCurLangType() ~= LangSettings.kr then
		slot1 = string.gsub(slot1, "\n", "")
	end

	if #string.split(slot1, string.find(slot1, "：") and "：" or ": ") > 1 then
		return slot3[2]
	else
		return slot1
	end
end

function slot0._getFormatStr(slot0, slot1)
	if string.nilorempty(slot1) then
		return ""
	end

	slot2 = GameUtil.utf8sub(slot1, 1, 1)
	slot3 = ""

	if GameUtil.utf8len(slot1) >= 2 then
		slot3 = GameUtil.utf8sub(slot1, 2, GameUtil.utf8len(slot1) - 1)
	end

	return string.format("<size=90>%s</size>%s", slot2, slot3)
end

function slot0._onSignatureImageLoad(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simagesignature.gameObject)
end

function slot0.onSkinSwitchBtnOnClick(slot0)
	if slot0.fromHandbookView then
		if #slot0.haveSkinList == 1 then
			GameFacade.showToast(ToastEnum.CharacterDataTitle)

			return
		end

		slot0.currentShowSkinIndex = slot0.currentShowSkinIndex + 1

		if slot0.currentShowSkinIndex > #slot0.haveSkinList then
			slot0.currentShowSkinIndex = 1
		end

		if SkinConfig.instance:getSkinCo(slot0.haveSkinList and slot0.haveSkinList[slot0.currentShowSkinIndex].skin or slot0.heroInfo.skin).showDrawingSwitch == 0 then
			slot0.showStatusDraw = false

			gohelper.setActive(slot0._goCharacterStaticContainer, slot0.showStatusDraw)
			gohelper.setActive(slot0._goCharacterDynamicContainer, not slot0.showStatusDraw)
		end

		if slot0.showStatusDraw then
			slot0:loadStaticDraw()
		else
			slot0:loadSpine()
		end

		slot0._animbtnskinswitch:Play("skinswitch_click", 0, 0)
		gohelper.setActive(slot0._gohasskin, slot0.currentShowSkinIndex ~= 1)
	end
end

function slot0.onSignatureOnClick(slot0)
	if slot0.fromHandbookView then
		if SkinConfig.instance:getSkinCo(slot0.haveSkinList and slot0.haveSkinList[slot0.currentShowSkinIndex].skin or slot0.heroInfo.skin).showDrawingSwitch == 0 then
			return
		end

		slot0.showStatusDraw = not slot0.showStatusDraw

		gohelper.setActive(slot0._goCharacterStaticContainer, slot0.showStatusDraw)
		gohelper.setActive(slot0._goCharacterDynamicContainer, not slot0.showStatusDraw)

		if slot0.showStatusDraw then
			slot0:loadStaticDraw()
		else
			slot0:loadSpine()
		end
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._playPercentAni, slot0)

	if slot0._faithTweenId then
		ZProj.TweenHelper.KillById(slot0._faithTweenId)

		slot0._faithTweenId = nil
	end

	gohelper.setActive(slot0.viewGO, false)

	if not slot0._uiSpine then
		return
	end

	slot0._uiSpine:setModelVisible(false)
	slot0:_disableClipAlpha()
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagecentericon:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerighticon2:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simagesignature:UnLoadImage()

	if slot0._uiSpine then
		slot0._uiSpine = nil
	end

	if slot0.fromHandbookView then
		slot0._btnskinswitch:RemoveClickListener()
	end

	if slot0._signatureClick then
		slot0._signatureClick:RemoveClickListener()
	end
end

return slot0
