module("modules.logic.backpack.model.BackpackPropListModel", package.seeall)

slot0 = class("BackpackPropListModel", ListScrollModel)

function slot0.setCategoryPropItemList(slot0, slot1)
	slot3 = 1

	if not slot1 then
		slot0:setList({})
	end

	table.sort(slot1, uv0._sortProp)

	for slot8, slot9 in pairs(slot1) do
		if slot9.isShow == 1 and slot9.isStackable == 1 then
			function (slot0)
				uv0 = uv0 + 1

				table.insert(uv1, {
					id = uv0,
					config = slot0
				})
			end(slot9)
		end

		if slot9.isShow == 1 and slot9.isStackable == 0 then
			for slot13 = 1, slot9.quantity do
				slot4(slot9)
			end
		end
	end

	slot0:setList(slot2)
end

function slot0.clearList(slot0)
	slot0:clear()
end

function slot0._sortProp(slot0, slot1)
	if slot0.type == MaterialEnum.MaterialType.Currency then
		slot2 = -3
	elseif slot2 == MaterialEnum.MaterialType.NewInsight then
		slot2 = -2
	elseif slot2 == MaterialEnum.MaterialType.PowerPotion then
		slot2 = -1
	end

	if slot1.type == MaterialEnum.MaterialType.Currency then
		slot3 = -3
	elseif slot3 == MaterialEnum.MaterialType.NewInsight then
		slot3 = -2
	elseif slot3 == MaterialEnum.MaterialType.PowerPotion then
		slot3 = -1
	end

	if slot2 ~= slot3 then
		return slot2 < slot3
	end

	if slot0:itemExpireTime() ~= slot1:itemExpireTime() then
		if slot5 == -1 or slot4 == -1 then
			return slot5 < slot4
		else
			return slot4 < slot5
		end
	end

	if uv0._getSubTypeUseType(slot0.subType) ~= uv0._getSubTypeUseType(slot1.subType) then
		return slot7 < slot6
	end

	if ItemModel.instance:getItemConfig(slot0.type, slot0.id).subType ~= ItemModel.instance:getItemConfig(slot1.type, slot1.id).subType then
		return uv0._getSubclassPriority(slot8.subType) < uv0._getSubclassPriority(slot9.subType)
	elseif slot8.rare ~= slot9.rare then
		return slot9.rare < slot8.rare
	elseif slot0.id ~= slot1.id then
		return slot1.id < slot0.id
	end
end

function slot0._getSubclassPriority(slot0)
	if not BackpackConfig.instance:getSubclassCo()[slot0] then
		return 0
	end

	return slot1[slot0].priority
end

function slot0._getSubTypeUseType(slot0)
	if not lua_item_use.configDict[slot0] then
		return 0
	end

	return slot1.useType or 0
end

slot0.instance = slot0.New()

return slot0
