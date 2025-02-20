module("modules.logic.summon.view.SummonPoolDetailProbabilityView", package.seeall)

slot0 = class("SummonPoolDetailProbabilityView", BaseView)
slot1 = {
	[LangSettings.zh] = "、",
	[LangSettings.tw] = "、",
	[LangSettings.en] = ", ",
	[LangSettings.kr] = ", ",
	[LangSettings.jp] = "、",
	[LangSettings.de] = ", ",
	[LangSettings.fr] = ", ",
	[LangSettings.thai] = ", "
}

function slot0.onInitView(slot0)
	slot0._goContent = gohelper.findChild(slot0.viewGO, "infoScroll/Viewport/#go_Content")
	slot0._goinfoItem = gohelper.findChild(slot0.viewGO, "infoScroll/Viewport/#go_Content/#go_infoItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._infoItemTab = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._poolParam = SummonController.instance:getPoolInfo()
	slot0._poolId = slot0._poolParam.poolId
	slot0._poolDetailId = slot0._poolParam.poolDetailId
	slot0._poolAwardTime = slot0._poolParam.poolAwardTime
	slot0._summonSimulationActId = slot0._poolParam.summonSimulationActId
	slot0._maxAwardTime = string.splitToNumber(slot0._poolAwardTime, "|")[2]

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if string.nilorempty(SummonConfig.instance:getPoolDetailConfig(slot0._poolDetailId).desc) then
		slot2 = CommonConfig.instance:getConstStr(ConstEnum.SummonPoolDetail)
	end

	slot3 = string.split(slot2, "#")
	slot4 = SummonConfig.instance:getSummonPool(slot0._poolId)
	slot0._rareHeroNames = slot0:buildRareNameDict(slot4)
	slot0._rareRates = slot0:buildRateRareDict(slot4)
	slot5 = nil

	if slot0._summonSimulationActId and SummonSimulationPickConfig.instance:getSummonConfigById(slot0._summonSimulationActId).heroExtraDesc then
		slot5 = {
			[tonumber(slot13[1])] = luaLang(slot13[2])
		}

		for slot11, slot12 in ipairs(string.split(slot6.heroExtraDesc, "|")) do
			slot13 = string.split(slot12, "#")
		end
	end

	for slot9, slot10 in ipairs(slot3) do
		if not slot0._infoItemTab[slot9] then
			slot11 = slot0:getUserDataTb_()
			slot11.go = gohelper.clone(slot0._goinfoItem, slot0._goContent, "item" .. slot9)
			slot11.txthero = gohelper.findChildText(slot11.go, "#txt_descContent")
			slot11.txtprobability = gohelper.findChildText(slot11.go, "desctitle/#go_starList/probability/#txt_probability")
			slot11.goprobup = gohelper.findChild(slot11.go, "#go_probup")
			slot0._infoItemTab[slot9] = slot11
		end

		gohelper.setActive(slot11.go, true)

		slot15 = slot11

		slot0:_refreshSummonDesc(slot15, slot10, slot5)

		for slot15 = 1, 6 do
			gohelper.setActive(gohelper.findChild(slot11.go, "desctitle/#go_starList/star" .. slot15), slot15 <= slot0._rate)
		end
	end
end

function slot0._refreshSummonDesc(slot0, slot1, slot2, slot3)
	slot1.txthero.text = ""
	slot1.txtprobability.text = ""
	slot0._rate = 0
	slot9 = "%[heroname=.-%]"

	for slot9 in string.format(slot2, slot0._maxAwardTime - 1, slot0._maxAwardTime):gmatch(slot9) do
		slot10, slot11, slot12, slot13, slot14 = string.find(slot9, "(%[heroname=)(.*)(%])")
		slot16 = ""
		slot17 = {}

		for slot21, slot22 in ipairs(string.splitToNumber(slot13, "#")) do
			table.insert(slot17, table.concat(slot0._rareHeroNames[slot22] or {}, uv0[LangSettings.instance:getCurLang()]))
		end

		slot16 = table.concat(slot17, uv0[LangSettings.instance:getCurLang()])
		slot2 = string.gsub(slot2, string.format("%s%s%s", "%[heroname=", slot13, "%]"), slot16)
		slot4.text = string.format(slot16)
	end

	slot9 = "%[rate=.-%]"

	for slot9 in slot2:gmatch(slot9) do
		slot10, slot11, slot12, slot13, slot14 = string.find(slot9, "(%[rate=)(.*)(%])")

		for slot20, slot21 in ipairs(string.splitToNumber(slot13, "#")) do
			slot16 = 0 + (slot0._rareRates[slot21] or 0)
		end

		slot17 = string.format("%s%%%%", slot16 * 100 - slot16 * 100 % 0.1)
		slot2 = string.gsub(slot2, string.format("%s%s%s", "%[rate=", slot13, "%]"), slot17)

		if slot3 and #slot15 == 1 and slot3[slot15[1]] then
			slot18 = string.format(slot17) .. slot3[slot15[1]]
		end

		slot5.text = slot18
		slot0._rate = CharacterEnum.Star[tonumber(slot13)]
	end
end

function slot0.buildRareNameDict(slot0, slot1)
	slot2 = {
		[slot6] = {}
	}

	for slot6 = 1, 5 do
	end

	slot3 = SummonMainModel.getResultType(slot1)

	for slot8, slot9 in pairs(SummonConfig.instance:getSummon(slot0._poolId)) do
		for slot15, slot16 in ipairs(string.splitToNumber(slot9.summonId, "#")) do
			if slot3 == SummonEnum.ResultType.Char then
				table.insert(slot2[slot8], HeroConfig.instance:getHeroCO(slot16).name)
			elseif slot3 == SummonEnum.ResultType.Equip then
				table.insert(slot2[slot8], EquipConfig.instance:getEquipCo(slot16).name)
			end
		end
	end

	return slot2
end

function slot0.buildRateRareDict(slot0, slot1)
	slot2 = {}
	slot4 = nil

	if not string.nilorempty(slot1.initWeight) then
		for slot9, slot10 in ipairs(string.split(slot3, "|")) do
			slot4 = string.split(slot10, "#")
			slot2[tonumber(slot4[1])] = (tonumber(slot4[2]) or 0) / 10000
		end
	end

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
