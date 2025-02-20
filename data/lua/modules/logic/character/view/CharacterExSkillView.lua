module("modules.logic.character.view.CharacterExSkillView", package.seeall)

slot0 = class("CharacterExSkillView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebgimg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bgimg")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_righticon")
	slot0._simagerighticon2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_righticon2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_mask")
	slot0._goglowcontainer = gohelper.findChild(slot0.viewGO, "bg/#go_glowcontainer")
	slot0._golvProgress = gohelper.findChild(slot0.viewGO, "#go_lvProgress")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "materialCost/#go_item")
	slot0._txtcostnum = gohelper.findChildText(slot0.viewGO, "materialCost/#txt_costnum")
	slot0._btnup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_up")
	slot0._golevelupeffect = gohelper.findChild(slot0.viewGO, "#btn_up/#go_levelupbeffect")
	slot0._gobtn = gohelper.findChild(slot0.viewGO, "#go_btn")
	slot0._goskillDetailTipView = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/tipViewBg/#go_arrow")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	slot0._godescripteList = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	slot0._godescitem = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList/descripteitem")
	slot0._goBuffContainer = gohelper.findChild(slot0.viewGO, "#go_buffContainer")
	slot0._goJumpAnimationMask = gohelper.findChild(slot0.viewGO, "#go_jumpAnimationMask")
	slot0._gotrialtip = gohelper.findChild(slot0.viewGO, "#go_trialtip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnup:AddClickListener(slot0._btnupOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnup:RemoveClickListener()
end

slot0.NormalDescColor = "#b1b1b1"
slot0.NotHaveDescColor = "#b1b1b1"
slot0.NormalDescColorA = 1
slot0.NotHaveDescColorA = 0.4

function slot0._btnupOnClick(slot0)
	if slot0._enoughCost then
		HeroRpc.instance:sendHeroUpgradeSkillRequest(slot0.heroId, 3, 1)
	else
		GameFacade.showToast(ToastEnum.CharacterExSkill)
	end
end

function slot0._onEscapeBtnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.goCircleNormal1 = gohelper.findChild(slot0.viewGO, "go_skills/#simage_circleup")
	slot0.goCircleNormal2 = gohelper.findChild(slot0.viewGO, "go_skills/#simage_circledown")
	slot0.goCircleMax1 = gohelper.findChild(slot0.viewGO, "go_skills/#simage_maxup")
	slot0.goCircleMax2 = gohelper.findChild(slot0.viewGO, "go_skills/#simage_maxdown")
	slot0._gocircle1 = gohelper.findChild(slot0.viewGO, "go_skills/decoration/#go_circle1")
	slot0._gocircle5 = gohelper.findChild(slot0.viewGO, "go_skills/decoration/#go_circle5")
	slot0._gosignature = gohelper.findChild(slot0.viewGO, "go_skills/signature")
	slot0._goclickani = gohelper.findChild(slot0.viewGO, "go_skills/click/ani")
	slot0._gomaxani = gohelper.findChild(slot0.viewGO, "go_skills/max/ani")
	slot0._simagefulllevel = gohelper.findChildSingleImage(slot0.viewGO, "go_skills/decoration/#simage_fulllevel")
	slot0._scrollskillDetailTipScroll = gohelper.findChildScrollRect(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll")

	slot0._scrollskillDetailTipScroll:AddOnValueChanged(slot0._refreshArrow, slot0)

	slot0.goMaterialCost = gohelper.findChild(slot0.viewGO, "materialCost")

	slot0._simagebgimg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	slot0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	slot0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	slot0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	slot0._simagefulllevel:LoadImage(ResUrl.getCharacterExskill("zs_02"))

	slot4 = "go_skills"
	slot0.skillContainerGo = gohelper.findChild(slot0.viewGO, slot4)
	slot0.skillCardGoDict = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.icon = gohelper.findChildSingleImage(slot0.skillContainerGo, string.format("skillicon%s/ani/imgIcon", slot4))
		slot5.tagIcon = gohelper.findChildSingleImage(slot0.skillContainerGo, string.format("skillicon%s/ani/tag/tagIcon", slot4))
		slot0.skillCardGoDict[slot4] = slot5
	end

	slot0._buffBg = gohelper.findChild(slot0.viewGO, "#go_buffContainer/buff_bg")
	slot0._buffBgClick = gohelper.getClick(slot0._buffBg)

	slot0._buffBgClick:AddClickDownListener(slot0.hideBuffContainer, slot0)

	slot0._jumpAnimationClick = gohelper.getClick(slot0._goJumpAnimationMask)

	slot0._jumpAnimationClick:AddClickListener(slot0.onJumpAnimationClick, slot0)

	slot0._goBuffItem = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem")
	slot0._txtBuffName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	slot0._goBuffTag = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	slot0._txtBuffTagName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	slot4 = "#go_buffContainer/#go_buffitem/txt_desc"
	slot0._txtBuffDesc = gohelper.findChildText(slot0.viewGO, slot4)
	slot0.golvList = slot0:getUserDataTb_()

	for slot4 = 1, CharacterEnum.MaxSkillExLevel do
		table.insert(slot0.golvList, gohelper.findChild(slot0.viewGO, "#go_lvProgress/#go_lv" .. slot4))
	end

	gohelper.setActive(slot0._goBuffContainer, false)
	gohelper.setActive(slot0._godescitem, false)
	gohelper.setActive(slot0._gosignature, false)
	gohelper.setActive(slot0._goJumpAnimationMask, false)

	slot0.goSignatureAnimator = slot0._gosignature:GetComponent(typeof(UnityEngine.Animator))
	slot0.viewGoAnimator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.viewGoAniEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0.viewGoAniEventWrap:AddEventListener("end", slot0.onAniEnd, slot0)
	slot0.viewGoAniEventWrap:AddEventListener("refreshUI", slot0.onAniRefreshUI, slot0)
	slot0.viewGoAniEventWrap:AddEventListener("onJumpTargetFrame", slot0.onJumpTargetFrame, slot0)

	slot0.goClickAnimation = slot0._goclickani:GetComponent(typeof(UnityEngine.Animation))
	slot0.maxBuffContainerWidth = 570
end

function slot0.initViewParam(slot0)
	slot0.heroId = slot0.viewParam.heroId
	slot0._config = HeroConfig.instance:getHeroCO(slot0.heroId)
	slot0.showAttributeOption = slot0.viewParam.showAttributeOption
	slot0.fromHeroDetailView = slot0.viewParam.fromHeroDetailView

	if slot0.showAttributeOption == CharacterEnum.showAttributeOption.ShowMin then
		slot0.exSkillLevel = 0
	elseif slot0.showAttributeOption == CharacterEnum.showAttributeOption.ShowMax then
		slot0.exSkillLevel = CharacterEnum.MaxSkillExLevel
	else
		slot0.exSkillLevel = (slot0.viewParam.heroMo or HeroModel.instance:getByHeroId(slot0.heroId)).exSkillLevel
	end

	slot0._isOwnHero = slot0.viewParam.isOwnHero
	slot0._hideTrialTip = slot0.viewParam.hideTrialTip
end

function slot0.onOpen(slot0)
	slot0:initViewParam()
	slot0:_refreshUI()

	if slot0:_isSkillLevelTop() then
		gohelper.setActive(slot0._gosignature, true)
		slot0.goSignatureAnimator:Play(UIAnimationName.Open)
	end

	if slot0.fromHeroDetailView then
		slot0.viewContainer:hideHomeBtn()
	end

	if slot0:_isSkillLevelTop() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_opengeneral)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_open)
	end

	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._onHeroExSkillUp, slot0)
	NavigateMgr.instance:addEscape(ViewName.CharacterExSkillView, slot0._onEscapeBtnClick, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:initViewParam()
	slot0:_refreshUI()
	gohelper.setActive(slot0._gosignature, slot0:_isSkillLevelTop())
end

function slot0._refreshUI(slot0)
	slot0:refreshCircleAnimation()
	slot0:refreshSkillCardInfo()
	slot0:refreshExLevel()
	slot0:showSkillDetail()

	slot1 = true

	if slot0.viewParam.heroMo then
		slot1 = slot0.viewParam.heroMo:isOwnHero()
	end

	if slot0._isOwnHero ~= nil then
		slot1 = slot0._isOwnHero
	end

	slot0:setSkillLevelTop(slot0:_isSkillLevelTop() and slot1)
	gohelper.setActive(slot0._gotrialtip, not slot1 and not slot0._hideTrialTip)

	if slot0:_isSkillLevelTop() or slot0.fromHeroDetailView or not slot1 then
		slot0:hideItemAndBtn()
	else
		slot0:showItemAndBtn()
		slot0:refreshItem()
	end
end

function slot0.refreshCircleAnimation(slot0)
	slot1 = slot0:_isSkillLevelTop()

	gohelper.setActive(slot0.goCircleNormal1, not slot1)
	gohelper.setActive(slot0.goCircleNormal2, not slot1)
	gohelper.setActive(slot0.goCircleMax1, slot1)
	gohelper.setActive(slot0.goCircleMax2, slot1)
end

function slot0.refreshSkillCardInfo(slot0)
	slot2, slot3 = nil

	for slot7 = 1, 3 do
		if not lua_skill.configDict[SkillConfig.instance:getHeroBaseSkillIdDict(slot0._config.id)[slot7]] then
			logError(string.format("heroID : %s, skillId not found : %s", slot0._config.id, slot3))
		end

		slot0.skillCardGoDict[slot7].icon:LoadImage(ResUrl.getSkillIcon(slot2.icon))
		slot0.skillCardGoDict[slot7].tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot2.showTag))
	end
end

function slot0.refreshExLevel(slot0)
	for slot4 = 1, slot0.exSkillLevel do
		gohelper.setActive(slot0.golvList[slot4], true)
	end

	for slot4 = slot0.exSkillLevel + 1, CharacterEnum.MaxSkillExLevel do
		gohelper.setActive(slot0.golvList[slot4], false)
	end
end

function slot0.setSkillLevelTop(slot0, slot1)
	if slot1 or slot0.fromHeroDetailView then
		recthelper.setHeight(slot0._scrollskillDetailTipScroll.transform, 638)
	else
		recthelper.setHeight(slot0._scrollskillDetailTipScroll.transform, 480)
	end

	gohelper.setActive(slot0._simagefulllevel.gameObject, slot1)
	gohelper.setActive(slot0._gocircle5, slot1)
	gohelper.setActive(slot0._gocircle1, slot1 == false)
end

function slot0.hideItemAndBtn(slot0)
	gohelper.setActive(slot0.goMaterialCost, false)
	gohelper.setActive(slot0._btnup.gameObject, false)
end

function slot0.showItemAndBtn(slot0)
	gohelper.setActive(slot0.goMaterialCost, true)
	gohelper.setActive(slot0._btnup.gameObject, true)
end

function slot0.refreshItem(slot0)
	if slot0:_isSkillLevelTop() then
		gohelper.setActive(slot0.goMaterialCost, false)

		return
	end

	gohelper.setActive(slot0.goMaterialCost, true)

	slot1 = SkillConfig.instance:getherolevelexskillCO(slot0.heroId, slot0.exSkillLevel + 1)

	if not slot0._itemIcon then
		slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._goitem)
	end

	slot2 = string.splitToNumber(slot1.consume, "#")

	slot0._itemIcon:setMOValue(slot2[1], slot2[2], slot2[3])
	slot0._itemIcon:isShowCount(false)

	slot0._enoughCost = slot2[3] <= ItemModel.instance:getItemQuantity(slot2[1], slot2[2])

	if slot0._enoughCost then
		slot0._txtcostnum.text = string.format("%s/%s", slot3, slot2[3])
	else
		slot0._txtcostnum.text = string.format("<color=#ce4949>%s</color>/%s", slot3, slot2[3])
	end

	gohelper.setActive(slot0._golevelupeffect, slot0._enoughCost)
end

function slot0._refreshArrow(slot0)
	if slot0._scrollskillDetailTipScroll.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(slot0._goarrow, true)
	else
		gohelper.setActive(slot0._goarrow, false)
	end
end

function slot0._isSkillLevelTop(slot0)
	return slot0.exSkillLevel == CharacterEnum.MaxSkillExLevel
end

function slot0._onHeroExSkillUp(slot0)
	slot0.exSkillLevel = (slot0.viewParam.heroMo or HeroModel.instance:getByHeroId(slot0.heroId)).exSkillLevel

	slot0:resetJumpValue()
	gohelper.setActive(slot0._goJumpAnimationMask, true)

	if slot0:_isSkillLevelTop() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_succeedspecial)
		slot0.viewGoAnimator:Play("max", 0, 0)
		gohelper.setActive(slot0._gosignature, true)
		slot0.goSignatureAnimator:Play("max", 0, 0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_succeedgeneral)
		slot0.viewGoAnimator:Play("nomal", 0, 0)
	end

	gohelper.setActive(slot0.golvList[slot0.exSkillLevel], true)

	slot0.lvAnimator = slot0.golvList[slot0.exSkillLevel]:GetComponent(typeof(UnityEngine.Animator))

	slot0.lvAnimator:Play(UIAnimationName.Click, 0, 0)
	slot0._descList[slot0.exSkillLevel]:playHeroExSkillUPAnimation()
end

function slot0.onAniEnd(slot0)
	gohelper.setActive(slot0._goJumpAnimationMask, false)
	gohelper.setActive(slot0._goclickani, true)
	gohelper.setActive(slot0._gomaxani, true)
end

function slot0.onAniRefreshUI(slot0)
	slot0:_refreshUI()
end

function slot0.onJumpTargetFrame(slot0)
	slot0.inPreTargetFrame = false
end

function slot0.resetJumpValue(slot0)
	slot0.inPreTargetFrame = true
	slot0.jumped = false
end

function slot0.getExSkillTipInfo(slot0, slot1, slot2)
	if not SkillConfig.instance:getherolevelexskillCO(slot1, slot2) then
		return
	end

	slot5 = lua_skill.configDict[slot3.skillEx]

	return slot5.name, slot5.desc, slot5.icon, slot5.desc_art
end

function slot0.showSkillDetail(slot0)
	slot1 = 0
	slot2 = 0

	for slot6 = 1, CharacterEnum.MaxSkillExLevel do
		slot8 = slot0:addDescItem(slot6, SkillConfig.instance:getherolevelexskillCO(slot0.heroId, slot6))

		if slot6 == slot0.exSkillLevel then
			slot2 = slot1
		end

		slot1 = slot1 + slot8
	end

	slot0._goContent:SetActive(true)
	slot0:rebuildLayout()
	recthelper.setAnchorY(slot0._goContent.transform, slot2)
end

function slot0.rebuildLayout(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._godescripteList.transform)
	slot0:_refreshArrow()
end

function slot0.addDescItem(slot0, slot1, slot2)
	slot0._descList = slot0._descList or slot0:getUserDataTb_()

	if not slot0._descList[slot1] then
		slot3 = CharacterSkillDescripte.New()
		slot4 = gohelper.clone(slot0._godescitem, slot0._godescripteList)

		slot4:SetActive(true)
		slot3:initView(slot4)

		slot0._descList[slot1] = slot3
	end

	return slot3:updateInfo(slot0, slot0.heroId, slot1, slot0.exSkillLevel, slot0.fromHeroDetailView)
end

function slot0.showBuffContainer(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._goBuffContainer, true)

	slot0.buffItemWidth = GameUtil.getTextWidthByLine(slot0._txtBuffDesc, slot2, 24)
	slot0.buffItemWidth = slot0.buffItemWidth + 70

	if slot0.maxBuffContainerWidth < slot0.buffItemWidth then
		slot0.buffItemWidth = slot0.maxBuffContainerWidth
	end

	slot0._txtBuffName.text = slot1
	slot0._txtBuffDesc.text = slot2
	slot4 = FightConfig.instance:getBuffTag(slot1)

	gohelper.setActive(slot0._goBuffTag, not string.nilorempty(slot4))

	slot0._txtBuffTagName.text = slot4
	slot5 = recthelper.screenPosToAnchorPos(slot3, slot0.viewGO.transform)

	recthelper.setAnchor(slot0._goBuffItem.transform, slot5.x - 20, slot5.y)
end

function slot0.hideBuffContainer(slot0)
	gohelper.setActive(slot0._goBuffContainer, false)
end

function slot0.getShowAttributeOption(slot0)
	return slot0.showAttributeOption
end

function slot0.onJumpAnimationClick(slot0)
	if slot0.jumped then
		return
	end

	if not slot0.inPreTargetFrame then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_mould)

	slot0.jumped = true

	if slot0:_isSkillLevelTop() then
		slot0.viewGoAnimator:Play("max", 0, 0.7913043478260869)
		slot0.goSignatureAnimator:Play("max", 0, 0.9479166666666666)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_skipspecial)
	else
		slot0.viewGoAnimator:Play("nomal", 0, 0.7913043478260869)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_skipgeneral)
	end

	slot0.goClickAnimation:Stop()
	gohelper.setActive(slot0._goclickani, false)
	gohelper.setActive(slot0._gomaxani, false)
	gohelper.setActive(slot0.golvList[slot0.exSkillLevel], true)
	slot0.lvAnimator:Play(UIAnimationName.Click, 0, 1)
	slot0._descList[slot0.exSkillLevel]:jumpAnimation()
	gohelper.setActive(slot0._goJumpAnimationMask, false)
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._descList) do
		slot5:onClose()
	end
end

function slot0.onDestroyView(slot0)
	slot0._buffBgClick:RemoveClickDownListener()
	slot0._jumpAnimationClick:RemoveClickListener()
	slot0._scrollskillDetailTipScroll:RemoveOnValueChanged()
	slot0._simagebgimg:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerighticon2:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simagefulllevel:UnLoadImage()
	slot0.viewGoAniEventWrap:RemoveAllEventListener()

	for slot4, slot5 in pairs(slot0.skillCardGoDict) do
		slot5.icon:UnLoadImage()
		slot5.tagIcon:UnLoadImage()
	end
end

return slot0
