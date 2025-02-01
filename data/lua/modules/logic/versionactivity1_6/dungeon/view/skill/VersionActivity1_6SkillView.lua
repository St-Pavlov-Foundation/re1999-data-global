module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillView", package.seeall)

slot0 = "#E4C599"
slot1 = class("VersionActivity1_6SkillView", BaseView)
slot2 = 4

function slot1.onInitView(slot0)
	slot0._goItem1 = gohelper.findChild(slot0.viewGO, "#go_Item1")
	slot0._goItem2 = gohelper.findChild(slot0.viewGO, "#go_Item2")
	slot0._goItem3 = gohelper.findChild(slot0.viewGO, "#go_Item3")
	slot0._goItem4 = gohelper.findChild(slot0.viewGO, "#go_Item4")
	slot0._goDetailPanel = gohelper.findChild(slot0.viewGO, "SkillPanel")
	slot0._detailAnimator = slot0._goDetailPanel:GetComponent(typeof(UnityEngine.Animator))
	slot0._goSkillEffectDesc = gohelper.findChild(slot0.viewGO, "SkillPanel/Skill/Scroll View/Viewport/Content/#go_SkillDescr")
	slot0._goSkillAttrDesc = gohelper.findChild(slot0.viewGO, "SkillPanel/Value/Layout/#go_Attri")
	slot0._goSkillEffectEmpty = gohelper.findChild(slot0.viewGO, "SkillPanel/Skill/#go_Empty")
	slot0._goSkillAttrEmpty = gohelper.findChild(slot0.viewGO, "SkillPanel/Value/#go_Empty")
	slot0._goBuffItemTemplate = gohelper.findChild(slot0.viewGO, "v1a6_talent_lvupitem")
	slot0._btnReset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Reset")
	slot0._btnPreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Wish")
	slot0._btnClosePreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "SkillPanel/#btn_close")
	slot0._btnSkillPointArea = gohelper.findChildButtonWithAudio(slot0.viewGO, "SkillPoint/#btn_Info/Click")
	slot0._btnSkillPointTips = gohelper.findChildButtonWithAudio(slot0.viewGO, "SkillPoint/#btn_Info")
	slot0._btnTipsClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "SkillPoint/#btn_Info/image_TipsBG/#btn_Tips_Close")
	slot0._goSkilPointTips = gohelper.findChild(slot0.viewGO, "SkillPoint/#btn_Info/image_TipsBG")
	slot0._txtSkillPointNum = gohelper.findChildText(slot0.viewGO, "SkillPoint/#btn_Info/image_TipsBG/txt_Tips_Num")
	slot0._txtRemainSkillPointNum = gohelper.findChildText(slot0.viewGO, "SkillPoint/txt_Skill_Num")
	slot0._imageSkillPoint = gohelper.findChildImage(slot0.viewGO, "SkillPoint/#simage_Prop")
	slot0._goSkillPointEffect = gohelper.findChild(slot0.viewGO, "SkillPoint/eff")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot1.addEvents(slot0)
	slot0._btnPreview:AddClickListener(slot0._btnPreviewOnClick, slot0)
	slot0._btnReset:AddClickListener(slot0._btnResetOnClick, slot0)
	slot0._btnClosePreview:AddClickListener(slot0._btnPreviewCloseOnClick, slot0)
	slot0._btnSkillPointArea:AddClickListener(slot0._btnSkillPointOnClick, slot0)
	slot0._btnSkillPointTips:AddClickListener(slot0._btnSkillPointTipsOnClick, slot0)
	slot0._btnTipsClose:AddClickListener(slot0._btnSkillPointTipsCloseOnClick, slot0)
end

function slot1.removeEvents(slot0)
	slot0._btnPreview:RemoveClickListener()
	slot0._btnReset:RemoveClickListener()
	slot0._btnClosePreview:RemoveClickListener()
	slot0._btnSkillPointTips:RemoveClickListener()
	slot0._btnSkillPointArea:RemoveClickListener()
	slot0._btnTipsClose:RemoveClickListener()
end

function slot1._editableInitView(slot0)
	gohelper.setActive(slot0._goBuffItemTemplate, false)
	gohelper.setActive(slot0._goDetailPanel, false)
	gohelper.setActive(slot0._goSkilPointTips, false)
	gohelper.setActive(slot0._goSkillEffectDesc, false)
	gohelper.setActive(slot0._goSkillAttrDesc, false)

	slot0._buffItemList = {}
end

function slot1.onUpdateParam(slot0)
end

function slot1.onOpen(slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillReset, slot0._onSkillReset, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillLvDown, slot0._onLvChange, slot0)
	slot0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillLvUp, slot0._onLvChange, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterSkillView)
end

function slot1.onOpenFinish(slot0)
	slot0:_initSkillItem()
	slot0:_refreshSkillPoint()
	slot0:_refreshSkillEffects()
	slot0:_refreshSkillAttrs()
end

function slot1._initSkillItem(slot0)
	for slot4 = 1, uv0 do
		slot5 = VersionActivity1_6SkillItem.New()
		slot6 = gohelper.cloneInPlace(slot0._goBuffItemTemplate)

		gohelper.setActive(slot6, true)
		slot6.transform:SetParent(slot0["_goItem" .. slot4].transform)
		transformhelper.setLocalPos(slot6.transform, 0, 0, 0)
		slot5:init(slot6, slot4)

		slot0._buffItemList[slot4] = slot5
	end
end

function slot1._refreshSkillItems(slot0)
	for slot4 = 1, uv0 do
		slot0._buffItemList[slot4]:refreshItemUI()
	end
end

function slot1._refreshSkillPoint(slot0)
	slot1 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	slot2 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill)

	if CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill) then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageSkillPoint, string.format("%s_1", slot3 and slot3.icon))
	end

	if LangSettings.instance:isEn() then
		slot0._txtRemainSkillPointNum.text = " " .. (slot2 and slot2.quantity or 0)
	else
		slot0._txtRemainSkillPointNum.text = slot4
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtRemainSkillPointNum, uv0)

	if LangSettings.instance:isEn() then
		slot0._txtSkillPointNum.text = " " .. string.format("<color=#EB5F34>%s</color>/%s", VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum() or 0, slot1)
	else
		slot0._txtSkillPointNum.text = slot6
	end
end

function slot1.refreshSkillDetailPanel(slot0, slot1)
	gohelper.setActive(slot0._goDetailPanel, true)
	gohelper.setActive(slot0._btnClosePreview.gameObject, slot1)
	slot0._detailAnimator:Play(slot1 and UIAnimationName.Open or UIAnimationName.Close, 0, 0)
end

function slot1._refreshSkillEffects(slot0)
	slot1 = {}

	for slot5 = 1, uv0 do
		for slot12 = 1, VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(slot5) and slot7:getLevel() or 0 do
			if VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[slot12] then
				slot1[#slot1 + 1] = Activity148Config.instance:getAct148CfgByTypeLv(slot6, slot12)
			end
		end
	end

	slot0._skillEffectItemList = {}

	for slot5 = 1, #slot1 do
		slot6 = slot1[slot5]
		slot8 = gohelper.cloneInPlace(slot0._goSkillEffectDesc)

		gohelper.setActive(slot8, true)

		slot0._skillEffectItemList[slot5] = slot0:getUserDataTb_()
		slot0._skillEffectItemList[slot5].go = slot8
		slot8:GetComponent(gohelper.Type_TextMesh).text = gohelper.getRichColorText(GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity1_6skillview_skilleff_overseas"), {
			Activity148Config.instance:getAct148SkillTypeCfg(slot6.type).skillName,
			slot6.level
		}), "#E99B56") .. (FightConfig.instance:getSkillEffectCO(slot6.skillId) and slot10.desc)
	end

	gohelper.setActive(slot0._goSkillEffectEmpty, #slot1 == 0)
end

function slot1._refreshSkillAttrs(slot0)
	slot1 = {}

	for slot5 = 1, uv0 do
		for slot12 = 1, VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(slot5) and slot7:getLevel() or 0 do
			if not VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[slot12] then
				slot16 = string.splitToNumber(Activity148Config.instance:getAct148CfgByTypeLv(slot6, slot12).attrs, "#")
				slot18 = slot16[2]

				if not slot1[slot16[1]] then
					slot1[slot17] = 0
				end

				slot1[slot17] = slot1[slot17] + slot18
			end
		end
	end

	slot0._skillAttrItemList = {}

	for slot6, slot7 in pairs(slot1) do
		slot8 = HeroConfig.instance:getHeroAttributeCO(slot6)
		slot9 = gohelper.cloneInPlace(slot0._goSkillAttrDesc)

		gohelper.setActive(slot9, true)

		slot0._skillAttrItemList[slot6] = slot0:getUserDataTb_()
		slot0._skillAttrItemList[slot6].go = slot9
		slot9:GetComponent(gohelper.Type_TextMesh).text = slot8.name
		gohelper.findChildText(slot9, "#go_AttriNum").text = "+" .. (tonumber(string.format("%.3f", slot7 / 10)) .. "%")

		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot9, "#image_Icon"), "icon_att_" .. slot8.id, true)

		slot2 = 0 + 1
	end

	gohelper.setActive(slot0._goSkillAttrEmpty, slot2 == 0)
end

function slot1._clearSkillDetailItems(slot0)
	if slot0._skillEffectItemList then
		for slot4, slot5 in pairs(slot0._skillEffectItemList) do
			gohelper.destroy(slot5.go)

			slot5.go = nil
		end
	end

	slot0._skillEffectItemList = nil

	if slot0._skillAttrItemList then
		for slot4, slot5 in pairs(slot0._skillAttrItemList) do
			gohelper.destroy(slot5.go)

			slot5.go = nil
		end
	end

	slot0._skillAttrItemList = nil
end

function slot1.refreshSkillPointTips(slot0, slot1)
	gohelper.setActive(slot0._goSkilPointTips, slot1)
end

function slot1.onClose(slot0)
end

function slot1.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._buffItemList) do
		slot5:onDestroyItem()
	end

	slot0._buffItemList = nil
end

function slot1._onCurrencyChange(slot0)
	slot0:_refreshSkillPoint()
end

function slot1._onSkillReset(slot0)
	for slot4 = 1, uv0 do
		slot0._buffItemList[slot4]:refreshResetEffect()
	end

	gohelper.setActive(slot0._goSkillPointEffect, false)
	gohelper.setActive(slot0._goSkillPointEffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonSkillViewReset)
	slot0:_onLvChange()
end

function slot1._onLvChange(slot0)
	slot0:_refreshSkillItems()
	slot0:_refreshSkillPoint()
	slot0:_clearSkillDetailItems()
	slot0:_refreshSkillEffects()
	slot0:_refreshSkillAttrs()
end

function slot1._btnPreviewOnClick(slot0)
	slot0:refreshSkillDetailPanel(true)
end

function slot1._btnPreviewCloseOnClick(slot0)
	slot0:refreshSkillDetailPanel(false)
end

function slot1._btnSkillPointOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6DungeonSkill, false, nil, false)
end

function slot1._btnSkillPointTipsOnClick(slot0)
	slot0:refreshSkillPointTips(true)
end

function slot1._btnSkillPointTipsCloseOnClick(slot0)
	slot0:refreshSkillPointTips(false)
end

function slot1._btnResetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6ResetSkill, MsgBoxEnum.BoxType.Yes_No, slot0.btnResetFunc, nil, , slot0)
end

function slot1.btnResetFunc(slot0)
	VersionActivity1_6DungeonRpc.instance:sendAct148ResetRequest()
end

return slot1
