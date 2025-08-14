module("modules.logic.character.view.destiny.SkillDescComp", package.seeall)

local var_0_0 = class("SkillDescComp", LuaCompBase)
local var_0_1 = "SkillDescComp"
local var_0_2 = "#7e99d0"
local var_0_3 = {}
local var_0_4 = "▩rich_replace▩"
local var_0_5 = 0
local var_0_6 = {}
local var_0_7 = "▩bracket_replace▩"
local var_0_8 = 0

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
end

function var_0_0.updateInfo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if LangSettings.instance:isEn() then
		arg_2_2 = SkillConfig.replaceHeroName(arg_2_2, arg_2_3)
	end

	arg_2_0._txtComp = arg_2_1
	arg_2_0._heroId = arg_2_3

	if arg_2_0._skillNameList ~= nil then
		tabletool.clear(arg_2_0._skillNameList)
	end

	arg_2_2 = arg_2_0:_replaceSkillTag(arg_2_2, "▩(%d)%%s")
	arg_2_2 = arg_2_0:addLink(arg_2_2)
	arg_2_2 = arg_2_0:filterBracketText(arg_2_2)
	arg_2_2 = arg_2_0:addNumColor(arg_2_2)
	arg_2_2 = arg_2_0:revertBracketText(arg_2_2)
	arg_2_2 = arg_2_0:_revertSkillName(arg_2_2, 1)
	arg_2_0._hyperLinkClick = gohelper.onceAddComponent(arg_2_0.viewGO, typeof(ZProj.TMPHyperLinkClick))

	arg_2_0._hyperLinkClick:SetClickListener(arg_2_0._onHyperLinkClick, arg_2_0)

	arg_2_0._txtComp.text = arg_2_2
	arg_2_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.viewGO.gameObject, FixTmpBreakLine)

	arg_2_0._fixTmpBreakLine:refreshTmpContent(arg_2_0.viewGO)

	arg_2_0.heroMo = HeroModel.instance:getByHeroId(arg_2_3)

	if not arg_2_0.heroMo then
		arg_2_0.heroMo = HeroMo.New()

		local var_2_0 = HeroConfig.instance:getHeroCO(arg_2_0._heroId)

		arg_2_0.heroMo:init({}, var_2_0)

		arg_2_0.heroMo.passiveSkillLevel = {}

		for iter_2_0 = 1, 3 do
			table.insert(arg_2_0.heroMo.passiveSkillLevel, iter_2_0)
		end
	end
end

function var_0_0.setTipParam(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._skillTipAnchorX = arg_3_1
	arg_3_0._buffTipAnchor = arg_3_2
end

function var_0_0.setBuffTipPivot(arg_4_0, arg_4_1)
	arg_4_0._buffTipPivot = arg_4_1
end

function var_0_0._replaceSkillTag(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0, var_5_1, var_5_2 = string.find(arg_5_1, arg_5_2)

	if not var_5_0 then
		return arg_5_1
	end

	local var_5_3 = tonumber(var_5_2)
	local var_5_4

	if var_5_3 == 0 then
		var_5_4 = SkillConfig.instance:getpassiveskillsCO(arg_5_0._heroId)[1].skillPassive
	else
		var_5_4 = SkillConfig.instance:getHeroBaseSkillIdDict(arg_5_0._heroId)[var_5_3]
	end

	if not var_5_4 then
		logError("没找到当前角色的技能：heroId:" .. arg_5_0._heroId .. "  skillindex:" .. var_5_3)

		return arg_5_1
	end

	local var_5_5 = lua_skill.configDict[var_5_4].name
	local var_5_6 = var_5_5 and string.format(luaLang("SkillDescComp_replaceSkillTag_overseas"), var_0_2, var_5_3, var_5_5) or ""

	if not arg_5_0._skillNameList then
		arg_5_0._skillNameList = {}
	end

	table.insert(arg_5_0._skillNameList, var_5_6)

	arg_5_1 = string.gsub(arg_5_1, arg_5_2, var_0_1, 1)

	return arg_5_0:_replaceSkillTag(arg_5_1, arg_5_2)
end

function var_0_0._revertSkillName(arg_6_0, arg_6_1, arg_6_2)
	if not string.find(arg_6_1, var_0_1) then
		return arg_6_1
	end

	local var_6_0 = arg_6_0._skillNameList[arg_6_2]

	if not var_6_0 then
		return arg_6_1
	end

	arg_6_1 = string.gsub(arg_6_1, var_0_1, var_6_0, 1)

	return arg_6_0:_revertSkillName(arg_6_1, arg_6_2 + 1)
end

function var_0_0.addLink(arg_7_0, arg_7_1)
	arg_7_1 = string.gsub(arg_7_1, "%[(.-)%]", arg_7_0.addLinkCb1)
	arg_7_1 = string.gsub(arg_7_1, "【(.-)】", arg_7_0.addLinkCb2)

	return arg_7_1
end

local function var_0_9(arg_8_0, arg_8_1)
	local var_8_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_8_1)

	arg_8_1 = SkillHelper.removeRichTag(arg_8_1)

	if not var_8_0 then
		return arg_8_1
	end

	local var_8_1 = var_0_2

	if not var_8_0.notAddLink or var_8_0.notAddLink == 0 then
		arg_8_1 = string.format("<u><link=%s>%s</link></u>", var_8_0.id, arg_8_1)
	end

	arg_8_1 = string.format(arg_8_0, arg_8_1)

	return string.format("<color=%s>%s</color>", var_8_1, arg_8_1)
end

function var_0_0.addLinkCb1(arg_9_0)
	local var_9_0 = "[%s]"

	return var_0_9(var_9_0, arg_9_0)
end

function var_0_0.addLinkCb2(arg_10_0)
	local var_10_0 = "【%s】"

	return var_0_9(var_10_0, arg_10_0)
end

function var_0_0.addNumColor(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_0:filterRichText(arg_11_1)

	local var_11_0 = SkillHelper.getColorFormat("#deaa79", "%1")

	arg_11_1 = string.gsub(arg_11_1, "[+-]?[%d%./%%]+", var_11_0)
	arg_11_1 = arg_11_0:revertRichText(arg_11_1)

	return arg_11_1
end

function var_0_0.replaceColorFunc(arg_12_0)
	if string.find(arg_12_0, "[<>]") then
		return arg_12_0
	end
end

function var_0_0.filterRichText(arg_13_0, arg_13_1)
	tabletool.clear(var_0_3)

	arg_13_1 = string.gsub(arg_13_1, "(<.->)", arg_13_0._filterRichText)

	return arg_13_1
end

function var_0_0._filterRichText(arg_14_0)
	table.insert(var_0_3, arg_14_0)

	return var_0_4
end

function var_0_0.revertRichText(arg_15_0, arg_15_1)
	var_0_5 = 0
	arg_15_1 = string.gsub(arg_15_1, var_0_4, arg_15_0._revertRichText)

	tabletool.clear(var_0_3)

	return arg_15_1
end

function var_0_0._revertRichText(arg_16_0)
	var_0_5 = var_0_5 + 1

	return var_0_3[var_0_5] or ""
end

function var_0_0.filterBracketText(arg_17_0, arg_17_1)
	tabletool.clear(var_0_6)

	arg_17_1 = string.gsub(arg_17_1, "【.-】", arg_17_0._filterBracketText)
	arg_17_1 = string.gsub(arg_17_1, "%[.-%]", arg_17_0._filterBracketText)

	return arg_17_1
end

function var_0_0._filterBracketText(arg_18_0)
	table.insert(var_0_6, arg_18_0)

	return var_0_7
end

function var_0_0.revertBracketText(arg_19_0, arg_19_1)
	var_0_8 = 0
	arg_19_1 = string.gsub(arg_19_1, var_0_7, arg_19_0._reverBracketText)

	tabletool.clear(var_0_6)

	return arg_19_1
end

function var_0_0._reverBracketText(arg_20_0)
	var_0_8 = var_0_8 + 1

	return var_0_6[var_0_8] or ""
end

function var_0_0._onHyperLinkClick(arg_21_0, arg_21_1, arg_21_2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_21_0 = string.match(arg_21_1, "skillIndex=(%d)")

	var_21_0 = var_21_0 and tonumber(var_21_0)

	if not var_21_0 then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_21_1), arg_21_0._buffTipAnchor or CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], arg_21_0._buffTipPivot or CommonBuffTipEnum.Pivot.Right)
	elseif var_21_0 == 0 then
		local var_21_1 = {}

		var_21_1.tag = "passiveskill"
		var_21_1.heroid = arg_21_0._heroId
		var_21_1.tipPos = Vector2.New(-292, -51.1)
		var_21_1.anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		}
		var_21_1.buffTipsX = -776
		var_21_1.heroMo = arg_21_0.heroMo

		CharacterController.instance:openCharacterTipView(var_21_1)
	else
		local var_21_2 = {}
		local var_21_3 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(arg_21_0._heroId)

		var_21_2.super = var_21_0 == 3
		var_21_2.skillIdList = var_21_3[var_21_0]
		var_21_2.monsterName = HeroConfig.instance:getHeroCO(arg_21_0._heroId).name
		var_21_2.anchorX = arg_21_0._skillTipAnchorX
		var_21_2.heroMo = arg_21_0.heroMo

		ViewMgr.instance:openView(ViewName.SkillTipView, var_21_2)
	end
end

return var_0_0
