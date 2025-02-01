module("modules.logic.tips.controller.MaterialTipController", package.seeall)

slot0 = class("MaterialTipController", BaseController)

function slot0.onInit(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.showMaterialInfo(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11, slot12, slot13)
	slot0:showMaterialInfoWithData(slot1, slot2, {
		type = tonumber(slot1),
		id = tonumber(slot2),
		inpack = slot3,
		uid = slot4,
		canJump = not slot5,
		recordFarmItem = slot6,
		fakeQuantity = slot7,
		needQuantity = slot8,
		isConsume = slot9,
		jumpFinishCallback = slot10,
		jumpFinishCallbackObj = slot11,
		jumpFinishCallbackParam = slot12,
		roomBuildingLevel = slot13 and slot13.roomBuildingLevel
	})
end

function slot0.showMaterialInfoWithData(slot0, slot1, slot2, slot3)
	slot3.type = slot1
	slot3.id = slot2
	slot4 = slot3.inpack

	if slot1 == MaterialEnum.MaterialType.Item then
		if ItemModel.instance:getItemConfig(slot1, slot2).subType == ItemEnum.SubType.MainSceneSkin then
			ViewMgr.instance:openView(ViewName.MainSceneSkinMaterialTipView, slot3)

			return
		end

		if slot4 ~= true and MaterialEnum.SubTypePackages[slot5.subType] then
			ViewMgr.instance:openView(ViewName.MaterialPackageTipView, slot3)
		elseif ItemEnum.RoomBackpackPropSubType[slot5.subType] then
			ViewMgr.instance:openView(ViewName.RoomManufactureMaterialTipView, slot3)
		else
			ViewMgr.instance:openView(ViewName.MaterialTipView, slot3)
		end
	elseif slot1 == MaterialEnum.MaterialType.Currency then
		slot3.inpack = false

		ViewMgr.instance:openView(ViewName.MaterialTipView, slot3)
	elseif slot1 == MaterialEnum.MaterialType.Hero then
		slot3.hero = true

		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = slot2
		})
	elseif slot1 == MaterialEnum.MaterialType.HeroSkin then
		CharacterController.instance:openCharacterSkinTipView(slot2)
	elseif slot1 == MaterialEnum.MaterialType.Equip then
		EquipController.instance:openEquipView({
			equipId = slot2
		})
	elseif slot1 == MaterialEnum.MaterialType.PlayerCloth then
		slot3.isTip = true

		ViewMgr.instance:openView(ViewName.PlayerClothView, slot3)
	elseif slot1 == MaterialEnum.MaterialType.Building or slot1 == MaterialEnum.MaterialType.BlockPackage then
		ViewMgr.instance:openView(ViewName.RoomMaterialTipView, slot3)
	elseif slot1 == MaterialEnum.MaterialType.EquipCard then
		Activity104Controller.instance:openSeasonCelebrityCardTipView(slot3)
	elseif slot1 == MaterialEnum.MaterialType.Season123EquipCard then
		Season123Controller.instance:openSeasonCelebrityCardTipView(slot3)
	elseif slot1 == MaterialEnum.MaterialType.Antique then
		AntiqueController.instance:openAntiqueView(slot2)
	else
		slot3.special = true

		ViewMgr.instance:openView(ViewName.MaterialTipView, slot3)
	end
end

function slot0.onUseOptionalHeroGift(slot0, slot1, slot2)
	if not slot2 or #slot2 < 0 then
		return
	end

	slot3 = {}

	table.insert(slot3, {
		materialId = slot1.id,
		quantity = slot1.quantity
	})
	ItemRpc.instance:sendUseItemRequest(slot3, slot2[1])
	CustomPickChoiceController.instance:dispatchEvent(CustomPickChoiceEvent.onCustomPickComplete)
end

slot0.instance = slot0.New()

return slot0
