module("modules.logic.versionactivity1_2.jiexika.view.Activity114FeaturesItem", package.seeall)

slot0 = class("Activity114FeaturesItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtName = gohelper.findChildText(slot0.go, "#txt_name")
	slot0._imageIcon = gohelper.findChildImage(slot0.go, "#image_bg")
	slot0._click = gohelper.getClickWithAudio(slot0.go)
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._onClick(slot0)
	Activity114Controller.instance:dispatchEvent(Activity114Event.ShowFeaturesTips)
end

function slot0.onUpdateMO(slot0, slot1)
	recthelper.setWidth(slot0.go.transform, Activity114FeaturesModel.instance:getFeaturePreferredLength(slot0._txtName, 276, 420))

	slot0.mo = slot1

	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(slot0._imageIcon, slot1.inheritable == 1 and "img_shuxing1" or "img_shuxing2")

	slot0._txtName.text = slot0.mo.features
end

function slot0.onDestroyView(slot0)
end

return slot0
