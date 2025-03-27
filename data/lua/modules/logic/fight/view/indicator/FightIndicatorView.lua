module("modules.logic.fight.view.indicator.FightIndicatorView", package.seeall)

slot0 = class("FightIndicatorView", FightIndicatorBaseView)
slot0.PrefabPath = "ui/sceneui/fight/seasoncelebritycardi.prefab"
slot0.EffectDuration = 1.667
slot0.EffectDurationForDot = 0.8
slot0.MaxIndicatorCount = 5

function slot0.initView(slot0, slot1, slot2, slot3)
	uv0.super.initView(slot0, slot1, slot2, slot3)

	slot0.totalIndicatorNum = uv0.MaxIndicatorCount
	slot0.goIndicatorContainer = gohelper.findChild(slot0.goIndicatorRoot, "fight_indicator")
end

function slot0.startLoadPrefab(slot0)
	gohelper.setActive(slot0.goIndicatorContainer, true)

	slot0.loader = PrefabInstantiate.Create(slot0.goIndicatorContainer)

	slot0.loader:startLoad(uv0.PrefabPath, slot0.loadCallback, slot0)
end

function slot0.loadCallback(slot0)
	slot0.loadDone = true
	slot0.instanceGo = slot0.loader:getInstGO()

	slot0:initNode()
	slot0:onIndicatorChange()
end

function slot0.initNode(slot0)
	slot0.init = true
	slot0.goDownOne = gohelper.findChild(slot0.instanceGo, "down_one")
	slot0.goDownAll = gohelper.findChild(slot0.instanceGo, "down_all")
	slot0.goUpOne = gohelper.findChild(slot0.instanceGo, "up_one")
	slot0.goUpAll = gohelper.findChild(slot0.instanceGo, "up_all")
	slot0.pointContainer = gohelper.findChild(slot0.instanceGo, "pointContainer")
	slot0.goDotItemList = {}
	slot5 = slot0

	table.insert(slot0.goDotItemList, slot0.createDotItem(slot5, gohelper.findChild(slot0.instanceGo, "pointContainer/dot_item")))

	for slot5 = 2, slot0.totalIndicatorNum do
		table.insert(slot0.goDotItemList, slot0:createDotItem(gohelper.cloneInPlace(slot1)))
	end

	slot0.simageIcon = gohelper.findChildSingleImage(slot0.instanceGo, "card/#go_rare5/image_icon")
	slot0.simageSignature = gohelper.findChildSingleImage(slot0.instanceGo, "card/#go_rare5/simage_signature")

	gohelper.setActive(gohelper.findChild(slot0.instanceGo, "card/#go_rare5/image_career"), false)
	slot0:loadImage()
end

function slot0.createDotItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.goDot = slot1
	slot2.goDarkIcon = gohelper.findChild(slot1, "dark_icon")
	slot2.goBrightIcon = gohelper.findChild(slot1, "bright_icon")
	slot2.goEffect = gohelper.findChild(slot1, "effect")
	slot2.goEffectOne = gohelper.findChild(slot1, "effect/one")
	slot2.goEffectAll = gohelper.findChild(slot1, "effect/all")

	return slot2
end

function slot0.loadImage(slot0)
	slot1 = slot0:getCardConfig()

	slot0.simageIcon:LoadImage(ResUrl.getSeasonCelebrityCard(slot1.icon))

	if not string.nilorempty(slot1.signIcon) then
		slot0.simageSignature:LoadImage(ResUrl.getSignature(slot1.signIcon, "characterget"))
	end
end

function slot0.getCardConfig(slot0)
	return SeasonConfig.instance:getSeasonEquipCo(slot0:getCardId())
end

function slot0.getCardId(slot0)
	return 11549
end

function slot0.onIndicatorChange(slot0)
	if not slot0.loadDone then
		return
	end

	if FightDataHelper.fieldMgr:getIndicatorNum(slot0.indicatorId) <= 0 or slot0.totalIndicatorNum < slot1 then
		return
	end

	slot0.indicatorNum = slot1

	slot0:playEffect()
end

function slot0.playEffect(slot0)
	gohelper.setActive(slot0.goIndicatorContainer, true)
	slot0:resetEffect()
	slot0:refreshDotItemNode()

	if slot0.indicatorNum == slot0.totalIndicatorNum then
		AudioMgr.instance:trigger(AudioEnum.UI.play_buff_accrued_number_2)
		gohelper.setActive(slot0.goDownAll, true)
		gohelper.setActive(slot0.goUpAll, true)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_buff_accrued_number_1)
		gohelper.setActive(slot0.goDownOne, true)
		gohelper.setActive(slot0.goUpOne, true)
	end

	TaskDispatcher.runDelay(slot0.playEffectDone, slot0, uv0.EffectDuration)

	if slot0.goDotItemList[slot0.indicatorNum] then
		gohelper.setActive(slot1.goEffect, true)

		slot2 = slot0.indicatorNum == slot0.totalIndicatorNum

		gohelper.setActive(slot1.goEffectOne, not slot2)
		gohelper.setActive(slot1.goEffectAll, slot2)
	end
end

function slot0.refreshDotItemNode(slot0)
	slot1 = nil

	for slot5 = 1, slot0.totalIndicatorNum do
		slot1 = slot0.goDotItemList[slot5]

		gohelper.setActive(slot1.goEffectOne, false)
		gohelper.setActive(slot1.goEffectAll, false)
		gohelper.setActive(slot1.goBrightIcon, slot5 <= slot0.indicatorNum)
		gohelper.setActive(slot1.goDarkIcon, slot0.indicatorNum < slot5)
	end
end

function slot0.playEffectDone(slot0)
	gohelper.setActive(slot0.goIndicatorContainer, false)
	slot0:resetEffect()
end

function slot0.resetEffect(slot0)
	gohelper.setActive(slot0.goDownOne, false)
	gohelper.setActive(slot0.goDownAll, false)
	gohelper.setActive(slot0.goUpOne, false)
	gohelper.setActive(slot0.goUpAll, false)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.playEffectDone, slot0)

	slot0.goDotItemList = nil

	if slot0.loader then
		slot0.loader:onDestroy()

		slot0.loader = nil
	end

	if gohelper.isNil(slot0.simageIcon) then
		slot0.simageIcon:UnLoadImage()
	end

	if gohelper.isNil(slot0.simageSignature) then
		slot0.simageSignature:UnLoadImage()
	end

	uv0.super.onDestroy(slot0)
end

return slot0
