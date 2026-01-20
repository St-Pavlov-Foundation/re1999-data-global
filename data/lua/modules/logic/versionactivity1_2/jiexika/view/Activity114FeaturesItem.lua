-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114FeaturesItem.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114FeaturesItem", package.seeall)

local Activity114FeaturesItem = class("Activity114FeaturesItem", ListScrollCell)

function Activity114FeaturesItem:init(go)
	self.go = go
	self._txtName = gohelper.findChildText(self.go, "#txt_name")
	self._imageIcon = gohelper.findChildImage(self.go, "#image_bg")
	self._click = gohelper.getClickWithAudio(self.go)
end

function Activity114FeaturesItem:addEventListeners()
	self._click:AddClickListener(self._onClick, self)
end

function Activity114FeaturesItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function Activity114FeaturesItem:_onClick()
	Activity114Controller.instance:dispatchEvent(Activity114Event.ShowFeaturesTips)
end

function Activity114FeaturesItem:onUpdateMO(mo)
	local cellWith = Activity114FeaturesModel.instance:getFeaturePreferredLength(self._txtName, 276, 420)

	recthelper.setWidth(self.go.transform, cellWith)

	self.mo = mo

	UISpriteSetMgr.instance:setVersionActivitywhitehouseSprite(self._imageIcon, mo.inheritable == 1 and "img_shuxing1" or "img_shuxing2")

	self._txtName.text = self.mo.features
end

function Activity114FeaturesItem:onDestroyView()
	return
end

return Activity114FeaturesItem
