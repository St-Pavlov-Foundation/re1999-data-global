module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractEffect", package.seeall)

slot0 = class("YaXianInteractEffect", UserDataDispose)
slot0.EffectPath = {
	[YaXianGameEnum.EffectType.Fight] = YaXianGameEnum.SceneResPath.FightEffect,
	[YaXianGameEnum.EffectType.Assassinate] = YaXianGameEnum.SceneResPath.AssassinateEffect,
	[YaXianGameEnum.EffectType.Die] = YaXianGameEnum.SceneResPath.DieEffect,
	[YaXianGameEnum.EffectType.FightSuccess] = YaXianGameEnum.SceneResPath.FightSuccessEffect,
	[YaXianGameEnum.EffectType.PlayerAssassinateEffect] = YaXianGameEnum.SceneResPath.PlayerAssassinateEffect
}
slot0.EffectAudio = {
	[YaXianGameEnum.EffectType.Assassinate] = AudioEnum.YaXian.Assassinate,
	[YaXianGameEnum.EffectType.PlayerAssassinateEffect] = AudioEnum.YaXian.Assassinate,
	[YaXianGameEnum.EffectType.Fight] = AudioEnum.YaXian.Fight,
	[YaXianGameEnum.EffectType.Die] = AudioEnum.YaXian.Die
}

function slot0.ctor(slot0)
	slot0:__onInit()
end

function slot0.init(slot0, slot1)
	slot0.interactItem = slot1
	slot0.interactMo = slot1.interactMo
	slot0.effectGoContainer = slot1.effectGoContainer
	slot0.config = slot0.interactMo.config
	slot0.effectGoDict = slot0:getUserDataTb_()
	slot0.assetItemList = slot0:getUserDataTb_()
	slot0.loadedEffectList = {}
end

function slot0.showEffect(slot0, slot1, slot2, slot3)
	if slot0.interactItem:isDelete() then
		if slot0.doneCallback then
			slot0.doneCallback(slot0.callbackObj)
		end

		return
	end

	slot0.showEffectType = slot0:getInputEffectType(slot1)
	slot0.doneCallback = slot2
	slot0.callbackObj = slot3

	if not slot0.effectGoDict[slot0.showEffectType] then
		slot0:loadEffect()

		return
	end

	YaXianGameController.instance:dispatchEvent(YaXianEvent.RefreshInteractStatus, false)
	slot0:_showEffect()
end

function slot0.getInputEffectType(slot0, slot1)
	if slot1 == YaXianGameEnum.EffectType.Assassinate and slot0.config.interactType == YaXianGameEnum.InteractType.Player then
		return YaXianGameEnum.EffectType.PlayerAssassinateEffect
	end

	return slot1
end

function slot0._showEffect(slot0)
	slot1 = slot0.effectGoDict[slot0.showEffectType]

	gohelper.setActive(slot1, false)
	gohelper.setActive(slot1, true)
	YaXianGameController.instance:playEffectAudio(uv0.EffectAudio[slot0.showEffectType])
	TaskDispatcher.runDelay(slot0.onEffectDone, slot0, YaXianGameEnum.EffectDuration[slot0.showEffectType] or YaXianGameEnum.DefaultEffectDuration)
end

function slot0.onEffectDone(slot0)
	gohelper.setActive(slot0.effectGoDict[slot0.showEffectType], false)

	if slot0.showEffectType == YaXianGameEnum.EffectType.Die then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.DeleteInteractObj, slot0.interactItem.id)
	end

	if slot0.doneCallback then
		slot0.doneCallback(slot0.callbackObj)
	end
end

function slot0.loadEffect(slot0)
	if tabletool.indexOf(slot0.loadedEffectList, slot0.showEffectType) then
		return
	end

	table.insert(slot0.loadedEffectList, slot1)
	loadAbAsset(uv0.EffectPath[slot1], true, slot0._onLoadCallback, slot0)
end

function slot0._onLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		table.insert(slot0.assetItemList, slot1)
		slot1:Retain()

		slot2 = gohelper.clone(slot1:GetResource(), slot0.effectGoContainer)
		slot0.effectGoDict[slot0.showEffectType] = slot2

		gohelper.setActive(slot2, false)
		slot0:showEffect(slot0.showEffectType, slot0.doneCallback, slot0.callbackObj)
	end
end

function slot0.cancelTask(slot0)
	gohelper.setActive(slot0.effectGoDict[slot0.showEffectType], false)
	TaskDispatcher.cancelTask(slot0.onEffectDone, slot0)
end

function slot0.dispose(slot0)
	for slot4, slot5 in ipairs(slot0.loadedEffectList) do
		removeAssetLoadCb(uv0.EffectPath[slot5], slot0._onLoadCallback, slot0)
	end

	slot0:cancelTask()
	slot0:__onDispose()
end

return slot0
