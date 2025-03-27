module("modules.logic.rouge.dlc.102.controller.RougeDLCHelper102", package.seeall)

slot0 = class("RougeDLCHelper102")

function slot0.getSpCollectionHeaderInfo(slot0, slot1, slot2, slot3, slot4)
	if not RougeDLCHelper.isUsingTargetDLC(RougeDLCEnum.DLCEnum.DLC_102) then
		return
	end

	if RougeDLCConfig102.instance:getCollectionOwnerCo(slot1) then
		return {
			slot6
		}
	end
end

function slot0.getSpCollectionDescInfo(slot0, slot1, slot2, slot3, slot4)
	if not RougeDLCHelper.isUsingTargetDLC(RougeDLCEnum.DLCEnum.DLC_102) then
		return
	end

	if not RougeDLCConfig102.instance:getSpCollectionDescCos(slot1) then
		return
	end

	slot10 = (slot4 and slot4.infoType or RougeCollectionModel.instance:getCurCollectionInfoType()) == RougeEnum.CollectionInfoType.Complex
	slot12 = slot4 and slot4.isKeepConditionVisible

	if not (slot4 and slot4.isAllActive) and not (slot4 and slot4.activeEffectMap) and slot0 ~= nil then
		slot13 = RougeCollectionModel.instance:getCollectionActiveEffectMap(slot0)
	end

	slot15 = {}

	for slot21, slot22 in ipairs(slot6) do
		if not string.nilorempty(slot10 and slot22.desc or slot22.descSimply) then
			table.insert(slot15, {
				isActive = slot11 or slot13 and slot13[slot22.effectId] == true,
				content = RougeCollectionExpressionHelper.getDescExpressionResult(slot23, slot3, slot4 and slot4.spDescExpressionFunc),
				isConditionVisible = slot12 or uv0.checkpCollectionConditionVisible(slot0, slot21),
				condition = RougeCollectionExpressionHelper.getDescExpressionResult(slot10 and slot22.condition or slot22.conditionSimply, slot3, slot4 and slot4.spConditionExpressionFunc)
			})
		end
	end

	return slot15
end

slot1 = {
	3001,
	3002,
	4001
}

function slot0.checkpCollectionConditionVisible(slot0, slot1)
	slot2 = true

	if slot0 and slot0 ~= 0 and RougeCollectionModel.instance:getCollectionByUid(slot0) and uv0[slot1] then
		slot2 = not slot3:isAttrExist(uv0[slot1])
	end

	return slot2
end

function slot0._defaultSpDescExpressionFunc()
end

function slot0._defaultSpConditionExpressionFunc()
end

function slot0._showSpCollectionHeader(slot0, slot1)
	gohelper.findChildText(slot0, "txt_desc").text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_spcollection_header"), slot1.name)
end

slot2 = "#B7B7B7"
slot3 = "#7E7E7E"
slot4 = 1
slot5 = 1
slot6 = "#A08156"

function slot0._showSpCollectionDescInfo(slot0, slot1)
	slot2 = gohelper.findChildText(slot0, "txt_desc")
	slot2.text = SkillHelper.buildDesc(slot1.content)

	SLFramework.UGUI.GuiHelper.SetColor(slot2, slot1.isActive and uv0 or uv1)
	ZProj.UGUIHelper.SetColorAlpha(slot2, slot5 and uv2 or uv3)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot0, "txt_desc/image_point"), slot5 and "rouge_collection_point1" or "rouge_collection_point2")
	SkillHelper.addHyperLinkClick(slot2)

	slot7 = slot1.isConditionVisible

	gohelper.setActive(gohelper.findChildText(slot0, "txt_desc2"), slot7)

	if slot7 then
		slot3.text = SkillHelper.buildDesc(GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_spcollection_unlock"), {
			slot1.condition
		}))

		SLFramework.UGUI.GuiHelper.SetColor(slot3, uv4)
	end
end

return slot0
