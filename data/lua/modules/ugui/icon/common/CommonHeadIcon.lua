module("modules.ugui.icon.common.CommonHeadIcon", package.seeall)

slot0 = class("CommonHeadIcon", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._headIcon = gohelper.findChildSingleImage(slot1, "#simage_headicon")
	slot0._goframe = gohelper.findChild(slot1, "frame")
	slot0._imgaeheadIcon = gohelper.findChildImage(slot1, "#simage_headicon")
	slot0._imageframe = gohelper.findChildImage(slot1, "frame")
	slot0._goframenode = gohelper.findChild(slot1, "framenode")
	slot0._btnClick = gohelper.findChildClick(slot1, "#simage_headicon")
end

function slot0.addEventListeners(slot0)
	if slot0._btnClick then
		slot0._btnClick:AddClickListener(slot0._onClick, slot0)
	end
end

function slot0.removeEventListeners(slot0)
	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()

		slot0._btnClick = nil
	end
end

function slot0._onClick(slot0)
	if slot0.noClick then
		return
	end

	if not slot0._materialType or not slot0._itemId then
		return
	end

	MaterialTipController.instance:showMaterialInfo(slot0._materialType, slot0._itemId)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1

	slot0:setItemId(slot1.materilId, slot1.materialType)
end

function slot0.setItemId(slot0, slot1, slot2)
	slot0._itemId = slot1
	slot0._materialType = slot2 or MaterialEnum.MaterialType.Item
	slot0._config = ItemModel.instance:getItemConfigAndIcon(slot0._materialType, slot1)

	slot0:setHeadIcon()
	slot0:updateFrame()
	slot0:setVisible(true)
end

function slot0.setHeadIcon(slot0)
	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._headIcon)
	end

	slot0._liveHeadIcon:setLiveHead(slot0._config.id)
end

function slot0.updateFrame(slot0)
	if #string.split(slot0._config.effect, "#") > 1 and slot0._config.id == tonumber(slot1[#slot1]) then
		gohelper.setActive(slot0._goframe, false)
		gohelper.setActive(slot0._goframenode, true)

		if not slot0.frame and not slot0.isloading then
			slot0.isloading = true
			slot0._frameloader = MultiAbLoader.New()

			slot0._frameloader:addPath("ui/viewres/common/effect/frame.prefab")
			slot0._frameloader:startLoad(slot0._onFrameLoadCallback, slot0)
		end
	else
		gohelper.setActive(slot0._goframe, true)
		gohelper.setActive(slot0._goframenode, false)
	end
end

function slot0._onFrameLoadCallback(slot0)
	slot0.isloading = false
	slot0.frame = gohelper.clone(slot0._frameloader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")
end

function slot0.setColor(slot0, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imgaeheadIcon, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageframe, slot1)
end

function slot0.setVisible(slot0, slot1)
	if slot0.isVisible == slot1 then
		return
	end

	slot0.isVisible = slot1

	gohelper.setActive(slot0.go, slot1)
end

function slot0.setNoClick(slot0, slot1)
	slot0.noClick = slot1
end

function slot0.onDestroy(slot0)
	slot0._headIcon:UnLoadImage()
end

return slot0
