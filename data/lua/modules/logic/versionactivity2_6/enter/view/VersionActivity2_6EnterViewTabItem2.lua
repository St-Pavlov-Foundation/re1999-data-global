-- chunkname: @modules/logic/versionactivity2_6/enter/view/VersionActivity2_6EnterViewTabItem2.lua

module("modules.logic.versionactivity2_6.enter.view.VersionActivity2_6EnterViewTabItem2", package.seeall)

local VersionActivity2_6EnterViewTabItem2 = class("VersionActivity2_6EnterViewTabItem2", VersionActivity2_6EnterViewTabItemBase)

function VersionActivity2_6EnterViewTabItem2:_editableInitView()
	VersionActivity2_6EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity2_6EnterViewTabItem2:afterSetData()
	VersionActivity2_6EnterViewTabItem2.super.afterSetData(self)

	self.txtName.text = self.activityCo and self.activityCo.name or ""
	self.txtNameEn.text = self.activityCo and self.activityCo.nameEn or ""
end

function VersionActivity2_6EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity2_6EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivity2_6Enum.TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivity2_6Enum.TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)
	self.txtNameEn.color = GameUtil.parseColor(tabSetting.enColor)
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivity2_6EnterViewTabItem2
