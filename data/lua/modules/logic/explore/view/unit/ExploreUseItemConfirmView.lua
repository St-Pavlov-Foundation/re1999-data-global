module("modules.logic.explore.view.unit.ExploreUseItemConfirmView", package.seeall)

slot0 = class("ExploreUseItemConfirmView")

function slot0.ctor(slot0)
	slot0._containerGO = gohelper.create2d(GameSceneMgr.instance:getCurScene().view:getRoot(), "ExploreUseItemConfirmView")
	slot0._uiLoader = PrefabInstantiate.Create(slot0._containerGO)

	slot0._uiLoader:startLoad("ui/viewres/explore/exploreconfirmview.prefab", slot0._onLoaded, slot0)

	slot0._uiFollower = gohelper.onceAddComponent(slot0._containerGO, typeof(ZProj.UIFollower))

	slot0._uiFollower:Set(CameraMgr.instance:getMainCamera(), CameraMgr.instance:getUICamera(), ViewMgr.instance:getUIRoot().transform, slot0._containerGO.transform, 0, 0, 0, 0, 0)
	slot0._uiFollower:SetEnable(false)
	gohelper.setActive(slot0._containerGO, false)
end

function slot0.setTarget(slot0, slot1, slot2)
	slot0._targetPos = slot2

	if slot1 then
		slot0._uiFollower:SetTarget3d(slot1.transform)
		slot0._uiFollower:SetEnable(true)
		gohelper.setActive(slot0._containerGO, true)
	else
		slot0._uiFollower:SetEnable(false)
		gohelper.setActive(slot0._containerGO, false)
	end
end

function slot0._onLoaded(slot0)
	slot0.viewGO = slot0._uiLoader:getInstGO()
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_confirm/go_container/btn_confirm")
	slot0._btncancle = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_confirm/go_container/btn_cancel")

	slot0._btnconfirm:AddClickListener(slot0.onConfirm, slot0)
	slot0._btncancle:AddClickListener(slot0.onCancel, slot0)
end

function slot0.onCancel(slot0)
	ExploreController.instance:getMap():getCompByType(ExploreEnum.MapStatus.UseItem):onCancel(slot0._targetPos)
	slot0:setTarget()
end

function slot0.onConfirm(slot0)
	slot1 = ExploreController.instance:getMap()
	slot3 = slot0._targetPos
	slot4 = slot1:getHero()

	slot4:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.CreateUnit, true, true)
	slot4:onCheckDir(slot4.nodePos, slot3)
	ExploreRpc.instance:sendExploreUseItemRequest(slot1:getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo().id, slot3.x, slot3.y)
	slot1:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function slot0.dispose(slot0)
	if slot0.viewGO then
		slot0._btnconfirm:RemoveClickListener()
		slot0._btncancle:RemoveClickListener()

		slot0._btnconfirm = nil
		slot0._btncancle = nil
		slot0.viewGO = nil
	end

	slot0._targetPos = nil

	slot0._uiLoader:dispose()

	slot0._uiLoader = nil

	gohelper.destroy(slot0._containerGO)

	slot0._containerGO = nil
end

return slot0
