module("modules.logic.versionactivity2_4.pinball.view.PinballGameSceneView", package.seeall)

slot0 = class("PinballGameSceneView", BaseView)

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "mask/#go_root")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "mask/#go_root/item")
	slot0._gotopitem = gohelper.findChild(slot0.viewGO, "#go_root_top/item")
	slot0._gonumitem = gohelper.findChild(slot0.viewGO, "#go_root_num/item")
end

function slot0.onOpen(slot0)
	PinballStatHelper.instance:resetGameDt()
	gohelper.setActive(slot0._goitem, false)
	gohelper.setActive(slot0._gotopitem, false)
	gohelper.setActive(slot0._gonumitem, false)

	slot0._layers = slot0:getUserDataTb_()

	for slot4 in ipairs(PinballEnum.UnitLayers) do
		slot0._layers[slot4] = gohelper.create2d(slot0._goroot, "Layer" .. slot4)
	end

	PinballEntityMgr.instance:setRoot(slot0._goitem, slot0._gotopitem, slot0._gonumitem, slot0._layers)
end

function slot0.onClose(slot0)
	PinballEntityMgr.instance:clear()
end

return slot0
