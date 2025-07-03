module("modules.logic.versionactivity2_7.act191.view.item.Act191CharacterSkillDesc", package.seeall)

local var_0_0 = class("Act191CharacterSkillDesc", BaseChildView)

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

function var_0_0.updateInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.config = arg_6_2

	local var_6_0 = arg_6_0.config.exLevel

	arg_6_0.parentView = arg_6_1

	local var_6_1 = Activity191Config.instance:getHeroLevelExSkillCo(arg_6_0.config.id, arg_6_3)

	arg_6_0._txtlv.text = arg_6_3
	arg_6_0._needUseSkillEffDescList = {}
	arg_6_0._needUseSkillEffDescList2 = {}

	local var_6_2, var_6_3, var_6_4 = Activity191Config.instance:getExSkillDesc(var_6_1, arg_6_0.config.id)

	arg_6_0._skillIndex = var_6_4

	local var_6_5 = string.gsub(var_6_2, "▩(%d)%%s", "CharacterSkillDescripte_skillNameDesc")
	local var_6_6 = SkillHelper.addLink(var_6_5)
	local var_6_7 = arg_6_0:addNumColor(var_6_6)
	local var_6_8 = SkillHelper.addBracketColor(var_6_7, "#7e99d0")
	local var_6_9 = arg_6_0:_buildSkillNameLinkTag(var_6_3)
	local var_6_10 = string.gsub(var_6_8, "CharacterSkillDescripte_skillNameDesc", var_6_9)

	gohelper.setActive(arg_6_0._goCurlevel, false)

	arg_6_0.canvasGroup.alpha = var_6_0 < arg_6_3 and 0.5 or 1
	arg_6_0.txtlvcanvasGroup.alpha = var_6_0 < arg_6_3 and 0.5 or 1
	arg_6_0._hyperLinkClick = arg_6_0._txtskillDesc:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_6_0._hyperLinkClick:SetClickListener(arg_6_0._onHyperLinkClick, arg_6_0)

	local var_6_11 = GameUtil.getTextHeightByLine(arg_6_0._txtskillDesc, var_6_10, 28, -3) + 54

	recthelper.setHeight(arg_6_0.viewGO.transform, var_6_11)

	arg_6_0._txtskillDesc.text = var_6_10
	arg_6_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._txtskillDesc.gameObject, FixTmpBreakLine)

	arg_6_0._fixTmpBreakLine:refreshTmpContent(arg_6_0._txtskillDesc)

	return var_6_11
end

function var_0_0.addNumColor(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_0:filterRichText(arg_7_1)

	local var_7_0 = SkillHelper.getColorFormat("#deaa79", "%1")

	arg_7_1 = string.gsub(arg_7_1, "[+-]?[%d%./%%]+", var_7_0)
	arg_7_1 = arg_7_0:revertRichText(arg_7_1)

	return arg_7_1
end

function var_0_0.replaceColorFunc(arg_8_0)
	if string.find(arg_8_0, "[<>]") then
		return arg_8_0
	end
end

var_0_0.richTextList = {}
var_0_0.replaceText = "▩replace▩"
var_0_0.replaceIndex = 0

function var_0_0.filterRichText(arg_9_0, arg_9_1)
	tabletool.clear(var_0_0.richTextList)

	arg_9_1 = string.gsub(arg_9_1, "(<.->)", arg_9_0._filterRichText)

	return arg_9_1
end

function var_0_0._filterRichText(arg_10_0)
	table.insert(var_0_0.richTextList, arg_10_0)

	return var_0_0.replaceText
end

function var_0_0.revertRichText(arg_11_0, arg_11_1)
	var_0_0.replaceIndex = 0
	arg_11_1 = string.gsub(arg_11_1, var_0_0.replaceText, arg_11_0._revertRichText)

	tabletool.clear(var_0_0.richTextList)

	return arg_11_1
end

function var_0_0._revertRichText(arg_12_0)
	var_0_0.replaceIndex = var_0_0.replaceIndex + 1

	return var_0_0.richTextList[var_0_0.replaceIndex] or ""
end

function var_0_0._onHyperLinkClick(arg_13_0, arg_13_1, arg_13_2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_13_1 ~= "skillIndex" then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_13_1), CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif arg_13_0._skillIndex == 0 then
		if arg_13_0.config.type == Activity191Enum.CharacterType.Hero then
			local var_13_0 = {
				id = arg_13_0.config.id,
				tipPos = Vector2.New(-292, -51.1),
				anchorParams = {
					Vector2.New(1, 0.5),
					Vector2.New(1, 0.5)
				}
			}

			var_13_0.buffTipsX = -776

			ViewMgr.instance:openView(ViewName.Act191CharacterTipView, var_13_0)
		end
	else
		local var_13_1 = {}
		local var_13_2 = Activity191Config.instance:getHeroSkillIdDic(arg_13_0.config.id)

		var_13_1.super = arg_13_0._skillIndex == 3
		var_13_1.skillIdList = var_13_2[arg_13_0._skillIndex]
		var_13_1.monsterName = arg_13_0.config.name
		var_13_1.heroId = arg_13_0.config.roleId
		var_13_1.skillIndex = arg_13_0._skillIndex

		ViewMgr.instance:openView(ViewName.SkillTipView, var_13_1)
	end
end

function var_0_0._buildSkillNameLinkTag(arg_14_0, arg_14_1)
	local var_14_0 = "<link=\"skillIndex\"><color=#7e99d0>%s</color></link>"
	local var_14_1 = string.format(var_14_0, GameConfig:GetCurLangType() == LangSettings.en and "%s" or "【%s】")

	return (string.format(var_14_1, arg_14_1))
end

function var_0_0.playHeroExSkillUPAnimation(arg_15_0)
	gohelper.setActive(arg_15_0.govx, true)
	TaskDispatcher.runDelay(arg_15_0.onAnimationDone, arg_15_0, arg_15_0.aniLength)
end

function var_0_0.onAnimationDone(arg_16_0)
	gohelper.setActive(arg_16_0.govx, false)
end

function var_0_0.jumpAnimation(arg_17_0)
	local var_17_0 = 0.782608695652174

	TaskDispatcher.cancelTask(arg_17_0.onAnimationDone, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0.onAnimationDone, arg_17_0, arg_17_0.aniLength * (1 - var_17_0))
	ZProj.GameHelper.SetAnimationStateNormalizedTime(arg_17_0.vxAni, "item_vx_in", var_17_0)
end

function var_0_0.onOpen(arg_18_0)
	return
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0.onAnimationDone, arg_19_0)
	arg_19_0.vxAni:Stop()
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0
