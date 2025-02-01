module("modules.logic.rouge.model.RougeCollectionListModel", package.seeall)

slot0 = class("RougeCollectionListModel", MixScrollModel)

function slot0.onInitData(slot0, slot1, slot2, slot3, slot4)
	slot0._selectedConfig = nil
	slot0._baseTagFilterMap = slot1
	slot0._extraTagFilterMap = slot2
	slot0._selectedType = slot3
	slot0._updatePos = slot4

	if slot4 then
		slot0._posMap = {}
	end

	slot0:onCollectionDataUpdate()
end

function slot0.getPos(slot0, slot1)
	return lua_rouge_collection_unlock.configDict[slot1] and slot2.sortId or 0
end

function slot0.setSelectedConfig(slot0, slot1)
	slot0._selectedConfig = slot1

	RougeController.instance:dispatchEvent(RougeEvent.OnClickCollectionListItem)
end

function slot0.getSelectedConfig(slot0)
	return slot0._selectedConfig
end

function slot0._canShow(slot0, slot1)
	if not slot1.interactable then
		return false
	end

	if slot0._selectedType == 1 then
		return true
	end

	slot2 = RougeOutsideModel.instance:collectionIsPass(slot1.id)

	if slot0._selectedType == 2 then
		return slot2
	end

	return not slot2
end

function slot0.onCollectionDataUpdate(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = 0
	slot5 = {}

	if RougeCollectionConfig.instance:getAllInteractCollections() then
		for slot10, slot11 in pairs(slot6) do
			if RougeCollectionHelper.checkCollectionHasAnyOneTag(slot11.id, nil, slot0._baseTagFilterMap, slot0._extraTagFilterMap) then
				if not slot1[slot11.type] then
					slot13 = {
						type = slot11.type
					}
					slot1[slot11.type] = slot13

					table.insert(slot2, slot13)
				end

				if slot0:_canShow(slot11) then
					table.insert(slot13, slot11)
				end
			end
		end
	end

	table.sort(slot2, uv0.sortType)

	slot7 = 1
	slot0._firstType = nil

	for slot11, slot12 in ipairs(slot2) do
		slot13 = slot1[slot12.type]

		table.sort(slot13, uv0.sortTypeList)

		for slot18, slot19 in ipairs(slot13) do
			if not nil then
				slot14 = {
					type = slot12.type
				}

				if slot18 == 1 and slot0._firstType then
					-- Nothing
				end

				if not slot0._firstType then
					slot0._firstType = slot12.type
				end

				table.insert(slot3, slot14)

				if slot14.type then
					slot5[slot14.type] = slot4
				end

				slot4 = slot4 + (slot14.type and RougeEnum.CollectionHeight.Big or RougeEnum.CollectionHeight.Small)
			end

			table.insert(slot14, slot19)

			if slot0._updatePos then
				slot0._posMap[slot19.id] = slot7
				slot7 = slot7 + 1
			end

			if not slot0._selectedConfig then
				slot0:setSelectedConfig(slot19)
			end

			if RougeEnum.CollectionListRowNum <= #slot14 then
				slot14 = nil
			end
		end
	end

	if slot0._updatePos then
		slot0._enchantList = slot1[RougeEnum.CollectionType.Enchant]
	end

	slot0._typeHeightMap = slot5
	slot0._typeList = slot2

	slot0:setList(slot3)
end

function slot0.getTypeHeightMap(slot0)
	return slot0._typeHeightMap
end

function slot0.getTypeList(slot0)
	return slot0._typeList
end

function slot0.getFirstType(slot0)
	return slot0._firstType
end

function slot0.getEnchantList(slot0)
	return slot0._enchantList
end

function slot0.sortType(slot0, slot1)
	slot3 = RougeEnum.CollectionTypeSort[slot1.type]

	if not RougeEnum.CollectionTypeSort[slot0.type] or not slot3 then
		if not slot2 then
			logError(string.format("无法查询到收藏夹造物类型排序，类型 = %s", slot0.type))
		end

		if not slot3 then
			logError(string.format("无法查询到收藏夹造物类型排序，类型 = %s", slot1.type))
		end

		return slot2 ~= nil
	end

	return slot2 < slot3
end

function slot0.getSize(slot0)
	return RougeCollectionConfig.instance:getCollectionCellCount(slot0, RougeEnum.CollectionEditorParamType.Shape)
end

function slot0.sortTypeList(slot0, slot1)
	if uv0.instance:getPos(slot0.id) ~= uv0.instance:getPos(slot1.id) then
		return slot2 < slot3
	end

	return slot0.id < slot1.id
end

function slot0.getInfoList(slot0, slot1)
	slot0._mixCellInfo = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		table.insert(slot0._mixCellInfo, SLFramework.UGUI.MixCellInfo.New(slot7.type and 1 or 2, slot7.type and RougeEnum.CollectionHeight.Big or RougeEnum.CollectionHeight.Small))
	end

	return slot0._mixCellInfo
end

function slot0.isFiltering(slot0)
	return not GameUtil.tabletool_dictIsEmpty(slot0._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(slot0._extraTagFilterMap)
end

slot0.instance = slot0.New()

return slot0
