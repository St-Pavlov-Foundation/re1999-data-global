-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/VersionActivity3_2DungeonMapInteractView.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.VersionActivity3_2DungeonMapInteractView", package.seeall)

local VersionActivity3_2DungeonMapInteractView = class("VersionActivity3_2DungeonMapInteractView", BaseViewExtended)

function VersionActivity3_2DungeonMapInteractView:onInitView(go)
	self._gointeractroot = gohelper.findChild(self.viewGO, "#go_interactive_root")
	self._gointeractitem = gohelper.findChild(self.viewGO, "#go_interactive_root/#go_interactitem")

	gohelper.setActive(self._gointeractitem, false)
	gohelper.setActive(self._gointeractroot, false)
end

function VersionActivity3_2DungeonMapInteractView:addEvents()
	self:addEventCb(VersionActivityFixedHelper.getVersionActivityDungeonController().instance, VersionActivityFixedDungeonEvent.OnClickElement, self._onClickElement, self)
	self:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, self.onHideInteractUI, self)
end

function VersionActivity3_2DungeonMapInteractView:hide()
	if self._interactView then
		self._interactView:hide()
	end
end

function VersionActivity3_2DungeonMapInteractView:_onClickElement(mapElement)
	local config = mapElement._config

	if config.type == DungeonEnum.ElementType.V3a2Dialogue then
		self._interactView = self:_getInteract3View()
	elseif config.type == DungeonEnum.ElementType.V3a2Option or config.type == DungeonEnum.ElementType.V3a2OptionFinish then
		self._interactView = self:_getInteract2View()
	else
		self._interactView = self:_getInteractView()
	end

	self._interactView:removeEvents()
	self._interactView:addEvents()
	self._interactView:showInteractUI(mapElement)
end

function VersionActivity3_2DungeonMapInteractView:_getInteractView()
	if not self._interact1View then
		self._interact1View = self:openSubView(VersionActivity3_2DungeonMapNormalInteractView, self.viewGO)
	end

	return self._interact1View
end

function VersionActivity3_2DungeonMapInteractView:_getInteract2View()
	if not self._interact2View then
		self._gointeractroot2 = self:getResInst(self.viewContainer._viewSetting.otherRes.v3a2_dungeonmap_panelview2, self.viewGO, "#go_interactive_root2")

		gohelper.setSiblingAfter(self._gointeractroot2, self._gointeractroot)
		gohelper.setActive(self._gointeractroot2, false)

		self._interact2View = self:openSubView(VersionActivity3_2DungeonMapNormalInteract2View, self.viewGO)
	end

	return self._interact2View
end

function VersionActivity3_2DungeonMapInteractView:_getInteract3View()
	if not self._interact3View then
		self._gointeractroot3 = self:getResInst(self.viewContainer._viewSetting.otherRes.v3a2_dungeonmap_panelview, self.viewGO, "#go_interactive_root3")

		gohelper.setSiblingAfter(self._gointeractroot3, self._gointeractroot)
		gohelper.setActive(self._gointeractroot3, false)

		self._interact3View = self:openSubView(VersionActivity3_2DungeonMapNormalInteract3View, self.viewGO)
	end

	return self._interact3View
end

function VersionActivity3_2DungeonMapInteractView:onHideInteractUI()
	if self._interactView then
		self._interactView:removeEvents()

		self._interactView = nil
	end
end

return VersionActivity3_2DungeonMapInteractView
