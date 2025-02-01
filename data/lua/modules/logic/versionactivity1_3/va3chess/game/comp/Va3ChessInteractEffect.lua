module("modules.logic.versionactivity1_3.va3chess.game.comp.Va3ChessInteractEffect", package.seeall)

slot0 = class("Va3ChessInteractEffect")

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

	slot2 = slot1:getInstGO()
	slot0._target.avatar.goLostTarget = gohelper.findChild(slot2, "piecea/vx_vertigo")
	slot0.effectGoContainer = slot2

	slot0:refreshSearchFailed()
end

function slot0.refreshSearchFailed(slot0)
	if slot0._target.originData and slot0._target.originData.data and slot0._target.avatar and slot0._target.avatar.goLostTarget then
		gohelper.setActive(slot0._target.avatar.goLostTarget, slot0._target.originData.data.lostTarget)
	end
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

	if slot0.showEffectType == Va3ChessEnum.EffectType.ArrowHit then
		slot2 = nil

		AudioMgr.instance:trigger((slot0._target.objType ~= Va3ChessEnum.InteractType.Player and slot3 ~= Va3ChessEnum.InteractType.AssistPlayer or AudioEnum.chess_activity142.ArrowHitPlayer) and AudioEnum.chess_activity142.MonsterBeHit)
	end
end

function slot0.loadEffect(slot0)
	if tabletool.indexOf(slot0.loadedEffectTypeList, slot0.showEffectType) then
		return
	end

	table.insert(slot0.loadedEffectTypeList, slot1)
	loadAbAsset(Va3ChessEnum.EffectPath[slot1], true, slot0._onLoadCallback, slot0)
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
		removeAssetLoadCb(Va3ChessEnum.EffectPath[slot5], slot0._onLoadCallback, slot0)
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
