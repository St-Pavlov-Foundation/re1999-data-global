module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillView", package.seeall)

local var_0_0 = "#E4C599"
local var_0_1 = class("VersionActivity1_6SkillView", BaseView)
local var_0_2 = 4

function var_0_1.onInitView(arg_1_0)
	arg_1_0._goItem1 = gohelper.findChild(arg_1_0.viewGO, "#go_Item1")
	arg_1_0._goItem2 = gohelper.findChild(arg_1_0.viewGO, "#go_Item2")
	arg_1_0._goItem3 = gohelper.findChild(arg_1_0.viewGO, "#go_Item3")
	arg_1_0._goItem4 = gohelper.findChild(arg_1_0.viewGO, "#go_Item4")
	arg_1_0._goDetailPanel = gohelper.findChild(arg_1_0.viewGO, "SkillPanel")
	arg_1_0._detailAnimator = arg_1_0._goDetailPanel:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goSkillEffectDesc = gohelper.findChild(arg_1_0.viewGO, "SkillPanel/Skill/Scroll View/Viewport/Content/#go_SkillDescr")
	arg_1_0._goSkillAttrDesc = gohelper.findChild(arg_1_0.viewGO, "SkillPanel/Value/Layout/#go_Attri")
	arg_1_0._goSkillEffectEmpty = gohelper.findChild(arg_1_0.viewGO, "SkillPanel/Skill/#go_Empty")
	arg_1_0._goSkillAttrEmpty = gohelper.findChild(arg_1_0.viewGO, "SkillPanel/Value/#go_Empty")
	arg_1_0._goBuffItemTemplate = gohelper.findChild(arg_1_0.viewGO, "v1a6_talent_lvupitem")
	arg_1_0._btnReset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Reset")
	arg_1_0._btnPreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Wish")
	arg_1_0._btnClosePreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "SkillPanel/#btn_close")
	arg_1_0._btnSkillPointArea = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "SkillPoint/#btn_Info/Click")
	arg_1_0._btnSkillPointTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "SkillPoint/#btn_Info")
	arg_1_0._btnTipsClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "SkillPoint/#btn_Info/image_TipsBG/#btn_Tips_Close")
	arg_1_0._goSkilPointTips = gohelper.findChild(arg_1_0.viewGO, "SkillPoint/#btn_Info/image_TipsBG")
	arg_1_0._txtSkillPointNum = gohelper.findChildText(arg_1_0.viewGO, "SkillPoint/#btn_Info/image_TipsBG/txt_Tips_Num")
	arg_1_0._txtRemainSkillPointNum = gohelper.findChildText(arg_1_0.viewGO, "SkillPoint/txt_Skill_Num")
	arg_1_0._imageSkillPoint = gohelper.findChildImage(arg_1_0.viewGO, "SkillPoint/#simage_Prop")
	arg_1_0._goSkillPointEffect = gohelper.findChild(arg_1_0.viewGO, "SkillPoint/eff")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	arg_2_0._btnPreview:AddClickListener(arg_2_0._btnPreviewOnClick, arg_2_0)
	arg_2_0._btnReset:AddClickListener(arg_2_0._btnResetOnClick, arg_2_0)
	arg_2_0._btnClosePreview:AddClickListener(arg_2_0._btnPreviewCloseOnClick, arg_2_0)
	arg_2_0._btnSkillPointArea:AddClickListener(arg_2_0._btnSkillPointOnClick, arg_2_0)
	arg_2_0._btnSkillPointTips:AddClickListener(arg_2_0._btnSkillPointTipsOnClick, arg_2_0)
	arg_2_0._btnTipsClose:AddClickListener(arg_2_0._btnSkillPointTipsCloseOnClick, arg_2_0)
end

function var_0_1.removeEvents(arg_3_0)
	arg_3_0._btnPreview:RemoveClickListener()
	arg_3_0._btnReset:RemoveClickListener()
	arg_3_0._btnClosePreview:RemoveClickListener()
	arg_3_0._btnSkillPointTips:RemoveClickListener()
	arg_3_0._btnSkillPointArea:RemoveClickListener()
	arg_3_0._btnTipsClose:RemoveClickListener()
end

function var_0_1._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._goBuffItemTemplate, false)
	gohelper.setActive(arg_4_0._goDetailPanel, false)
	gohelper.setActive(arg_4_0._goSkilPointTips, false)
	gohelper.setActive(arg_4_0._goSkillEffectDesc, false)
	gohelper.setActive(arg_4_0._goSkillAttrDesc, false)

	arg_4_0._buffItemList = {}
end

function var_0_1.onUpdateParam(arg_5_0)
	return
end

function var_0_1.onOpen(arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillReset, arg_6_0._onSkillReset, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillLvDown, arg_6_0._onLvChange, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_6DungeonController.instance, Act148Event.SkillLvUp, arg_6_0._onLvChange, arg_6_0)
	arg_6_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_6_0._onCurrencyChange, arg_6_0)
	arg_6_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_6_0.closeThis, arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterSkillView)
end

function var_0_1.onOpenFinish(arg_7_0)
	arg_7_0:_initSkillItem()
	arg_7_0:_refreshSkillPoint()
	arg_7_0:_refreshSkillEffects()
	arg_7_0:_refreshSkillAttrs()
end

function var_0_1._initSkillItem(arg_8_0)
	for iter_8_0 = 1, var_0_2 do
		local var_8_0 = VersionActivity1_6SkillItem.New()
		local var_8_1 = gohelper.cloneInPlace(arg_8_0._goBuffItemTemplate)

		gohelper.setActive(var_8_1, true)
		var_8_1.transform:SetParent(arg_8_0["_goItem" .. iter_8_0].transform)
		transformhelper.setLocalPos(var_8_1.transform, 0, 0, 0)
		var_8_0:init(var_8_1, iter_8_0)

		arg_8_0._buffItemList[iter_8_0] = var_8_0
	end
end

function var_0_1._refreshSkillItems(arg_9_0)
	for iter_9_0 = 1, var_0_2 do
		arg_9_0._buffItemList[iter_9_0]:refreshItemUI()
	end
end

function var_0_1._refreshSkillPoint(arg_10_0)
	local var_10_0 = Activity148Config.instance:getAct148ConstValue(VersionActivity1_6Enum.ActivityId.DungeonSkillTree, VersionActivity1_6DungeonEnum.DungeonConstId.MaxSkillPointNum)
	local var_10_1 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local var_10_2 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)

	if var_10_2 then
		local var_10_3 = string.format("%s_1", var_10_2 and var_10_2.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_10_0._imageSkillPoint, var_10_3)
	end

	local var_10_4 = var_10_1 and var_10_1.quantity or 0

	if LangSettings.instance:isEn() then
		arg_10_0._txtRemainSkillPointNum.text = " " .. var_10_4
	else
		arg_10_0._txtRemainSkillPointNum.text = var_10_4
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._txtRemainSkillPointNum, var_0_0)

	local var_10_5 = VersionActivity1_6DungeonSkillModel.instance:getTotalGotSkillPointNum()
	local var_10_6 = string.format("<color=#EB5F34>%s</color>/%s", var_10_5 or 0, var_10_0)

	if LangSettings.instance:isEn() then
		arg_10_0._txtSkillPointNum.text = " " .. var_10_6
	else
		arg_10_0._txtSkillPointNum.text = var_10_6
	end
end

function var_0_1.refreshSkillDetailPanel(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goDetailPanel, true)
	gohelper.setActive(arg_11_0._btnClosePreview.gameObject, arg_11_1)
	arg_11_0._detailAnimator:Play(arg_11_1 and UIAnimationName.Open or UIAnimationName.Close, 0, 0)
end

function var_0_1._refreshSkillEffects(arg_12_0)
	local var_12_0 = {}

	for iter_12_0 = 1, var_0_2 do
		local var_12_1 = iter_12_0
		local var_12_2 = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(var_12_1)
		local var_12_3 = var_12_2 and var_12_2:getLevel() or 0

		for iter_12_1 = 1, var_12_3 do
			if VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[iter_12_1] then
				local var_12_4 = Activity148Config.instance:getAct148CfgByTypeLv(var_12_1, iter_12_1)

				var_12_0[#var_12_0 + 1] = var_12_4
			end
		end
	end

	arg_12_0._skillEffectItemList = {}

	for iter_12_2 = 1, #var_12_0 do
		local var_12_5 = var_12_0[iter_12_2]
		local var_12_6 = Activity148Config.instance:getAct148SkillTypeCfg(var_12_5.type)
		local var_12_7 = gohelper.cloneInPlace(arg_12_0._goSkillEffectDesc)

		gohelper.setActive(var_12_7, true)

		arg_12_0._skillEffectItemList[iter_12_2] = arg_12_0:getUserDataTb_()
		arg_12_0._skillEffectItemList[iter_12_2].go = var_12_7

		local var_12_8 = var_12_7:GetComponent(gohelper.Type_TextMesh)
		local var_12_9 = FightConfig.instance:getSkillEffectCO(var_12_5.skillId)
		local var_12_10 = var_12_9 and FightConfig.instance:getSkillEffectDesc(nil, var_12_9)
		local var_12_11 = GameUtil.getSubPlaceholderLuaLang(luaLang("versionactivity1_6skillview_skilleff_overseas"), {
			var_12_6.skillName,
			var_12_5.level
		})

		var_12_8.text = gohelper.getRichColorText(var_12_11, "#E99B56") .. var_12_10
	end

	gohelper.setActive(arg_12_0._goSkillEffectEmpty, #var_12_0 == 0)
end

function var_0_1._refreshSkillAttrs(arg_13_0)
	local var_13_0 = {}

	for iter_13_0 = 1, var_0_2 do
		local var_13_1 = iter_13_0
		local var_13_2 = VersionActivity1_6DungeonSkillModel.instance:getAct148SkillMo(var_13_1)
		local var_13_3 = var_13_2 and var_13_2:getLevel() or 0

		for iter_13_1 = 1, var_13_3 do
			if not VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[iter_13_1] then
				local var_13_4 = Activity148Config.instance:getAct148CfgByTypeLv(var_13_1, iter_13_1).attrs
				local var_13_5 = string.splitToNumber(var_13_4, "#")
				local var_13_6 = var_13_5[1]
				local var_13_7 = var_13_5[2]

				if not var_13_0[var_13_6] then
					var_13_0[var_13_6] = 0
				end

				var_13_0[var_13_6] = var_13_0[var_13_6] + var_13_7
			end
		end
	end

	arg_13_0._skillAttrItemList = {}

	local var_13_8 = 0

	for iter_13_2, iter_13_3 in pairs(var_13_0) do
		local var_13_9 = HeroConfig.instance:getHeroAttributeCO(iter_13_2)
		local var_13_10 = gohelper.cloneInPlace(arg_13_0._goSkillAttrDesc)

		gohelper.setActive(var_13_10, true)

		arg_13_0._skillAttrItemList[iter_13_2] = arg_13_0:getUserDataTb_()
		arg_13_0._skillAttrItemList[iter_13_2].go = var_13_10
		var_13_10:GetComponent(gohelper.Type_TextMesh).text = var_13_9.name
		iter_13_3 = tonumber(string.format("%.3f", iter_13_3 / 10)) .. "%"
		gohelper.findChildText(var_13_10, "#go_AttriNum").text = "+" .. iter_13_3

		local var_13_11 = gohelper.findChildImage(var_13_10, "#image_Icon")

		UISpriteSetMgr.instance:setCommonSprite(var_13_11, "icon_att_" .. var_13_9.id, true)

		var_13_8 = var_13_8 + 1
	end

	gohelper.setActive(arg_13_0._goSkillAttrEmpty, var_13_8 == 0)
end

function var_0_1._clearSkillDetailItems(arg_14_0)
	if arg_14_0._skillEffectItemList then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._skillEffectItemList) do
			gohelper.destroy(iter_14_1.go)

			iter_14_1.go = nil
		end
	end

	arg_14_0._skillEffectItemList = nil

	if arg_14_0._skillAttrItemList then
		for iter_14_2, iter_14_3 in pairs(arg_14_0._skillAttrItemList) do
			gohelper.destroy(iter_14_3.go)

			iter_14_3.go = nil
		end
	end

	arg_14_0._skillAttrItemList = nil
end

function var_0_1.refreshSkillPointTips(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._goSkilPointTips, arg_15_1)
end

function var_0_1.onClose(arg_16_0)
	return
end

function var_0_1.onDestroyView(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0._buffItemList) do
		iter_17_1:onDestroyItem()
	end

	arg_17_0._buffItemList = nil
end

function var_0_1._onCurrencyChange(arg_18_0)
	arg_18_0:_refreshSkillPoint()
end

function var_0_1._onSkillReset(arg_19_0)
	for iter_19_0 = 1, var_0_2 do
		arg_19_0._buffItemList[iter_19_0]:refreshResetEffect()
	end

	gohelper.setActive(arg_19_0._goSkillPointEffect, false)
	gohelper.setActive(arg_19_0._goSkillPointEffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonSkillViewReset)
	arg_19_0:_onLvChange()
end

function var_0_1._onLvChange(arg_20_0)
	arg_20_0:_refreshSkillItems()
	arg_20_0:_refreshSkillPoint()
	arg_20_0:_clearSkillDetailItems()
	arg_20_0:_refreshSkillEffects()
	arg_20_0:_refreshSkillAttrs()
end

function var_0_1._btnPreviewOnClick(arg_21_0)
	arg_21_0:refreshSkillDetailPanel(true)
end

function var_0_1._btnPreviewCloseOnClick(arg_22_0)
	arg_22_0:refreshSkillDetailPanel(false)
end

function var_0_1._btnSkillPointOnClick(arg_23_0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6DungeonSkill, false, nil, false)
end

function var_0_1._btnSkillPointTipsOnClick(arg_24_0)
	arg_24_0:refreshSkillPointTips(true)
end

function var_0_1._btnSkillPointTipsCloseOnClick(arg_25_0)
	arg_25_0:refreshSkillPointTips(false)
end

function var_0_1._btnResetOnClick(arg_26_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6ResetSkill, MsgBoxEnum.BoxType.Yes_No, arg_26_0.btnResetFunc, nil, nil, arg_26_0)
end

function var_0_1.btnResetFunc(arg_27_0)
	VersionActivity1_6DungeonRpc.instance:sendAct148ResetRequest()
end

return var_0_1
