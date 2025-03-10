module("modules.logic.rouge.controller.RougeCollectionHelper", package.seeall)

slot0 = _M
slot1 = Vector2.New(0, 0)
slot0.CollectionSlotCellSize = Vector2.New(98, 98)

function slot0.anchorPos2SlotPos(slot0)
	if not slot0 then
		logError("anchorPos is nil")

		return uv0.x, uv0.y
	end

	slot1 = Vector2(slot0.x - uv0.x, -slot0.y - uv0.y)

	return math.floor(slot1.x / uv1.CollectionSlotCellSize.x + 0.5), math.floor(slot1.y / uv1.CollectionSlotCellSize.y + 0.5)
end

function slot0.slotPos2AnchorPos(slot0, slot1, slot2)
	if not slot0 then
		return Vector2.zero
	end

	return slot0.x * (slot1 or uv0.CollectionSlotCellSize.x) + uv1.x, -slot0.y * (slot2 or uv0.CollectionSlotCellSize.y) + uv1.y
end

function slot0.getCollectionPlacePosition(slot0, slot1, slot2)
	slot4, slot5 = uv0.slotPos2AnchorPos(Vector2(slot0.x - 0.5, slot0.y - 0.5), slot1, slot2)

	return slot4, slot5
end

function slot0.getSlotCellSize()
	return uv0.CollectionSlotCellSize
end

function slot0.getSlotCellInsideLine(slot0, slot1, slot2)
	if not slot0 then
		return
	end

	slot3 = slot1 + Vector2(0, 1)
	slot5 = slot1 - Vector2(1, 0)
	slot6 = slot1 + Vector2(1, 0)

	if slot2 then
		slot3 = slot1 - Vector2(0, 1)
		slot4 = slot3
	end

	if slot0[slot3.x] and slot0[slot3.x][slot3.y] then
		table.insert({}, RougeEnum.SlotCellDirection.Top)
	end

	if slot0[slot4.x] and slot0[slot4.x][slot4.y] then
		table.insert(slot7, RougeEnum.SlotCellDirection.Bottom)
	end

	if slot0[slot5.x] and slot0[slot5.x][slot5.y] then
		table.insert(slot7, RougeEnum.SlotCellDirection.Left)
	end

	if slot0[slot6.x] and slot0[slot6.x][slot6.y] then
		table.insert(slot7, RougeEnum.SlotCellDirection.Right)
	end

	return slot7
end

function slot0.getCollectionTopLeftSlotPos(slot0, slot1, slot2)
	slot3 = uv0.getCollectionTopLeftPos(slot0, slot2)

	return Vector2(slot1.x + slot3.x, slot1.y - slot3.y)
end

function slot0.getCollectionCenterSlotPos(slot0, slot1, slot2)
	if not uv0.getCollectionTopLeftPos(slot0, slot1) then
		return slot2
	end

	return Vector2(slot2.x - slot3.x, slot2.y + slot3.y)
end

function slot0.getCollectionTopLeftPos(slot0, slot1)
	slot3 = 1000
	slot4 = 1000
	slot5 = -1000
	slot6 = -1000

	if RougeCollectionConfig.instance:getRotateEditorParam(slot0, slot1, RougeEnum.CollectionEditorParamType.Shape) then
		for slot10, slot11 in pairs(slot2) do
			if slot11.x < slot3 then
				slot3 = slot11.x
			end

			if slot11.y < slot4 then
				slot4 = slot11.x
			end

			if slot5 < slot11.y then
				slot5 = slot11.x
			end

			if slot6 < slot11.y then
				slot6 = slot11.y
			end
		end
	end

	return Vector2(slot3, slot6)
end

function slot0.getRotateAngleByRotation(slot0)
	return Mathf.Clamp(slot0 or 0, 0, 3) * -90
end

function slot0.getCollectionIconUrl(slot0)
	if RougeCollectionConfig.instance:getCollectionCfg(slot0) then
		return ResUrl.getRougeIcon("collection/" .. slot1.iconPath)
	end
end

function slot0.getCollectionSizeAfterRotation(slot0, slot1)
	slot2, slot3 = RougeCollectionConfig.instance:getShapeSize(slot0)

	if (slot1 or 0) % 2 == 0 then
		return slot2, slot3
	else
		return slot3, slot2
	end
end

function slot0.loadShapeGrid(slot0, slot1, slot2, slot3, slot4)
	gohelper.setActive(slot2, false)

	slot5 = RougeCollectionConfig.instance:getShapeMatrix(slot0)
	slot6, slot7 = RougeCollectionConfig.instance:getShapeSize(slot0)

	if slot4 == nil or slot4 == true then
		slot8 = uv0.getCollectionBgScaleSize(slot6, slot7)

		transformhelper.setLocalScale(slot1.transform, slot8, slot8, 1)
	end

	gohelper.onceAddComponent(slot1, gohelper.Type_GridLayoutGroup).constraintCount = slot6
	slot9 = 0

	for slot13 = 1, slot7 do
		for slot17 = 1, slot6 do
			slot18 = nil

			if slot3 then
				if not slot3[slot9 + 1] then
					table.insert(slot3, gohelper.cloneInPlace(slot2))
				end
			else
				slot18 = gohelper.cloneInPlace(slot2)
			end

			gohelper.setActive(slot18, true)

			slot20 = tonumber(slot5[slot13][slot17]) == 1
			slot18:GetComponent(gohelper.Type_Image).enabled = slot20

			if slot20 then
				UISpriteSetMgr.instance:setRougeSprite(slot19, "rouge_collection_grid_big_" .. tostring(RougeCollectionConfig.instance:getCollectionCfg(slot0) and slot21.showRare))
			end
		end
	end

	if slot3 then
		for slot13 = slot9 + 1, #slot3 do
			gohelper.setActive(slot3[slot13], false)
		end
	end
end

function slot0.getCollectionBgScaleSize(slot0, slot1)
	if slot0 == 0 or slot1 == 0 then
		logError("get collection size zero, please check")

		return 0
	end

	if slot1 < slot0 then
		return RougeEnum.CollectionBgMaxSize / slot0
	end

	return RougeEnum.CollectionBgMaxSize / slot1
end

function slot0.loadTags(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(RougeCollectionConfig.instance:getCollectionTags(slot0)) do
		slot9 = nil

		if slot2 then
			if not slot2[slot7] then
				table.insert(slot2, gohelper.cloneInPlace(slot1))
			end
		else
			slot9 = gohelper.cloneInPlace(slot1)
		end

		gohelper.setActive(slot9, true)
		UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot9, "image_tagicon"), RougeCollectionConfig.instance:getCollectioTagCo(slot8) and slot10.iconUrl)
	end

	for slot7 = #slot3 + 1, #slot2 do
		gohelper.setActive(slot2[slot7], false)
	end
end

function slot0.loadCollectionAndEnchantTagsById(slot0, slot1, slot2)
	if not RougeCollectionModel.instance:getCollectionByUid(slot0) then
		return
	end

	uv0.loadCollectionAndEnchantTags(slot3.cfgId, slot3:getAllEnchantCfgId(), slot1, slot2)
end

function slot0.loadCollectionAndEnchantTags(slot0, slot1, slot2, slot3)
	slot4, slot5 = uv0.getCollectionAndEnchantTagIds(slot0, slot1)
	slot6 = slot4 and #slot4 or 0
	slot4 = slot4 or {}

	tabletool.addValues(slot4, slot5)
	gohelper.CreateObjList(nil, uv0._loadCollectionTagCallBack, slot4, slot2, slot3, nil, 1, slot6)
	gohelper.CreateObjList(nil, uv0._loadEnchantTagCallBack, slot4, slot2, slot3, nil, slot6 + 1)
end

function slot0.loadCollectionTags(slot0, slot1, slot2)
	if not RougeCollectionConfig.instance:getCollectionCfg(slot0) then
		return
	end

	gohelper.CreateObjList(nil, uv0._loadCollectionTagCallBack, slot3.tags or {}, slot1, slot2)
end

function slot0._loadCollectionTagCallBack(slot0, slot1, slot2, slot3)
	uv0._loadCollectionIconFunc(slot1, slot2, slot3)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "image_tagframe"), "rouge_collection_tagframe_1")
end

function slot0._loadEnchantTagCallBack(slot0, slot1, slot2, slot3)
	uv0._loadCollectionIconFunc(slot1, slot2, slot3)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "image_tagframe"), "rouge_collection_tagframe_2")
end

function slot0._loadCollectionIconFunc(slot0, slot1, slot2)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot0, "image_tagicon"), RougeCollectionConfig.instance:getCollectioTagCo(slot1) and slot4.iconUrl)
end

function slot0.getCollectionAndEnchantTagIds(slot0, slot1)
	slot3 = {}

	uv0._getFilterCollectionTags(RougeCollectionConfig.instance:getCollectionCfg(slot0) and slot5.tags, {}, {})

	if slot1 then
		for slot10, slot11 in ipairs(slot1) do
			if slot11 > 0 then
				uv0._getFilterCollectionTags(RougeCollectionConfig.instance:getCollectionCfg(slot11) and slot12.tags, slot3, slot4, true)
			end
		end
	end

	return slot2, slot3
end

function slot0._getFilterCollectionTags(slot0, slot1, slot2, slot3)
	if not slot0 then
		return
	end

	slot2 = slot2 or {}

	for slot7, slot8 in ipairs(slot0) do
		if uv0._isCollectionTagSatisfy(slot8, slot2, slot3) then
			table.insert(slot1 or {}, slot8)

			slot2[slot8] = true
		end
	end
end

function slot0._isCollectionTagSatisfy(slot0, slot1, slot2)
	if not slot0 or slot1[slot0] then
		return false
	end

	if slot2 then
		return slot0 < RougeEnum.MinCollectionExtraTagID
	end

	return true
end

function slot0.loadCollectionAndEnchantTagNames(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7 = uv0.getCollectionAndEnchantTagIds(slot0, slot1)
	slot6 = slot6 or {}

	tabletool.addValues(slot6, slot7)
	gohelper.CreateObjList(slot5 or uv0, slot4 or uv0._loadCollectionTagNameWithIconCallBack, slot6, slot2, slot3)
end

function slot0._loadCollectionTagNameWithIconCallBack(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot1, "image_tagicon"), RougeCollectionConfig.instance:getCollectioTagCo(slot2) and slot5.iconUrl)

	slot1:GetComponent(gohelper.Type_TextMesh).text = slot5 and slot5.name
end

function slot0._loadCollectionTagNameCallBack(slot0, slot1, slot2, slot3)
	slot1:GetComponent(gohelper.Type_TextMesh).text = RougeCollectionConfig.instance:getCollectioTagCo(slot2) and slot4.name
end

function slot0.refreshCollectionEffectInfosById(slot0, slot1, slot2, slot3, slot4)
	if not RougeCollectionModel.instance:getCollectionByUid(slot0) then
		return
	end

	slot6 = slot5.cfgId
	slot7 = slot5:getAllEnchantCfgId()
	slot8 = RougeCollectionModel.instance:getCurCollectionInfoType()
	slot9 = uv0._buildCollectionAttrMap2(slot5)
	slot10 = RougeCollectionModel.instance:getCollectionActiveEffectMap(slot0)
	slot11 = slot4 and slot4.callback
	slot12 = slot4 and slot4.callbackObj

	if slot3 == nil then
		slot3 = true
	end

	uv0._refreshCollectionEffectInfosByParams(uv0.getCollectionInfos(slot6, slot7, slot9, {
		activeEffectMap = slot10,
		infoType = slot8,
		inclueDesc = slot3
	}), slot1, slot2, slot11, slot12)
end

function slot0.getCollectionEffectStrById(slot0, slot1, slot2)
	if not RougeCollectionModel.instance:getCollectionByUid(slot0) then
		return
	end

	return uv0._buildEffectInfos2Str(slot3.cfgId, RougeCollectionModel.instance:getCollectionActiveEffectMap(slot0), uv0._buildCollectionAttrMap2(slot3), RougeCollectionModel.instance:getCurCollectionInfoType(), slot1, slot2)
end

function slot0.getCollectionEffectStr(slot0, slot1, slot2, slot3, slot4)
	if not slot0 then
		return
	end

	return uv0._buildEffectInfos2Str(slot0, slot2, uv0._buildCollectionAttrMap(slot0, slot1), RougeCollectionModel.instance:getCurCollectionInfoType(), slot3, slot4)
end

function slot0._buildEffectInfos2Str(slot0, slot1, slot2, slot3, slot4, slot5)
	if not RougeCollectionConfig.instance:getCollectionDescsCfg(slot0) then
		return
	end

	slot7 = (slot3 or RougeCollectionModel.instance:getCurCollectionInfoType()) == RougeEnum.CollectionInfoType.Complex
	slot8 = {}

	for slot12, slot13 in ipairs(slot6) do
		slot14 = slot7 and slot13.desc or slot13.descSimply

		if not string.nilorempty(slot7 and slot13.descExtra or slot13.descExtraSimply) then
			table.insert(slot8, uv0._decorateCollectionEffectStr(uv0.translateCollectionEffectDesc(slot15, slot2), not slot1 or slot1[slot13.effectId], slot4, slot5))
		end

		if not string.nilorempty(slot14) then
			table.insert(slot8, uv0._decorateCollectionEffectStr(uv0.translateCollectionEffectDesc(slot14, slot2), slot16, slot4, slot5))
		end
	end

	return table.concat(slot8, "\n")
end

function slot0.refreshCollectionEffectInfos(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = slot5 and slot5.activeEffectMap
	slot7 = slot5 and slot5.overrideCallBack
	slot8 = slot5 and slot5.callbackObj
	slot9 = RougeCollectionModel.instance:getCurCollectionInfoType()
	slot10 = uv0._buildCollectionAttrMap(slot0, slot1)

	if slot4 == nil then
		slot4 = true
	end

	uv0._refreshCollectionEffectInfosByParams(uv0.getCollectionInfos(slot0, slot1, slot10, {
		activeEffectMap = slot6,
		infoType = slot9,
		inclueDesc = slot4
	}), slot2, slot3, slot7, slot8)
end

function slot0._refreshCollectionEffectInfosByParams(slot0, slot1, slot2, slot3, slot4)
	gohelper.CreateObjList(slot4, slot3 or uv0._defaultCollectionEffectCallBack, slot0, slot1, slot2)
end

slot0.ActiveEffectColor = "#B7B7B7"
slot0.DisactiveEffectColor = "#7E7E7E"

function slot0._defaultCollectionEffectCallBack(slot0, slot1, slot2, slot3)
	gohelper.setActive(gohelper.findChild(slot1, "#go_descitem1"), slot2.type == RougeEnum.CollectionDescType.ExtraEffect)
	gohelper.setActive(gohelper.findChild(slot1, "#go_descitem2"), slot6 == RougeEnum.CollectionDescType.BaseEffect)
	gohelper.setActive(gohelper.findChild(slot1, "#go_descitem3"), slot6 == RougeEnum.CollectionDescType.Desc)

	if slot6 == RougeEnum.CollectionDescType.ExtraEffect then
		slot11 = gohelper.findChildText(slot7, "txt_desc")
		slot11.text = uv0._decorateCollectionEffectStr(slot2.content, slot2.isActive)

		SkillHelper.addHyperLinkClick(slot11)
		uv0.addFixTmpBreakLine(slot11)
	elseif slot6 == RougeEnum.CollectionDescType.BaseEffect then
		slot11 = gohelper.findChildText(slot8, "txt_desc")

		UISpriteSetMgr.instance:setRougeSprite(gohelper.findChildImage(slot8, "txt_desc/image_point"), slot4 and "rouge_collection_point1" or "rouge_collection_point2")

		slot11.text = slot10

		SkillHelper.addHyperLinkClick(slot11)
		uv0.addFixTmpBreakLine(slot11)
	elseif slot6 == RougeEnum.CollectionDescType.Desc then
		gohelper.findChildText(slot9, "#txt_desc").text = slot5
	else
		logError("造物描述类型不存在:" .. tostring(slot6))
	end
end

function slot0.addFixTmpBreakLine(slot0)
	if not slot0 then
		return
	end

	slot1 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.gameObject, FixTmpBreakLine)

	slot1:refreshTmpContent(slot0)

	return slot1
end

function slot0._decorateCollectionEffectStr(slot0, slot1, slot2, slot3)
	slot4 = slot3 or uv0.DisactiveEffectColor

	if slot1 then
		slot4 = slot2 or uv0.ActiveEffectColor
	end

	return string.format("<%s>%s</color>", slot4, SkillHelper.buildDesc(slot0))
end

function slot0.getCollectionInfos(slot0, slot1, slot2, slot3)
	slot5 = slot3 and slot3.activeEffectMap
	slot6 = slot3 and slot3.inclueDesc
	slot2 = slot2 or uv0._buildCollectionAttrMap(slot0, slot1)
	slot8 = (slot3 and slot3.infoType or RougeEnum.CollectionInfoType.Complex) == RougeEnum.CollectionInfoType.Complex
	slot9 = {}

	for slot13, slot14 in ipairs(RougeCollectionConfig.instance:getCollectionDescsCfg(slot0)) do
		slot17 = not slot5 or slot5 and slot5[slot14.effectId] ~= nil

		table.insert(slot9, uv0._createDescInfo(uv0.translateCollectionEffectDesc(slot8 and slot14.descExtra or slot14.descExtraSimply, slot2), RougeEnum.CollectionDescType.ExtraEffect, slot17))
		table.insert(slot9, uv0._createDescInfo(uv0.translateCollectionEffectDesc(slot8 and slot14.desc or slot14.descSimply, slot2), RougeEnum.CollectionDescType.BaseEffect, slot17))
	end

	if slot6 then
		table.insert(slot9, uv0._createDescInfo(RougeCollectionConfig.instance:getCollectionOfficialDesc(slot0), RougeEnum.CollectionDescType.Desc))
	end

	return slot9
end

function slot0._createDescInfo(slot0, slot1, slot2)
	if string.nilorempty(slot0) then
		return
	end

	return {
		isActive = slot2,
		content = slot0,
		type = slot1
	}
end

function slot0._buildCollectionAttrMap(slot0, slot1)
	return uv0._computeAttrValue(slot1, RougeCollectionConfig.instance:getCollectionStaticAttrValueMap(slot0))
end

function slot0._buildCollectionAttrMap2(slot0)
	if not slot0 then
		return
	end

	slot1 = slot0:getAttrValueMap()

	if RougeCollectionModel.instance:isCollectionPlaceInSlotArea(slot0.id) then
		return slot1
	end

	slot3 = uv0._buildCollectionAttrMap(slot0.cfgId, slot0:getAllEnchantCfgId())

	if slot1 then
		for slot7, slot8 in pairs(slot1) do
			slot3[slot7] = (slot3[slot7] or 0) + slot8
		end
	end

	return slot3
end

function slot0._computeAttrValue(slot0, slot1)
	slot2 = {}

	if slot0 and slot1 then
		for slot6, slot7 in ipairs(slot0) do
			if slot7 > 0 and slot1[slot7] then
				for slot11, slot12 in pairs(slot1[slot7]) do
					slot14 = RougeCollectionConfig.instance:getCollectionAttrByFlag(slot11) and slot13.id or 0
					slot2[slot14] = slot2[slot14] or 0
					slot2[slot14] = slot2[slot14] + slot12
				end
			end
		end
	end

	return slot2
end

slot2 = "#CCFF99"

function slot0.translateCollectionEffectDesc(slot0, slot1)
	if string.nilorempty(slot0) or not slot1 then
		return slot0
	end

	return string.gsub(slot0, "%b{}", function (slot0)
		return uv0._gsubExperisonFunc(slot0, uv1)
	end)
end

function slot0.translateCollectionEffectDescByCfgId(slot0, slot1, slot2)
	return uv0.translateCollectionEffectDesc(slot2, uv0._buildCollectionAttrMap(slot0, slot1))
end

function slot0._gsubExperisonFunc(slot0, slot1)
	if not loadstring(string.format("return %s, hasAttrMuchZero", string.lower(string.gsub(string.gsub(slot0, "{", ""), "}", "")))) then
		logError("肉鸽造物描述表达式解析失败: 文本内容:" .. tostring(slot0))

		return slot0
	end

	setfenv(slot3, uv0._buildGsubExperisonEnv(slot1))

	slot5, slot6 = slot3()

	if slot6 then
		slot5 = string.format("<%s>%s</color>", uv1, slot5)
	end

	return tostring(slot5)
end

slot3 = {
	__index = function (slot0, slot1)
		if not (slot0.attrMap and slot0.attrMap[slot1]) then
			logError(string.format("尝试解析造物描述失败!!! 失败原因: 无法匹配属性Flag:%s", slot1))
		end

		if (slot2 or 0) > 0 then
			slot0.hasAttrMuchZero = true
		end

		return slot2
	end
}

function slot0._buildGsubExperisonEnv(slot0)
	setmetatable({
		hasAttrMuchZero = false,
		min = math.min,
		max = math.max,
		attrMap = {}
	}, uv0)

	if RougeCollectionConfig.instance:getAllCollectionAttrMap() then
		for slot6, slot7 in pairs(slot2) do
			slot1.attrMap[string.lower(slot7.flag)] = slot0[slot6] or 0
		end
	end

	return slot1
end

function slot0.computeAndSetCollectionIconScale(slot0, slot1, slot2, slot3)
	slot4, slot5 = RougeCollectionConfig.instance:getShapeSize(slot0)
	slot6 = slot4 * slot2

	if slot4 < slot5 then
		slot6 = slot5 * slot3
	end

	recthelper.setSize(slot1, slot6, slot6)
end

function slot0.checkCollectionHasAnyOneTag(slot0, slot1, slot2, slot3)
	if GameUtil.tabletool_dictIsEmpty(slot2) and GameUtil.tabletool_dictIsEmpty(slot3) then
		return true
	end

	slot4, slot5 = uv0.getCollectionAndEnchantTagIds(slot0, slot1)
	slot6 = {}

	tabletool.addValues(slot6, slot4)
	tabletool.addValues(slot6, slot5)

	slot9 = not (slot2 and tabletool.len(slot2) > 0)
	slot10 = not (slot3 and tabletool.len(slot3) > 0)

	if slot6 then
		for slot14, slot15 in ipairs(slot6) do
			if slot7 and slot2[slot15] then
				slot9 = true
			end

			if slot8 and slot3[slot15] then
				slot10 = true
			end

			if slot9 and slot10 then
				return true
			end
		end
	end
end

function slot0.checkCollectionHasAnyOneTag1(slot0, slot1)
	if GameUtil.tabletool_dictIsEmpty(slot1) then
		return true
	end

	if RougeCollectionConfig.instance:getCollectionTags(slot0) then
		for slot6, slot7 in ipairs(slot2) do
			if slot1[slot7] then
				return true
			end
		end
	end
end

function slot0.removeInValidItem(slot0)
	if GameUtil.tabletool_dictIsEmpty(slot0) then
		return
	end

	for slot4, slot5 in pairs(slot0) do
		if not slot0[slot4] then
			slot0[slot4] = nil
		end
	end
end

function slot0.buildCollectionSlotMOs(slot0)
	if not slot0 then
		return
	end

	slot1 = {}

	for slot5, slot6 in ipairs(slot0) do
		table.insert(slot1, uv0.buildNewCollectionSlotMO(slot6))
	end

	return slot1
end

function slot0.buildNewCollectionSlotMO(slot0)
	slot1 = RougeCollectionSlotMO.New()

	slot1:init(slot0)

	return slot1
end

function slot0.buildNewBagCollectionMO(slot0)
	slot1 = RougeCollectionMO.New()

	slot1:init(slot0)

	return slot1
end

function slot0.isCollectionShapeAsSquare(slot0)
	slot1, slot2 = RougeCollectionConfig.instance:getShapeSize(slot0)

	if slot1 ~= slot2 then
		return false
	end

	return slot1 * slot2 == (RougeCollectionConfig.instance:getOriginEditorParam(slot0, RougeEnum.CollectionEditorParamType.Shape) and #slot4 or 0)
end

function slot0.getCollectionCellSlotPos(slot0, slot1)
	return Vector2(slot1.x + slot0.x, slot0.y - slot1.y)
end

function slot0.isNewGetCollection(slot0)
	return slot0 == RougeEnum.CollectionReason.Product or slot0 == RougeEnum.CollectionReason.Composite
end

slot4 = Vector2(1, 1)

function slot0.getCollectionDragPos(slot0, slot1)
	if not RougeCollectionConfig.instance:getCollectionCfg(slot0) then
		return
	end

	slot3 = RougeCollectionConfig.instance:getShapeMatrix(slot0, slot1)
	slot4 = tabletool.len(slot3)
	slot5 = slot3[slot4]

	if slot4 <= 1 and #slot5 <= 1 then
		return uv0.x, uv0.y
	end

	if slot5 then
		for slot9, slot10 in ipairs(slot5) do
			if slot10 and slot10 > 0 then
				return slot9, slot4
			end
		end
	end
end

function slot0.checkIsCollectionSlotArea(slot0, slot1, slot2, slot3)
	if not slot0 or not slot1 or not slot2 then
		return
	end

	if RougeCollectionConfig.instance:getShapeMatrix(slot0, slot2) then
		for slot8, slot9 in ipairs(slot4) do
			for slot13, slot14 in ipairs(slot9) do
				if slot14 and slot14 > 0 then
					if slot3 and not uv0.isSlotPosInSlotArea(slot1.y + slot8 - 1, slot1.x + slot13 - 1) then
						return true
					elseif not slot3 and slot17 then
						return true
					end
				end
			end
		end
	end
end

function slot0.isSlotPosInSlotArea(slot0, slot1)
	if slot2 then
		return slot0 >= 0 and slot0 < (RougeCollectionModel.instance:getCurSlotAreaSize().row or 0) and slot1 >= 0 and slot1 < (slot2.col or 0)
	end
end

slot0.DefaultSlotParam = RougeCollectionSlotCompParam.New()
slot0.StyleShowCollectionSlotParam = RougeCollectionSlotCompParam.New()
slot0.StyleShowCollectionSlotParam.cellLineNameMap = {
	[RougeEnum.LineState.Grey] = "rouge_bagline_yellow",
	[RougeEnum.LineState.Green] = "rouge_bagline_yellow_light"
}
slot0.StyleCollectionSlotParam = RougeCollectionSlotCompParam.New()
slot0.StyleCollectionSlotParam.cellLineNameMap = {
	[RougeEnum.LineState.Grey] = "rouge_bagline_black",
	[RougeEnum.LineState.Green] = "rouge_bagline_grey"
}
slot0.ResultReViewCollectionSlotParam = RougeCollectionSlotCompParam.New()
slot0.ResultReViewCollectionSlotParam.cellWidth = slot0.CollectionSlotCellSize.x
slot0.ResultReViewCollectionSlotParam.cellHeight = slot0.CollectionSlotCellSize.y
slot0.ResultReViewCollectionSlotParam.cellLineNameMap = {
	[RougeEnum.LineState.Grey] = "rouge_collection_gridline_grey",
	[RougeEnum.LineState.Green] = "rouge_collection_gridline_green",
	[RougeEnum.LineState.Red] = "rouge_collection_gridline_red",
	[RougeEnum.LineState.Blue] = "rouge_collection_gridline_blue"
}
slot0.ResultReViewCollectionSlotParam.showIcon = true

function slot0.foreachCollectionCells(slot0, slot1, slot2, ...)
	if not slot0 then
		return
	end

	if RougeCollectionConfig.instance:getShapeMatrix(slot0.cfgId, slot0:getRotation()) then
		for slot9, slot10 in ipairs(slot5) do
			for slot14, slot15 in ipairs(slot10) do
				if slot15 and slot15 > 0 then
					slot1(slot2, slot0, slot9, slot14, ...)
				end
			end
		end
	end
end

function slot0.getTwoCollectionConnectCell(slot0, slot1)
	if not slot0 or not slot1 then
		return
	end

	slot2 = slot1.cfgId
	slot3 = {}

	uv0.foreachCollectionCells(slot0, uv0._checkIsTwoCollectionCellNear, nil, slot1, slot3)

	if slot3 and #slot3 > 0 then
		return slot3[1], slot3[2]
	end
end

function slot0._checkIsTwoCollectionCellNear(slot0, slot1, slot2, slot3, slot4, slot5)
	if (not slot1 or not slot4) and slot5 then
		return
	end

	slot6 = slot1:getLeftTopPos()
	slot7 = slot6.x + slot3 - 1
	slot8 = slot6.y + slot2 - 1

	if uv0._checkIsCellNearCollection(slot7 - 1, slot8, slot4) or uv0._checkIsCellNearCollection(slot7 + 1, slot8, slot4) or uv0._checkIsCellNearCollection(slot7, slot8 - 1, slot4) or uv0._checkIsCellNearCollection(slot7, slot8 + 1, slot4) then
		table.insert(slot5, Vector2(slot7, slot8))

		if slot9 then
			table.insert(slot5, Vector2(slot7 - 1, slot8))
		elseif slot10 then
			table.insert(slot5, Vector2(slot7 + 1, slot8))
		elseif slot11 then
			table.insert(slot5, Vector2(slot7, slot8 - 1))
		else
			table.insert(slot5, Vector2(slot7, slot8 + 1))
		end
	end
end

function slot0._checkIsCellNearCollection(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	slot3 = slot2:getLeftTopPos()
	slot5 = slot1 - slot3.y + 1
	slot7 = false

	if RougeCollectionConfig.instance:getShapeMatrix(slot2.cfgId, slot2:getRotation()) then
		slot8 = slot6[slot5] and slot6[slot5][slot0 - slot3.x + 1]
		slot7 = slot8 and slot8 > 0
	end

	return slot7
end

function slot0.isCanDragCollection()
	return UnityEngine.Input.touchCount <= 1
end

function slot0.isUniqueCollection(slot0)
	return RougeCollectionConfig.instance:getCollectionCfg(slot0) and slot1.isUnique
end

function slot0.isUnremovableCollection(slot0)
	return RougeCollectionConfig.instance:getCollectionCfg(slot0) and slot1.unremovable
end

function slot0.getNotUniqueCollectionNum()
	for slot5, slot6 in ipairs(RougeCollectionModel.instance:getAllCollections()) do
		if not uv0.isUniqueCollection(slot6.cfgId) then
			slot1 = 0 + 1
		end
	end

	return slot1
end

return slot0
