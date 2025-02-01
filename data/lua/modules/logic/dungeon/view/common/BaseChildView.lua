module("modules.logic.dungeon.view.common.BaseChildView", package.seeall)

slot0 = class("BaseChildView", UserDataDispose)

function slot0.initView(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.viewParam = slot2
	slot0.viewGO = slot1

	slot0:onInitView()
	slot0:addEvents()
	slot0:onOpen()
end

function slot0.updateParam(slot0, slot1)
	slot0.viewParam = slot1

	slot0:onUpdateParam()
end

function slot0.onOpenFinish(slot0)
end

function slot0.destroyView(slot0)
	slot0:onClose()
	slot0:removeEvents()
	slot0:onDestroyView()

	if slot0.viewGO then
		gohelper.destroy(slot0.viewGO)

		slot0.viewGO = nil
	end

	slot0:__onDispose()
end

return slot0
