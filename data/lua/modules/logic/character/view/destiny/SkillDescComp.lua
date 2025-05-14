module("modules.logic.character.view.destiny.SkillDescComp", package.seeall)

local var_0_0 = class("SkillDescComp", LuaCompBase)
local var_0_1 = "SkillDescComp"
local var_0_2 = "#7e99d0"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
end

function var_0_0.updateInfo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._txtComp = arg_2_1
	arg_2_0._heroId = arg_2_3

	if arg_2_0._skillNameList ~= nil then
		tabletool.clear(arg_2_0._skillNameList)
	end

	arg_2_2 = arg_2_0:_replaceSkillTag(arg_2_2, "▩(%d)%%s")
	arg_2_2 = arg_2_0:addLink(arg_2_2)
	arg_2_2 = arg_2_0:addNumColor(arg_2_2)
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

function var_0_0._replaceSkillTag(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1, var_4_2 = string.find(arg_4_1, arg_4_2)

	if not var_4_0 then
		return arg_4_1
	end

	local var_4_3 = tonumber(var_4_2)
	local var_4_4

	if var_4_3 == 0 then
		var_4_4 = SkillConfig.instance:getpassiveskillsCO(arg_4_0._heroId)[1].skillPassive
	else
		var_4_4 = SkillConfig.instance:getHeroBaseSkillIdDict(arg_4_0._heroId)[var_4_3]
	end

	if not var_4_4 then
		logError("没找到当前角色的技能：heroId:" .. arg_4_0._heroId .. "  skillindex:" .. var_4_3)

		return arg_4_1
	end

	local var_4_5 = lua_skill.configDict[var_4_4].name
	local var_4_6 = var_4_5 and string.format(luaLang("SkillDescComp_replaceSkillTag_overseas"), var_0_2, var_4_3, var_4_5) or ""

	if not arg_4_0._skillNameList then
		arg_4_0._skillNameList = {}
	end

	table.insert(arg_4_0._skillNameList, var_4_6)

	arg_4_1 = string.gsub(arg_4_1, arg_4_2, var_0_1, 1)

	return arg_4_0:_replaceSkillTag(arg_4_1, arg_4_2)
end

function var_0_0._revertSkillName(arg_5_0, arg_5_1, arg_5_2)
	if not string.find(arg_5_1, var_0_1) then
		return arg_5_1
	end

	local var_5_0 = arg_5_0._skillNameList[arg_5_2]

	if not var_5_0 then
		return arg_5_1
	end

	arg_5_1 = string.gsub(arg_5_1, var_0_1, var_5_0, 1)

	return arg_5_0:_revertSkillName(arg_5_1, arg_5_2 + 1)
end

function var_0_0.addLink(arg_6_0, arg_6_1)
	arg_6_1 = string.gsub(arg_6_1, "%[(.-)%]", arg_6_0.addLinkCb1)
	arg_6_1 = string.gsub(arg_6_1, "【(.-)】", arg_6_0.addLinkCb2)

	return arg_6_1
end

local function var_0_3(arg_7_0, arg_7_1)
	local var_7_0 = SkillConfig.instance:getSkillEffectDescCoByName(arg_7_1)

	arg_7_1 = SkillHelper.removeRichTag(arg_7_1)

	if not var_7_0 then
		return arg_7_1
	end

	local var_7_1 = var_0_2

	arg_7_1 = string.format(arg_7_0, arg_7_1)

	if not var_7_0.notAddLink or var_7_0.notAddLink == 0 then
		return string.format("<color=%s><u><link=%s>%s</link></u></color>", var_7_1, var_7_0.id, arg_7_1)
	end

	return string.format("<color=%s>%s</color>", var_7_1, arg_7_1)
end

function var_0_0.addLinkCb1(arg_8_0)
	local var_8_0 = "[%s]"

	return var_0_3(var_8_0, arg_8_0)
end

function var_0_0.addLinkCb2(arg_9_0)
	local var_9_0 = "【%s】"

	return var_0_3(var_9_0, arg_9_0)
end

function var_0_0.addNumColor(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_0:filterRichText(arg_10_1)

	local var_10_0 = SkillHelper.getColorFormat("#deaa79", "%1")

	arg_10_1 = string.gsub(arg_10_1, "[+-]?[%d%./%%]+", var_10_0)
	arg_10_1 = arg_10_0:revertRichText(arg_10_1)

	return arg_10_1
end

function var_0_0.replaceColorFunc(arg_11_0)
	if string.find(arg_11_0, "[<>]") then
		return arg_11_0
	end
end

var_0_0.richTextList = {}
var_0_0.replaceText = "▩replace▩"
var_0_0.replaceIndex = 0

function var_0_0.filterRichText(arg_12_0, arg_12_1)
	tabletool.clear(var_0_0.richTextList)

	arg_12_1 = string.gsub(arg_12_1, "(<.->)", arg_12_0._filterRichText)

	return arg_12_1
end

function var_0_0._filterRichText(arg_13_0)
	table.insert(var_0_0.richTextList, arg_13_0)

	return var_0_0.replaceText
end

function var_0_0.revertRichText(arg_14_0, arg_14_1)
	var_0_0.replaceIndex = 0
	arg_14_1 = string.gsub(arg_14_1, var_0_0.replaceText, arg_14_0._revertRichText)

	tabletool.clear(var_0_0.richTextList)

	return arg_14_1
end

function var_0_0._revertRichText(arg_15_0)
	var_0_0.replaceIndex = var_0_0.replaceIndex + 1

	return var_0_0.richTextList[var_0_0.replaceIndex] or ""
end

function var_0_0._onHyperLinkClick(arg_16_0, arg_16_1, arg_16_2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_16_0 = string.match(arg_16_1, "skillIndex=(%d)")

	var_16_0 = var_16_0 and tonumber(var_16_0)

	if not var_16_0 then
		CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(arg_16_1), arg_16_0._buffTipAnchor or CommonBuffTipEnum.Anchor[ViewName.CharacterExSkillView], CommonBuffTipEnum.Pivot.Right)
	elseif var_16_0 == 0 then
		local var_16_1 = {}

		var_16_1.tag = "passiveskill"
		var_16_1.heroid = arg_16_0._heroId
		var_16_1.tipPos = Vector2.New(-292, -51.1)
		var_16_1.anchorParams = {
			Vector2.New(1, 0.5),
			Vector2.New(1, 0.5)
		}
		var_16_1.buffTipsX = -776
		var_16_1.heroMo = arg_16_0.heroMo

		CharacterController.instance:openCharacterTipView(var_16_1)
	else
		local var_16_2 = {}
		local var_16_3 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(arg_16_0._heroId)

		var_16_2.super = var_16_0 == 3
		var_16_2.skillIdList = var_16_3[var_16_0]
		var_16_2.monsterName = HeroConfig.instance:getHeroCO(arg_16_0._heroId).name
		var_16_2.anchorX = arg_16_0._skillTipAnchorX
		var_16_2.heroMo = arg_16_0.heroMo

		ViewMgr.instance:openView(ViewName.SkillTipView, var_16_2)
	end
end

return var_0_0
