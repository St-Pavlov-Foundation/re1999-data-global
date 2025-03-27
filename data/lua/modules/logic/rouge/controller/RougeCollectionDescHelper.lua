module("modules.logic.rouge.controller.RougeCollectionDescHelper", package.seeall)

slot0 = _M

function slot0.setCollectionDescInfos(slot0, slot1, slot2, slot3, slot4)
	slot3 = slot3 or uv0.getDefaultShowDescTypes()
	slot4 = slot4 or uv0.getDefaultExtraParams_HasInst()

	uv0._showCollectionDescs(slot1, slot2, slot3, uv0.buildCollectionInfos(slot3, slot0, nil, , slot4), slot4)
end

function slot0.setCollectionDescInfos2(slot0, slot1, slot2, slot3, slot4, slot5)
	slot4 = slot4 or uv0.getDefaultShowDescTypes()
	slot5 = slot5 or uv0.getDefaultExtraParams_NoneInst()

	uv0._showCollectionDescs(slot2, slot3, slot4, uv0.buildCollectionInfos(slot4, nil, slot0, slot1, slot5), slot5)
end

function slot0.setCollectionDescInfos3(slot0, slot1, slot2, slot3, slot4)
	slot3 = slot3 or uv0.getDefaultShowDescTypes()
	slot4 = slot4 or uv0.getDefaultExtraParams_NoneInst()

	uv0._showCollectionDesc2(slot3, uv0.buildCollectionInfos(slot3, nil, slot0, slot1, slot4), slot2, slot4)
end

function slot0.setCollectionDescInfos4(slot0, slot1, slot2, slot3)
	slot2 = slot2 or uv0.getDefaultShowDescTypes()
	slot3 = slot3 or uv0.getDefaultExtraParams_HasInst()

	uv0._showCollectionDesc2(slot2, uv0.buildCollectionInfos(slot2, slot0, slot3), slot1, slot3)
end

function slot0._showCollectionDescs(slot0, slot1, slot2, slot3, slot4)
	if not slot2 or not slot3 then
		return
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot2) do
		if slot3[slot10] then
			for slot15, slot16 in ipairs(slot11) do
				uv0._showCollectionSingleContent(slot10, slot16, uv0._getOrCreateDescItem(slot10, slot5, slot0, slot1), slot4)
			end
		end
	end

	for slot9, slot10 in pairs(slot1) do
		for slot16 = (slot5[slot9] or 0) + 1, #slot10 do
			gohelper.setActive(slot10[slot16], false)
		end
	end
end

function slot0._showCollectionDesc2(slot0, slot1, slot2, slot3)
	if not slot0 or not slot1 or not slot2 then
		return
	end

	slot3 and slot3.showDescToListFunc or uv0._defaultShowDescToListFunc(slot0, slot1, slot2, slot3)
end

function slot0._defaultShowDescToListFunc(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = slot3 and slot3.isAllActive

	for slot9, slot10 in ipairs(slot0) do
		if slot1[slot10] then
			for slot15, slot16 in ipairs(slot11) do
				table.insert(slot4, uv0._decorateCollectionEffectStr(slot16.content, slot5 or slot16.isActive))

				if slot16.isConditionVisible and not string.nilorempty(slot16.condition) then
					table.insert(slot4, uv0._decorateCollectionEffectStr(slot16.condition, slot17))
				end
			end
		end
	end

	slot2.text = table.concat(slot4, "\n")

	SkillHelper.addHyperLinkClick(slot2)
end

function slot0._getOrCreateDescItem(slot0, slot1, slot2, slot3)
	if not gohelper.findChild(slot2, "go_descitem" .. slot0) then
		logError("找不到描述类型对应的预制体 descType = " .. tostring(slot0))

		return
	end

	slot5 = slot3 and slot3[slot0]
	slot7 = (slot1 and slot1[slot0] or 0) + 1

	if not ((slot5 and #slot5 or 0) > slot7) then
		slot3[slot0] = slot3[slot0] or {}

		table.insert(slot3[slot0], gohelper.cloneInPlace(slot4, string.format("%s_%s", slot0, slot7)))
	end

	slot1[slot0] = slot7

	return slot3[slot0][slot7]
end

function slot0._showCollectionSingleContent(slot0, slot1, slot2, slot3)
	slot4 = slot3 and slot3.showDescFuncMap

	if not (slot4 and slot4[slot0] or uv0.getDefaultDescTypeShowFunc(slot0)) then
		logError("缺少造物描述显示方法 描述类型 : " .. tostring(slot0))

		return
	end

	gohelper.setActive(slot2, true)
	gohelper.setAsLastSibling(slot2)
	slot7(slot2, slot1)
end

function slot0._showCollectionBaseEffect(slot0, slot1)
	slot2 = gohelper.findChildText(slot0, "txt_desc")

	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot0, "txt_desc/image_point"), slot1.isActive and "rouge_collection_point1" or "rouge_collection_point2")

	slot2.text = uv0._decorateCollectionEffectStr(slot1.content, slot1.isActive)

	SkillHelper.addHyperLinkClick(slot2)
	uv0.addFixTmpBreakLine(slot2)
end

function slot0._showCollectionExtraEffect(slot0, slot1)
	slot2 = gohelper.findChildText(slot0, "txt_desc")
	slot2.text = uv0._decorateCollectionEffectStr(slot1.content, slot1.isActive)

	SkillHelper.addHyperLinkClick(slot2)
	uv0.addFixTmpBreakLine(slot2)
end

function slot0._showCollectionText(slot0, slot1)
	gohelper.findChildText(slot0, "txt_desc").text = slot1.content
end

function slot0.addFixTmpBreakLine(slot0)
	if not slot0 then
		return
	end

	slot1 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.gameObject, FixTmpBreakLine)

	slot1:refreshTmpContent(slot0)

	return slot1
end

function slot0.buildCollectionInfos(slot0, slot1, slot2, slot3, slot4)
	if not slot0 then
		return
	end

	slot5, slot6, slot7, slot8 = uv0._checkExtraParamsValid(slot1, slot2, slot3)

	if not slot5 then
		return
	end

	slot9 = slot4 and slot4.buildDescFuncMap
	slot10 = RougeCollectionExpressionHelper.getCollectionAttrMap(slot6, slot7, slot8)
	slot11 = {}

	for slot15, slot16 in ipairs(slot0) do
		if not (slot9 and slot9[slot16] or uv0.getDefaultDescTypeExecuteFunc(slot16)) then
			logError("缺少造物描述数据构建方法 描述类型 : " .. tostring(slot16))
		elseif slot19(slot6, slot7, slot8, slot10, slot4) and #slot20 > 0 then
			slot11[slot16] = slot20
		end
	end

	return slot11
end

function slot0._checkExtraParamsValid(slot0, slot1, slot2)
	if slot0 then
		if not RougeCollectionModel.instance:getCollectionByUid(slot0) then
			return
		end

		slot1 = slot3:getCollectionCfgId()
		slot2 = slot3:getAllEnchantCfgId()
	elseif not RougeCollectionConfig.instance:getCollectionCfg(slot1) then
		return
	end

	return true, slot0, slot1, slot2
end

function slot0.getCollectionBaseEffectInfo(slot0, slot1, slot2, slot3, slot4)
	if not (slot4 and slot4.isAllActive) and not (slot4 and slot4.activeEffectMap) and slot0 ~= nil then
		slot6 = RougeCollectionModel.instance:getCollectionActiveEffectMap(slot0)
	end

	slot15 = {}

	for slot19, slot20 in ipairs(slot4 and slot4.effectInfos or RougeCollectionConfig.instance:getCollectionDescsCfg(slot1)) do
		if not string.nilorempty((slot4 and slot4.infoType or RougeCollectionModel.instance:getCurCollectionInfoType()) == RougeEnum.CollectionInfoType.Complex and slot20.desc or slot20.descSimply) then
			slot24 = uv0._createCollectionDescMo(RougeCollectionExpressionHelper.getDescExpressionResult(slot21, slot3))
			slot24.isActive = slot5 or slot6 and slot6[slot20.effectId] == true

			table.insert(slot15, slot24)
		end
	end

	return slot15
end

function slot0.getCollectionExtraEffectInfo(slot0, slot1, slot2, slot3, slot4)
	if not (slot4 and slot4.isAllActive) and not (slot4 and slot4.activeEffectMap) and slot0 ~= nil then
		slot6 = RougeCollectionModel.instance:getCollectionActiveEffectMap(slot0)
	end

	slot15 = {}

	for slot19, slot20 in ipairs(slot4 and slot4.effectInfos or RougeCollectionConfig.instance:getCollectionDescsCfg(slot1)) do
		if not string.nilorempty((slot4 and slot4.infoType or RougeCollectionModel.instance:getCurCollectionInfoType()) == RougeEnum.CollectionInfoType.Complex and slot20.descExtra or slot20.descExtraSimply) then
			slot24 = uv0._createCollectionDescMo(RougeCollectionExpressionHelper.getDescExpressionResult(slot21, slot3))
			slot24.isActive = slot5 or slot6 and slot6[slot20.effectId] == true

			table.insert(slot15, slot24)
		end
	end

	return slot15
end

function slot0.getCollectionTextInfo(slot0, slot1, slot2, slot3)
	if not string.nilorempty(RougeCollectionConfig.instance:getCollectionOfficialDesc(slot1)) then
		return {
			uv0._createCollectionDescMo(slot4)
		}
	end
end

function slot0._createCollectionDescMo(slot0)
	return {
		content = slot0
	}
end

slot0.ActiveEffectColor = "#B7B7B7"
slot0.DisactiveEffectColor = "#7E7E7E"

function slot0._decorateCollectionEffectStr(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot0) then
		return
	end

	return string.format("<%s>%s</color>", slot1 and (slot2 or uv0.ActiveEffectColor) or (slot3 or uv0.DisactiveEffectColor), SkillHelper.buildDesc(slot0))
end

function slot0.getDefaultDescTypeShowFunc(slot0)
	if not uv0.DefaultDescTypeShowFuncMap then
		uv0.DefaultDescTypeShowFuncMap = {
			[RougeEnum.CollectionDescType.BaseEffect] = uv0._showCollectionBaseEffect,
			[RougeEnum.CollectionDescType.ExtraEffect] = uv0._showCollectionExtraEffect,
			[RougeEnum.CollectionDescType.Text] = uv0._showCollectionText,
			[RougeEnum.CollectionDescType.SpecialHeader] = RougeDLCHelper102._showSpCollectionHeader,
			[RougeEnum.CollectionDescType.SpecialText] = RougeDLCHelper102._showSpCollectionDescInfo
		}
	end

	return uv0.DefaultDescTypeShowFuncMap[slot0]
end

function slot0.getDefaultDescTypeExecuteFunc(slot0)
	if not uv0.DefaultDescTypeExecuteFuncMap then
		uv0.DefaultDescTypeExecuteFuncMap = {
			[RougeEnum.CollectionDescType.BaseEffect] = uv0.getCollectionBaseEffectInfo,
			[RougeEnum.CollectionDescType.ExtraEffect] = uv0.getCollectionExtraEffectInfo,
			[RougeEnum.CollectionDescType.Text] = uv0.getCollectionTextInfo,
			[RougeEnum.CollectionDescType.SpecialHeader] = RougeDLCHelper102.getSpCollectionHeaderInfo,
			[RougeEnum.CollectionDescType.SpecialText] = RougeDLCHelper102.getSpCollectionDescInfo
		}
	end

	return uv0.DefaultDescTypeExecuteFuncMap[slot0]
end

function slot0.getDefaultShowDescTypes()
	if not uv0.DefaultShowDescTypes then
		uv0.DefaultShowDescTypes = {}

		for slot3, slot4 in pairs(RougeEnum.CollectionDescType) do
			table.insert(uv0.DefaultShowDescTypes, slot4)
		end

		table.sort(uv0.DefaultShowDescTypes, uv0._showDescTypeSortFunc)
	end

	return uv0.DefaultShowDescTypes
end

function slot0._showDescTypeSortFunc(slot0, slot1)
	if (RougeEnum.CollectionDescTypeSort[slot0] or 10000) ~= (RougeEnum.CollectionDescTypeSort[slot1] or 10000) then
		return slot2 < slot3
	end

	return slot0 < slot1
end

function slot0.getShowDescTypesWithoutText()
	if not uv0.ShowDescTypesWithoutText then
		uv0.ShowDescTypesWithoutText = {}

		for slot3, slot4 in pairs(RougeEnum.CollectionDescType) do
			if slot4 ~= RougeEnum.CollectionDescType.Text then
				table.insert(uv0.ShowDescTypesWithoutText, slot4)
			end
		end

		table.sort(uv0.ShowDescTypesWithoutText, uv0._showDescTypeSortFunc)
	end

	return uv0.ShowDescTypesWithoutText
end

function slot0.getDefaultExtraParams_NoneInst()
	if not uv0.NoneInstExtraParams then
		uv0.NoneInstExtraParams = {
			isKeepConditionVisible = true,
			isAllActive = true
		}
	end

	return uv0.NoneInstExtraParams
end

function slot0.getDefaultExtraParams_HasInst()
	if not uv0.HasInstExtraParams then
		uv0.HasInstExtraParams = {}
	end

	return uv0.HasInstExtraParams
end

function slot0.getExtraParams_KeepAllActive()
	if not uv0.ExtraParams_KeepAllActive then
		uv0.ExtraParams_KeepAllActive = {
			isAllActive = true
		}
	end

	return uv0.ExtraParams_KeepAllActive
end

return slot0
