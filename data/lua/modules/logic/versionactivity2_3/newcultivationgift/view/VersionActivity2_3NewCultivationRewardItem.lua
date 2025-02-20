module("modules.logic.versionactivity2_3.newcultivationgift.view.VersionActivity2_3NewCultivationRewardItem", package.seeall)

slot0 = class("VersionActivity2_3NewCultivationRewardItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.go = slot1

	gohelper.setActive(slot1, false)

	slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot1)
end

function slot0.setEnable(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3)
	slot0._itemIcon:setInPack(false)
	slot0._itemIcon:setMOValue(slot1, slot2, slot3)
	slot0._itemIcon:isShowName(false)
	slot0._itemIcon:isShowCount(true)
	slot0._itemIcon:isShowEffect(true)
	slot0._itemIcon:setRecordFarmItem({
		type = slot1,
		id = slot2,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

return slot0
