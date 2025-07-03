module("modules.logic.versionactivity2_7.act191.view.Act191CharacterExSkillView", package.seeall)

local var_0_0 = class("Act191CharacterExSkillView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golvProgress = gohelper.findChild(arg_1_0.viewGO, "#go_lvProgress")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "materialCost/#go_item")
	arg_1_0._goskillDetailTipView = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/tipViewBg/#go_arrow")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	arg_1_0._godescripteList = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList/descripteitem")
	arg_1_0._goBuffContainer = gohelper.findChild(arg_1_0.viewGO, "#go_buffContainer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.NormalDescColor = "#b1b1b1"
var_0_0.NotHaveDescColor = "#b1b1b1"
var_0_0.NormalDescColorA = 1
var_0_0.NotHaveDescColorA = 0.4

function var_0_0._onEscapeBtnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.goCircleNormal1 = gohelper.findChild(arg_5_0.viewGO, "go_skills/#simage_circleup")
	arg_5_0.goCircleNormal2 = gohelper.findChild(arg_5_0.viewGO, "go_skills/#simage_circledown")
	arg_5_0.goCircleMax1 = gohelper.findChild(arg_5_0.viewGO, "go_skills/#simage_maxup")
	arg_5_0.goCircleMax2 = gohelper.findChild(arg_5_0.viewGO, "go_skills/#simage_maxdown")
	arg_5_0._gocircle1 = gohelper.findChild(arg_5_0.viewGO, "go_skills/decoration/#go_circle1")
	arg_5_0._gocircle5 = gohelper.findChild(arg_5_0.viewGO, "go_skills/decoration/#go_circle5")
	arg_5_0._gosignature = gohelper.findChild(arg_5_0.viewGO, "go_skills/signature")
	arg_5_0._goclickani = gohelper.findChild(arg_5_0.viewGO, "go_skills/click/ani")
	arg_5_0._gomaxani = gohelper.findChild(arg_5_0.viewGO, "go_skills/max/ani")
	arg_5_0._simagefulllevel = gohelper.findChildSingleImage(arg_5_0.viewGO, "go_skills/decoration/#simage_fulllevel")
	arg_5_0._scrollskillDetailTipScroll = gohelper.findChildScrollRect(arg_5_0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll")

	arg_5_0._scrollskillDetailTipScroll:AddOnValueChanged(arg_5_0._refreshArrow, arg_5_0)
	arg_5_0._simagefulllevel:LoadImage(ResUrl.getCharacterExskill("zs_02"))

	arg_5_0.skillContainerGo = gohelper.findChild(arg_5_0.viewGO, "go_skills")
	arg_5_0.skillCardGoDict = arg_5_0:getUserDataTb_()

	for iter_5_0 = 1, 3 do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.icon = gohelper.findChildSingleImage(arg_5_0.skillContainerGo, string.format("skillicon%s/ani/imgIcon", iter_5_0))
		var_5_0.tagIcon = gohelper.findChildSingleImage(arg_5_0.skillContainerGo, string.format("skillicon%s/ani/tag/tagIcon", iter_5_0))
		arg_5_0.skillCardGoDict[iter_5_0] = var_5_0
	end

	arg_5_0._buffBg = gohelper.findChild(arg_5_0.viewGO, "#go_buffContainer/buff_bg")
	arg_5_0._buffBgClick = gohelper.getClick(arg_5_0._buffBg)

	arg_5_0._buffBgClick:AddClickDownListener(arg_5_0.hideBuffContainer, arg_5_0)

	arg_5_0._goBuffItem = gohelper.findChild(arg_5_0.viewGO, "#go_buffContainer/#go_buffitem")
	arg_5_0._txtBuffName = gohelper.findChildText(arg_5_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	arg_5_0._goBuffTag = gohelper.findChild(arg_5_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	arg_5_0._txtBuffTagName = gohelper.findChildText(arg_5_0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	arg_5_0._txtBuffDesc = gohelper.findChildText(arg_5_0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")
	arg_5_0.golvList = arg_5_0:getUserDataTb_()

	for iter_5_1 = 1, CharacterEnum.MaxSkillExLevel do
		table.insert(arg_5_0.golvList, gohelper.findChild(arg_5_0.viewGO, "#go_lvProgress/#go_lv" .. iter_5_1))
	end

	gohelper.setActive(arg_5_0._goBuffContainer, false)
	gohelper.setActive(arg_5_0._godescitem, false)
	gohelper.setActive(arg_5_0._gosignature, false)

	arg_5_0.goSignatureAnimator = arg_5_0._gosignature:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0.viewGoAnimator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0.viewGoAniEventWrap = arg_5_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_5_0.viewGoAniEventWrap:AddEventListener("end", arg_5_0.onAniEnd, arg_5_0)
	arg_5_0.viewGoAniEventWrap:AddEventListener("refreshUI", arg_5_0.onAniRefreshUI, arg_5_0)
	arg_5_0.viewGoAniEventWrap:AddEventListener("onJumpTargetFrame", arg_5_0.onJumpTargetFrame, arg_5_0)

	arg_5_0.goClickAnimation = arg_5_0._goclickani:GetComponent(typeof(UnityEngine.Animation))
	arg_5_0.maxBuffContainerWidth = 570
end

function var_0_0.initViewParam(arg_6_0)
	arg_6_0.config = arg_6_0.viewParam.config
	arg_6_0.exSkillLevel = arg_6_0.config.exLevel
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:initViewParam()
	arg_7_0:_refreshUI()

	if arg_7_0:_isSkillLevelTop() then
		gohelper.setActive(arg_7_0._gosignature, true)
		arg_7_0.goSignatureAnimator:Play(UIAnimationName.Open)
	end

	if arg_7_0:_isSkillLevelTop() then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_opengeneral)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_mould_open)
	end

	NavigateMgr.instance:addEscape(ViewName.Act191CharacterExSkillView, arg_7_0._onEscapeBtnClick, arg_7_0)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:initViewParam()
	arg_8_0:_refreshUI()
	gohelper.setActive(arg_8_0._gosignature, arg_8_0:_isSkillLevelTop())
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0:refreshCircleAnimation()
	arg_9_0:refreshSkillCardInfo()
	arg_9_0:refreshExLevel()
	arg_9_0:showSkillDetail()
	arg_9_0:setSkillLevelTop(arg_9_0:_isSkillLevelTop())
end

function var_0_0.refreshCircleAnimation(arg_10_0)
	local var_10_0 = arg_10_0:_isSkillLevelTop()

	gohelper.setActive(arg_10_0.goCircleNormal1, not var_10_0)
	gohelper.setActive(arg_10_0.goCircleNormal2, not var_10_0)
	gohelper.setActive(arg_10_0.goCircleMax1, var_10_0)
	gohelper.setActive(arg_10_0.goCircleMax2, var_10_0)
end

function var_0_0.refreshSkillCardInfo(arg_11_0)
	local var_11_0 = Activity191Config.instance:getHeroSkillIdDic(arg_11_0.config.id, true)
	local var_11_1
	local var_11_2

	for iter_11_0 = 1, 3 do
		local var_11_3 = var_11_0[iter_11_0]
		local var_11_4 = lua_skill.configDict[var_11_3]

		if not var_11_4 then
			logError(string.format("heroID : %s, skillId not found : %s", arg_11_0.config.id, var_11_3))
		end

		arg_11_0.skillCardGoDict[iter_11_0].icon:LoadImage(ResUrl.getSkillIcon(var_11_4.icon))
		arg_11_0.skillCardGoDict[iter_11_0].tagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_11_4.showTag))
	end
end

function var_0_0.refreshExLevel(arg_12_0)
	for iter_12_0 = 1, arg_12_0.exSkillLevel do
		gohelper.setActive(arg_12_0.golvList[iter_12_0], true)
	end

	for iter_12_1 = arg_12_0.exSkillLevel + 1, CharacterEnum.MaxSkillExLevel do
		gohelper.setActive(arg_12_0.golvList[iter_12_1], false)
	end
end

function var_0_0.setSkillLevelTop(arg_13_0, arg_13_1)
	if arg_13_1 then
		recthelper.setHeight(arg_13_0._scrollskillDetailTipScroll.transform, 638)
	else
		recthelper.setHeight(arg_13_0._scrollskillDetailTipScroll.transform, 750)
	end

	gohelper.setActive(arg_13_0._simagefulllevel.gameObject, arg_13_1)
	gohelper.setActive(arg_13_0._gocircle5, arg_13_1)
	gohelper.setActive(arg_13_0._gocircle1, arg_13_1 == false)
end

function var_0_0._refreshArrow(arg_14_0)
	if arg_14_0._scrollskillDetailTipScroll.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(arg_14_0._goarrow, true)
	else
		gohelper.setActive(arg_14_0._goarrow, false)
	end
end

function var_0_0._isSkillLevelTop(arg_15_0)
	return arg_15_0.exSkillLevel == CharacterEnum.MaxSkillExLevel
end

function var_0_0.onAniEnd(arg_16_0)
	gohelper.setActive(arg_16_0._goJumpAnimationMask, false)
	gohelper.setActive(arg_16_0._goclickani, true)
	gohelper.setActive(arg_16_0._gomaxani, true)
end

function var_0_0.onAniRefreshUI(arg_17_0)
	arg_17_0:_refreshUI()
end

function var_0_0.onJumpTargetFrame(arg_18_0)
	arg_18_0.inPreTargetFrame = false
end

function var_0_0.resetJumpValue(arg_19_0)
	arg_19_0.inPreTargetFrame = true
	arg_19_0.jumped = false
end

function var_0_0.showSkillDetail(arg_20_0)
	local var_20_0 = 0
	local var_20_1 = 0

	for iter_20_0 = 1, CharacterEnum.MaxSkillExLevel do
		local var_20_2 = arg_20_0:addDescItem(iter_20_0)

		if iter_20_0 == arg_20_0.exSkillLevel then
			var_20_1 = var_20_0
		end

		var_20_0 = var_20_0 + var_20_2
	end

	arg_20_0._goContent:SetActive(true)
	arg_20_0:rebuildLayout()
	recthelper.setAnchorY(arg_20_0._goContent.transform, var_20_1)
end

function var_0_0.rebuildLayout(arg_21_0)
	ZProj.UGUIHelper.RebuildLayout(arg_21_0._godescripteList.transform)
	arg_21_0:_refreshArrow()
end

function var_0_0.addDescItem(arg_22_0, arg_22_1)
	arg_22_0._descList = arg_22_0._descList or arg_22_0:getUserDataTb_()

	local var_22_0 = arg_22_0._descList[arg_22_1]

	if not var_22_0 then
		var_22_0 = Act191CharacterSkillDesc.New()

		local var_22_1 = gohelper.clone(arg_22_0._godescitem, arg_22_0._godescripteList)

		var_22_1:SetActive(true)
		var_22_0:initView(var_22_1)

		arg_22_0._descList[arg_22_1] = var_22_0
	end

	return (var_22_0:updateInfo(arg_22_0, arg_22_0.config, arg_22_1))
end

function var_0_0.showBuffContainer(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	gohelper.setActive(arg_23_0._goBuffContainer, true)

	arg_23_0.buffItemWidth = GameUtil.getTextWidthByLine(arg_23_0._txtBuffDesc, arg_23_2, 24)
	arg_23_0.buffItemWidth = arg_23_0.buffItemWidth + 70

	if arg_23_0.buffItemWidth > arg_23_0.maxBuffContainerWidth then
		arg_23_0.buffItemWidth = arg_23_0.maxBuffContainerWidth
	end

	arg_23_0._txtBuffName.text = arg_23_1
	arg_23_0._txtBuffDesc.text = arg_23_2

	local var_23_0 = FightConfig.instance:getBuffTag(arg_23_1)

	gohelper.setActive(arg_23_0._goBuffTag, not string.nilorempty(var_23_0))

	arg_23_0._txtBuffTagName.text = var_23_0

	local var_23_1 = recthelper.screenPosToAnchorPos(arg_23_3, arg_23_0.viewGO.transform)

	recthelper.setAnchor(arg_23_0._goBuffItem.transform, var_23_1.x - 20, var_23_1.y)
end

function var_0_0.hideBuffContainer(arg_24_0)
	gohelper.setActive(arg_24_0._goBuffContainer, false)
end

function var_0_0.getShowAttributeOption(arg_25_0)
	return CharacterEnum.showAttributeOption.ShowCurrent
end

function var_0_0.onClose(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._descList) do
		iter_26_1:onClose()
	end
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0._buffBgClick:RemoveClickDownListener()
	arg_27_0._scrollskillDetailTipScroll:RemoveOnValueChanged()
	arg_27_0._simagefulllevel:UnLoadImage()
	arg_27_0.viewGoAniEventWrap:RemoveAllEventListener()

	for iter_27_0, iter_27_1 in pairs(arg_27_0.skillCardGoDict) do
		iter_27_1.icon:UnLoadImage()
		iter_27_1.tagIcon:UnLoadImage()
	end
end

return var_0_0
