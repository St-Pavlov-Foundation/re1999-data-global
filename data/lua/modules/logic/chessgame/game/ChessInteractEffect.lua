module("modules.logic.chessgame.game.ChessInteractEffect", package.seeall)

slot0 = class("ChessInteractEffect")

function slot0.ctor(slot0, slot1)
	slot0._target = slot1
	slot0.effectGoDict = {}
	slot0.assetItemList = {}
	slot0.loadedEffectTypeList = {}
end

function slot0.onAvatarLoaded(slot0)
	if not slot0._target.avatar.loader then
		return
	end

	slot0.effectGoContainer = slot1:getInstGO()
end

function slot0.showEffect(slot0, slot1)
	slot0.showEffectType = slot1

	if not slot0.effectGoDict[slot0.showEffectType] then
		slot0:loadEffect()

		return
	end

	slot0:_realShowEffect()
end

function slot0._realShowEffect(slot0)
	slot1 = slot0.effectGoDict[slot0.showEffectType]

	gohelper.setActive(slot1, false)
	gohelper.setActive(slot1, true)
end

function slot0.loadEffect(slot0)
	if tabletool.indexOf(slot0.loadedEffectTypeList, slot0.showEffectType) then
		return
	end

	table.insert(slot0.loadedEffectTypeList, slot1)
	loadAbAsset(ChessGameEnum.EffectPath[slot1], true, slot0._onLoadCallback, slot0)
end

function slot0._onLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		table.insert(slot0.assetItemList, slot1)
		slot1:Retain()

		slot2 = gohelper.clone(slot1:GetResource(), slot0.effectGoContainer)
		slot0.effectGoDict[slot0.showEffectType] = slot2

		gohelper.setActive(slot2, false)
		slot0:showEffect(slot0.showEffectType)
	end
end

function slot0.dispose(slot0)
	for slot4, slot5 in ipairs(slot0.loadedEffectTypeList) do
		removeAssetLoadCb(ChessGameEnum.EffectPath[slot5], slot0._onLoadCallback, slot0)
	end

	for slot4, slot5 in ipairs(slot0.assetItemList) do
		slot5:Release()

		slot0.assetItemList[slot4] = nil
	end

	slot0.assetItemList = {}

	for slot4, slot5 in pairs(slot0.effectGoDict) do
		if not gohelper.isNil(slot5) then
			gohelper.destroy(slot5)
		end

		slot0.effectGoDict[slot4] = nil
	end

	slot0.effectGoDict = {}
	slot0._target = nil
	slot0.effectGoContainer = nil
end

return slot0
