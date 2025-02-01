module("modules.logic.versionactivity2_4.act181.view.Activity181RewardItem", package.seeall)

slot0 = class("Activity181RewardItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goHaveGet = gohelper.findChild(slot1, "#go_haveGet")

	gohelper.setActive(slot1, false)

	slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot1)

	gohelper.setAsLastSibling(slot0._goHaveGet)
end

function slot0.setEnable(slot0, slot1)
	gohelper.setActive(slot0.go, slot1)
end

function slot0.onUpdateMO(slot0, slot1, slot2, slot3, slot4)
	slot0._itemIcon:setInPack(false)
	slot0._itemIcon:setMOValue(slot1, slot2, slot3)
	slot0._itemIcon:isShowName(false)
	slot0._itemIcon:isShowCount(true)
	slot0._itemIcon:isShowEffect(true)
	slot0._itemIcon:setGetMask(slot4)
	slot0._itemIcon:setRecordFarmItem({
		type = slot1,
		id = slot2,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
	gohelper.setActive(slot0._goHaveGet, slot4)
end

return slot0
