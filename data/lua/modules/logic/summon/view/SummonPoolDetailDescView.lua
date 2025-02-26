module("modules.logic.summon.view.SummonPoolDetailDescView", package.seeall)

slot0 = class("SummonPoolDetailDescView", BaseView)

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
	slot0._infoItemTab = slot0:getUserDataTb_()
	slot0._paragraphItems = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0._poolParam = SummonController.instance:getPoolInfo()
	slot0._poolDetailId = slot0._poolParam.poolDetailId
	slot0._poolId = slot0._poolParam.poolId
	slot0._summonSimulationActId = slot0._poolParam.summonSimulationActId
	slot0._resultType = SummonMainModel.getResultType(SummonConfig.instance:getSummonPool(slot0._poolId))

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:cleanParagraphs()

	slot0._probUpRareIds, slot0._probUpIds = SummonPoolDetailCategoryListModel.buildProbUpDict(slot0._poolId)

	for slot6, slot7 in ipairs(slot0:parseDesc(slot0:buildDesc())) do
		if not slot0._infoItemTab[slot6] then
			table.insert(slot0._infoItemTab, gohelper.clone(slot0._goinfoItem, slot0._goContent, "item" .. slot6))
		end

		gohelper.setActive(slot8, true)
		slot0:checkBuildProbUp(slot7)

		gohelper.findChildText(slot8, "desctitle/#txt_desctitle").text = slot7.title
		slot9, slot10 = slot0:splitParagraph(slot7.desc)

		if not slot9 or #slot9 == 0 then
			return
		end

		for slot14, slot15 in ipairs(slot9) do
			slot0:createParagraphUI(slot15, slot10[slot14] or "", slot8)
		end
	end
end

function slot0.cleanParagraphs(slot0)
	for slot4 = #slot0._paragraphItems, 1, -1 do
		gohelper.destroy(slot0._paragraphItems[slot4])

		slot0._paragraphItems[slot4] = nil
	end
end

function slot0.buildDesc(slot0)
	slot1 = SummonConfig.instance:getSummonPool(slot0._poolId)
	slot2 = SummonConfig.instance:getPoolDetailConfig(slot0._poolDetailId)
	slot3 = {
		slot1.nameCn,
		slot1.nameEn,
		[6 - (slot12[1] + 1) + 3] = slot12[2] / 100 .. "%",
		[8] = string.split(slot1.awardTime, "|")[2]
	}
	slot4 = nil

	for slot10, slot11 in ipairs(string.split(slot1.initWeight, "|")) do
		slot12 = string.splitToNumber(slot11, "#")
	end

	slot7 = ""

	if slot0._summonSimulationActId then
		return GameUtil.getSubPlaceholderLuaLang(CommonConfig.instance:getConstStr(SummonSimulationPickConfig.instance:getSummonConfigById(slot0._summonSimulationActId).constId), slot3)
	end

	if slot2 then
		if tonumber(slot2.info) then
			slot7 = GameUtil.getSubPlaceholderLuaLang(CommonConfig.instance:getConstStr(slot8), slot3)
		else
			logError(string.format("summon_pool_detail.info error! self._poolId = %s, detailId = %s", slot0._poolId, slot0._poolDetailId))
		end
	else
		logError(string.format("summon_pool_detail config not found ! self._poolId = %s, detailId = %s", slot0._poolId, slot0._poolDetailId))
	end

	return slot7
end

function slot0.parseDesc(slot0, slot1)
	for slot6 in string.gmatch(slot1, "{(.-)}") do
		table.insert({}, {
			title = slot6
		})
	end

	for slot7 = 2, #string.split(string.gsub(slot1, "{(.-)}", "|"), "|") do
		slot2[slot7 - 1].desc = slot3[slot7]
	end

	return slot2
end

function slot0.checkBuildProbUp(slot0, slot1)
	for slot6 in slot1.desc:gmatch("%[upname=.-%]") do
		slot7, slot8, slot9, slot10, slot11 = string.find(slot6, "(%[upname=)(.*)(%])")
		slot6 = string.format("%s%s%s", "%[upname=", slot10, "%]")
		slot2 = (not slot0._probUpIds[tonumber(slot10)] or string.gsub(slot2, slot6, slot0:getTargetName(slot13))) and string.gsub(string.gsub(slot2, slot6, slot0:getTargetName(slot13)), slot6, "")
	end

	slot1.desc = slot0:descReplace(slot0:descReplace(slot2, "%[ssr_up_rate%]", CommonConfig.instance:getConstNum(ConstEnum.SummonSSRUpProb) / 10 .. "%%"), "%[sr_up_rate%]", CommonConfig.instance:getConstNum(ConstEnum.SummonSRUpProb) / 10 .. "%%")
end

function slot0.splitParagraph(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot4 = slot1

	while not string.nilorempty(slot4) do
		slot5, slot6, slot7, slot8 = string.find(slot4, "%[para=(%d-)%](.-)%[/para%]")

		if slot5 == nil then
			table.insert(slot2, SummonEnum.DetailParagraphType.Normal)
			table.insert(slot3, slot4)

			break
		end

		if not string.nilorempty(string.sub(slot4, 0, slot5 - 1)) then
			table.insert(slot2, SummonEnum.DetailParagraphType.Normal)
			table.insert(slot3, slot9)
		end

		if not string.nilorempty(slot8) then
			table.insert(slot2, tonumber(slot7))
			table.insert(slot3, tostring(slot8))
		end

		if string.find(string.sub(slot4, slot6 + 1), "\n") == 1 then
			slot4 = string.sub(slot4, 2)
		end
	end

	return slot2, slot3
end

function slot0.createParagraphUI(slot0, slot1, slot2, slot3)
	slot4 = nil

	if slot1 == SummonEnum.DetailParagraphType.SpaceOne then
		gohelper.cloneInPlace(gohelper.findChild(slot3, "#txt_descspaceone"), "para_2"):GetComponent(gohelper.Type_TextMesh).text = slot2
	else
		gohelper.cloneInPlace(gohelper.findChild(slot3, "#txt_descContent"), "para_1"):GetComponent(gohelper.Type_TextMesh).text = slot2
	end

	table.insert(slot0._paragraphItems, slot4)

	if not gohelper.isNil(slot4) then
		gohelper.setActive(slot4, true)
	end
end

function slot0.descReplace(slot0, slot1, slot2, slot3)
	for slot7 in slot1:gmatch(slot2) do
		slot1 = string.gsub(slot1, slot2, slot3)
	end

	return slot1
end

function slot0.getTargetName(slot0, slot1)
	if slot0._resultType == SummonEnum.ResultType.Char then
		return HeroConfig.instance:getHeroCO(slot1).name
	elseif slot0._resultType == SummonEnum.ResultType.Equip then
		return EquipConfig.instance:getEquipCo(slot1).name
	end

	return ""
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._rateUpIcons = nil
	slot0._rateUpIconsPool = nil
end

return slot0
