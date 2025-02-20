module("modules.logic.summon.view.luckybag.SummonLuckyBagProbabilityView", package.seeall)

slot0 = class("SummonLuckyBagProbabilityView", BaseView)

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
	slot0._maxAwardTime = string.splitToNumber(slot0._poolAwardTime, "|")[2]

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if string.nilorempty(SummonConfig.instance:getPoolDetailConfig(slot0._poolDetailId).desc) then
		slot2 = CommonConfig.instance:getConstStr(ConstEnum.SummonPoolDetail)
	end

	slot4 = SummonConfig.instance:getSummonPool(slot0._poolId)
	slot0._rareHeroNames = slot0:buildRareNameDict(slot4)
	slot8 = slot4
	slot0._rareRates = slot0:buildRateRareDict(slot8)

	for slot8, slot9 in ipairs(string.split(slot2, "#")) do
		if not slot0._infoItemTab[slot8] then
			slot10 = slot0:getUserDataTb_()
			slot10.go = gohelper.clone(slot0._goinfoItem, slot0._goContent, "item" .. slot8)
			slot10.txthero = gohelper.findChildText(slot10.go, "#txt_descContent")
			slot10.txtprobability = gohelper.findChildText(slot10.go, "desctitle/#go_starList/probability/#txt_probability")
			slot10.goprobup = gohelper.findChild(slot10.go, "#go_probup")
			slot0._infoItemTab[slot8] = slot10
		end

		gohelper.setActive(slot10.go, true)

		slot14 = slot10

		slot0:_refreshSummonDesc(slot14, slot9)

		for slot14 = 1, 6 do
			gohelper.setActive(gohelper.findChild(slot10.go, "desctitle/#go_starList/star" .. slot14), slot14 <= slot0._rate)
		end
	end
end

function slot0._refreshSummonDesc(slot0, slot1, slot2)
	slot1.txthero.text = ""
	slot1.txtprobability.text = ""
	slot0._rate = 0
	slot8 = "%[heroname=.-%]"

	for slot8 in string.format(slot2, slot0._maxAwardTime - 1, slot0._maxAwardTime):gmatch(slot8) do
		slot9, slot10, slot11, slot12, slot13 = string.find(slot8, "(%[heroname=)(.*)(%])")
		slot15 = ""
		slot16 = {}

		for slot20, slot21 in ipairs(string.splitToNumber(slot12, "#")) do
			table.insert(slot16, table.concat(slot0._rareHeroNames[slot21] or {}, "|"))
		end

		slot15 = table.concat(slot16, "|")
		slot2 = string.gsub(slot2, string.format("%s%s%s", "%[heroname=", slot12, "%]"), slot15)
		slot3.text = string.format(slot15)
	end

	slot8 = "%[rate=.-%]"

	for slot8 in slot2:gmatch(slot8) do
		slot9, slot10, slot11, slot12, slot13 = string.find(slot8, "(%[rate=)(.*)(%])")

		for slot19, slot20 in ipairs(string.splitToNumber(slot12, "#")) do
			slot15 = 0 + (slot0._rareRates[slot20] or 0)
		end

		slot16 = string.format("%s%%%%", slot15 * 100 - slot15 * 100 % 0.1)
		slot2 = string.gsub(slot2, string.format("%s%s%s", "%[rate=", slot12, "%]"), slot16)
		slot4.text = string.format(slot16)
		slot0._rate = CharacterEnum.Star[tonumber(slot12)]
	end
end

function slot0.buildRareNameDict(slot0, slot1)
	slot2 = {
		[slot6] = {}
	}

	for slot6 = 1, 5 do
	end

	slot3 = SummonMainModel.getResultType(slot1)

	if not SummonConfig.instance:getSummon(slot0._poolId) then
		logError("lua_summon poolId = " .. tostring(slot0._poolId) .. " is nil")

		return slot2
	end

	for slot8, slot9 in pairs(slot4) do
		for slot15, slot16 in ipairs(string.splitToNumber(slot9.summonId, "#")) do
			table.insert(slot2[slot8], HeroConfig.instance:getHeroCO(slot16).name)
		end

		for slot17, slot18 in ipairs(string.splitToNumber(slot9.luckyBagId, "#")) do
			table.insert(slot2[slot8], SummonConfig.instance:getLuckyBag(slot9.id, slot18).name)
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
