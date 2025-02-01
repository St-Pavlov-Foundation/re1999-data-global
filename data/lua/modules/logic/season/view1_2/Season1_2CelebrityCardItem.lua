module("modules.logic.season.view1_2.Season1_2CelebrityCardItem", package.seeall)

slot0 = class("Season1_2CelebrityCardItem", LuaCompBase)
slot0.AssetPath = "ui/viewres/v1a2_season/seasoncelebritycarditem.prefab"

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.go = slot1
	slot0._equipId = slot2
	slot0._showTag = false
	slot0._showNewFlag = slot3 and slot3.showNewFlag
	slot0._showNewFlag2 = slot3 and slot3.showNewFlag2
	slot0._targetFlagUIScale = slot3 and slot3.targetFlagUIScale
	slot0._targetFlagUIPosX = slot3 and slot3.targetFlagUIPosX
	slot0._targetFlagUIPosY = slot3 and slot3.targetFlagUIPosY
	slot0._noClick = slot3 and slot3.noClick
	slot0._gorares = {}
	slot0._gocarditem = gohelper.create2d(slot0.go, "cardItem")
	slot0._resLoader = PrefabInstantiate.Create(slot0._gocarditem)

	slot0._resLoader:startLoad(uv0.AssetPath, slot0._cardLoaded, slot0)
end

function slot0._cardLoaded(slot0)
	slot0._cardGo = slot0._resLoader:getInstGO()
	slot0._icon = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._cardGo, Season1_2CelebrityCardEquip)

	if not slot0._noClick then
		slot0._icon:setClickCall(slot0.onBtnClick, slot0)
	end

	slot0:_setItem()
end

function slot0.onBtnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.EquipCard, slot0._equipId)
end

function slot0._setItem(slot0)
	slot0._icon:updateData(slot0._equipId)
	slot0._icon:setShowTag(slot0._showTag)
	slot0._icon:setShowNewFlag(slot0._showNewFlag)
	slot0._icon:setShowNewFlag2(slot0._showNewFlag2)
	slot0._icon:setFlagUIScale(slot0._targetFlagUIScale)
	slot0._icon:setFlagUIPos(slot0._targetFlagUIPosX, slot0._targetFlagUIPosY)
	slot0._icon:setColorDark(slot0._colorDarkEnable)
end

function slot0.showTag(slot0, slot1)
	slot0._showTag = slot1

	if slot0._icon then
		slot0._icon:setShowTag(slot1)
	end
end

function slot0.showProbability(slot0, slot1)
	slot0._showTag = slot1

	if slot0._icon then
		slot0._icon:setShowProbability(slot1)
	end
end

function slot0.showNewFlag(slot0, slot1)
	slot0._showNewFlag = slot1

	if slot0._icon then
		slot0._icon:setShowNewFlag(slot1)
	end
end

function slot0.showNewFlag2(slot0, slot1)
	slot0._showNewFlag2 = slot1

	if slot0._icon then
		slot0._icon:setShowNewFlag2(slot1)
	end
end

function slot0.reset(slot0, slot1)
	slot0._equipId = slot1

	if slot0._cardGo then
		slot0:_setItem()
	end
end

function slot0.setColorDark(slot0, slot1)
	slot0._colorDarkEnable = slot1

	if slot0._icon then
		slot0._icon:setColorDark(slot1)
	end
end

function slot0.destroy(slot0)
	if slot0._icon then
		slot0._icon:disposeUI()

		slot0._icon = nil
	end

	if slot0._gocarditem then
		gohelper.destroy(slot0._gocarditem)

		slot0._gocarditem = nil
	end

	if slot0._cardGo then
		slot0._cardGo = nil
	end

	if slot0._resloader then
		slot0._resloader:dispose()

		slot0._resloader = nil
	end
end

return slot0
