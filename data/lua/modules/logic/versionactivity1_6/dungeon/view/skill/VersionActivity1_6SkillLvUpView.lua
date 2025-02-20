module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillLvUpView", package.seeall)

slot0 = class("VersionActivity1_6SkillLvUpView", BaseView)
slot1 = 570
slot2 = "v1a6_talent_paint_line_%s_%s"

function slot0.onInitView(slot0)
	slot0._btnLvUp = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_skillDetailTipView/#btn_LvUp")
	slot0._btnLvDown = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_skillDetailTipView/#btn_LvDown")
	slot0._btnLvUpDisable = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_skillDetailTipView/#btn_LvUpDisable")
	slot0._btnLvDownDisable = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_skillDetailTipView/#btn_LvDownDisable")
	slot0._textLvUpCost = gohelper.findChildText(slot0.viewGO, "#go_skillDetailTipView/#btn_LvUp/#txt_Num")
	slot0._textLvDownCost = gohelper.findChildText(slot0.viewGO, "#go_skillDetailTipView/#btn_LvDown/#txt_Num")
	slot0._iamgeBtnLvUp = gohelper.findChildImage(slot0.viewGO, "#go_skillDetailTipView/#btn_LvUp/#txt_Num/#simage_Prop")
	slot0._imageBtnLvDown = gohelper.findChildImage(slot0.viewGO, "#go_skillDetailTipView/#btn_LvDown/#txt_Num/#simage_Prop")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Left/Title/txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "Left/Title/txt_TitleEn")
	slot0._imageIcon = gohelper.findChildImage(slot0.viewGO, "Left/#image_Icon")
	slot0._imageIconGold = gohelper.findChildImage(slot0.viewGO, "Left/#image_Icon_gold")
	slot0._imageIconSliver = gohelper.findChildImage(slot0.viewGO, "Left/#image_Icon_sliver")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "Left/#txt_Descr")
	slot0._btnSkillPointProp = gohelper.findChildButtonWithAudio(slot0.viewGO, "SkillPoint/#btn_Info/Click")
	slot0._btnSkillPointTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "SkillPoint/#btn_Info")
	slot0._btnTipsClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "SkillPoint/#btn_Info/image_TipsBG/#btn_Tips_Close")
	slot0._goSkilPointTips = gohelper.findChild(slot0.viewGO, "SkillPoint/#btn_Info/image_TipsBG")
	slot0._txtSkillPointNum = gohelper.findChildText(slot0.viewGO, "SkillPoint/#btn_Info/image_TipsBG/txt_Tips_Num")
	slot0._txtRemainSkillPointNum = gohelper.findChildText(slot0.viewGO, "SkillPoint/txt_Skill_Num")
	slot0._imageSkillPoint = gohelper.findChildImage(slot0.viewGO, "SkillPoint/#simage_Prop")
	slot0._goSkillIconEffect = gohelper.findChild(slot0.viewGO, "Left/eff")
	slot0._goSkillPointEffect = gohelper.findChild(slot0.viewGO, "SkillPoint/eff")
	slot0._goSkilPointAttrContent = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content")
	slot0._goSkilPointAttrItem = gohelper.findChild(slot0.viewGO, "#go_skillDetailTipView/skillDetailTipScroll/Viewport/#go_Content/#go_descripteList")
	slot0._goBuffContainer = gohelper.findChild(slot0.viewGO, "#go_buffContainer")
	slot0._buffBg = gohelper.findChild(slot0.viewGO, "#go_buffContainer/buff_bg")
	slot0._buffBgClick = gohelper.getClick(slot0._buffBg)
	slot0._goBuffItem = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem")
	slot0._txtBuffName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	slot0._goBuffTag = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	slot0._txtBuffTagName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	slot0._txtBuffDesc = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLvUp:AddClickListener(slot0._btnLvUpOnClick, slot0)
	slot0._btnLvUpDisable:AddClickListener(slot0._btnLvUpOnClick, slot0)
	slot0._btnLvDown:AddClickListener(slot0._btnLvDownOnClick, slot0)
	slot0._btnLvDownDisable:AddClickListener(slot0._btnLvDownOnClick, slot0)
	slot0._btnSkillPointProp:AddClickListener(slot0._btnSkillPointOnClick, slot0)
	slot0._btnSkillPointTips:AddClickListener(slot0._btnSkillPointTipsOnClick, slot0)
	slot0._btnTipsClose:AddClickListener(slot0._btnSkillPointTipsCloseOnClick, slot0)
	slot0._buffBgClick:AddClickDownListener(slot0.hideBuffContainer, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLvUp:RemoveClickListener()
	slot0._btnLvDown:RemoveClickListener()
	slot0._btnLvUpDisable:RemoveClickListener()
	slot0._btnLvDownDisable:RemoveClickListener()
	slot0._btnSkillPointTips:RemoveClickListener()
	slot0._btnSkillPointProp:RemoveClickListener()
	slot0._btnTipsClose:RemoveClickListener()
	slot0._buffBgClick:RemoveClickDownListener()
end

function slot0._editableInitView(slot0)
	slot0.skillAttrItemDict = {}

	gohelper.setActive(slot0._goSkilPointAttrItem, false)
	gohelper.setActive(slot0._goBuffContainer, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillLvDown, slot0._onLvChange, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillLvUp, slot0._onLvChange, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, VersionActivity1_6DungeonEvent.SkillPointReturnBack, slot0._skillPointReturnBack, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)

	slot0._skillType = slot0.viewParam and slot0.viewParam.skillType
	slot0._skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(slot0._skillType)
	slot0._curLv = slot0._skillMo:getLevel()

	gohelper.setActive(slot0._goSkilPointTips, false)
end

function slot0.onOpenFinish(slot0)
	slot0:initCenterSkillNodes()
	slot0:refreshCenterSkillNodes()
	slot0:_refreshSkillPointNum()
	slot0:refreshSkillInfo()
	slot0:refreshSkillIcon()
	slot0:initSkillAttrItems()
	slot0:refreshSkillAttrs()
	slot0:refreshBtnCost()
	slot0:_refreshSkillPointIcon()
	slot0:_refreshBtnVisible()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._onLvChange(slot0, slot1)
	slot0._skillMo = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(slot0._skillType)
	slot2 = slot1 < slot0._curLv

	AudioMgr.instance:trigger(slot2 and AudioEnum.UI.Act1_6DungeonSkillViewLvDown or AudioEnum.UI.Act1_6DungeonSkillViewLvUp)

	slot0._curLv = slot1

	slot0:doSkillLvChangeView(slot1)
	slot0:refreshSkillAttrs(slot2)
	slot0:refreshCenterSkillNodes()
	slot0:_refreshSkillNodeEffect(slot2)
	slot0:_refreshSkillPointNum()
	slot0:refreshBtnCost()
	slot0:refreshSkillIcon()
	slot0:_refreshBtnVisible()
end

function slot0.initCenterSkillNodes(slot0)
	slot0._skillLvPoints = slot0:getUserDataTb_()

	for slot5 = 1, VersionActivity1_6DungeonEnum.skillTypeNum do
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "#go_Paint" .. slot5), slot5 == slot0._skillType)
	end

	slot2 = gohelper.findChild(slot0.viewGO, "#go_Paint" .. slot0._skillType)
	slot0._imageSkillNodeLine = gohelper.findChildImage(slot2, "image_PaintLineFG")
	slot8 = UnityEngine.Animator
	slot0._animatorSkillNodeLine = slot0._imageSkillNodeLine:GetComponent(typeof(slot8))

	for slot8 = 1, VersionActivity1_6DungeonEnum.skillPointMaxNum do
		slot10 = gohelper.clone(gohelper.findChild(slot2, "#go_Lv"), gohelper.findChild(slot2, "#go_Lv" .. slot8), "node")

		gohelper.setActive(slot10, true)

		slot0._skillLvPoints[slot8] = slot0:getUserDataTb_()
		slot0._skillLvPoints[slot8].normalPointDark = gohelper.findChild(slot10, "#go_Point1-1")
		slot0._skillLvPoints[slot8].normalPoint = gohelper.findChild(slot10, "#go_Point1-2")
		slot0._skillLvPoints[slot8].keyPointDark = gohelper.findChild(slot10, "#go_Point2-1")
		slot0._skillLvPoints[slot8].keyPoint = gohelper.findChild(slot10, "#go_Point2-2")
		slot0._skillLvPoints[slot8].effect = gohelper.findChild(slot10, "eff")
	end
end

function slot0.refreshCenterSkillNodes(slot0)
	for slot6 = 1, VersionActivity1_6DungeonEnum.skillPointMaxNum do
		slot8 = slot0._curLv < slot6
		slot9 = slot0._curLv < slot6
		slot10 = slot6 <= slot0._curLv
		slot11 = slot6 <= slot0._curLv

		if VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[slot6] then
			slot8 = false
			slot10 = false
		else
			slot11 = false
			slot9 = false
		end

		gohelper.setActive(slot0._skillLvPoints[slot6].normalPoint, slot10)
		gohelper.setActive(slot0._skillLvPoints[slot6].normalPointDark, slot8)
		gohelper.setActive(slot0._skillLvPoints[slot6].keyPoint, slot11)
		gohelper.setActive(slot0._skillLvPoints[slot6].keyPointDark, slot9)
	end

	gohelper.setActive(slot0._imageSkillNodeLine.gameObject, slot0._curLv > 1)

	if slot0._curLv > 1 then
		UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(slot0._imageSkillNodeLine, string.format(uv0, slot0._skillType, slot0._curLv - 1))

		if slot0._animatorSkillNodeLine then
			slot0._animatorSkillNodeLine:Play(UIAnimationName.Open, 0, 0)
		end
	end
end

function slot0._refreshSkillNodeEffect(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._goSkillPointEffect, false)
		gohelper.setActive(slot0._goSkillPointEffect, true)
	end

	gohelper.setActive(slot0._goSkillIconEffect, false)
	gohelper.setActive(slot0._goSkillIconEffect, true)

	slot2 = VersionActivity1_6DungeonEnum.SkillKeyPointIdxs

	for slot7 = 1, VersionActivity1_6DungeonEnum.skillPointMaxNum do
		if not slot1 then
			gohelper.setActive(slot0._skillLvPoints[slot7].effect, slot0._curLv == slot7)
		end
	end
end

slot3 = "#E4C599"

function slot0._refreshSkillPointNum(slot0)
	slot1 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)

	if LangSettings.instance:isEn() then
		slot0._txtRemainSkillPointNum.text = " " .. (CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill) and slot2.quantity or 0)
	else
		slot0._txtRemainSkillPointNum.text = slot3
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtRemainSkillPointNum, uv0)

	slot0._txtSkillPointNum.text = string.format("<color=#EB5F34>%s</color>/%s", VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum() or 0, slot1)
end

function slot0.refreshSkillInfo(slot0)
	slot1 = slot0._skillMo and slot0._skillMo:getLevel() or 0
	slot2 = Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillType, slot1)
	slot3 = Activity148Config.instance:getAct148SkillTypeCfg(slot0._skillType)

	if slot1 == 0 then
		slot2 = Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillType, 1)
	end

	slot0._txtTitle.text = slot3.skillName
	slot0._txtTitleEn.text = slot3.skillNameEn
	slot0._txtDesc.text = slot3.skillInfoDesc
end

function slot0.refreshSkillIcon(slot0)
	slot1 = slot0._skillMo and slot0._skillMo:getLevel() or 0
	slot3 = Activity148Config.instance:getAct148SkillTypeCfg(slot0._skillType)
	slot4 = nil
	slot4 = (slot1 ~= 0 or Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.SkillOriginIcon[slot0._skillType])) and Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillType, slot1).skillSmallIcon

	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(slot0._imageIcon, slot4)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(slot0._imageIconGold, slot4)
	UISpriteSetMgr.instance:setV1a6DungeonSkillSprite(slot0._imageIconSliver, slot4)

	slot8 = tonumber(Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.SilverEffectSkillLv)) <= slot1

	if tonumber(Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.GoldEffectSkillLv)) <= slot1 then
		gohelper.setActive(slot0._imageIconSliver.gameObject, false)
		gohelper.setActive(slot0._imageIconGold.gameObject, true)
	elseif slot8 then
		gohelper.setActive(slot0._imageIconSliver.gameObject, true)
		gohelper.setActive(slot0._imageIconGold.gameObject, false)
	else
		gohelper.setActive(slot0._imageIconSliver.gameObject, false)
		gohelper.setActive(slot0._imageIconGold.gameObject, false)
	end
end

function slot0.initSkillAttrItems(slot0)
	for slot5, slot6 in pairs(Activity148Config.instance:getAct148CfgDictByType(slot0._skillType)) do
		slot7 = gohelper.cloneInPlace(slot0._goSkilPointAttrItem, "item" .. slot5)

		gohelper.setActive(slot7, true)

		slot0.skillAttrItemDict[slot6.id] = slot0:createSkillAttrItem(slot7, slot6)
	end
end

function slot0.createSkillAttrItem(slot0, slot1, slot2)
	slot3 = VersionActivity1_6SkillDescItem.New()

	slot3:init(slot1, slot2, slot0)
	slot3:refreshInfo()

	return slot3
end

function slot0.refreshSkillAttrs(slot0, slot1)
	for slot6, slot7 in pairs(Activity148Config.instance:getAct148CfgDictByType(slot0._skillType)) do
		slot8 = slot0.skillAttrItemDict[slot7.id]
		slot8.canvasGroup.alpha = slot0._curLv < slot8.lv and 0.5 or 1
		slot8.txtlvcanvasGroup.alpha = slot0._curLv < slot8.lv and 0.5 or 1

		gohelper.setActive(slot8.goCurLvFlag, slot0._curLv == slot8.lv - 1)
	end

	slot3 = 3

	if slot1 and slot0._curLv < 5 or not slot1 and slot0._curLv > 3 then
		slot5 = 0
		slot6 = 0

		for slot10 = 1, VersionActivity1_6DungeonEnum.skillMaxLv do
			slot13 = slot0.skillAttrItemDict[slot2[slot10].id].height

			if slot10 == slot0._curLv then
				slot6 = slot5
			end

			slot5 = slot5 + slot13
		end

		recthelper.setAnchorY(slot0._goSkilPointAttrContent.transform, slot6)
	end
end

function slot0.doSkillLvChangeView(slot0, slot1)
	for slot5, slot6 in pairs(slot0.skillAttrItemDict) do
		gohelper.setActive(slot6.vx, slot1 == slot6.lv)
	end
end

function slot0.refreshBtnCost(slot0)
	slot1 = slot0._curLv
	slot2 = slot1 - 1
	slot3 = slot1 + 1
	slot5 = ""

	if Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillType, slot1) then
		slot5 = "+" .. string.splitToNumber(slot4.cost, "#")[3]
	end

	slot0._textLvDownCost.text = slot5
	slot6 = ""

	if Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillType, slot3) then
		slot6 = "-" .. string.splitToNumber(slot7.cost, "#")[3]
	end

	slot0._textLvUpCost.text = slot6
end

function slot0._refreshBtnVisible(slot0)
	slot1 = slot0._curLv
	slot5 = Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillType, slot1 + 1) ~= nil
	slot6 = slot1 - 1 >= 0

	gohelper.setActive(slot0._btnLvUp, slot5)
	gohelper.setActive(slot0._btnLvUpDisable, not slot5)
	gohelper.setActive(slot0._btnLvDown, slot6)
	gohelper.setActive(slot0._btnLvDownDisable, not slot6)
end

function slot0._refreshSkillPointIcon(slot0)
	slot2 = string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill) and slot1.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageSkillPoint, slot2)
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._iamgeBtnLvUp, slot2)
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageBtnLvDown, slot2)
end

function slot0.showBuffContainer(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot0._goBuffContainer, true)

	slot0.buffItemWidth = GameUtil.getTextWidthByLine(slot0._txtBuffDesc, slot2, 24)
	slot0.buffItemWidth = slot0.buffItemWidth + 70

	if uv0 < slot0.buffItemWidth then
		slot0.buffItemWidth = uv0
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

function slot0._btnLvUpOnClick(slot0)
	if not Activity148Config.instance:getAct148CfgByTypeLv(slot0._skillType, slot0._curLv + 1) then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60201)
	else
		slot5 = string.splitToNumber(slot3.cost, "#")

		if CurrencyModel.instance:getCurrency(slot5[2]).quantity < slot5[3] then
			GameFacade.showToast(ToastEnum.Act1_6DungeonToast60203)

			return
		end

		VersionActivity1_6DungeonRpc.instance:sendAct148UpLevelRequest(slot0._skillType)
	end
end

function slot0._btnLvDownOnClick(slot0)
	if slot0._curLv - 1 < 0 then
		GameFacade.showToast(ToastEnum.Act1_6DungeonToast60202)
	else
		VersionActivity1_6DungeonRpc.instance:sendAct148DownLevelRequest(slot0._skillType)
	end
end

function slot0._btnSkillPointOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6DungeonSkill, false, nil, false)
end

function slot0._btnSkillPointTipsOnClick(slot0)
	slot0:refreshSkillPointTips(true)
end

function slot0._btnSkillPointTipsCloseOnClick(slot0)
	slot0:refreshSkillPointTips(false)
end

function slot0.refreshSkillPointTips(slot0, slot1)
	gohelper.setActive(slot0._goSkilPointTips, slot1)
end

function slot0._skillPointReturnBack(slot0)
	slot0:_refreshSkillPointNum()
end

function slot0._onCurrencyChange(slot0)
	slot0:_refreshSkillPointNum()
end

return slot0
