module("modules.logic.character.view.CharacterSkillDescripte", package.seeall)

local var_0_0 = class("CharacterSkillDescripte", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtlv = gohelper.findChildText(arg_1_0.viewGO, "#txt_skillevel")
	arg_1_0._goCurlevel = gohelper.findChild(arg_1_0.viewGO, "#go_curlevel")
	arg_1_0._txtskillDesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_descripte")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.canvasGroup = gohelper.onceAddComponent(arg_4_0._txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	arg_4_0.txtlvcanvasGroup = gohelper.onceAddComponent(arg_4_0._txtlv.gameObject, gohelper.Type_CanvasGroup)
	arg_4_0.govx = gohelper.findChild(arg_4_0.viewGO, "vx")

	gohelper.setActive(arg_4_0.govx, false)

	arg_4_0.vxAni = arg_4_0.govx:GetComponent(typeof(UnityEngine.Animation))
	arg_4_0.aniLength = arg_4_0.vxAni.clip.length
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

var_0_0.skillNameDesc = "CharacterSkillDescripte_skillNameDesc"

function var_0_0.updateInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	arg_6_0.parentView = arg_6_1

	local var_6_0 = SkillConfig.instance:getherolevelexskillCO(arg_6_2, arg_6_3)

	arg_6_0._txtlv.text = arg_6_3
	arg_6_0._needUseSkillEffDescList = {}
	arg_6_0._needUseSkillEffDescList2 = {}

	local var_6_1, var_6_2, var_6_3, var_6_4 = SkillConfig.instance:getExSkillDesc(var_6_0)

	arg_6_0._skillIndex = var_6_3
	arg_6_0._choiceSkillMatchInfos = var_6_4
	arg_6_0._heroId = arg_6_2

	if arg_6_0:_isChoiceSkill() then
		var_6_1 = string.gsub(var_6_1, "▩%d%%s<%d>", var_0_0.skillNameDesc)
	else
		var_6_1 = string.gsub(var_6_1, "▩(%d)%%s", var_0_0.skillNameDesc)
	end

	local var_6_5 = SkillHelper.addLink(var_6_1)
	local var_6_6 = arg_6_0:addNumColor(var_6_5)
	local var_6_7 = SkillHelper.addBracketColor(var_6_6, "#7e99d0")

	if arg_6_0:_isChoiceSkill() then
		for iter_6_0 = 1, #var_6_4 do
			local var_6_8 = var_6_4[iter_6_0]
			local var_6_9 = arg_6_0:_buildChioceSkillNameLinkTag(var_6_8.skillName, var_6_8.choiceSkillIndex)

			var_6_7 = string.gsub(var_6_7, var_0_0.skillNameDesc, var_6_9, 1)
		end
	else
		local var_6_10 = arg_6_0:_buildSkillNameLinkTag(var_6_2)

		var_6_7 = string.gsub(var_6_7, var_0_0.skillNameDesc, var_6_10)
	end

	gohelper.setActive(arg_6_0._goCurlevel, not arg_6_5 and arg_6_4 + 1 == arg_6_3)

	arg_6_0.canvasGroup.alpha = arg_6_4 < arg_6_3 and 0.5 or 1
	arg_6_0.txtlvcanvasGroup.alpha = arg_6_4 < arg_6_3 and 0.5 or 1
	arg_6_0._hyperLinkClick = arg_6_0._txtskillDesc:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_6_0._hyperLinkClick:SetClickListener(arg_6_0._onHyperLinkClick, arg_6_0)

	local var_6_11 = GameUtil.getTextHeightByLine(arg_6_0._txtskillDesc, var_6_7, 28, -3) + 54

	recthelper.setHeight(arg_6_0.viewGO.transform, var_6_11)

	arg_6_0._txtskillDesc.text = var_6_7
	arg_6_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._txtskillDesc.gameObject, FixTmpBreakLine)

	arg_6_0._fixTmpBreakLine:refreshTmpContent(arg_6_0._txtskillDesc)

	return var_6_11
end

function var_0_0._isChoiceSkill(arg_7_0)
	return arg_7_0._choiceSkillMatchInfos and #arg_7_0._choiceSkillMatchInfos > 0
end

function var_0_0.addNumColor(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_0:filterRichText(arg_8_1)

	local var_8_0 = SkillHelper.getColorFormat("#deaa79", "%1")

	arg_8_1 = string.gsub(arg_8_1, "[+-]?[%d%./%%]+", var_8_0)
	arg_8_1 = arg_8_0:revertRichText(arg_8_1)

	return arg_8_1
end

function var_0_0.replaceColorFunc(arg_9_0)
	if string.find(arg_9_0, "[<>]") then
		return arg_9_0
	end
end

var_0_0.richTextList = {}
var_0_0.replaceText = "▩replace▩"
var_0_0.replaceIndex = 0

function var_0_0.filterRichText(arg_10_0, arg_10_1)
	tabletool.clear(var_0_0.richTextList)

	arg_10_1 = string.gsub(arg_10_1, "(<.->)", arg_10_0._filterRichText)

	return arg_10_1
end

function var_0_0._filterRichText(arg_11_0)
	table.insert(var_0_0.richTextList, arg_11_0)

	return var_0_0.replaceText
end

function var_0_0.revertRichText(arg_12_0, arg_12_1)
	var_0_0.replaceIndex = 0
	arg_12_1 = string.gsub(arg_12_1, var_0_0.replaceText, arg_12_0._revertRichText)

	tabletool.clear(var_0_0.richTextList)

	return arg_12_1
end

function var_0_0._revertRichText(arg_13_0)
	var_0_0.replaceIndex = var_0_0.replaceIndex + 1

	return var_0_0.richTextList[var_0_0.replaceIndex] or ""
end

function var_0_0._onHyperLinkClick(arg_14_0, arg_14_1, arg_14_2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_14_0, var_14_1, var_14_2 = string.find(arg_14_1, "skillIndex_(%d)")

	if arg_14_1 ~= "skillIndex" and not var_14_2 then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_14_1), CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif arg_14_0._skillIndex == 0 then
		local var_14_3 = {}

		var_14_3.tag = "passiveskill"
		var_14_3.heroid = arg_14_0._heroId
		var_14_3.heroMo = arg_14_0.parentView.viewParam.heroMo
		var_14_3.tipPos = Vector2.New(-292, -51.1)
		var_14_3.anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		}
		var_14_3.buffTipsX = -776
		var_14_3.showAttributeOption = arg_14_0.parentView:getShowAttributeOption()
		var_14_3.heroMo = arg_14_0.parentView.viewParam.heroMo

		CharacterController.instance:openCharacterTipView(var_14_3)
	else
		local var_14_4 = {}
		local var_14_5 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(arg_14_0._heroId, arg_14_0.parentView:getShowAttributeOption(), arg_14_0.parentView.viewParam.heroMo, nil, true)

		var_14_4.super = arg_14_0._skillIndex == 3

		local var_14_6 = var_14_5[arg_14_0._skillIndex]

		if arg_14_0:_isChoiceSkill() then
			if var_14_2 then
				local var_14_7 = tonumber(var_14_2)
				local var_14_8 = {}

				for iter_14_0, iter_14_1 in ipairs(var_14_6) do
					local var_14_9 = SkillConfig.instance:getFightCardChoiceSkillIdByIndex(iter_14_1, var_14_7)

					if var_14_9 then
						table.insert(var_14_8, var_14_9)
					end
				end

				var_14_4.skillIdList = var_14_8
			else
				var_14_4.skillIdList = var_14_6
			end
		else
			var_14_4.skillIdList = var_14_6
		end

		var_14_4.monsterName = HeroConfig.instance:getHeroCO(arg_14_0._heroId).name
		var_14_4.heroMo = arg_14_0.parentView.viewParam.heroMo

		ViewMgr.instance:openView(ViewName.SkillTipView, var_14_4)
	end
end

function var_0_0._buildSkillNameLinkTag(arg_15_0, arg_15_1)
	local var_15_0 = "<link=\"skillIndex\"><color=#7e99d0>%s</color></link>"
	local var_15_1 = string.format(var_15_0, GameConfig:GetCurLangType() == LangSettings.en and "%s" or "【%s】")

	return (string.format(var_15_1, arg_15_1))
end

function var_0_0._buildChioceSkillNameLinkTag(arg_16_0, arg_16_1, arg_16_2)
	return (string.format("<link=\"skillIndex_%s\"><color=#7e99d0>【%s】</color></link>", arg_16_2, arg_16_1))
end

function var_0_0.playHeroExSkillUPAnimation(arg_17_0)
	gohelper.setActive(arg_17_0.govx, true)
	TaskDispatcher.runDelay(arg_17_0.onAnimationDone, arg_17_0, arg_17_0.aniLength)
end

function var_0_0.onAnimationDone(arg_18_0)
	gohelper.setActive(arg_18_0.govx, false)
end

function var_0_0.jumpAnimation(arg_19_0)
	local var_19_0 = 0.782608695652174

	TaskDispatcher.cancelTask(arg_19_0.onAnimationDone, arg_19_0)
	TaskDispatcher.runDelay(arg_19_0.onAnimationDone, arg_19_0, arg_19_0.aniLength * (1 - var_19_0))
	ZProj.GameHelper.SetAnimationStateNormalizedTime(arg_19_0.vxAni, "item_vx_in", var_19_0)
end

function var_0_0.onOpen(arg_20_0)
	return
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.onAnimationDone, arg_21_0)
	arg_21_0.vxAni:Stop()
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
