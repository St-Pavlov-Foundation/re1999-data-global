module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleEffectItem", package.seeall)

local var_0_0 = class("V2a1_BossRush_OfferRoleEffectItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "image_Line")

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
	arg_4_0._txt = arg_4_0.viewGO:GetComponent(gohelper.Type_TextMesh)
end

local var_0_1 = "OfferRoleEffectItem_skillNameDesc"

function var_0_0.activeLine(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._goline, arg_5_1)
end

function var_0_0.updateInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.parentView = arg_6_1
	arg_6_0._needUseSkillEffDescList = {}
	arg_6_0._needUseSkillEffDescList2 = {}
	arg_6_0._heroId = arg_6_3

	local var_6_0, var_6_1, var_6_2 = arg_6_0:_parseDesc(arg_6_2)

	arg_6_0._skillIndex = var_6_2
	arg_6_2 = arg_6_0:addLink(arg_6_2)
	arg_6_2 = string.gsub(arg_6_2, "▩(%d)%%s", var_0_1)
	arg_6_2 = arg_6_0:addNumColor(arg_6_2)

	local var_6_3 = arg_6_0:_buildSkillNameLinkTag(var_6_1)

	arg_6_2 = string.gsub(arg_6_2, var_0_1, var_6_3)
	arg_6_0._hyperLinkClick = arg_6_0.viewGO:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_6_0._hyperLinkClick:SetClickListener(arg_6_0._onHyperLinkClick, arg_6_0)

	arg_6_0._txt.text = arg_6_2
	arg_6_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0.viewGO.gameObject, FixTmpBreakLine)

	arg_6_0._fixTmpBreakLine:refreshTmpContent(arg_6_0.viewGO)
end

function var_0_0._parseDesc(arg_7_0, arg_7_1)
	local var_7_0, var_7_1, var_7_2 = string.find(arg_7_1, "▩(%d)%%s")

	if not var_7_2 then
		return arg_7_1
	end

	local var_7_3 = tonumber(var_7_2)
	local var_7_4

	if var_7_3 == 0 then
		var_7_4 = SkillConfig.instance:getpassiveskillsCO(arg_7_0._heroId)[1].skillPassive
	else
		var_7_4 = SkillConfig.instance:getHeroBaseSkillIdDict(arg_7_0._heroId)[var_7_3]
	end

	if not var_7_4 then
		return arg_7_1
	end

	local var_7_5 = lua_skill.configDict[var_7_4].name

	return arg_7_1, var_7_5, var_7_3
end

local var_0_2 = "#7e99d0"

function var_0_0._buildSkillNameLinkTag(arg_8_0, arg_8_1)
	local var_8_0 = var_0_2

	return arg_8_1 and string.format(luaLang("V2a1_BossRush_OfferRoleEffectItem_skillname_link_overseas"), var_8_0, arg_8_1) or ""
end

function var_0_0.addLink(arg_9_0, arg_9_1)
	arg_9_1 = string.gsub(arg_9_1, "%[(.-)%]", arg_9_0.addLinkCb1)
	arg_9_1 = string.gsub(arg_9_1, "【(.-)】", arg_9_0.addLinkCb2)

	return arg_9_1
end

local function var_0_3(arg_10_0, arg_10_1)
	local var_10_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_10_1)

	arg_10_1 = SkillHelper.removeRichTag(arg_10_1)

	if not var_10_0 then
		return arg_10_1
	end

	local var_10_1 = var_0_2

	arg_10_1 = string.format(arg_10_0, arg_10_1)

	if not var_10_0.notAddLink or var_10_0.notAddLink == 0 then
		return string.format("<color=%s><u><link=%s>%s</link></u></color>", var_10_1, var_10_0.id, arg_10_1)
	end

	return string.format("<color=%s>%s</color>", var_10_1, arg_10_1)
end

function var_0_0.addLinkCb1(arg_11_0)
	local var_11_0 = "[%s]"

	return var_0_3(var_11_0, arg_11_0)
end

function var_0_0.addLinkCb2(arg_12_0)
	local var_12_0 = "【%s】"

	return var_0_3(var_12_0, arg_12_0)
end

function var_0_0.addNumColor(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_0:filterRichText(arg_13_1)

	local var_13_0 = SkillHelper.getColorFormat("#deaa79", "%1")

	arg_13_1 = string.gsub(arg_13_1, "[+-]?[%d%./%%]+", var_13_0)
	arg_13_1 = arg_13_0:revertRichText(arg_13_1)

	return arg_13_1
end

function var_0_0.replaceColorFunc(arg_14_0)
	if string.find(arg_14_0, "[<>]") then
		return arg_14_0
	end
end

var_0_0.richTextList = {}
var_0_0.replaceText = "▩replace▩"
var_0_0.replaceIndex = 0

function var_0_0.filterRichText(arg_15_0, arg_15_1)
	tabletool.clear(var_0_0.richTextList)

	arg_15_1 = string.gsub(arg_15_1, "(<.->)", arg_15_0._filterRichText)

	return arg_15_1
end

function var_0_0._filterRichText(arg_16_0)
	table.insert(var_0_0.richTextList, arg_16_0)

	return var_0_0.replaceText
end

function var_0_0.revertRichText(arg_17_0, arg_17_1)
	var_0_0.replaceIndex = 0
	arg_17_1 = string.gsub(arg_17_1, var_0_0.replaceText, arg_17_0._revertRichText)

	tabletool.clear(var_0_0.richTextList)

	return arg_17_1
end

function var_0_0._revertRichText(arg_18_0)
	var_0_0.replaceIndex = var_0_0.replaceIndex + 1

	return var_0_0.richTextList[var_0_0.replaceIndex] or ""
end

function var_0_0._onHyperLinkClick(arg_19_0, arg_19_1, arg_19_2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_19_1 ~= "skillIndex" then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_19_1), CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif arg_19_0._skillIndex == 0 then
		local var_19_0 = {}

		var_19_0.tag = "passiveskill"
		var_19_0.heroid = arg_19_0._heroId
		var_19_0.tipPos = Vector2.New(-292, -51.1)
		var_19_0.anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		}
		var_19_0.buffTipsX = -776

		local var_19_1 = HeroMo.New()
		local var_19_2 = HeroConfig.instance:getHeroCO(arg_19_0._heroId)

		var_19_1:init(var_19_0, var_19_2)

		var_19_1.passiveSkillLevel = {}

		for iter_19_0 = 1, 3 do
			table.insert(var_19_1.passiveSkillLevel, iter_19_0)
		end

		var_19_0.heroMo = var_19_1

		CharacterController.instance:openCharacterTipView(var_19_0)
	else
		local var_19_3 = {}
		local var_19_4 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(arg_19_0._heroId)

		var_19_3.super = arg_19_0._skillIndex == 3
		var_19_3.skillIdList = var_19_4[arg_19_0._skillIndex]
		var_19_3.monsterName = HeroConfig.instance:getHeroCO(arg_19_0._heroId).name
		var_19_3.anchorX = -500

		ViewMgr.instance:openView(ViewName.SkillTipView, var_19_3)
	end
end

function var_0_0.onOpen(arg_20_0)
	return
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
