module("modules.logic.character.view.CharacterExSkillView", package.seeall)

local var_0_0 = class("CharacterExSkillView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bgimg")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_mask")
	arg_1_0._goglowcontainer = gohelper.findChild(arg_1_0.viewGO, "bg/#go_glowcontainer")
	arg_1_0._golvProgress = gohelper.findChild(arg_1_0.viewGO, "#go_lvProgress")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "materialCost/#go_item")
	arg_1_0._txtcostnum = gohelper.findChildText(arg_1_0.viewGO, "materialCost/#txt_costnum")
	arg_1_0._btnup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_up")
	arg_1_0._golevelupeffect = gohelper.findChild(arg_1_0.viewGO, "#btn_up/#go_levelupbeffect")
	arg_1_0._gobtn = gohelper.findChild(arg_1_0.viewGO, "#go_btn")
	arg_1_0._goskillDetailTipView = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/tipViewBg/#go_arrow")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	arg_1_0._godescripteList = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList/descripteitem")
	arg_1_0._goBuffContainer = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer")
	arg_1_0._goJumpAnimationMask = gohelper.findChild(arg_1_0.viewGO, "#go_jumpAnimationMask")
	arg_1_0._gotrialtip = gohelper.findChild(arg_1_0.viewGO, "#go_trialtip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnup:AddClickListener(arg_2_0._btnupOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnup:RemoveClickListener()
end

var_0_0.NormalDescColor = "#b1b1b1"
var_0_0.NotHaveDescColor = "#b1b1b1"
var_0_0.NormalDescColorA = 1
var_0_0.NotHaveDescColorA = 0.4

function var_0_0._btnupOnClick(arg_4_0)
	if arg_4_0._enoughCost then
		HeroRpc.instance:sendHeroUpgradeSkillRequest(arg_4_0.heroId, 3, 1)
	else
		GameFacade.showToast(ToastEnum.CharacterExSkill)
	end
end

function var_0_0._onEscapeBtnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.goCircleNormal1 = gohelper.findChild(arg_6_0.viewGO, "go_skills/#simage_circleup")
	arg_6_0.goCircleNormal2 = gohelper.findChild(arg_6_0.viewGO, "go_skills/#simage_circledown")
	arg_6_0.goCircleMax1 = gohelper.findChild(arg_6_0.viewGO, "go_skills/#simage_maxup")
	arg_6_0.goCircleMax2 = gohelper.findChild(arg_6_0.viewGO, "go_skills/#simage_maxdown")
	arg_6_0._gocircle1 = gohelper.findChild(arg_6_0.viewGO, "go_skills/decoration/#go_circle1")
	arg_6_0._gocircle5 = gohelper.findChild(arg_6_0.viewGO, "go_skills/decoration/#go_circle5")
	arg_6_0._gosignature = gohelper.findChild(arg_6_0.viewGO, "go_skills/signature")
	arg_6_0._goclickani = gohelper.findChild(arg_6_0.viewGO, "go_skills/click/ani")
	arg_6_0._gomaxani = gohelper.findChild(arg_6_0.viewGO, "go_skills/max/ani")
	arg_6_0._simagefulllevel = gohelper.findChildSingleImage(arg_6_0.viewGO, "go_skills/decoration/#simage_fulllevel")
	arg_6_0._scrollskillDetailTipScroll = gohelper.findChildScrollRect(arg_6_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll")

	arg_6_0._scrollskillDetailTipScroll:AddOnValueChanged(arg_6_0._refreshArrow, arg_6_0)

	arg_6_0.goMaterialCost = gohelper.findChild(arg_6_0.viewGO, "materialCost")

	arg_6_0._simagebgimg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_6_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_6_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_6_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_6_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	arg_6_0._simagefulllevel:LoadImage(ResUrl.getCharacterExskill("zs_02"))

	arg_6_0.skillContainerGo = gohelper.findChild(arg_6_0.viewGO, "go_skills")
	arg_6_0.skillCardGoDict = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, 3 do
		local var_6_0 = arg_6_0:getUserDataTb_()

		var_6_0.icon = gohelper.findChildSingleImage(arg_6_0.skillContainerGo, string.format("skillicon%s/ani/imgIcon", iter_6_0))
		var_6_0.tagIcon = gohelper.findChildSingleImage(arg_6_0.skillContainerGo, string.format("skillicon%s/ani/tag/tagIcon", iter_6_0))
		arg_6_0.skillCardGoDict[iter_6_0] = var_6_0
	end

	arg_6_0._buffBg = gohelper.findChild(arg_6_0.viewGO, "#go_buffContainer/buff_bg")
	arg_6_0._buffBgClick = gohelper.getClick(arg_6_0._buffBg)

	arg_6_0._buffBgClick:AddClickDownListener(arg_6_0.hideBuffContainer, arg_6_0)

	arg_6_0._jumpAnimationClick = gohelper.getClick(arg_6_0._goJumpAnimationMask)

	arg_6_0._jumpAnimationClick:AddClickListener(arg_6_0.onJumpAnimationClick, arg_6_0)

	arg_6_0._goBuffItem = gohelper.findChild(arg_6_0.viewGO, "#go_buffContainer/#go_buffitem")
	arg_6_0._txtBuffName = gohelper.findChildText(arg_6_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	arg_6_0._goBuffTag = gohelper.findChild(arg_6_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	arg_6_0._txtBuffTagName = gohelper.findChildText(arg_6_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	arg_6_0._txtBuffDesc = gohelper.findChildText(arg_6_0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")
	arg_6_0.golvList = arg_6_0:getUserDataTb_()

	for iter_6_1 = 1, CharacterEnum.MaxSkillExLevel do
		table.insert(arg_6_0.golvList, gohelper.findChild(arg_6_0.viewGO, "#go_lvProgress/#go_lv" .. iter_6_1))
	end

	gohelper.setActive(arg_6_0._goBuffContainer, false)
	gohelper.setActive(arg_6_0._godescitem, false)
	gohelper.setActive(arg_6_0._gosignature, false)
	gohelper.setActive(arg_6_0._goJumpAnimationMask, false)

	arg_6_0.goSignatureAnimator = arg_6_0._gosignature:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0.viewGoAnimator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0.viewGoAniEventWrap = arg_6_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_6_0.viewGoAniEventWrap:AddEventListener("end", arg_6_0.onAniEnd, arg_6_0)
	arg_6_0.viewGoAniEventWrap:AddEventListener("refreshUI", arg_6_0.onAniRefreshUI, arg_6_0)
	arg_6_0.viewGoAniEventWrap:AddEventListener("onJumpTargetFrame", arg_6_0.onJumpTargetFrame, arg_6_0)

	arg_6_0.goClickAnimation = arg_6_0._goclickani:GetComponent(typeof(UnityEngine.Animation))
	arg_6_0.maxBuffContainerWidth = 570
end

function var_0_0.initViewParam(arg_7_0)
	arg_7_0.heroId = arg_7_0.viewParam.heroId
	arg_7_0._config = HeroConfig.instance:getHeroCO(arg_7_0.heroId)
	arg_7_0.showAttributeOption = arg_7_0.viewParam.showAttributeOption
	arg_7_0.fromHeroDetailView = arg_7_0.viewParam.fromHeroDetailView

	if arg_7_0.showAttributeOption == CharacterEnum.showAttributeOption.ShowMin then
		arg_7_0.exSkillLevel = 0
	elseif arg_7_0.showAttributeOption == CharacterEnum.showAttributeOption.ShowMax then
		arg_7_0.exSkillLevel = CharacterEnum.MaxSkillExLevel
	else
		arg_7_0.exSkillLevel = (arg_7_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_7_0.heroId)).exSkillLevel
	end

	arg_7_0._isOwnHero = arg_7_0.viewParam.isOwnHero
	arg_7_0._hideTrialTip = arg_7_0.viewParam.hideTrialTip
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:initViewParam()
	arg_8_0:_refreshUI()

	if arg_8_0:_isSkillLevelTop() then
		gohelper.setActive(arg_8_0._gosignature, true)
		arg_8_0.goSignatureAnimator:Play(UIAnimationName.Open)
	end

	if arg_8_0.fromHeroDetailView then
		arg_8_0.viewContainer:hideHomeBtn()
	end

	if arg_8_0:_isSkillLevelTop() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_opengeneral)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_open)
	end

	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_8_0._onHeroExSkillUp, arg_8_0)
	NavigateMgr.instance:addEscape(ViewName.CharacterExSkillView, arg_8_0._onEscapeBtnClick, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:initViewParam()
	arg_9_0:_refreshUI()
	gohelper.setActive(arg_9_0._gosignature, arg_9_0:_isSkillLevelTop())
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0:refreshCircleAnimation()
	arg_10_0:refreshSkillCardInfo()
	arg_10_0:refreshExLevel()
	arg_10_0:showSkillDetail()

	local var_10_0 = true

	if arg_10_0.viewParam.heroMo then
		var_10_0 = arg_10_0.viewParam.heroMo:isOwnHero()
	end

	if arg_10_0._isOwnHero ~= nil then
		var_10_0 = arg_10_0._isOwnHero
	end

	arg_10_0:setSkillLevelTop(arg_10_0:_isSkillLevelTop() and var_10_0)
	gohelper.setActive(arg_10_0._gotrialtip, not var_10_0 and not arg_10_0._hideTrialTip)

	if arg_10_0:_isSkillLevelTop() or arg_10_0.fromHeroDetailView or not var_10_0 then
		arg_10_0:hideItemAndBtn()
	else
		arg_10_0:showItemAndBtn()
		arg_10_0:refreshItem()
	end
end

function var_0_0.refreshCircleAnimation(arg_11_0)
	local var_11_0 = arg_11_0:_isSkillLevelTop()

	gohelper.setActive(arg_11_0.goCircleNormal1, not var_11_0)
	gohelper.setActive(arg_11_0.goCircleNormal2, not var_11_0)
	gohelper.setActive(arg_11_0.goCircleMax1, var_11_0)
	gohelper.setActive(arg_11_0.goCircleMax2, var_11_0)
end

function var_0_0.refreshSkillCardInfo(arg_12_0)
	local var_12_0 = SkillConfig.instance:getHeroBaseSkillIdDict(arg_12_0._config.id)
	local var_12_1
	local var_12_2

	for iter_12_0 = 1, 3 do
		local var_12_3 = var_12_0[iter_12_0]
		local var_12_4 = lua_skill.configDict[var_12_3]

		if not var_12_4 then
			logError(string.format("heroID : %s, skillId not found : %s", arg_12_0._config.id, var_12_3))
		end

		arg_12_0.skillCardGoDict[iter_12_0].icon:LoadImage(ResUrl.getSkillIcon(var_12_4.icon))
		arg_12_0.skillCardGoDict[iter_12_0].tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_12_4.showTag))
	end
end

function var_0_0.refreshExLevel(arg_13_0)
	for iter_13_0 = 1, arg_13_0.exSkillLevel do
		gohelper.setActive(arg_13_0.golvList[iter_13_0], true)
	end

	for iter_13_1 = arg_13_0.exSkillLevel + 1, CharacterEnum.MaxSkillExLevel do
		gohelper.setActive(arg_13_0.golvList[iter_13_1], false)
	end
end

function var_0_0.setSkillLevelTop(arg_14_0, arg_14_1)
	if arg_14_1 or arg_14_0.fromHeroDetailView then
		recthelper.setHeight(arg_14_0._scrollskillDetailTipScroll.transform, 638)
	else
		recthelper.setHeight(arg_14_0._scrollskillDetailTipScroll.transform, 480)
	end

	gohelper.setActive(arg_14_0._simagefulllevel.gameObject, arg_14_1)
	gohelper.setActive(arg_14_0._gocircle5, arg_14_1)
	gohelper.setActive(arg_14_0._gocircle1, arg_14_1 == false)
end

function var_0_0.hideItemAndBtn(arg_15_0)
	gohelper.setActive(arg_15_0.goMaterialCost, false)
	gohelper.setActive(arg_15_0._btnup.gameObject, false)
end

function var_0_0.showItemAndBtn(arg_16_0)
	gohelper.setActive(arg_16_0.goMaterialCost, true)
	gohelper.setActive(arg_16_0._btnup.gameObject, true)
end

function var_0_0.refreshItem(arg_17_0)
	if arg_17_0:_isSkillLevelTop() then
		gohelper.setActive(arg_17_0.goMaterialCost, false)

		return
	end

	gohelper.setActive(arg_17_0.goMaterialCost, true)

	local var_17_0 = SkillConfig.instance:getherolevelexskillCO(arg_17_0.heroId, arg_17_0.exSkillLevel + 1)

	if not arg_17_0._itemIcon then
		arg_17_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_17_0._goitem)
	end

	local var_17_1 = string.splitToNumber(var_17_0.consume, "#")

	arg_17_0._itemIcon:setMOValue(var_17_1[1], var_17_1[2], var_17_1[3])
	arg_17_0._itemIcon:isShowCount(false)

	local var_17_2 = ItemModel.instance:getItemQuantity(var_17_1[1], var_17_1[2])

	arg_17_0._enoughCost = var_17_2 >= var_17_1[3]

	if arg_17_0._enoughCost then
		arg_17_0._txtcostnum.text = string.format("%s/%s", var_17_2, var_17_1[3])
	else
		arg_17_0._txtcostnum.text = string.format("<color=#ce4949>%s</color>/%s", var_17_2, var_17_1[3])
	end

	gohelper.setActive(arg_17_0._golevelupeffect, arg_17_0._enoughCost)
end

function var_0_0._refreshArrow(arg_18_0)
	if arg_18_0._scrollskillDetailTipScroll.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(arg_18_0._goarrow, true)
	else
		gohelper.setActive(arg_18_0._goarrow, false)
	end
end

function var_0_0._isSkillLevelTop(arg_19_0)
	return arg_19_0.exSkillLevel == CharacterEnum.MaxSkillExLevel
end

function var_0_0._onHeroExSkillUp(arg_20_0)
	arg_20_0.exSkillLevel = (arg_20_0.viewParam.heroMo or HeroModel.instance:getByHeroId(arg_20_0.heroId)).exSkillLevel

	arg_20_0:resetJumpValue()
	gohelper.setActive(arg_20_0._goJumpAnimationMask, true)

	if arg_20_0:_isSkillLevelTop() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_succeedspecial)
		arg_20_0.viewGoAnimator:Play("max", 0, 0)
		gohelper.setActive(arg_20_0._gosignature, true)
		arg_20_0.goSignatureAnimator:Play("max", 0, 0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_succeedgeneral)
		arg_20_0.viewGoAnimator:Play("nomal", 0, 0)
	end

	gohelper.setActive(arg_20_0.golvList[arg_20_0.exSkillLevel], true)

	arg_20_0.lvAnimator = arg_20_0.golvList[arg_20_0.exSkillLevel]:GetComponent(typeof(UnityEngine.Animator))

	arg_20_0.lvAnimator:Play(UIAnimationName.Click, 0, 0)
	arg_20_0._descList[arg_20_0.exSkillLevel]:playHeroExSkillUPAnimation()
end

function var_0_0.onAniEnd(arg_21_0)
	gohelper.setActive(arg_21_0._goJumpAnimationMask, false)
	gohelper.setActive(arg_21_0._goclickani, true)
	gohelper.setActive(arg_21_0._gomaxani, true)
end

function var_0_0.onAniRefreshUI(arg_22_0)
	arg_22_0:_refreshUI()
end

function var_0_0.onJumpTargetFrame(arg_23_0)
	arg_23_0.inPreTargetFrame = false
end

function var_0_0.resetJumpValue(arg_24_0)
	arg_24_0.inPreTargetFrame = true
	arg_24_0.jumped = false
end

function var_0_0.getExSkillTipInfo(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = SkillConfig.instance:getherolevelexskillCO(arg_25_1, arg_25_2)

	if not var_25_0 then
		return
	end

	local var_25_1 = var_25_0.skillEx
	local var_25_2 = lua_skill.configDict[var_25_1]

	return var_25_2.name, var_25_2.desc, var_25_2.icon, var_25_2.desc_art
end

function var_0_0.showSkillDetail(arg_26_0)
	local var_26_0 = 0
	local var_26_1 = 0

	for iter_26_0 = 1, CharacterEnum.MaxSkillExLevel do
		local var_26_2 = SkillConfig.instance:getherolevelexskillCO(arg_26_0.heroId, iter_26_0)
		local var_26_3 = arg_26_0:addDescItem(iter_26_0, var_26_2)

		if iter_26_0 == arg_26_0.exSkillLevel then
			var_26_1 = var_26_0
		end

		var_26_0 = var_26_0 + var_26_3
	end

	arg_26_0._goContent:SetActive(true)
	arg_26_0:rebuildLayout()
	recthelper.setAnchorY(arg_26_0._goContent.transform, var_26_1)
end

function var_0_0.rebuildLayout(arg_27_0)
	ZProj.UGUIHelper.RebuildLayout(arg_27_0._godescripteList.transform)
	arg_27_0:_refreshArrow()
end

function var_0_0.addDescItem(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0._descList = arg_28_0._descList or arg_28_0:getUserDataTb_()

	local var_28_0 = arg_28_0._descList[arg_28_1]

	if not var_28_0 then
		var_28_0 = CharacterSkillDescripte.New()

		local var_28_1 = gohelper.clone(arg_28_0._godescitem, arg_28_0._godescripteList)

		var_28_1:SetActive(true)
		var_28_0:initView(var_28_1)

		arg_28_0._descList[arg_28_1] = var_28_0
	end

	return (var_28_0:updateInfo(arg_28_0, arg_28_0.heroId, arg_28_1, arg_28_0.exSkillLevel, arg_28_0.fromHeroDetailView))
end

function var_0_0.showBuffContainer(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	gohelper.setActive(arg_29_0._goBuffContainer, true)

	arg_29_0.buffItemWidth = GameUtil.getTextWidthByLine(arg_29_0._txtBuffDesc, arg_29_2, 24)
	arg_29_0.buffItemWidth = arg_29_0.buffItemWidth + 70

	if arg_29_0.buffItemWidth > arg_29_0.maxBuffContainerWidth then
		arg_29_0.buffItemWidth = arg_29_0.maxBuffContainerWidth
	end

	arg_29_0._txtBuffName.text = arg_29_1
	arg_29_0._txtBuffDesc.text = arg_29_2

	local var_29_0 = FightConfig.instance:getBuffTag(arg_29_1)

	gohelper.setActive(arg_29_0._goBuffTag, not string.nilorempty(var_29_0))

	arg_29_0._txtBuffTagName.text = var_29_0

	local var_29_1 = recthelper.screenPosToAnchorPos(arg_29_3, arg_29_0.viewGO.transform)

	recthelper.setAnchor(arg_29_0._goBuffItem.transform, var_29_1.x - 20, var_29_1.y)
end

function var_0_0.hideBuffContainer(arg_30_0)
	gohelper.setActive(arg_30_0._goBuffContainer, false)
end

function var_0_0.getShowAttributeOption(arg_31_0)
	return arg_31_0.showAttributeOption
end

function var_0_0.onJumpAnimationClick(arg_32_0)
	if arg_32_0.jumped then
		return
	end

	if not arg_32_0.inPreTargetFrame then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_mould)

	arg_32_0.jumped = true

	if arg_32_0:_isSkillLevelTop() then
		arg_32_0.viewGoAnimator:Play("max", 0, 0.7913043478260869)
		arg_32_0.goSignatureAnimator:Play("max", 0, 0.9479166666666666)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_skipspecial)
	else
		arg_32_0.viewGoAnimator:Play("nomal", 0, 0.7913043478260869)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mould_skipgeneral)
	end

	arg_32_0.goClickAnimation:Stop()
	gohelper.setActive(arg_32_0._goclickani, false)
	gohelper.setActive(arg_32_0._gomaxani, false)
	gohelper.setActive(arg_32_0.golvList[arg_32_0.exSkillLevel], true)
	arg_32_0.lvAnimator:Play(UIAnimationName.Click, 0, 1)
	arg_32_0._descList[arg_32_0.exSkillLevel]:jumpAnimation()
	gohelper.setActive(arg_32_0._goJumpAnimationMask, false)
end

function var_0_0.onClose(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0._descList) do
		iter_33_1:onClose()
	end
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._buffBgClick:RemoveClickDownListener()
	arg_34_0._jumpAnimationClick:RemoveClickListener()
	arg_34_0._scrollskillDetailTipScroll:RemoveOnValueChanged()
	arg_34_0._simagebgimg:UnLoadImage()
	arg_34_0._simagelefticon:UnLoadImage()
	arg_34_0._simagerighticon:UnLoadImage()
	arg_34_0._simagerighticon2:UnLoadImage()
	arg_34_0._simagemask:UnLoadImage()
	arg_34_0._simagefulllevel:UnLoadImage()
	arg_34_0.viewGoAniEventWrap:RemoveAllEventListener()

	for iter_34_0, iter_34_1 in pairs(arg_34_0.skillCardGoDict) do
		iter_34_1.icon:UnLoadImage()
		iter_34_1.tagIcon:UnLoadImage()
	end
end

return var_0_0
