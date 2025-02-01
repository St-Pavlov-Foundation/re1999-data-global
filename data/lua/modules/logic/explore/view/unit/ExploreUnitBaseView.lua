module("modules.logic.explore.view.unit.ExploreUnitBaseView", package.seeall)

slot0 = class("ExploreUnitBaseView", LuaCompBase)

function slot0.ctor(slot0, slot1, slot2)
	slot0.unit = slot1
	slot0.url = slot2
	slot0.viewGO = nil
	slot0.isInitDone = false

	slot0:startLoad()
end

function slot0.startLoad(slot0)
	if slot0._uiLoader or not slot0.url then
		return
	end

	slot0._containerGO = gohelper.create2d(GameSceneMgr.instance:getCurScene().view:getRoot(), slot0.unit.id)
	slot0._uiLoader = PrefabInstantiate.Create(slot0._containerGO)

	slot0._uiLoader:startLoad(slot0.url, slot0._onLoaded, slot0)
end

function slot0._onLoaded(slot0)
	slot0.isInitDone = true
	slot0.viewGO = slot0._uiLoader:getInstGO()
	slot0._uiFollower = gohelper.onceAddComponent(slot0._containerGO, typeof(ZProj.UIFollower))

	slot0._uiFollower:Set(CameraMgr.instance:getMainCamera(), CameraMgr.instance:getUICamera(), ViewMgr.instance:getUIRoot().transform, slot0.unit._displayTr or slot0.unit.trans, 0, 0, 0, 0, slot0._offsetY2d or 15)
	slot0._uiFollower:SetEnable(true)
	slot0:onInit()
	slot0:addEventListeners()
	slot0:onOpen()
end

function slot0.setTarget(slot0, slot1)
	if not slot0.isInitDone then
		return
	end

	slot0._uiFollower:SetTarget3d(slot1.transform)
end

function slot0.onInit(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.closeThis(slot0)
	slot0.unit.uiComp:removeUI(slot0.class)
end

function slot0.tryDispose(slot0)
	if slot0.isInitDone then
		slot0:removeEventListeners()
		slot0:onClose()
		slot0:onDestroy()
		gohelper.destroy(slot0._containerGO)

		slot0.isInitDone = false
	end

	slot0._containerGO = nil
	slot0._uiFollower = nil

	if slot0._uiLoader then
		slot0._uiLoader:dispose()

		slot0._uiLoader = nil
	end

	slot0.viewGO = nil
	slot0.unit = nil
	slot0.url = nil
end

return slot0
