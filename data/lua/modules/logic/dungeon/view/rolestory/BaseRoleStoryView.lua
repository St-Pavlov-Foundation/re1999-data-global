module("modules.logic.dungeon.view.rolestory.BaseRoleStoryView", package.seeall)

slot0 = class("BaseRoleStoryView", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.parentGO = slot1
	slot0.isShow = false

	slot0:onInit()
end

function slot0._loadPrefab(slot0)
	if slot0._loader then
		return
	end

	if not slot0.resPathList then
		return
	end

	slot1 = {}

	for slot5, slot6 in pairs(slot0.resPathList) do
		table.insert(slot1, slot6)
	end

	slot0._abLoader = MultiAbLoader.New()

	slot0._abLoader:setPathList(slot1)
	slot0._abLoader:startLoad(slot0._onLoaded, slot0)
end

function slot0._onLoaded(slot0)
	slot0.viewGO = gohelper.clone(slot0._abLoader:getAssetItem(slot0.resPathList.mainRes):GetResource(slot0.resPathList.mainRes), slot0.parentGO, slot0.viewName)

	if not slot0.viewGO then
		return
	end

	slot0:onInitView()
	slot0:addEvents()

	if slot0.isShow then
		slot0:show(true)
	else
		slot0:hide(true)
	end
end

function slot0.getResInst(slot0, slot1, slot2, slot3)
	if slot0._abLoader:getAssetItem(slot1) then
		if slot4:GetResource(slot1) then
			return gohelper.clone(slot5, slot2, slot3)
		else
			logError(slot0.__cname .. " prefab not exist: " .. slot1)
		end
	else
		logError(slot0.__cname .. " resource not load: " .. slot1)
	end

	return nil
end

function slot0.show(slot0, slot1)
	if slot0.isShow and not slot1 then
		return
	end

	slot0.isShow = true

	if not slot0.viewGO then
		slot0:_loadPrefab()

		return
	end

	gohelper.setActive(slot0.viewGO, true)
	slot0:onShow()
end

function slot0.hide(slot0, slot1)
	if not slot0.isShow and not slot1 then
		return
	end

	slot0.isShow = false

	if not slot0.viewGO then
		return
	end

	gohelper.setActive(slot0.viewGO, false)
	slot0:onHide()
end

function slot0.destory(slot0)
	slot0:removeEvents()
	slot0:onDestroyView()

	if slot0._abLoader then
		slot0._abLoader:dispose()

		slot0._abLoader = nil
	end

	if slot0.viewGO then
		gohelper.destroy(slot0.viewGO)

		slot0.viewGO = nil
	end

	slot0:__onDispose()
end

function slot0.onInit(slot0)
end

function slot0.onInitView(slot0)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onShow(slot0)
end

function slot0.onHide(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
